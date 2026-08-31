#!/usr/bin/env python3
"""Renders the Play Store feature graphic, one per store language.

    python3 tool/feature_graphic.py     # -> store-assets/<locale>/feature-graphic-1024x500.png

The feature graphic is a per-language asset, and the previous one existed only
in German — so the English listing, which is now the default, had none.

It shares its palette, font and glow with `tool/caption_screenshots.py` on
purpose: the header banner and the six screenshots sit on the same page, and
two different design languages up there look like two different apps.

Requires Pillow and the app font in assets/fonts.
"""

from __future__ import annotations

import os

from PIL import Image, ImageDraw, ImageFilter

from caption_screenshots import PALETTE, _mix, _weighted, rounded, shadow_paste

W, H = 1024, 500

# Play crops this asset differently depending on where it appears — letterboxed
# on the listing, tighter in editorial collections. Everything that carries
# meaning stays inside the conservative safe area, 100 px in from every edge;
# only the gradient and the glow are allowed into the outer band, where losing
# them costs nothing. The old graphic put the "100% OFFLINE" badge 44 px from
# the right edge, which a tighter crop would have taken the end off.
SAFE_L, SAFE_R = 100, W - 100
SAFE_T, SAFE_B = 50, H - 50

ICON = "store-assets/app-icon-512.png"
OUT = "store-assets/{locale}/feature-graphic-1024x500.png"

TEXT = (245, 247, 255)
MUTED = (176, 182, 212)
EYEBROW = (0xFF, 0xC2, 0x4B)  # theme.dart, Classic `fever`

# Three to six words, and the one thing this game has that the top of the genre
# does not. The loop itself is what the screenshots are for.
COPY = {
    "en": ("BLOCK PUZZLE", "No forced ads. Plays offline."),
    "de": ("BLOCK PUZZLE", "Keine Zwangswerbung. Komplett offline."),
}

# The tray colours from the Classic theme, as a brand strip.
CHIPS = [
    (0x7C, 0x6B, 0xFF),
    (0x4F, 0xE0, 0xC6),
    (0xF5, 0xF6, 0xFF),
    (0xFF, 0x6F, 0xB0),
    (0xFF, 0xC2, 0x4B),
]


def background() -> Image.Image:
    """Same gradient-and-glow treatment as the screenshot plates."""
    base, accent = PALETTE["classic"]
    top = _mix(base, (0, 0, 0), 0.30)
    bottom = _mix(base, (255, 255, 255), 0.05)
    column = Image.new("RGB", (1, H))
    px = column.load()
    for y in range(H):
        px[0, y] = _mix(top, bottom, y / (H - 1))
    canvas = column.resize((W, H), Image.BILINEAR)

    glow = Image.new("RGB", (W, H), (0, 0, 0))
    ImageDraw.Draw(glow).ellipse([(-260, 90), (620, 620)], fill=accent)
    glow = glow.filter(ImageFilter.GaussianBlur(150))
    return Image.blend(canvas, glow, 0.16)


def fit_text(draw, text: str, weight: int, size: int, max_width: int, floor: int):
    """Largest size at or below [size] that keeps [text] on one line.

    One line is the point: the German graphic used to wrap its tagline and left
    a single word hanging on the second line.
    """
    while size > floor:
        font = _weighted(size, weight)
        if draw.textlength(text, font=font) <= max_width:
            return font
        size -= 2
    return _weighted(floor, weight)


def build(locale: str) -> str:
    eyebrow, tagline = COPY[locale]
    canvas = background().convert("RGBA")
    draw = ImageDraw.Draw(canvas)

    # App icon on the left, inside the safe area.
    icon_size = 268
    icon = Image.open(ICON).convert("RGB").resize((icon_size, icon_size), Image.LANCZOS)
    icon_y = (H - icon_size) // 2
    canvas = shadow_paste(canvas, rounded(icon, 60), SAFE_L + 8, icon_y, 60)
    draw = ImageDraw.Draw(canvas)

    x = SAFE_L + 8 + icon_size + 60
    avail = SAFE_R - x

    eyebrow_font = _weighted(28, 800)
    word_font = fit_text(draw, "Qubble.", 800, 108, avail, 72)
    tag_font = fit_text(draw, tagline, 500, 34, avail, 24)

    word_h = word_font.getbbox("Qubble")[3] - word_font.getbbox("Qubble")[1]
    block_h = 28 + 20 + word_h + 40 + 34 + 30 + 46
    y = (H - block_h) // 2

    # Letterspaced eyebrow — Pillow has no tracking, so step the glyphs.
    cx = x
    for ch in eyebrow:
        draw.text((cx, y), ch, font=eyebrow_font, fill=EYEBROW)
        cx += draw.textlength(ch, font=eyebrow_font) + 5
    y += 28 + 20

    # Wordmark, with the full stop in the accent colour.
    draw.text((x, y), "Qubble", font=word_font, fill=TEXT)
    dot_x = x + draw.textlength("Qubble", font=word_font)
    draw.text((dot_x, y), ".", font=word_font, fill=PALETTE["classic"][1])
    y += word_h + 40

    draw.text((x, y), tagline, font=tag_font, fill=MUTED)
    y += 34 + 30

    chip, gap = 46, 14
    for i, colour in enumerate(CHIPS):
        cx = x + i * (chip + gap)
        draw.rounded_rectangle(
            [(cx, y), (cx + chip, y + chip)], radius=13, fill=colour
        )

    out = OUT.format(locale=locale)
    os.makedirs(os.path.dirname(out), exist_ok=True)
    # Play rejects an alpha channel here too.
    canvas.convert("RGB").save(out, "PNG", optimize=True)
    return out


def main() -> int:
    for locale in COPY:
        print(f"  ✓ {build(locale)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
