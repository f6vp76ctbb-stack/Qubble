#!/usr/bin/env python3
"""Renders the Play Store feature graphic, one per store language.

    python3 tool/feature_graphic.py     # -> store-assets/<locale>/feature-graphic-1024x500.png
    python3 tool/feature_graphic.py og  # -> web/og-image.png (link preview, 1200x630)

Four languages, as for the screenshots: the listings kept by hand (owner,
09.11.2026).

It shares its palette, font and glow with `tool/caption_screenshots.py` on
purpose: the header banner and the screenshots sit on the same page, and two
different design languages up there look like two different apps.

What it shows is what sets the game apart: a real board, and three Qubbies in
front of it — the free starter, and two that bring an effect of their own.
Board and Qubbies come from the same captures as the screenshots (the app's
own pixels): run tool/generate_screenshots.dart first.

What Google asks of it is in "Add preview assets to showcase your app"
(support.google.com/googleplay/android-developer/answer/9866151, read
14.11.2026), under "Highly recommended":

* "Avoid using pure white, black, or dark gray", "consider using more vibrant
  colors" — hence the violet field instead of the app's own dark navy, which
  sank into the store's dark background.
* "Keep prominent visuals and the focal point towards the center", key
  elements out of the cutoff zones. Google shows those zones only as a
  picture this tool's author could not load; the margin kept here (SAFE_L,
  SAFE_R and the block's vertical centring) is a cautious guess, not Google's
  number.
* No "Best", "#1", "Top", "New", "Free", "Discount", "Sale" (COPY is read by
  test/store_listing_test.dart), nothing time-bound, no device, no store
  badge, no prominent copy of the app icon.
* Not the same message as the short description and the first screenshot:
  "these assets may be shown side by side".

Requires Pillow and the app font in assets/fonts.
"""

from __future__ import annotations

import os
import sys

from PIL import Image, ImageDraw, ImageFilter

from caption_screenshots import (
    PALETTE,
    _mix,
    _weighted,
    draw_text,
    fit,
    portrait,
    rounded,
    text_length,
    tile,
)

W, H = 1024, 500

# Play crops this asset differently depending on where it appears — letterboxed
# on the listing, tighter in editorial collections. Everything that carries
# meaning stays inside the conservative safe area, 100 px in from every edge;
# only the gradient and the glow are allowed into the outer band, where losing
# them costs nothing.
SAFE_L, SAFE_R = 112, W - 112

# The board behind the Qubbies: a real one from tool/generate_screenshots.dart
# (classic with sparkles — the look of the app's own icon).
BOARD = "look-1"
# Left, right, front. The front one is the dragon of the first screenshot.
QUBBIES = ["kiki", "zapp", "funki"]
OUT = "store-assets/{locale}/feature-graphic-1024x500.png"

TEXT = (255, 255, 255)
MUTED = (226, 222, 255)
EYEBROW = (0xFF, 0xD3, 0x6B)  # a lighter cut of theme.dart's Classic `fever`

# The field: the violet of the icon's blocks, deepening to the right, with
# the icon's pink behind the scene. Saturated on purpose (see above).
FIELD_FROM = (0x7A, 0x5C, 0xF0)
FIELD_TO = (0x45, 0x2A, 0xB8)
FIELD_GLOW = (0xFF, 0x6F, 0xA8)
DOT = (0x5E, 0xEA, 0xD4)  # the icon's mint, for the wordmark's full stop

# locale -> (eyebrow, tagline, second line). Each must survive a reading of
# the code, like every store text (test/store_claims_test.dart): a Qubbie
# plays along and changes nothing about the score; there are no interstitials
# or banners; the game runs without a connection. Nothing here says free,
# best, new or number one, and nothing is set in capitals.
COPY = {
    "en": ("Block Puzzle", "A pet on your board.", "No forced ads. Plays offline."),
    "de": ("Block Puzzle", "Ein Haustier auf deinem Brett.", "Keine Zwangswerbung. Läuft offline."),
    "es": ("Puzzle de bloques", "Una mascota en tu tablero.", "Sin anuncios obligatorios. Sin conexión."),
    "pt": ("Jogo de blocos", "Um mascote no seu tabuleiro.", "Sem anúncios obrigatórios. Funciona offline."),
}


def scene(canvas: Image.Image, cx: float, cy: float, size: int) -> Image.Image:
    """The board, a little tilted, and the three Qubbies standing before it."""
    board = rounded(tile(BOARD).resize((size, size), Image.LANCZOS), size // 9)
    board = board.rotate(-6, resample=Image.BICUBIC, expand=True)
    bx = round(cx - board.width / 2)
    by = round(cy - board.height / 2 - size * 0.06)
    shadow = Image.new("RGBA", canvas.size, (0, 0, 0, 0))
    mask = board.split()[3].point(lambda a: 150 if a else 0)
    shadow.paste((0, 0, 0, 255), (bx, by + size // 14), mask)
    canvas = Image.alpha_composite(
        canvas, shadow.filter(ImageFilter.GaussianBlur(size // 12))
    )
    canvas.alpha_composite(board, (bx, by))

    ground = cy + size * 0.56
    # (id, centre as a share of the board's size, height as a share of it)
    spots = [
        (QUBBIES[0], -0.50, 0.40),
        (QUBBIES[1], 0.47, 0.40),
        (QUBBIES[2], -0.02, 0.56),
    ]
    for pet_id, dx, height in spots:
        art = portrait(pet_id)
        art = fit(art, round(size * 0.92), round(size * height))
        x = round(cx + dx * size - art.width / 2)
        y = round(ground - art.height)
        contact = Image.new("RGBA", canvas.size, (0, 0, 0, 0))
        ImageDraw.Draw(contact).ellipse(
            [(x + art.width * 0.12, y + art.height - 14),
             (x + art.width * 0.88, y + art.height + 12)],
            fill=(0, 0, 0, 170),
        )
        canvas = Image.alpha_composite(
            canvas, contact.filter(ImageFilter.GaussianBlur(9))
        )
        canvas.alpha_composite(art, (x, y))
    return canvas


def background(w: int = W, h: int = H) -> Image.Image:
    """A saturated violet field with a warm light behind the scene."""
    row = Image.new("RGB", (w, 1))
    px = row.load()
    for x in range(w):
        px[x, 0] = _mix(FIELD_FROM, FIELD_TO, x / (w - 1))
    canvas = row.resize((w, h), Image.BILINEAR)
    # A little darker towards the bottom, so the Qubbies have ground to stand
    # on and the field is not a flat poster colour.
    shade = Image.new("L", (1, h))
    spx = shade.load()
    for y in range(h):
        spx[0, y] = round(70 * (y / (h - 1)) ** 1.6)
    canvas = Image.composite(
        Image.new("RGB", (w, h), _mix(FIELD_TO, (0, 0, 0), 0.45)), canvas,
        shade.resize((w, h), Image.BILINEAR),
    )

    glow = Image.new("RGB", (w, h), (0, 0, 0))
    ImageDraw.Draw(glow).ellipse(
        [(-0.08 * w, 0.02 * h), (0.52 * w, 1.05 * h)], fill=FIELD_GLOW
    )
    glow = glow.filter(ImageFilter.GaussianBlur(round(w * 0.11)))
    mask = glow.convert("L").point(lambda v: round(v * 0.42))
    return Image.composite(Image.new("RGB", (w, h), FIELD_GLOW), canvas, mask)


def fit_text(draw, text: str, weight: int, size: int, max_width: int, floor: int):
    """Largest size at or below [size] that keeps [text] on one line.

    One line is the point: a wrapped tagline leaves a single word hanging on
    the second line.
    """
    while size > floor:
        font = _weighted(size, weight)
        if text_length(draw, text, font) <= max_width:
            return font
        size -= 2
    font = _weighted(floor, weight)
    # Past the floor the text would run off the graphic, silently. Shorter
    # copy is the fix, not a smaller font.
    if text_length(draw, text, font) > max_width:
        sys.exit(f"{text!r} does not fit in {max_width} px even at {floor} px "
                 "— shorten it in COPY")
    return font


def build(locale: str, w: int = W, h: int = H, out: str | None = None) -> str:
    eyebrow, tagline, second = COPY[locale]
    safe_l, safe_r = SAFE_L, w - (W - SAFE_R)
    canvas = background(w, h).convert("RGBA")

    # The scene on the left, inside the safe area; the text block beside it.
    slot = round(300 * h / H)
    canvas = scene(canvas, safe_l + slot / 2 + 10, h / 2, round(slot * 0.84))
    draw = ImageDraw.Draw(canvas)

    x = safe_l + slot + 78
    avail = safe_r - x

    eyebrow_font = _weighted(28, 800)
    word_font = fit_text(draw, "Qubble.", 800, 104, avail, 72)
    tag_font = fit_text(draw, tagline, 800, 40, avail, 26)
    second_font = fit_text(draw, second, 500, 27, avail, 19)

    word_h = word_font.getbbox("Qubble")[3] - word_font.getbbox("Qubble")[1]
    block_h = 26 + 18 + word_h + 46 + 40 + 20 + 27
    y = (h - block_h) // 2

    # Letterspaced eyebrow — Pillow has no tracking, so step the glyphs.
    cx = x
    for ch in eyebrow:
        draw_text(draw, (cx, y), ch, eyebrow_font, EYEBROW)
        cx += text_length(draw, ch, eyebrow_font) + 3
    y += 26 + 18

    # Wordmark, with the full stop in the accent colour.
    draw.text((x, y), "Qubble", font=word_font, fill=TEXT)
    dot_x = x + draw.textlength("Qubble", font=word_font)
    draw.text((dot_x, y), ".", font=word_font, fill=DOT)
    y += word_h + 46

    draw_text(draw, (x, y), tagline, tag_font, TEXT)
    y += 40 + 20
    draw_text(draw, (x, y), second, second_font, MUTED)

    out = out or OUT.format(locale=locale)
    os.makedirs(os.path.dirname(out), exist_ok=True)
    # Play rejects an alpha channel here too.
    canvas.convert("RGB").save(out, "PNG", optimize=True)
    return out


# The link preview for the web build. Chat apps and social sites show this
# image when someone pastes the link — which is what the daily share text
# contains. 1200x630 is the size the Open Graph consumers crop to; the English
# copy, because the web build's page is English (web/index.html).
OG_OUT = "web/og-image.png"
OG_W, OG_H = 1200, 630


def main() -> int:
    # `python3 tool/feature_graphic.py es` builds only that locale;
    # `og` builds the web link preview.
    for locale in sys.argv[1:] or COPY:
        if locale == "og":
            print(f"  ✓ {build('en', OG_W, OG_H, OG_OUT)}")
        else:
            print(f"  ✓ {build(locale)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
