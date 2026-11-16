#!/usr/bin/env python3
"""Carousel slides for Instagram and TikTok, built from the raw app captures.

    flutter test tool/generate_screenshots.dart   # writes store-assets/raw/en/
    python3 tool/social_slides.py                 # writes store-assets/social/

Two sets, English only (the social channels post in English, owner
16.11.2026):

* `qubbies` — a cover with all nine Qubbies, one slide per Qubbie, an end card.
* `looks`   — the same board in nine looks (the tiles of the store mosaic),
  one slide per look, an end card.

Every slide comes in two sizes: `ig/` 1080x1350 (4:5, the tallest frame an
Instagram feed post keeps uncropped) and `tt/` 1080x1920 (9:16, TikTok's photo
mode). On the tall frame the content sits higher, out of the band TikTok
covers with the caption and the buttons.

The pixels of every board and every Qubbie come from the app; this script only
lays them out and writes the names the app itself shows
(store-assets/raw/en/designs.json). JPEG, so the slides stay small enough to
be served from the repository for Buffer.

Requires Pillow and the app font in assets/fonts.
"""

from __future__ import annotations

import json
import os
import sys

from PIL import Image, ImageDraw, ImageFilter

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from caption_screenshots import _mix, _weighted  # noqa: E402

RAW = "store-assets/raw/en"
OUT = "store-assets/social"
ICON = "store-assets/app-icon-512.png"
W = 1080
SIZES = {"ig": 1350, "tt": 1920}

WHITE = (255, 255, 255)
MUTED = (200, 204, 230)
INK = (14, 12, 30)

# The Qubbies in catalog order (lib/game/pet.dart), with what each one does to
# a cleared row. Starters fly with the row effect the player has equipped.
PETS = [
    ("kiki", "cat", "starter, free pick after run 3", (79, 224, 184)),
    ("bit", "dog", "starter, free pick after run 3", (255, 154, 82)),
    ("glim", "slime", "starter, free pick after run 3", (165, 139, 255)),
    ("frosti", "penguin", "freezes the rows you clear", (92, 200, 255)),
    ("optik", "owl", "fires a laser through your clears", (123, 227, 130)),
    ("zapp", "thunderbird", "zaps every row with lightning", (255, 194, 75)),
    ("funki", "dragon", "sets your clears on fire", (255, 111, 97)),
    ("prisma", "unicorn", "clears in rainbow colors", (255, 126, 182)),
    ("pyra", "phoenix", "the legendary one", (255, 122, 61)),
]

# The tiles of the store mosaic (tool/generate_screenshots.dart, `_looks`).
LOOKS = [
    ("look-1", "classic", "glossy", "sparkle", (158, 168, 255)),
    ("look-2", "neon", "glow", None, (57, 255, 20)),
    ("look-3", "candy", "jelly", "flower", (255, 158, 207)),
    ("look-4", "volcano", "ember", None, (255, 122, 61)),
    ("look-5", "glacier", "marble", "snowCap", (191, 239, 255)),
    ("look-6", "wood", "bevel", "dewdrop", (217, 160, 91)),
    ("look-7", "ocean", "wave", None, (53, 208, 186)),
    ("look-8", "sunset", "prism", "crown", (255, 126, 95)),
    ("look-9", "forest", "pixel", None, (123, 227, 130)),
]


def font(size: int, weight: int = 800):
    return _weighted(size, weight)


def backdrop(h: int, accent, glow_y: float) -> Image.Image:
    """Dark field tinted with [accent], a soft glow where the art sits."""
    top = _mix(accent, INK, 0.90)
    bottom = _mix(accent, INK, 0.78)
    column = Image.new("RGB", (1, h))
    px = column.load()
    for y in range(h):
        px[0, y] = _mix(top, bottom, y / (h - 1))
    canvas = column.resize((W, h), Image.BILINEAR)
    glow = Image.new("RGB", (W, h), (0, 0, 0))
    r = W * 0.55
    cy = h * glow_y
    ImageDraw.Draw(glow).ellipse([(W / 2 - r, cy - r), (W / 2 + r, cy + r)], fill=accent)
    glow = glow.filter(ImageFilter.GaussianBlur(160))
    return Image.blend(canvas, glow, 0.30)


def trimmed(path: str) -> Image.Image:
    img = Image.open(path).convert("RGBA")
    return img.crop(img.getchannel("A").getbbox())


def fit(img: Image.Image, max_w: int, max_h: int) -> Image.Image:
    scale = min(max_w / img.width, max_h / img.height)
    return img.resize((round(img.width * scale), round(img.height * scale)), Image.LANCZOS)


def rounded(img: Image.Image, radius: int) -> Image.Image:
    mask = Image.new("L", img.size, 0)
    ImageDraw.Draw(mask).rounded_rectangle([(0, 0), img.size], radius, fill=255)
    out = img.convert("RGBA")
    out.putalpha(mask)
    return out


def shadowed(canvas: Image.Image, art: Image.Image, x: int, y: int, blur: int = 28):
    shadow = Image.new("RGBA", (art.width + blur * 4, art.height + blur * 4), (0, 0, 0, 0))
    shadow.paste((0, 0, 0, 150), (blur * 2, blur * 2 + 14), art.getchannel("A"))
    shadow = shadow.filter(ImageFilter.GaussianBlur(blur))
    canvas.alpha_composite(shadow, (x - blur * 2, y - blur * 2))
    canvas.alpha_composite(art, (x, y))


def chip(canvas: Image.Image, cy: int, text: str, fill, ink=INK, size: int = 40):
    draw = ImageDraw.Draw(canvas)
    fnt = font(size, 800)
    tw = draw.textlength(text, font=fnt)
    pad_x, h = 34, size + 34
    x0 = round((W - tw) / 2 - pad_x)
    draw.rounded_rectangle([(x0, cy - h // 2), (x0 + tw + 2 * pad_x, cy + h // 2)], h // 2, fill=fill)
    draw.text((W / 2, cy), text, font=fnt, fill=ink, anchor="mm")


def corner(canvas: Image.Image, index: str | None):
    draw = ImageDraw.Draw(canvas)
    draw.text((64, 64), "Qubble", font=font(40, 900), fill=(*WHITE, 210), anchor="lt")
    if index:
        draw.text((W - 64, 64), index, font=font(36, 700), fill=(*MUTED, 200), anchor="rt")


def anchor_y(h: int) -> float:
    """Where the art centres: a little higher on the tall TikTok frame."""
    return 0.40 if h == SIZES["ig"] else 0.36


def grid_cell(h: int) -> tuple[int, int]:
    """Tile size and gap of the 3x3 covers: the 4:5 frame has less height."""
    return (262, 20) if h == SIZES["ig"] else (300, 24)


def pet_slide(h: int, i: int, pet) -> Image.Image:
    pid, species, line, accent = pet
    canvas = backdrop(h, accent, anchor_y(h)).convert("RGBA")
    corner(canvas, f"{i}/9")
    art = fit(trimmed(f"{RAW}/pet-{pid}.png"), 640, round(h * 0.40))
    cy = round(h * anchor_y(h))
    shadowed(canvas, art, (W - art.width) // 2, cy - art.height // 2)
    draw = ImageDraw.Draw(canvas)
    y = cy + art.height // 2 + 70
    draw.text((W / 2, y), species.upper(), font=font(38, 800), fill=accent, anchor="mt")
    draw.text((W / 2, y + 52), pid.capitalize(), font=font(150, 900), fill=WHITE, anchor="mt")
    draw.text((W / 2, y + 230), line, font=font(48, 600), fill=MUTED, anchor="mt")
    return canvas


def qubbies_cover(h: int) -> Image.Image:
    canvas = backdrop(h, (165, 139, 255), 0.55).convert("RGBA")
    corner(canvas, None)
    draw = ImageDraw.Draw(canvas)
    top = 140 if h == SIZES["ig"] else 200
    draw.text((W / 2, top), "rank the Qubbies", font=font(104, 900), fill=WHITE, anchor="mt")
    draw.text((W / 2, top + 132), "9 pets that fly through the rows you clear",
              font=font(42, 600), fill=MUTED, anchor="mt")
    cell, gap = grid_cell(h)
    grid_w = 3 * cell + 2 * gap
    x0 = (W - grid_w) // 2
    y0 = top + 230
    for n, (pid, _, _, accent) in enumerate(PETS):
        cx = x0 + (n % 3) * (cell + gap)
        cy = y0 + (n // 3) * (cell + gap)
        tile = Image.new("RGBA", (cell, cell), (*_mix(accent, INK, 0.62), 255))
        canvas.alpha_composite(rounded(tile, 40), (cx, cy))
        art = fit(trimmed(f"{RAW}/pet-{pid}.png"), cell - 70, cell - 92)
        canvas.alpha_composite(art, (cx + (cell - art.width) // 2, cy + 18))
        draw.text((cx + cell / 2, cy + cell - 20), pid.capitalize(), font=font(34, 800),
                  fill=WHITE, anchor="mb")
    chip(canvas, y0 + 3 * cell + 2 * gap + 80, "1 = best, 9 = worst. go", (255, 194, 75))
    return canvas


def board(stem: str) -> Image.Image:
    rect = json.load(open(f"{RAW}/{stem}.json"))
    img = Image.open(f"{RAW}/{stem}.png").convert("RGB")
    pad = 6
    x, y, w, hh = rect["x"], rect["y"], rect["w"], rect["h"]
    return img.crop((x - pad, y - pad, x + w + pad, y + hh + pad))


def look_label(names: dict, theme: str, skin: str, accessory: str | None) -> str:
    parts = [names["themes"][theme], names["skins"][skin]]
    if accessory:
        parts.append(names["accessories"][accessory])
    return " + ".join(parts)


def look_slide(h: int, i: int, look, names: dict) -> Image.Image:
    stem, theme, skin, accessory, accent = look
    canvas = backdrop(h, accent, anchor_y(h)).convert("RGBA")
    corner(canvas, f"{i}/9")
    side = 880
    art = rounded(board(stem).resize((side, side), Image.LANCZOS), 36)
    cy = round(h * anchor_y(h))
    shadowed(canvas, art, (W - side) // 2, cy - side // 2)
    draw = ImageDraw.Draw(canvas)
    y = cy + side // 2 + 56
    draw.text((W / 2, y), names["themes"][theme], font=font(96, 900), fill=WHITE, anchor="mt")
    rest = look_label(names, theme, skin, accessory).split(" + ", 1)[1]
    draw.text((W / 2, y + 120), rest, font=font(46, 600), fill=MUTED, anchor="mt")
    return canvas


def looks_cover(h: int) -> Image.Image:
    canvas = backdrop(h, (255, 126, 95), 0.55).convert("RGBA")
    corner(canvas, None)
    draw = ImageDraw.Draw(canvas)
    top = 140 if h == SIZES["ig"] else 200
    draw.text((W / 2, top), "same board, 9 looks", font=font(96, 900), fill=WHITE, anchor="mt")
    draw.text((W / 2, top + 124), "which one would you play on?", font=font(46, 600),
              fill=MUTED, anchor="mt")
    cell, gap = grid_cell(h)
    grid_w = 3 * cell + 2 * gap
    x0 = (W - grid_w) // 2
    y0 = top + 220
    for n, look in enumerate(LOOKS):
        art = rounded(board(look[0]).resize((cell, cell), Image.LANCZOS), 26)
        canvas.alpha_composite(art, (x0 + (n % 3) * (cell + gap), y0 + (n // 3) * (cell + gap)))
    chip(canvas, y0 + 3 * cell + 2 * gap + 78, "pick a number 1-9", (255, 194, 75))
    return canvas


def end_card(h: int, accent) -> Image.Image:
    canvas = backdrop(h, accent, 0.40).convert("RGBA")
    icon = rounded(Image.open(ICON).convert("RGBA").resize((340, 340), Image.LANCZOS), 76)
    cy = round(h * (0.36 if h == SIZES["ig"] else 0.34))
    shadowed(canvas, icon, (W - 340) // 2, cy - 170)
    draw = ImageDraw.Draw(canvas)
    draw.text((W / 2, cy + 230), "Qubble", font=font(132, 900), fill=WHITE, anchor="mt")
    draw.text((W / 2, cy + 395), "block puzzle where a pet plays along", font=font(46, 600),
              fill=MUTED, anchor="mt")
    chip(canvas, cy + 540, "search Qubble on Google Play", (255, 194, 75), size=42)
    return canvas


def save(img: Image.Image, path: str):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    img.convert("RGB").save(path, "JPEG", quality=90, optimize=True, progressive=True)
    print(f"  ✓ {path}")


def main() -> int:
    if not os.path.exists(f"{RAW}/designs.json"):
        print(f"{RAW} is missing — run `flutter test tool/generate_screenshots.dart` first.",
              file=sys.stderr)
        return 1
    names = json.load(open(f"{RAW}/designs.json"))
    for key, h in SIZES.items():
        slides = [qubbies_cover(h)]
        slides += [pet_slide(h, i, pet) for i, pet in enumerate(PETS, 1)]
        slides.append(end_card(h, (165, 139, 255)))
        for n, img in enumerate(slides, 1):
            save(img, f"{OUT}/qubbies/{key}/{n:02d}.jpg")
        slides = [looks_cover(h)]
        slides += [look_slide(h, i, look, names) for i, look in enumerate(LOOKS, 1)]
        slides.append(end_card(h, (255, 126, 95)))
        for n, img in enumerate(slides, 1):
            save(img, f"{OUT}/looks/{key}/{n:02d}.jpg")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
