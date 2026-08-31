#!/usr/bin/env python3
"""Turns the raw app captures into finished Play Store screenshots.

    flutter test tool/generate_screenshots.dart   # writes store-assets/raw/<locale>/
    python3 tool/caption_screenshots.py           # writes store-assets/<locale>/

Two things drive the design, both from looking at what the frames were actually
selling:

1. **Crop to the board.** The old frames shrank the whole 360x640 screen into a
   card, so a block ended up ~16 px wide in the search-results thumbnail that
   most people ever see. The board is the product; it gets the room. The
   generator writes the exact board rect next to each PNG (it is not the same
   size on every screen), so the crop is measured, not guessed.

2. **Show the clear.** The captures are taken mid-burst, so these frames carry
   particles, a floating score and a lit combo instead of a settled board.

The background is a plate. By default it is generated here from the theme's own
palette; if `store-assets/plates/<stem>.png` exists it is used instead, which is
where an image model's output goes. The app UI itself is never repainted —
Play's store-listing policy wants screenshots that depict the real app, so the
pixels of the board come from the app and nothing else.

Requires Pillow (`pip install Pillow`) and the app font in assets/fonts.
"""

from __future__ import annotations

import json
import os
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

# Straight from lib/ui/theme.dart, so every frame agrees with the app it shows.
PALETTE = {
    "classic": ((0x0F, 0x10, 0x30), (0x4F, 0xE0, 0xC6)),
    "neon": ((0x07, 0x07, 0x0C), (0x39, 0xFF, 0x14)),
    "ocean": ((0x06, 0x26, 0x3A), (0x35, 0xD0, 0xBA)),
    "wood": ((0x24, 0x18, 0x11), (0xD9, 0xA0, 0x5B)),
    "sunset": ((0x1E, 0x10, 0x30), (0xFF, 0x7E, 0x5F)),
    "forest": ((0x0C, 0x1F, 0x14), (0x7B, 0xE3, 0x82)),
}

# stem -> (layout, theme, source capture, keep the header band above the board)
#
# The header carries score and best. Only the Daily Challenge takes it: every
# other mode draws a full-width "New pieces (video)" button between the header
# and the board, and a crop that reaches up for the score has to bring that
# along — a video call-to-action is the last thing frame 2 should be selling.
# The Daily hides it (game_screen.dart gates it on `!isDaily`), so there the
# score row crops clean. The rest read better tight to the board anyway, where
# the blocks are twice the size in a search thumbnail.
FRAMES = [
    ("1-clear", "hero", "classic", "1-clear", False),
    ("2-combo", "hero", "neon", "2-combo", False),
    ("3-daily", "hero", "ocean", "3-daily", True),
    ("4-themes", "collage", "sunset", None, False),
    ("5-puzzle", "screen", "wood", "4-puzzle", False),
    ("6-offline", "statement", "classic", "6-home", False),
]

# Top of the header band, in capture pixels: below the coin chip, above SCORE.
HEADER_TOP = 125

# The 2x2 tiles for the collage frame, in reading order.
COLLAGE = ["theme-classic", "theme-neon", "theme-sunset", "theme-forest"]
COLLAGE_LABELS = ["Classic", "Neon", "Sunset", "Forest"]

# Every claim here has to survive a reading of the code, because a screenshot
# that overstates the app is a Misrepresentation case, not a marketing choice.
# "solvable" is safe: PuzzleGenerator builds each level solvable by
# construction and the solver verifies it (lib/game/puzzle.dart). "One move"
# rather than "one tap": pieces are dragged.
CAPTIONS = {
    "en": {
        "1-clear": ("Fill a line.\nWatch it blow.", "One move, one satisfying clear"),
        "2-combo": ("Clear a column.\nThen chain it.", "Combos multiply everything you clear"),
        "3-daily": ("A new board\nevery day", "Same puzzle for everyone. Build a streak."),
        "4-themes": ("Eight themes.\nPick your mood.", "Wood, neon, ocean, forest and more"),
        "5-puzzle": ("Every puzzle\nhas a solution", "Checked by the solver, not left to chance"),
        "6-offline": ("No forced ads.\nEver.", "No account. No server. Plays on a plane."),
    },
    "de": {
        "1-clear": ("Reihe voll.\nReihe weg.", "Ein Zug, ein befriedigendes Clear"),
        "2-combo": ("Spalte weg.\nDann verketten.", "Combos vervielfachen jedes Clear"),
        "3-daily": ("Jeden Tag\nein neues Board", "Für alle dasselbe Puzzle. Bau deinen Streak."),
        "4-themes": ("Acht Themes.\nDeine Stimmung.", "Holz, Neon, Ozean, Wald und mehr"),
        "5-puzzle": ("Jedes Rätsel\nist lösbar", "Vom Solver geprüft, nicht dem Zufall überlassen"),
        "6-offline": ("Keine Zwangs-\nwerbung.", "Kein Konto. Kein Server. Läuft im Flugzeug."),
    },
}

# The three proof lines on the statement frame.
PROOF = {
    "en": ["Plays fully offline", "No account, ever", "Your data stays on the phone"],
    "de": ["Komplett offline", "Nie ein Konto nötig", "Daten bleiben auf dem Handy"],
}


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

    An image model's output at `store-assets/plates/<stem>.png` wins; otherwise
    build one from the theme's own background colour: a vertical gradient with a
    wide, soft glow in the accent colour sitting where the board will land, so
    the board reads as lit rather than pasted onto a flat field.
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
    img: Image.Image, rect, pad_ratio: float = 0.06, header: bool = False
) -> Image.Image:
    """The board plus a little of its surroundings.

    The particle burst throws well past the board's own edge; cropping tight to
    the rect would slice the celebration in half. With [header] the crop starts
    high enough to take the score row in as one contiguous piece of the real
    screen — nothing is cut out of the middle.
    """
    x, y, w, h = rect
    pad = round(w * pad_ratio)
    top = HEADER_TOP if header else max(0, y - pad)
    # Less room below than above: the tray sits directly under the board, and a
    # symmetric pad slices the top off its pieces, which looks like a rendering
    # fault rather than a crop.
    bottom = min(img.height, y + h + round(pad * 0.45))
    box = (
        max(0, x - pad),
        min(top, max(0, y - pad)),
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
            if draw.textlength(probe, font=font) <= max_width or not line:
                line = probe
            else:
                lines.append(line)
                line = word
        lines.append(line)
    return lines


def draw_caption(canvas, headline, subline, accent, size=88):
    """Headline block at the top, with an accent rule under it.

    Top-stacked and large on purpose: most people only ever see the frame as a
    ~200 px thumbnail, where a bottom caption in body-copy sizes is a grey
    smudge. Shrinks the type rather than spilling past three lines.
    """
    draw = ImageDraw.Draw(canvas)
    while size > 56:
        font = _weighted(size, HEADLINE_WEIGHT)
        lines = wrap(draw, headline, font, W - 2 * MARGIN)
        if len(lines) <= 3:
            break
        size -= 6
    font = _weighted(size, HEADLINE_WEIGHT)
    lines = wrap(draw, headline, font, W - 2 * MARGIN)

    y = 108
    for line in lines:
        draw.text((MARGIN, y), line, font=font, fill=TEXT)
        y += round(size * 1.14)

    y += 14
    sub_font = _weighted(38, SUB_WEIGHT)
    for line in wrap(draw, subline, sub_font, W - 2 * MARGIN):
        draw.text((MARGIN, y), line, font=sub_font, fill=MUTED)
        y += 50

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


def hero(canvas, capture, rect, accent, headline, subline, header=False):
    """Board crop, as large as the frame allows.

    Near the full width on purpose: the board is what a browser is judging, and
    at thumbnail size a comfortable margin costs more than it buys.
    """
    bottom = draw_caption(canvas, headline, subline, accent)
    top, floor = bottom + 60, H - 70
    art = fit(crop_board(capture, rect, header=header), W - 2 * 24, floor - top)
    art = rounded(art, 40)
    y = place_y(top, floor, art.height)
    return shadow_paste(canvas, art, (W - art.width) // 2, y, 40)


def screen(canvas, capture, accent, headline, subline):
    """Whole screen, for the modes whose layout is the point."""
    bottom = draw_caption(canvas, headline, subline, accent)
    top, floor = bottom + 56, H - 70
    art = fit(capture, W - 2 * 96, floor - top)
    art = rounded(art, 44)
    y = place_y(top, floor, art.height)
    return shadow_paste(canvas, art, (W - art.width) // 2, y, 44)


def collage(canvas, tiles, accent, headline, subline):
    """Four real boards, one per theme, tiled 2x2.

    Replaces the old theme frame, which was a screenshot of the settings list —
    five "Tap to activate" rows, selling a menu instead of a game.
    """
    bottom = draw_caption(canvas, headline, subline, accent)
    gap, label_gap = 26, 56
    side = 40
    top, floor = bottom + 56, H - 70
    cell = min(
        (W - 2 * side - gap) // 2,
        (floor - top - gap - 2 * label_gap) // 2,
    )
    block_w = 2 * cell + gap
    block_h = 2 * (cell + label_gap) + gap
    x0 = (W - block_w) // 2
    y0 = place_y(top, floor, block_h)
    label_font = _weighted(34, HEADLINE_WEIGHT)
    for i, (tile, label) in enumerate(zip(tiles, COLLAGE_LABELS)):
        art = rounded(tile.resize((cell, cell), Image.LANCZOS), 26)
        x = x0 + (i % 2) * (cell + gap)
        y = y0 + (i // 2) * (cell + label_gap + gap)
        canvas = shadow_paste(canvas, art, x, y, 26)
        ImageDraw.Draw(canvas).text(
            (x + 4, y + cell + 12), label, font=label_font, fill=MUTED
        )
    return canvas


def statement(canvas, capture, rect, accent, headline, subline, proof):
    """The differentiator frame: big claim, three proof lines, smaller art.

    Qubble's one advantage over the top of this genre is that it does not
    interrupt you. That deserves its own composition rather than a caption
    bolted onto another board shot.
    """
    bottom = draw_caption(canvas, headline, subline, accent, size=96)
    draw = ImageDraw.Draw(canvas)
    y = bottom + 64
    line_font = _weighted(40, SUB_WEIGHT)
    for item in proof:
        draw.ellipse([(MARGIN, y + 12), (MARGIN + 18, y + 30)], fill=accent)
        draw.text((MARGIN + 40, y), item, font=line_font, fill=TEXT)
        y += 68

    art = crop_board(capture, rect) if rect else capture
    top, floor = y + 52, H - 60
    art = fit(art, W - 2 * 104, floor - top)
    art = rounded(art, 40)
    y = place_y(top, floor, art.height)
    return shadow_paste(canvas, art, (W - art.width) // 2, y, 40)


def build(locale: str) -> int:
    raw = os.path.join(RAW_DIR, locale)
    if not os.path.isdir(raw):
        print(f"skipping {locale}: no captures in {raw}")
        return 0

    tiles = []
    for stem in COLLAGE:
        path = os.path.join(RAW_DIR, "en", f"{stem}.png")
        if not os.path.exists(path):
            print(f"  ! missing collage tile {path}", file=sys.stderr)
            return 1
        rect = board_rect("en", stem)
        img = Image.open(path).convert("RGB")
        tiles.append(crop_board(img, rect, pad_ratio=0.02) if rect else img)

    made = 0
    for stem, layout, theme, source, header in FRAMES:
        headline, subline = CAPTIONS[locale][stem]
        _, accent = PALETTE[theme]
        canvas = plate(stem, theme).convert("RGBA")

        if layout == "collage":
            canvas = collage(canvas, tiles, accent, headline, subline)
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
                canvas = hero(
                    canvas, capture, rect, accent, headline, subline, header
                )
            elif layout == "screen":
                canvas = screen(canvas, capture, accent, headline, subline)
            else:
                canvas = statement(
                    canvas, capture, rect, accent, headline, subline, PROOF[locale]
                )

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
    for locale in CAPTIONS:
        print(f"\nFraming {locale} screenshots …")
        if build(locale):
            return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
