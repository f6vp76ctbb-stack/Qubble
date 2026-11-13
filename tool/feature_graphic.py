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
SAFE_L, SAFE_R = 100, W - 100

# The board behind the Qubbies: a real one from tool/generate_screenshots.dart
# (classic with sparkles — the look of the app's own icon).
BOARD = "look-1"
# Left, right, front. The front one is the dragon of the first screenshot.
QUBBIES = ["kiki", "zapp", "funki"]
OUT = "store-assets/{locale}/feature-graphic-1024x500.png"

TEXT = (245, 247, 255)
MUTED = (176, 182, 212)
EYEBROW = (0xFF, 0xC2, 0x4B)  # theme.dart, Classic `fever`

# locale -> (eyebrow, tagline, second line). Each must survive a reading of
# the code, like every store text (test/store_claims_test.dart): a Qubbie
# plays along and changes nothing about the score; there are no interstitials
# or banners; the game runs without a connection. Nothing here says free,
# best or number one (Google's metadata policy).
COPY = {
    "en": ("BLOCK PUZZLE", "Pets that play along.", "No forced ads. Plays offline."),
    "de": ("BLOCK PUZZLE", "Haustiere, die mitspielen.", "Keine Zwangswerbung. Läuft offline."),
    "es": ("PUZZLE DE BLOQUES", "Mascotas que juegan contigo.", "Sin anuncios obligatorios. Sin conexión."),
    "pt": ("JOGO DE BLOCOS", "Mascotes que jogam junto.", "Sem anúncios obrigatórios. Funciona offline."),
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
    """Same gradient-and-glow treatment as the screenshot plates."""
    base, accent = PALETTE["classic"]
    top = _mix(base, (0, 0, 0), 0.30)
    bottom = _mix(base, (255, 255, 255), 0.05)
    column = Image.new("RGB", (1, h))
    px = column.load()
    for y in range(h):
        px[0, y] = _mix(top, bottom, y / (h - 1))
    canvas = column.resize((w, h), Image.BILINEAR)

    glow = Image.new("RGB", (w, h), (0, 0, 0))
    ImageDraw.Draw(glow).ellipse([(-260, 90), (620, 620)], fill=accent)
    glow = glow.filter(ImageFilter.GaussianBlur(150))
    return Image.blend(canvas, glow, 0.16)


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

    eyebrow_font = _weighted(26, 800)
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
        cx += text_length(draw, ch, eyebrow_font) + 5
    y += 26 + 18

    # Wordmark, with the full stop in the accent colour.
    draw.text((x, y), "Qubble", font=word_font, fill=TEXT)
    dot_x = x + draw.textlength("Qubble", font=word_font)
    draw.text((dot_x, y), ".", font=word_font, fill=PALETTE["classic"][1])
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
