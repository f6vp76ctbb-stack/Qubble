#!/usr/bin/env python3
"""Renders the image assets for the Google Ads App campaign.

    python3 tool/ad_creatives.py          # -> store-assets/ads/<locale>/

App campaigns take three image shapes and switch between them per placement,
so all three have to exist or the campaign simply does not serve where a shape
is missing: 1200x1200 (square), 1200x628 (landscape) and 1200x1500 (portrait)
(<https://support.google.com/google-ads/answer/17091671>).

The board pixels come from the finished store screenshots in
`store-assets/<locale>/`, which are themselves rendered from the real app
(`tool/generate_screenshots.dart`). Nothing here repaints the game: an ad that
shows a UI the app does not have is a Misrepresentation case, exactly like a
store screenshot that does.

The caption band of the source screenshot is cropped away on purpose — the ad
supplies its own headline, and two headlines stacked on one image read as a
mistake. The crop line is measured below, not guessed.

Palette, font and glow are shared with `tool/caption_screenshots.py` and
`tool/feature_graphic.py` so the ad, the listing header and the screenshots
do not look like three different apps.

Requires Pillow and the app font in assets/fonts.
"""

from __future__ import annotations

import os

from PIL import Image, ImageDraw, ImageFilter

from caption_screenshots import PALETTE, _mix, _weighted, rounded, shadow_paste

SRC_DIR = "store-assets"
OUT_DIR = "store-assets/ads"
ICON = "store-assets/app-icon-512.png"

# The three shapes an App campaign asks for.
FORMATS = {
    "square": (1200, 1200),
    "landscape": (1200, 628),
    "portrait": (1200, 1500),
}

TEXT = (245, 247, 255)
MUTED = (168, 174, 205)

# Source screenshots are 1080x1920 and share one layout: caption band on top,
# board card below. Measured on store-assets/en/screenshot-1-clear.png — the
# accent rule under the subline ends at y=404, the card's own glow starts
# around y=520. 470 sits between the two, so the crop takes the card with air
# above it and no trace of the burned-in headline.
CAPTION_FLOOR = 470

# A row of the bare plate spans at most this much grey between its darkest
# and brightest pixel; anything wider is the card, its glow or a particle.
FLAT_RANGE = 12

# Air kept around the measured card so it does not sit flush against the
# creative's rounded corner.
BLEED = 24

# The accent rule under a caption is 8 px tall and the headline's descenders
# reach ~60 px; the board card is never shorter than a third of the frame.
MIN_CARD = 200

# Which screenshot carries which creative, and the claim that goes with it.
# Every line has to survive a reading of the code — same bar as the store
# listing, because an ad is metadata too. "No forced ads" is backed by
# lib/monetization/ads.dart carrying rewarded units only.
CREATIVES = {
    "en": [
        ("clear", "1-clear", "classic", "Fill a line.", "Watch it go."),
        ("combo", "2-combo", "neon", "Chain the clears.", "Watch the score run."),
        ("noads", "6-offline", "classic", "No forced ads.", "Not one, anywhere."),
        ("daily", "3-daily", "ocean", "A new board daily.", "Same one for everyone."),
    ],
    "de": [
        ("clear", "1-clear", "classic", "Reihe voll.", "Reihe weg."),
        ("combo", "2-combo", "neon", "Clears verketten.", "Punkte explodieren."),
        ("noads", "6-offline", "classic", "Keine Zwangswerbung.", "Nirgends, nie."),
        ("daily", "3-daily", "ocean", "Jeden Tag neu.", "Für alle dasselbe Board."),
    ],
}


def plate(size: tuple[int, int], theme: str) -> Image.Image:
    """Vertical gradient with a soft accent glow, sized to the format."""
    w, h = size
    base, accent = PALETTE[theme]
    top = _mix(base, (0, 0, 0), 0.35)
    bottom = _mix(base, (255, 255, 255), 0.06)
    column = Image.new("RGB", (1, h))
    px = column.load()
    for y in range(h):
        px[0, y] = _mix(top, bottom, y / (h - 1))
    canvas = column.resize((w, h), Image.BILINEAR)

    glow = Image.new("RGB", (w, h), (0, 0, 0))
    ImageDraw.Draw(glow).ellipse(
        [(-w * 0.20, h * 0.25), (w * 1.20, h * 0.95)], fill=accent
    )
    glow = glow.filter(ImageFilter.GaussianBlur(int(min(w, h) * 0.18)))
    return Image.blend(canvas, Image.blend(canvas, glow, 0.22), 1.0)


def _bands(img: Image.Image, top: int) -> list[tuple[int, int]]:
    """Contiguous row bands below [top] that carry more than the flat plate.

    A row counts as content when its grey range exceeds [FLAT_RANGE], which the
    plate's own vertical gradient never does.
    """
    grey = img.convert("L")
    out: list[list[int]] = []
    for y in range(top, grey.height):
        lo, hi = grey.crop((0, y, grey.width, y + 1)).getextrema()
        if hi - lo <= FLAT_RANGE:
            continue
        if out and y - out[-1][1] <= 1:
            out[-1][1] = y
        else:
            out.append([y, y])
    return [(a, b) for a, b in out]


def board_art(locale: str, stem: str) -> Image.Image:
    """The source screenshot cropped to the board card alone.

    The caption band goes because the ad brings its own headline; the empty
    plate above and below the card goes because it is empty.

    [CAPTION_FLOOR] alone is not enough. The caption's accent rule sits at a
    different height on every frame — the German statement frame wraps its
    headline one line shorter and pushes the rule below the floor, where a
    fixed crop leaves a stray teal dash floating above the board. So any thin
    band that is separated from the card by a stretch of bare plate is dropped:
    the card is the first band taller than [MIN_CARD].
    """
    src = Image.open(os.path.join(SRC_DIR, locale, f"screenshot-{stem}.png")).convert("RGB")
    bands = [b for b in _bands(src, CAPTION_FLOOR) if b[1] - b[0] >= MIN_CARD]
    if not bands:
        return src.crop((0, CAPTION_FLOOR, src.width, src.height))
    top = max(CAPTION_FLOOR, bands[0][0] - BLEED)
    bottom = min(src.height, bands[-1][1] + 1 + BLEED)
    return src.crop((0, top, src.width, bottom))


def fit_height(art: Image.Image, height: int) -> Image.Image:
    scale = height / art.height
    return art.resize((max(1, round(art.width * scale)), height), Image.LANCZOS)


def fit_width(art: Image.Image, width: int) -> Image.Image:
    scale = width / art.width
    return art.resize((width, max(1, round(art.height * scale))), Image.LANCZOS)


def draw_block(canvas, x, y, width, head, sub, accent, head_size, sub_size):
    """Headline, subline and the accent rule under them. Returns the bottom y."""
    draw = ImageDraw.Draw(canvas)
    hf = _weighted(head_size, 800)
    sf = _weighted(sub_size, 500)
    draw.text((x, y), head, font=hf, fill=TEXT)
    y += round(head_size * 1.16)
    draw.text((x, y), sub, font=sf, fill=MUTED)
    y += round(sub_size * 1.5)
    draw.rounded_rectangle(
        [(x, y), (x + round(width * 0.18), y + max(4, head_size // 14))],
        radius=6,
        fill=accent,
    )
    return y + head_size // 10


def badge(canvas, x, y, size):
    """The app icon, rounded, as the only branding on the creative."""
    icon = Image.open(ICON).convert("RGB").resize((size, size), Image.LANCZOS)
    return shadow_paste(canvas, rounded(icon, size // 4), x, y, size // 4)


def landscape(theme, art, head, sub):
    w, h = FORMATS["landscape"]
    canvas = plate((w, h), theme).convert("RGBA")
    accent = PALETTE[theme][1]

    panel = fit_height(art, round(h * 0.92))
    px = w - panel.width - 48
    canvas = shadow_paste(canvas, rounded(panel, 34), px, (h - panel.height) // 2, 34)

    canvas = badge(canvas, 64, 62, 96)
    draw_block(canvas, 64, 200, px - 128, head, sub, accent, 62, 34)
    return canvas.convert("RGB")


def square(theme, art, head, sub):
    w, h = FORMATS["square"]
    canvas = plate((w, h), theme).convert("RGBA")
    accent = PALETTE[theme][1]

    canvas = badge(canvas, 72, 72, 104)
    bottom = draw_block(canvas, 72, 210, w - 144, head, sub, accent, 72, 38)

    panel = fit_width(art, w - 144)
    room = h - bottom - 64
    if panel.height > room:
        panel = fit_height(panel, room)
    canvas = shadow_paste(canvas, rounded(panel, 34), (w - panel.width) // 2, bottom + 46, 34)
    return canvas.convert("RGB")


def portrait(theme, art, head, sub):
    w, h = FORMATS["portrait"]
    canvas = plate((w, h), theme).convert("RGBA")
    accent = PALETTE[theme][1]

    canvas = badge(canvas, 80, 80, 112)
    bottom = draw_block(canvas, 80, 232, w - 160, head, sub, accent, 78, 40)

    panel = fit_width(art, w - 160)
    room = h - bottom - 70
    if panel.height > room:
        panel = fit_height(panel, room)
    canvas = shadow_paste(canvas, rounded(panel, 36), (w - panel.width) // 2, bottom + 52, 36)
    return canvas.convert("RGB")


BUILDERS = {"landscape": landscape, "square": square, "portrait": portrait}


def build(locale: str) -> int:
    out = os.path.join(OUT_DIR, locale)
    os.makedirs(out, exist_ok=True)
    written = 0
    for name, stem, theme, head, sub in CREATIVES[locale]:
        art = board_art(locale, stem)
        for shape, builder in BUILDERS.items():
            img = builder(theme, art, head, sub)
            assert img.size == FORMATS[shape], (shape, img.size)
            path = os.path.join(out, f"{name}-{shape}.png")
            img.save(path, "PNG", optimize=True)
            written += 1
    return written


def main() -> int:
    total = sum(build(locale) for locale in CREATIVES)
    print(f"{total} ad creatives -> {OUT_DIR}/<locale>/")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
