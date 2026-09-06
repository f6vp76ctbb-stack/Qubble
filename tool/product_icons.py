#!/usr/bin/env python3
"""Renders one store icon per in-app product.

    python3 tool/product_icons.py     # writes store-assets/product-icons/

The Play Console asks for an icon per product with a hard spec, quoted from
the form itself: 32-bit PNG, 1:1,each side between 512 and 1080 px, up to 8 MB,
and — the part that shapes the drawings — "no text, no advertising and no
branding". So every icon is a plain object on the app's own ground: a coin, a
diamond, a heart. Quantity is shown by repetition, never by a numeral, because
a numeral is text.

Colours come from lib/ui/theme.dart so the icons and the game agree.
"""
import os
from PIL import Image, ImageDraw

SIZE = 512
OUT = "store-assets/product-icons"

BG = (25, 27, 64, 255)          # GridColors.boardBackground
GOLD = (255, 194, 75, 255)      # GridColors.fever
GOLD_DARK = (214, 154, 44, 255)
TEAL = (79, 224, 198, 255)      # GridColors.placed
TEAL_DARK = (46, 168, 148, 255)
INDIGO = (124, 107, 255, 255)   # traySlots[0]
PINK = (255, 111, 176, 255)     # traySlots[2]
NEON = (57, 255, 20, 255)
NEON_BG = (7, 7, 12, 255)

def ground(fill=BG):
    img = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    d.rounded_rectangle([0, 0, SIZE - 1, SIZE - 1], radius=96, fill=fill)
    return img, d

def coin(d, cx, cy, r):
    d.ellipse([cx - r, cy - r, cx + r, cy + r], fill=GOLD_DARK)
    d.ellipse([cx - r * 0.86, cy - r * 0.86, cx + r * 0.86, cy + r * 0.86], fill=GOLD)
    d.ellipse([cx - r * 0.52, cy - r * 0.52, cx + r * 0.52, cy + r * 0.52],
              outline=GOLD_DARK, width=max(3, int(r * 0.13)))

def diamond(d, cx, cy, r):
    d.polygon([(cx, cy - r), (cx + r * 0.82, cy), (cx, cy + r), (cx - r * 0.82, cy)],
              fill=TEAL)
    d.polygon([(cx, cy - r), (cx + r * 0.82, cy), (cx, cy)], fill=TEAL_DARK)

def heart(d, cx, cy, r):
    d.ellipse([cx - r, cy - r * 0.95, cx, cy + r * 0.05], fill=PINK)
    d.ellipse([cx, cy - r * 0.95, cx + r, cy + r * 0.05], fill=PINK)
    # The triangle meets the lobes at their widest point (their centre line),
    # not below it — meeting lower left a notch on each shoulder.
    d.polygon([(cx - r, cy - r * 0.45), (cx + r, cy - r * 0.45),
               (cx, cy + r)], fill=PINK)

def gift(d, cx, cy, r):
    d.rounded_rectangle([cx - r, cy - r * 0.55, cx + r, cy + r], radius=18, fill=INDIGO)
    d.rounded_rectangle([cx - r * 1.1, cy - r * 0.85, cx + r * 1.1, cy - r * 0.35],
                        radius=14, fill=TEAL)
    d.rectangle([cx - r * 0.13, cy - r * 0.85, cx + r * 0.13, cy + r], fill=TEAL)

def tag(d, cx, cy, r):
    d.rounded_rectangle([cx - r, cy - r * 0.62, cx + r * 0.45, cy + r * 0.62],
                        radius=22, fill=INDIGO)
    d.polygon([(cx + r * 0.4, cy - r * 0.62), (cx + r, cy), (cx + r * 0.4, cy + r * 0.62)],
              fill=INDIGO)
    d.ellipse([cx - r * 0.66, cy - r * 0.16, cx - r * 0.34, cy + r * 0.16], fill=BG)

def neon_block(d, cx, cy, r):
    # The J piece occupies dx in {-1, 0}, so its bounding box sits half a cell
    # left of the given centre. Shifted back, or the block hangs off-axis.
    cells = [(-1, -1), (0, -1), (0, 0), (0, 1)]
    cx += r * 0.62 * 0.5
    for (dx, dy) in cells:
        x, y = cx + dx * r * 0.62, cy + dy * r * 0.62
        d.rounded_rectangle([x - r * 0.29, y - r * 0.29, x + r * 0.29, y + r * 0.29],
                            radius=14, fill=NEON)

MARGIN = 48
GAP = 2.1  # centre distance, in radii

def row(d, draw_one, count, cap=150):
    """Repeats a shape; quantity without a numeral, since numerals are text.

    The radius is derived from the space available rather than chosen: three
    coins at a radius picked for one ran off both edges, and a clipped icon is
    the kind of thing a store review notices before the developer does.
    """
    r = min(cap, (SIZE - 2 * MARGIN) / (2 + GAP * (count - 1)))
    step = r * GAP
    start = SIZE / 2 - step * (count - 1) / 2
    for i in range(count):
        draw_one(d, start + i * step, SIZE / 2, r)

SPECS = {
    "qubble_coins_s":    lambda d: row(d, coin, 1),
    "qubble_coins_m":    lambda d: row(d, coin, 2),
    "qubble_coins_l":    lambda d: row(d, coin, 3),
    "qubble_diamonds_s": lambda d: row(d, diamond, 1, cap=155),
    "qubble_diamonds_m": lambda d: row(d, diamond, 2, cap=155),
    "qubble_diamonds_l": lambda d: row(d, diamond, 3, cap=155),
    "qubble_supporter":  lambda d: heart(d, SIZE / 2, SIZE / 2 - 10, 130),
    "qubble_starter":    lambda d: gift(d, SIZE / 2, SIZE / 2, 130),
    "qubble_rename":     lambda d: tag(d, SIZE / 2, SIZE / 2, 140),
    "qubble_neon_theme": lambda d: neon_block(d, SIZE / 2, SIZE / 2, 130),
}

os.makedirs(OUT, exist_ok=True)
for name, paint in SPECS.items():
    img, d = ground(NEON_BG if name == "qubble_neon_theme" else BG)
    paint(d)
    path = f"{OUT}/{name}.png"
    img.save(path)
    w, h = img.size
    assert w == h == SIZE and img.mode == "RGBA", (w, h, img.mode)
    # Nothing may touch the outer 16 px: a clipped shape reads as a broken
    # asset, and the ground itself is rounded so the corners are transparent.
    px = img.load()
    edge = 16
    for x in range(SIZE):
        for y in (edge, SIZE - 1 - edge):
            assert px[x, y][:3] in (BG[:3], NEON_BG[:3]) or px[x, y][3] == 0, \
                f"{name}: Motiv beruehrt den Rand bei ({x},{y})"
    for y in range(SIZE):
        for x in (edge, SIZE - 1 - edge):
            assert px[x, y][:3] in (BG[:3], NEON_BG[:3]) or px[x, y][3] == 0, \
                f"{name}: Motiv beruehrt den Rand bei ({x},{y})"
    print(f"  ok {path}  {w}x{h} {img.mode} {os.path.getsize(path) / 1024:.0f} KB")
print(f"\n{len(SPECS)} Symbole — 512x512 RGBA, ohne Text, ohne Branding.")
