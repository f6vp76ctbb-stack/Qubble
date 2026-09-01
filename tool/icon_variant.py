#!/usr/bin/env python3
"""Renders the A/B candidate app icon (store-assets/icon-variant/).

The shipped icon is a 3x3 grid of evenly coloured tiles on near-black navy.
Three things about it are worth testing against, all noted in audit/05-aso.md:

  1. It shows a grid, not a block puzzle. The genre's defining shape is a
     multi-cell piece; a field of equal tiles reads closer to a sudoku, or to
     the generic "apps" glyph most launchers use.
  2. The grid is 3x3 where the game is 8x8.
  3. It is dark, in a store category that is uniformly bright. In a column of
     search results a near-black tile recedes.

This candidate answers all three: an L-piece caught mid-drop over a partly
filled 4x4 board, on a lighter ground, in the app's own palette. It keeps the
rounded-square language so the two are recognisably the same product — the
test is about the subject, not a redesign.

One thing the first attempt got wrong, found by rendering both at 48 px on a
light and a dark backdrop: dim empty cells vanish at thumbnail size and the
icon falls apart into scattered dots. What makes the shipped icon work small is
that every cell is bright. So the empty cells here are drawn light enough to
hold the grid together at 48 px, and the piece is separated from the board by a
drop shadow rather than by contrast alone.

Run from the repo root:  python3 tool/icon_variant.py

Outputs 1024x1024 (launcher source), a 512x512 opaque store icon, and an
adaptive foreground with the safe-zone padding Android requires.
"""
from PIL import Image, ImageDraw

# lib/ui/theme.dart, GridColors.
INDIGO = (124, 107, 255)
TEAL = (79, 224, 198)
PINK = (255, 111, 176)
# Bright enough to survive a 48 px thumbnail — see the docstring. The in-app
# empty cell (0x424467) disappears at that size.
EMPTY = (92, 96, 146)

# Lighter than GridColors.background (0F1030) on purpose — see the docstring.
GROUND_TOP = (46, 48, 104)
GROUND_BOTTOM = (26, 28, 66)

S = 1024
SS = 4  # supersampling factor, for clean rounded corners


def ground(size: int) -> Image.Image:
    """Vertical gradient, so the icon has some depth at thumbnail size."""
    img = Image.new("RGB", (1, size))
    px = img.load()
    for y in range(size):
        t = y / (size - 1)
        px[0, y] = tuple(
            round(a + (b - a) * t) for a, b in zip(GROUND_TOP, GROUND_BOTTOM)
        )
    return img.resize((size, size), Image.BILINEAR)


def cell(draw: ImageDraw.ImageDraw, x, y, s, colour, radius_frac=0.24):
    draw.rounded_rectangle(
        [x, y, x + s, y + s], radius=round(s * radius_frac), fill=colour
    )


def shadow(img: Image.Image, cells, c, radius_frac=0.24):
    """Soft drop shadow under the falling piece, so the lift reads at any size.

    Contrast alone does not carry it: at 48 px the offset between the piece and
    the board is a couple of pixels.
    """
    from PIL import ImageFilter

    layer = Image.new("RGBA", img.size, (0, 0, 0, 0))
    d = ImageDraw.Draw(layer)
    for x, y in cells:
        d.rounded_rectangle(
            [x, y, x + c, y + c], radius=round(c * radius_frac), fill=(0, 0, 0, 150)
        )
    layer = layer.filter(ImageFilter.GaussianBlur(c * 0.16))
    img.alpha_composite(layer)


def render(size: int) -> Image.Image:
    big = size * SS
    img = ground(big).convert("RGBA")
    d = ImageDraw.Draw(img)

    # A 4x4 board, inset. Four cells across reads at thumbnail size; eight does
    # not, and the icon has to say "grid" rather than reproduce the board.
    pad = big * 0.17
    board = big - 2 * pad
    gap = board * 0.045
    c = (board - 3 * gap) / 4

    def at(col, row):
        return pad + col * (c + gap), pad + row * (c + gap)

    # Empty board first.
    for row in range(4):
        for col in range(4):
            x, y = at(col, row)
            cell(d, x, y, c, EMPTY + (255,))

    # Two rows already settled, so the piece has somewhere to land.
    for col in range(4):
        x, y = at(col, 3)
        cell(d, x, y, c, TEAL + (255,))
    for col in (0, 1):
        x, y = at(col, 2)
        cell(d, x, y, c, PINK + (255,))

    # The L-piece, mid-drop: lifted off the gap it fits, so it reads as a piece
    # being moved rather than one already placed.
    lift = c * 0.34
    piece = [(2, 0), (2, 1), (3, 1)]
    placed = [
        (at(col, row)[0] + lift * 0.22, at(col, row)[1] - lift)
        for col, row in piece
    ]
    shadow(img, placed, c)
    d = ImageDraw.Draw(img)
    for x, y in placed:
        cell(d, x, y, c, INDIGO + (255,))

    return img.resize((size, size), Image.LANCZOS)


def main():
    import os

    out = "store-assets/icon-variant"
    os.makedirs(out, exist_ok=True)

    full = render(S)
    full.convert("RGB").save(f"{out}/icon.png")
    full.convert("RGB").resize((512, 512), Image.LANCZOS).save(
        f"{out}/app-icon-512.png"
    )

    # Adaptive foreground: Android crops to a shape inside the middle ~72%, so
    # the art has to sit well inside the canvas or the launcher cuts it.
    fg = Image.new("RGBA", (S, S), (0, 0, 0, 0))
    inner = render(round(S * 0.62)).convert("RGBA")
    off = (S - inner.width) // 2
    fg.paste(inner, (off, off), inner)
    fg.save(f"{out}/icon_foreground.png")

    for name in ("icon.png", "app-icon-512.png", "icon_foreground.png"):
        path = f"{out}/{name}"
        print(f"  {path}: {os.path.getsize(path) / 1024:.0f} KB")


if __name__ == "__main__":
    main()
