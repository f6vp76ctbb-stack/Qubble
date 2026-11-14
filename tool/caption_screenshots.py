#!/usr/bin/env python3
"""Turns the raw app captures into finished Play Store screenshots.

    flutter test tool/generate_screenshots.dart   # writes store-assets/raw/<locale>/
    python3 tool/caption_screenshots.py           # writes store-assets/<locale>/

Four languages, the ones whose store listing is kept by hand (owner,
09.11.2026): English, German, Spanish, Portuguese. Every other store language
is translated by the Play Console and shows the English pictures.

Three things drive the design, all from looking at what the frames were
actually selling:

1. **Lead with what no other block puzzle has.** The first frame is a Qubbie
   flying along the row it is clearing; the third is the nine of them.

2. **Crop to the board.** A frame that shrinks the whole screen into a card
   leaves a block ~16 px wide in the search-results thumbnail that most people
   ever see. The generator writes the exact board rect next to each PNG, so
   the crop is measured, not guessed.

3. **Show the clear.** The captures are taken mid-burst, so these frames carry
   particles, a floating score and a lit combo instead of a settled board.

The background is a plate, generated here from the theme's own palette; if
`store-assets/plates/<stem>.png` exists it is used instead. The app UI itself
is never repainted — Play's store-listing policy wants screenshots that depict
the real app, so the pixels of the board and of every Qubbie come from the app
and nothing else.

Requires Pillow (`pip install Pillow`) and the app font in assets/fonts.
"""

from __future__ import annotations

import json
import os
import re
import sys

from PIL import Image, ImageDraw, ImageFilter, ImageFont

RAW_DIR = "store-assets/raw"
OUT_DIR = "store-assets"
PLATE_DIR = "store-assets/plates"
FONT = "assets/fonts/Nunito.ttf"

# Play Store phone screenshot: 9:16, 1080 px on the short edge.
W, H = 1080, 1920

MARGIN = 72
TEXT = (245, 247, 255)
MUTED = (168, 174, 205)

# Nunito ships as a variable font whose default instance is Light (200) — far
# too thin for a store headline. Pick the weights explicitly.
HEADLINE_WEIGHT = 800
SUB_WEIGHT = 500


# (background, accent) of every theme, read straight from lib/ui/theme.dart so
# every frame agrees with the app it shows — and a new theme needs no copy here.
def _theme_palette() -> dict[str, tuple[tuple[int, int, int], tuple[int, int, int]]]:
    src = open("lib/ui/theme.dart", encoding="utf-8").read()
    src = src[src.index("const List<ThemeEntry> kThemeCatalog"):]
    named = {"kDefaultThemeId": "classic", "kHalloweenThemeId": "pumpkin"}

    def rgb(chunk, field):
        value = re.search(field + r":\s*Color\(0x[0-9A-Fa-f]{2}([0-9A-Fa-f]{6})\)", chunk)
        h = value.group(1)
        return tuple(int(h[i:i + 2], 16) for i in (0, 2, 4))

    palette = {}
    for chunk in src.split("ThemeEntry(")[1:]:
        raw = re.search(r"id:\s*('(\w+)'|(\w+))", chunk)
        theme_id = raw.group(2) or named[raw.group(3)]
        palette[theme_id] = (rgb(chunk, "background"), rgb(chunk, "placed"))
    return palette


PALETTE = _theme_palette()

# stem -> (layout, theme, source capture, keep the header band above the board)
#
# The order is the pitch (owner, 09.11.2026: the pets go on the pictures):
# what is different (1), what it feels like (2), what there is to collect
# (3 to 5), and why to come back and stay (6 to 8).
#
# The header carries score and best. Only the Daily Challenge takes it: there
# the booster bar is hidden and the band above the board crops clean — and it
# is where the Qubbie sits when it is not in the air.
FRAMES = [
    ("1-qubbie", "hero", "classic", "qubbie", False),
    ("2-clear", "hero", "candy", "clear", False),
    ("3-qubbies", "roster", "aurora", None, False),
    ("4-designs", "mosaic", "sunset", None, False),
    ("5-skins", "skins", "forest", None, False),
    ("6-daily", "hero", "glacier", "daily", True),
    ("7-puzzle", "screen", "wood", "puzzle", False),
    ("8-offline", "statement", "classic", "home", False),
]

# Top of the header band, in capture pixels: below the coin chip, above SCORE.
HEADER_TOP = 125

# The tiles of the design frames, in reading order. Raw captures from
# tool/generate_screenshots.dart; their labels are the names the app shows
# (store-assets/raw/<locale>/designs.json), never typed in here.
MOSAIC = [f"look-{i}" for i in range(1, 10)]
SKIN_TILES = ["jelly", "crystal", "marble", "prism", "plasma", "fizz",
              "pixel", "liquid", "stardust"]
# The Qubbies in the order of the catalog (lib/game/pet.dart): the three
# starters, the premium ones, the legendary one.
PET_TILES = ["kiki", "bit", "glim", "frosti", "optik", "zapp", "funki",
             "prisma", "pyra"]
# What frame 2 shows, named under the headline (generate_screenshots.dart).
CLEAR_LOOK = {"theme": "candy", "skin": "jelly", "burst": "confetti"}
# The Qubbie a gameplay frame shows again, large, in the space under the
# board: it is the one flying in that capture. At thumbnail size the one on
# the board is a few pixels; this one is what a browser sees.
MASCOT = {"1-qubbie": "funki", "2-clear": "kiki"}

# Every claim here has to survive a reading of the code, because a screenshot
# that overstates the app is a Misrepresentation case, not a marketing choice
# (test/store_claims_test.dart reads this file).
#
# * "play along": a Qubbie flies along a cleared line and never touches score
#   or pieces (lib/ui/state/pet_controller.dart). No frame says it helps.
# * "{pets} Qubbies", "after run {firstEggAfterRuns}": filled from the catalog
#   by the generator, like every other number.
# * "solution": PuzzleGenerator builds each level solvable by construction and
#   the solver verifies it (lib/game/puzzle.dart).
# * "One move" rather than "one tap": pieces are dragged.
# * No frame says free, best or number one (Google's metadata policy), and
#   none looks or reads like a children's app: the board stays the largest
#   thing in every gameplay frame (docs/HAUSTIERE.md §8.1).
CAPTIONS = {
    "en": {
        "1-qubbie": ("Pets that\nplay along.", "Clear a line and your Qubbie flies in"),
        "2-clear": ("Fill a line.\nWatch it blow.", "Shown:"),
        "3-qubbies": ("{pets} Qubbies\nto hatch", "Your first one comes after run {firstEggAfterRuns}"),
        "4-designs": ("Your board.\nYour style.", "Mix and match themes, skins and accessories"),
        "5-skins": ("{skins} block skins", "{animated} of them are animated"),
        "6-daily": ("A new board\nevery day", "Same puzzle for everyone. Build a streak."),
        "7-puzzle": ("Every puzzle\nhas a solution", "Checked by the solver, not left to chance"),
        "8-offline": ("No forced ads.\nEver.", "No sign-up, no interruptions. Plays on a plane."),
    },
    "de": {
        "1-qubbie": ("Haustiere, die\nmitspielen.", "Räum eine Reihe, und dein Qubbie fliegt los"),
        "2-clear": ("Reihe voll.\nReihe weg.", "Im Bild:"),
        "3-qubbies": ("{pets} Qubbies\nzum Ausbrüten", "Dein erstes kommt nach Runde {firstEggAfterRuns}"),
        "4-designs": ("Dein Brett.\nDein Stil.", "Themes, Skins und Zubehör nach Lust kombinieren"),
        "5-skins": ("{skins} Block-Skins", "{animated} davon sind animiert"),
        "6-daily": ("Jeden Tag\nein neues Brett", "Für alle dasselbe Puzzle. Bau deine Serie."),
        "7-puzzle": ("Jedes Rätsel\nist lösbar", "Vom Löser geprüft, nicht dem Zufall überlassen"),
        "8-offline": ("Keine Zwangs-\nwerbung.", "Keine Anmeldung, keine Unterbrechung. Läuft im Flugzeug."),
    },
    "es": {
        "1-qubbie": ("Mascotas que\njuegan contigo.", "Limpia una fila y tu Qubbie sale volando"),
        "2-clear": ("Llena una fila.\nMira cómo estalla.", "En la imagen:"),
        "3-qubbies": ("{pets} Qubbies\npara criar", "El primero llega tras la partida {firstEggAfterRuns}"),
        "4-designs": ("Tu tablero.\nTu estilo.", "Combina temas, skins y accesorios a tu gusto"),
        "5-skins": ("{skins} skins de bloques", "{animated} tienen animación"),
        "6-daily": ("Un tablero nuevo\ncada día", "El mismo desafío para todos. Construye tu racha."),
        "7-puzzle": ("Cada rompecabezas\ntiene solución", "Verificado por el solucionador, no por azar"),
        "8-offline": ("Sin anuncios\nobligatorios. Nunca.", "Sin registro, sin interrupciones. Se juega en el avión."),
    },
    "pt": {
        "1-qubbie": ("Mascotes que\njogam junto.", "Limpe uma fileira e seu Qubbie sai voando"),
        "2-clear": ("Complete a fileira.\nVeja explodir.", "Na imagem:"),
        "3-qubbies": ("{pets} Qubbies\npara criar", "O primeiro chega depois da partida {firstEggAfterRuns}"),
        "4-designs": ("Seu tabuleiro.\nSeu estilo.", "Combine temas, skins e acessórios do seu jeito"),
        "5-skins": ("{skins} skins de blocos", "{animated} delas são animadas"),
        "6-daily": ("Um tabuleiro novo\ntodo dia", "O mesmo desafio para todos. Crie sua sequência."),
        "7-puzzle": ("Todo quebra-cabeça\ntem solução", "Verificado pelo solucionador, não pela sorte"),
        "8-offline": ("Sem anúncios\nobrigatórios. Nunca.", "Sem cadastro, sem interrupções. Funciona no avião."),
    },
}

# The three proof lines of the last frame. Each is a fact about the build:
# the game runs without a connection (CLAUDE.md, "komplett offline"), nothing
# asks for an account (the leaderboard name is optional), and no video starts
# without a tap (rewarded only — lib/monetization/ads.dart).
PROOF = {
    "en": ["Plays fully offline", "No account needed", "Videos only when you tap them"],
    "de": ["Komplett offline", "Kein Konto nötig", "Videos nur, wenn du sie antippst"],
    "es": ["Se juega sin conexión", "No hace falta cuenta", "Videos solo si tú los tocas"],
    "pt": ["Totalmente offline", "Não precisa de conta", "Vídeos só quando você toca"],
}

# The numbers the captions were written for. They come from the catalogs
# (designs.json); when one changes, a number word next to it may have to
# change with it ("1 Qubbie" is not "1 Qubbies"), so the build stops until
# the captions have been read again.
WRITTEN_FOR = {"themes": 11, "skins": 22, "animated": 11, "accessories": 6,
               "bursts": 6, "pets": 9, "firstEggAfterRuns": 3}


def text_length(draw, text: str, font) -> float:
    return draw.textlength(text, font=font)


def draw_text(draw, xy, text: str, font, fill) -> None:
    draw.text(xy, text, font=font, fill=fill)


def _weighted(size: int, weight: int) -> ImageFont.FreeTypeFont:
    """Nunito at an explicit weight on its variable-font axis."""
    font = ImageFont.truetype(FONT, size)
    try:
        font.set_variation_by_axes([weight])
    except (AttributeError, OSError):
        pass  # Static build of the font, or a Pillow without variation support.
    return font


def _mix(a, b, t):
    return tuple(round(a[i] + (b[i] - a[i]) * t) for i in range(3))


def plate(stem: str, theme: str) -> Image.Image:
    """The background behind everything.

    A picture at `store-assets/plates/<stem>.png` wins; otherwise build one
    from the theme's own background colour: a vertical gradient with a wide,
    soft glow in the accent colour sitting where the board will land, so the
    board reads as lit rather than pasted onto a flat field.
    """
    external = os.path.join(PLATE_DIR, f"{stem}.png")
    if os.path.exists(external):
        img = Image.open(external).convert("RGB")
        return img.resize((W, H), Image.LANCZOS) if img.size != (W, H) else img

    base, accent = PALETTE[theme]
    top = _mix(base, (0, 0, 0), 0.35)
    bottom = _mix(base, (255, 255, 255), 0.06)
    column = Image.new("RGB", (1, H))
    px = column.load()
    for y in range(H):
        px[0, y] = _mix(top, bottom, y / (H - 1))
    canvas = column.resize((W, H), Image.BILINEAR)

    # Soft accent glow, low opacity — enough to lift the board off the plate
    # without turning the frame into a light show.
    glow = Image.new("RGB", (W, H), (0, 0, 0))
    ImageDraw.Draw(glow).ellipse(
        [(-W * 0.20, H * 0.28), (W * 1.20, H * 0.94)], fill=accent
    )
    glow = glow.filter(ImageFilter.GaussianBlur(190))
    return Image.blend(canvas, Image.blend(canvas, glow, 0.22), 1.0)


def board_rect(locale: str, stem: str) -> tuple[int, int, int, int] | None:
    """The board's pixel rect, as measured by the generator."""
    path = os.path.join(RAW_DIR, locale, f"{stem}.json")
    if not os.path.exists(path):
        return None
    r = json.load(open(path))
    return (r["x"], r["y"], r["w"], r["h"])


def crop_board(
    img: Image.Image, rect, pad_ratio: float = 0.06, header: bool = False,
    pad_top: float | None = None,
) -> Image.Image:
    """The board plus a little of its surroundings.

    The particle burst throws well past the board's own edge; cropping tight to
    the rect would slice the celebration in half. With [header] the crop starts
    high enough to take the score row in as one contiguous piece of the real
    screen — nothing is cut out of the middle — and with it the Qubbie that
    sits on the board's top edge.
    """
    x, y, w, h = rect
    pad = round(w * pad_ratio)
    # [pad_top] keeps the crop below the bars that sit right above the board.
    above = pad if pad_top is None else round(w * pad_top)
    top = HEADER_TOP if header else max(0, y - above)
    # Less room below than above: the tray sits directly under the board, and a
    # symmetric pad slices the top off its pieces, which looks like a rendering
    # fault rather than a crop.
    bottom = min(img.height, y + h + round(pad * 0.45))
    box = (
        max(0, x - pad),
        min(top, max(0, y - above)),
        min(img.width, x + w + pad),
        bottom,
    )
    return img.crop(box)


def rounded(img: Image.Image, radius: int) -> Image.Image:
    mask = Image.new("L", img.size, 0)
    ImageDraw.Draw(mask).rounded_rectangle(
        [(0, 0), (img.width - 1, img.height - 1)], radius=radius, fill=255
    )
    out = img.convert("RGBA")
    out.putalpha(mask)
    return out


def shadow_paste(canvas: Image.Image, art: Image.Image, x: int, y: int, radius: int):
    """Drops [art] onto [canvas] with a soft contact shadow underneath."""
    shadow = Image.new("RGBA", canvas.size, (0, 0, 0, 0))
    ImageDraw.Draw(shadow).rounded_rectangle(
        [(x, y + 20), (x + art.width, y + art.height + 20)],
        radius=radius,
        fill=(0, 0, 0, 150),
    )
    canvas = Image.alpha_composite(
        canvas.convert("RGBA"), shadow.filter(ImageFilter.GaussianBlur(30))
    )
    canvas.paste(art, (x, y), art)
    return canvas


def wrap(draw, text: str, font, max_width: int) -> list[str]:
    """Greedy word wrap, honouring explicit newlines in the caption."""
    lines = []
    for paragraph in text.split("\n"):
        line = ""
        for word in paragraph.split():
            probe = f"{line} {word}".strip()
            if text_length(draw, probe, font) <= max_width or not line:
                line = probe
            else:
                lines.append(line)
                line = word
        lines.append(line)
    return lines


def draw_caption(canvas, headline, subline, accent, size=118):
    """Headline block at the top, with an accent rule under it.

    Top-stacked and large on purpose: most people only ever see the frame as a
    ~200 px thumbnail, where a bottom caption in body-copy sizes is a grey
    smudge. Shrinks the type rather than breaking a line the copy did not.
    """
    draw = ImageDraw.Draw(canvas)
    # The copy sets its own line breaks. Another one from the wrap leaves a
    # word dangling on a line of its own and pushes the art down, so the type
    # shrinks first, and past the smallest size the copy has to get shorter.
    written = headline.count("\n") + 1
    while size > 56:
        font = _weighted(size, HEADLINE_WEIGHT)
        lines = wrap(draw, headline, font, W - 2 * MARGIN)
        if len(lines) <= written:
            break
        size -= 6
    font = _weighted(size, HEADLINE_WEIGHT)
    lines = wrap(draw, headline, font, W - 2 * MARGIN)
    if len(lines) > written:
        sys.exit(f"{headline!r} wraps to {len(lines)} lines, written as "
                 f"{written} — shorten it in CAPTIONS")

    y = 96
    for line in lines:
        draw_text(draw, (MARGIN, y), line, font, TEXT)
        y += round(size * 1.1)

    y += 18
    sub_font = _weighted(44, SUB_WEIGHT)
    for line in wrap(draw, subline, sub_font, W - 2 * MARGIN):
        draw_text(draw, (MARGIN, y), line, sub_font, MUTED)
        y += 58

    y += 26
    draw.rounded_rectangle([(MARGIN, y), (MARGIN + 148, y + 8)], radius=4, fill=accent)
    return y + 8


def fit(art: Image.Image, max_w: int, max_h: int) -> Image.Image:
    scale = min(max_w / art.width, max_h / art.height)
    return art.resize((round(art.width * scale), round(art.height * scale)), Image.LANCZOS)


def place_y(top: int, floor: int, height: int) -> int:
    """Where the art sits in the space the caption leaves.

    A third of the slack above and two thirds below rather than centring it:
    the caption block already carries its own trailing whitespace, so dead
    centre reads as a gap between the headline and the thing it describes.
    """
    return top + max(0, (floor - top - height)) // 3


def portrait(pet_id: str) -> Image.Image:
    """A Qubbie drawn by the app, cut to its own outline."""
    path = os.path.join(RAW_DIR, "en", f"pet-{pet_id}.png")
    if not os.path.exists(path):
        sys.exit(f"missing portrait {path} — run tool/generate_screenshots.dart")
    img = Image.open(path).convert("RGBA")
    return img.crop(img.getbbox())


def hero(canvas, capture, rect, accent, headline, subline, header=False,
         mascot=None):
    """Board crop, as large as the frame allows.

    Near the full width on purpose: the board is what a browser is judging, and
    at thumbnail size a comfortable margin costs more than it buys. With
    [mascot] as (portrait, name, line) the Qubbie of the capture stands large
    in the corner under the board, with its name and what it does.
    """
    bottom = draw_caption(canvas, headline, subline, accent)
    top = bottom + 52
    floor = H - (300 if mascot else 70)
    art = crop_board(capture, rect, header=header,
                     pad_top=None if header else 0.025)
    art = rounded(fit(art, W - 2 * 24, floor - top), 40)
    y = place_y(top, floor, art.height) if not mascot else top
    canvas = shadow_paste(canvas, art, (W - art.width) // 2, y, 40)
    if not mascot:
        return canvas

    figure, name, line = mascot
    board_bottom = y + art.height
    # It stands on the frame's bottom edge and reaches up over the board's.
    figure = fit(figure, 470, H - 40 - (board_bottom - 110))
    fx = W - 44 - figure.width
    fy = H - 44 - figure.height
    glow = Image.new("RGBA", canvas.size, (0, 0, 0, 0))
    ImageDraw.Draw(glow).ellipse(
        [(fx - 30, fy + figure.height * 0.25),
         (fx + figure.width + 30, fy + figure.height + 30)],
        fill=(*accent, 90),
    )
    canvas = Image.alpha_composite(canvas, glow.filter(ImageFilter.GaussianBlur(60)))
    canvas.alpha_composite(figure, (fx, fy))

    draw = ImageDraw.Draw(canvas)
    room = fx - MARGIN - 28
    name_font = _fitted_font(draw, name, 84, 900, room)
    ty = board_bottom + (H - board_bottom - 84 - 58 - 20) // 2
    draw_text(draw, (MARGIN, ty), name, name_font, TEXT)
    line_font = _weighted(40, SUB_WEIGHT)
    ly = ty + 104
    for part in wrap(draw, line, line_font, room):
        draw_text(draw, (MARGIN, ly), part, line_font, MUTED)
        ly += 52
    return canvas


def screen(canvas, capture, accent, headline, subline):
    """Whole screen, for the modes whose layout is the point."""
    bottom = draw_caption(canvas, headline, subline, accent)
    top, floor = bottom + 56, H - 70
    art = fit(capture, W - 2 * 96, floor - top)
    art = rounded(art, 44)
    y = place_y(top, floor, art.height)
    return shadow_paste(canvas, art, (W - art.width) // 2, y, 44)


def _fitted_font(draw, text: str, size: int, weight: int, max_w: int):
    """The font for [text] at [size], shrunk until it fits [max_w]."""
    font = _weighted(size, weight)
    while size > 18 and text_length(draw, text, font) > max_w:
        size -= 2
        font = _weighted(size, weight)
    return font


def _tile_grid(canvas, tiles, labels, cols, top, floor, side=40, gap=26,
               below=0, label_size=32, label_fill=MUTED):
    """Lays [tiles] out in a grid between [top] and [floor], each with its
    label centred underneath (or none), leaving [below] pixels under the grid
    for whatever follows it. Returns the canvas and the grid's bottom edge."""
    rows = -(-len(tiles) // cols)
    label_h = round(label_size * 1.8) if labels else 0
    aspect = tiles[0].height / tiles[0].width
    cell_w = (W - 2 * side - (cols - 1) * gap) // cols
    cell_w = min(cell_w, int((floor - top - below - (rows - 1) * gap
                              - rows * label_h) / rows / aspect))
    cell_h = round(cell_w * aspect)
    block_w = cols * cell_w + (cols - 1) * gap
    block_h = rows * (cell_h + label_h) + (rows - 1) * gap
    x0 = (W - block_w) // 2
    y0 = place_y(top, floor, block_h + below)
    for i, tile in enumerate(tiles):
        art = rounded(tile.resize((cell_w, cell_h), Image.LANCZOS), 24)
        x = x0 + (i % cols) * (cell_w + gap)
        y = y0 + (i // cols) * (cell_h + label_h + gap)
        canvas = shadow_paste(canvas, art, x, y, 24)
        if labels:
            draw = ImageDraw.Draw(canvas)
            label = labels[i]
            font = _fitted_font(draw, label, label_size, HEADLINE_WEIGHT, cell_w)
            lx = x + (cell_w - text_length(draw, label, font)) / 2
            draw_text(draw, (lx, y + cell_h + 12), label, font, label_fill)
    return canvas, y0 + block_h


def grid(canvas, tiles, labels, cols, accent, headline, subline):
    """Real boards, one design each, with the app's name for it underneath."""
    bottom = draw_caption(canvas, headline, subline, accent)
    canvas, _ = _tile_grid(canvas, tiles, labels, cols, bottom + 56, H - 70)
    return canvas


def roster(canvas, tiles, labels, accent, headline, subline):
    """The nine Qubbies, each on a card of its own, under its name."""
    bottom = draw_caption(canvas, headline, subline, accent)
    canvas, _ = _tile_grid(canvas, tiles, labels, 3, bottom + 56, H - 70,
                           side=44, gap=22, label_size=38, label_fill=TEXT)
    return canvas


def mosaic(canvas, tiles, facts, accent, headline, subline):
    """Nine whole looks — theme, skin and accessory together — and the
    catalog sizes underneath, labelled with the Designs screen's own tab
    names."""
    bottom = draw_caption(canvas, headline, subline, accent)
    stats_h = 150
    canvas, grid_bottom = _tile_grid(canvas, tiles, None, 3, bottom + 48, H - 60,
                                     side=36, gap=18, below=56 + stats_h)
    draw = ImageDraw.Draw(canvas)
    counts, tabs = facts["counts"], facts["tabs"]
    items = [(counts[k], tabs[k]) for k in ("themes", "skins", "accessories", "bursts")]
    col_w = (W - 2 * 36) // len(items)
    y = grid_bottom + 56
    number_font = _weighted(80, 900)
    for i, (count, label) in enumerate(items):
        cx = 36 + i * col_w + col_w / 2
        number = str(count)
        draw_text(draw, (cx - text_length(draw, number, number_font) / 2, y),
                  number, number_font, accent)
        # A long tab name takes a second line rather than shrinking to a size
        # nobody can read in a thumbnail.
        size, lines = 32, [label]
        font = _weighted(size, HEADLINE_WEIGHT)
        while size > 28 and text_length(draw, label, font) > col_w - 16:
            size -= 2
            font = _weighted(size, HEADLINE_WEIGHT)
        if text_length(draw, label, font) > col_w - 16:
            lines = wrap(draw, label, font, col_w - 16)
        for n, line in enumerate(lines):
            line_font = _fitted_font(draw, line, size, HEADLINE_WEIGHT, col_w - 16)
            draw_text(draw, (cx - text_length(draw, line, line_font) / 2,
                             y + 100 + n * round(size * 1.3)),
                      line, line_font, TEXT)
    return canvas


def statement(canvas, capture, rect, accent, headline, subline, proof):
    """The differentiator frame: big claim, three proof lines, smaller art.

    Qubble does not interrupt you. That deserves its own composition rather
    than a caption bolted onto another board shot.
    """
    bottom = draw_caption(canvas, headline, subline, accent, size=96)
    draw = ImageDraw.Draw(canvas)
    y = bottom + 64
    line_font = _weighted(40, SUB_WEIGHT)
    for item in proof:
        draw.ellipse([(MARGIN, y + 12), (MARGIN + 18, y + 30)], fill=accent)
        draw_text(draw, (MARGIN + 40, y), item, line_font, TEXT)
        y += 68

    art = crop_board(capture, rect) if rect else capture
    top, floor = y + 52, H - 60
    art = fit(art, W - 2 * 104, floor - top)
    art = rounded(art, 40)
    y = place_y(top, floor, art.height)
    return shadow_paste(canvas, art, (W - art.width) // 2, y, 40)


def design_facts(locale: str) -> dict:
    """Counts and app names, as the generator wrote them for [locale]."""
    return json.load(open(os.path.join(RAW_DIR, locale, "designs.json"),
                          encoding="utf-8"))


def _fill(text: str, facts: dict) -> str:
    """Puts the counts and app names into a caption."""
    tables = {"theme": "themes", "skin": "skins", "burst": "bursts",
              "accessory": "accessories"}
    text = re.sub(r"\{(theme|skin|burst|accessory):(\w+)\}",
                  lambda m: facts[tables[m.group(1)]][m.group(2)], text)
    return text.format(**facts["counts"])


def frame_captions(locale: str, facts: dict) -> dict[str, tuple[str, str]]:
    """Headline and subline of every frame in FRAMES, filled in."""
    captions = dict(CAPTIONS[locale])
    # Frame 2 names the look it shows, in the app's own words.
    look = " · ".join(
        f"{{{kind}:{CLEAR_LOOK[kind]}}}" for kind in ("theme", "skin", "burst")
    )
    headline, shown = captions["2-clear"]
    captions["2-clear"] = (headline, f"{shown} {look}")
    return {stem: (_fill(h, facts), _fill(s, facts))
            for stem, (h, s) in captions.items()}


def tile(stem: str) -> Image.Image:
    """A board-only capture, cropped to the board."""
    path = os.path.join(RAW_DIR, "en", f"{stem}.png")
    if not os.path.exists(path):
        sys.exit(f"missing design tile {path} — run tool/generate_screenshots.dart")
    img = Image.open(path).convert("RGB")
    return crop_board(img, board_rect("en", stem), pad_ratio=0.02)


def pet_card(pet_id: str, theme: str) -> Image.Image:
    """A Qubbie's portrait from the app, on a card in the frame's colours."""
    figure = portrait(pet_id)
    base, accent = PALETTE[theme]
    side = 600
    card = Image.new("RGB", (side, side), _mix(base, (255, 255, 255), 0.07))
    # A soft light behind it, so a dark Qubbie does not sink into the card.
    glow = Image.new("RGB", (side, side), _mix(base, (255, 255, 255), 0.07))
    ImageDraw.Draw(glow).ellipse(
        [(side * 0.12, side * 0.16), (side * 0.88, side * 0.92)],
        fill=_mix(accent, (255, 255, 255), 0.25),
    )
    card = Image.blend(card, glow.filter(ImageFilter.GaussianBlur(70)), 0.34)
    art = fit(figure, round(side * 0.94), round(side * 0.74))
    card = card.convert("RGBA")
    card.alpha_composite(art, ((side - art.width) // 2,
                               round(side * 0.90) - art.height))
    return card


def build(locale: str) -> int:
    raw = os.path.join(RAW_DIR, locale)
    if not os.path.isdir(raw):
        print(f"skipping {locale}: no captures in {raw}")
        return 0
    facts = design_facts(locale)
    if facts["counts"] != WRITTEN_FOR:
        sys.exit(f"the catalogs now have {facts['counts']}, the captions were "
                 f"written for {WRITTEN_FOR}: read every CAPTIONS line whose "
                 "wording depends on a number, then update WRITTEN_FOR")
    captions = frame_captions(locale, facts)

    made = 0
    for stem, layout, theme, source, header in FRAMES:
        headline, subline = captions[stem]
        _, accent = PALETTE[theme]
        canvas = plate(stem, theme).convert("RGBA")

        if layout == "mosaic":
            canvas = mosaic(canvas, [tile(t) for t in MOSAIC], facts, accent,
                            headline, subline)
        elif layout == "skins":
            canvas = grid(canvas, [tile(f"skin-{t}") for t in SKIN_TILES],
                          [facts["skins"][t] for t in SKIN_TILES], 3, accent,
                          headline, subline)
        elif layout == "roster":
            canvas = roster(canvas, [pet_card(p, theme) for p in PET_TILES],
                            [facts["pets"][p] for p in PET_TILES], accent,
                            headline, subline)
        else:
            path = os.path.join(raw, f"{source}.png")
            if not os.path.exists(path):
                print(f"  ! missing capture {path}", file=sys.stderr)
                return 1
            capture = Image.open(path).convert("RGB")
            rect = board_rect(locale, source)
            if layout == "hero":
                if rect is None:
                    print(f"  ! no board rect for {source}", file=sys.stderr)
                    return 1
                pet = MASCOT.get(stem)
                canvas = hero(
                    canvas, capture, rect, accent, headline, subline, header,
                    mascot=None if pet is None else (
                        portrait(pet), facts["pets"][pet], facts["petLines"][pet]
                    ),
                )
            elif layout == "screen":
                canvas = screen(canvas, capture, accent, headline, subline)
            else:
                canvas = statement(canvas, capture, rect, accent, headline,
                                   subline, PROOF[locale])

        out = os.path.join(OUT_DIR, locale, f"screenshot-{stem}.png")
        os.makedirs(os.path.dirname(out), exist_ok=True)
        # Play rejects screenshots with an alpha channel.
        canvas.convert("RGB").save(out, "PNG", optimize=True)
        print(f"  ✓ {out}")
        made += 1
    return 0 if made else 1


def main() -> int:
    if not os.path.isdir(RAW_DIR):
        print(
            f"{RAW_DIR} is missing — run "
            "`flutter test tool/generate_screenshots.dart` first.",
            file=sys.stderr,
        )
        return 1
    # `python3 tool/caption_screenshots.py es` frames only that locale.
    wanted = sys.argv[1:] or list(CAPTIONS)
    for locale in wanted:
        print(f"\nFraming {locale} screenshots …")
        if build(locale):
            return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
