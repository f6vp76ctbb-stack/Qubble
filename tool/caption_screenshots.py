#!/usr/bin/env python3
"""Turns the raw app captures into finished Play Store screenshots.

The closed-test feedback asked for feature-centric screenshots with text
overlays instead of bare captures. This script takes the PNGs written by
`tool/generate_screenshots.dart` and frames each one: a headline naming the
feature, a supporting line, and the capture itself on the app's own palette.

    flutter test tool/generate_screenshots.dart   # writes store-assets/raw/<locale>/
    python3 tool/caption_screenshots.py           # writes store-assets/<locale>/

Requires Pillow (`pip install Pillow`) and the app font in assets/fonts.
"""

from __future__ import annotations

import os
import sys

from PIL import Image, ImageDraw, ImageFilter, ImageFont

RAW_DIR = "store-assets/raw"
OUT_DIR = "store-assets"
FONT = "assets/fonts/Nunito.ttf"

# Play Store phone screenshot: 9:16, 1080 px on the short edge.
W, H = 1080, 1920

# Straight from lib/ui/theme.dart, so the frame and the app agree.
BG_TOP = (18, 18, 42)
BG_BOTTOM = (30, 26, 66)
TEXT = (240, 242, 255)
MUTED = (150, 156, 190)
ACCENT = (79, 224, 198)

# Layout
MARGIN = 64
HEADLINE_TOP = 88
HEADLINE_SIZE = 64
SUB_SIZE = 34
SHOT_TOP = 330
SHOT_BOTTOM_MARGIN = 40
CORNER = 44

# Nunito ships as a variable font whose default instance is Light (200) — far
# too thin for a store headline. Pick the weights explicitly.
HEADLINE_WEIGHT = 800
SUB_WEIGHT = 400

# (filename stem, accent-underline?) -> headline + subline per locale.
CAPTIONS = {
    "en": {
        "1-gameplay": ("Clear rows and columns", "Easy to learn, hard to put down"),
        "2-combo": ("Ignite Combo Fever", "Chained clears multiply your score"),
        "3-daily": ("A new challenge every day", "Same puzzle for everyone — build your streak"),
        "4-puzzle": ("Puzzle mode, three stars", "Endless levels, every one solvable"),
        "5-themes": ("8 themes, 8 block skins", "Make the board yours"),
        "6-home": ("Plays fully offline", "No forced ads. No account. No server."),
    },
    "de": {
        "1-gameplay": ("Räume Reihen und Spalten", "Leicht zu lernen, schwer wegzulegen"),
        "2-combo": ("Combo-Fieber entfachen", "Verkettete Clears vervielfachen die Punkte"),
        "3-daily": ("Jeden Tag eine neue Challenge", "Für alle dasselbe Puzzle — bau deinen Streak"),
        "4-puzzle": ("Rätsel-Modus mit drei Sternen", "Unendlich viele Level, alle lösbar"),
        "5-themes": ("8 Themes, 8 Block-Skins", "Mach das Board zu deinem"),
        "6-home": ("Komplett offline spielbar", "Keine Zwangswerbung. Kein Konto. Kein Server."),
    },
}


def _weighted(size: int, weight: int) -> ImageFont.FreeTypeFont:
    """Nunito at an explicit weight on its variable-font axis."""
    font = ImageFont.truetype(FONT, size)
    try:
        font.set_variation_by_axes([weight])
    except (AttributeError, OSError):
        pass  # Static build of the font, or a Pillow without variation support.
    return font


def gradient(width: int, height: int) -> Image.Image:
    """Vertical background gradient in the app's palette."""
    base = Image.new("RGB", (1, height))
    px = base.load()
    for y in range(height):
        t = y / max(height - 1, 1)
        px[0, y] = tuple(
            round(BG_TOP[i] + (BG_BOTTOM[i] - BG_TOP[i]) * t) for i in range(3)
        )
    return base.resize((width, height), Image.BILINEAR)


def rounded(img: Image.Image, radius: int) -> Image.Image:
    """Rounds the corners of the capture so it reads as a device screen."""
    mask = Image.new("L", img.size, 0)
    ImageDraw.Draw(mask).rounded_rectangle(
        [(0, 0), (img.width - 1, img.height - 1)], radius=radius, fill=255
    )
    out = img.convert("RGBA")
    out.putalpha(mask)
    return out


def wrap(draw: ImageDraw.ImageDraw, text: str, font, max_width: int) -> list[str]:
    """Greedy word wrap against the real rendered width."""
    words, lines, line = text.split(), [], ""
    for word in words:
        probe = f"{line} {word}".strip()
        if draw.textlength(probe, font=font) <= max_width or not line:
            line = probe
        else:
            lines.append(line)
            line = word
    if line:
        lines.append(line)
    return lines


def compose(shot_path: str, headline: str, subline: str, out_path: str) -> None:
    canvas = gradient(W, H).convert("RGBA")
    draw = ImageDraw.Draw(canvas)

    head_font = _weighted(HEADLINE_SIZE, HEADLINE_WEIGHT)
    sub_font = _weighted(SUB_SIZE, SUB_WEIGHT)

    y = HEADLINE_TOP
    for line in wrap(draw, headline, head_font, W - 2 * MARGIN):
        draw.text((MARGIN, y), line, font=head_font, fill=TEXT)
        y += HEADLINE_SIZE + 10

    y += 8
    for line in wrap(draw, subline, sub_font, W - 2 * MARGIN):
        draw.text((MARGIN, y), line, font=sub_font, fill=MUTED)
        y += SUB_SIZE + 8

    # Accent rule between the copy and the capture.
    rule_y = y + 28
    draw.rounded_rectangle(
        [(MARGIN, rule_y), (MARGIN + 130, rule_y + 7)], radius=4, fill=ACCENT
    )

    # Scale to the available *height* so the whole screen is visible — scaling
    # to the width would crop the tray off the bottom.
    shot = Image.open(shot_path).convert("RGB")
    available = H - SHOT_TOP - SHOT_BOTTOM_MARGIN
    scale = min(available / shot.height, (W - 2 * MARGIN) / shot.width)
    shot = shot.resize(
        (round(shot.width * scale), round(shot.height * scale)), Image.LANCZOS
    )
    shot = rounded(shot, CORNER)
    shot_x = (W - shot.width) // 2

    # Soft drop shadow so the screen lifts off the background.
    shadow = Image.new("RGBA", canvas.size, (0, 0, 0, 0))
    ImageDraw.Draw(shadow).rounded_rectangle(
        [
            (shot_x, SHOT_TOP + 18),
            (shot_x + shot.width, SHOT_TOP + shot.height + 18),
        ],
        radius=CORNER,
        fill=(0, 0, 0, 130),
    )
    canvas = Image.alpha_composite(canvas, shadow.filter(ImageFilter.GaussianBlur(26)))
    canvas.paste(shot, (shot_x, SHOT_TOP), shot)

    os.makedirs(os.path.dirname(out_path), exist_ok=True)
    canvas.convert("RGB").save(out_path, "PNG", optimize=True)
    print(f"  ✓ {out_path}")


def main() -> int:
    if not os.path.isdir(RAW_DIR):
        print(
            f"{RAW_DIR} is missing — run "
            "`flutter test tool/generate_screenshots.dart` first.",
            file=sys.stderr,
        )
        return 1

    for locale, captions in CAPTIONS.items():
        raw_locale_dir = os.path.join(RAW_DIR, locale)
        if not os.path.isdir(raw_locale_dir):
            print(f"skipping {locale}: no captures in {raw_locale_dir}")
            continue
        print(f"\nFraming {locale} screenshots …")
        for stem, (headline, subline) in captions.items():
            src = os.path.join(raw_locale_dir, f"{stem}.png")
            if not os.path.exists(src):
                print(f"  ! missing capture {src}", file=sys.stderr)
                continue
            compose(
                src,
                headline,
                subline,
                os.path.join(OUT_DIR, locale, f"screenshot-{stem}.png"),
            )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
