#!/usr/bin/env python3
"""Renders the Play Store feature graphic, one per store language.

    python3 tool/feature_graphic.py     # -> store-assets/<locale>/feature-graphic-1024x500.png
    python3 tool/feature_graphic.py og  # -> web/og-image.png (link preview, 1200x630)

The feature graphic is a per-language asset, and the previous one existed only
in German — so the English listing, which is now the default, had none.

It shares its palette, font and glow with `tool/caption_screenshots.py` on
purpose: the header banner and the six screenshots sit on the same page, and
two different design languages up there look like two different apps.

Requires Pillow and the app font in assets/fonts.
"""

from __future__ import annotations

import os
import sys
import unicodedata

from PIL import Image, ImageDraw, ImageFilter

from caption_screenshots import (
    PALETTE,
    RTL_LOCALES,
    _mix,
    _weighted,
    draw_text,
    rounded,
    shadow_paste,
    text_length,
)

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
    "es": ("PUZZLE DE BLOQUES", "Sin anuncios obligatorios. Sin conexión."),
    "fr": ("PUZZLE DE BLOCS", "Aucune pub imposée. Jouable hors ligne."),
    "id": ("PUZZLE BALOK", "Tanpa iklan paksa. Bisa main offline."),
    "it": ("PUZZLE A BLOCCHI", "Niente pubblicità obbligatoria. Offline."),
    "pt": ("JOGO DE BLOCOS", "Sem anúncios obrigatórios. Funciona offline."),
    "tr": ("BLOK BULMACA", "Zorunlu reklam yok. Çevrimdışı oynanır."),
    "nl": ("BLOKPUZZEL", "Geen verplichte advertenties. Speelt offline."),
    "pl": ("PUZZLE Z KLOCKÓW", "Bez wymuszonych reklam. Działa offline."),
    "vi": ("XẾP KHỐI", "Không bắt xem quảng cáo. Chơi offline."),
    "ja": ("ブロックパズル", "強制広告なし。オフラインで遊べる。"),
    "ko": ("블록 퍼즐", "강제 광고 없음. 오프라인 플레이."),
    "th": ("เกมต่อบล็อก", "ไม่มีโฆษณาบังคับ เล่นออฟไลน์ได้"),
    "zh": ("方块拼图", "零强制广告，离线也能玩。"),
    "zh_Hant": ("方塊拼圖", "零強制廣告，離線也能玩。"),
    "ar": ("لغز المكعبات", "بلا إعلانات إجبارية. تعمل دون إنترنت."),
    "uk": ("БЛОК-ПАЗЛ", "Без примусової реклами. Працює офлайн."),
    "hi": ("ब्लॉक पहेली", "ज़बरदस्ती के विज्ञापन नहीं। ऑफ़लाइन खेलें।"),
    "ms": ("TEKA-TEKI BLOK", "Tiada iklan paksa. Main luar talian."),
    "ro": ("PUZZLE CU BLOCURI", "Fără reclame forțate. Merge offline."),
    "cs": ("HLAVOLAM S KOSTKAMI", "Bez vynucených reklam. Hraje offline."),
    "hu": ("BLOKKOS KIRAKÓS", "Nincs kényszerített reklám. Offline is megy."),
    "sv": ("BLOCKPUSSEL", "Ingen påtvingad reklam. Spelas offline."),
    "ur": ("بلاک پزل", "جبری اشتہار نہیں۔ آف لائن کھیلیں۔"),
    "fil": ("BLOCK PUZZLE", "Walang sapilitang ad. Nalalaro offline."),
    "he": ("פאזל בלוקים", "בלי מודעות כפויות. עובד אופליין."),
    "hr": ("SLAGALICA S BLOKOVIMA", "Bez nametnutih oglasa. Igra offline."),
    "bg": ("ПЪЗЕЛ С БЛОКЧЕТА", "Без натрапени реклами. Играе офлайн."),
    "fi": ("PALIKKAPELI", "Ei pakotettuja mainoksia. Toimii offline."),
    "nb": ("BLOKKPUSLESPILL", "Ingen påtvungne annonser. Spilles offline."),
    "da": ("BLOKPUSLESPIL", "Ingen tvungne reklamer. Spilles offline."),
    "el": ("ΠΑΖΛ ΜΕ ΤΟΥΒΛΑΚΙΑ", "Καμία διαφήμιση με το ζόρι. Offline."),
    "sk": ("HLAVOLAM S KOCKAMI", "Bez vynútených reklám. Hrá offline."),
}

# Scripts whose letters join or stack (Arabic, Urdu, Devanagari) or read as
# broken words when spaced (Thai): their eyebrow is drawn whole, untracked.
UNTRACKED = {"ar", "he", "hi", "th", "ur"}

# The tray colours from the Classic theme, as a brand strip.
CHIPS = [
    (0x7C, 0x6B, 0xFF),
    (0x4F, 0xE0, 0xC6),
    (0xF5, 0xF6, 0xFF),
    (0xFF, 0x6F, 0xB0),
    (0xFF, 0xC2, 0x4B),
]


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


def _clusters(text: str) -> list[str]:
    """Characters with the combining marks that belong to them."""
    out: list[str] = []
    for ch in text:
        if out and unicodedata.category(ch) == "Mn":
            out[-1] += ch
        else:
            out.append(ch)
    return out


def fit_text(
    draw, text: str, weight: int, size: int, max_width: int, floor: int,
    locale: str = "en",
):
    """Largest size at or below [size] that keeps [text] on one line.

    One line is the point: the German graphic used to wrap its tagline and left
    a single word hanging on the second line.
    """
    while size > floor:
        font = _weighted(size, weight, locale)
        if text_length(draw, text, font) <= max_width:
            return font
        size -= 2
    font = _weighted(floor, weight, locale)
    # Past the floor the text would run off the graphic, silently: the first
    # Greek tagline did. Shorter copy is the fix, not a smaller font.
    if text_length(draw, text, font) > max_width:
        sys.exit(f"{locale}: {text!r} does not fit in {max_width} px even at "
                 f"{floor} px — shorten it in COPY")
    return font


def build(locale: str, w: int = W, h: int = H, out: str | None = None) -> str:
    eyebrow, tagline = COPY[locale]
    safe_l, safe_r = SAFE_L, w - (W - SAFE_R)
    canvas = background(w, h).convert("RGBA")
    draw = ImageDraw.Draw(canvas)

    # App icon on the left, inside the safe area — on the right for a
    # right-to-left language, with the text block mirrored beside it.
    rtl = locale in RTL_LOCALES
    icon_size = 268
    icon = Image.open(ICON).convert("RGB").resize((icon_size, icon_size), Image.LANCZOS)
    icon_y = (h - icon_size) // 2
    icon_x = safe_r - 8 - icon_size if rtl else safe_l + 8
    canvas = shadow_paste(canvas, rounded(icon, 60), icon_x, icon_y, 60)
    draw = ImageDraw.Draw(canvas)

    x = safe_l if rtl else safe_l + 8 + icon_size + 60
    x_end = icon_x - 60 if rtl else safe_r
    avail = x_end - x

    def start(width: float) -> float:
        """Left edge of a line of [width] in the text block."""
        return x_end - width if rtl else x

    # The wordmark is Latin in every language, so it stays in Nunito; the
    # eyebrow and tagline take the locale's font (Noto Sans CJK for ja/ko).
    eyebrow_font = _weighted(28, 800, locale)
    word_font = fit_text(draw, "Qubble.", 800, 108, avail, 72)
    tag_font = fit_text(draw, tagline, 500, 34, avail, 24, locale)

    word_h = word_font.getbbox("Qubble")[3] - word_font.getbbox("Qubble")[1]
    block_h = 28 + 20 + word_h + 40 + 34 + 30 + 46
    y = (h - block_h) // 2

    # Letterspaced eyebrow — Pillow has no tracking, so step the glyphs, a
    # whole cluster at a time: a combining mark drawn on its own would land
    # beside its letter instead of on it.
    if locale in UNTRACKED:
        draw_text(draw, (start(text_length(draw, eyebrow, eyebrow_font)), y),
                  eyebrow, eyebrow_font, EYEBROW)
    else:
        cx = x
        for ch in _clusters(eyebrow):
            draw_text(draw, (cx, y), ch, eyebrow_font, EYEBROW)
            cx += text_length(draw, ch, eyebrow_font) + 5
    y += 28 + 20

    # Wordmark, with the full stop in the accent colour.
    word_x = start(draw.textlength("Qubble.", font=word_font))
    draw.text((word_x, y), "Qubble", font=word_font, fill=TEXT)
    dot_x = word_x + draw.textlength("Qubble", font=word_font)
    draw.text((dot_x, y), ".", font=word_font, fill=PALETTE["classic"][1])
    y += word_h + 40

    draw_text(draw, (start(text_length(draw, tagline, tag_font)), y), tagline, tag_font, MUTED)
    y += 34 + 30

    chip, gap = 46, 14
    row_x = start(len(CHIPS) * chip + (len(CHIPS) - 1) * gap)
    for i, colour in enumerate(CHIPS):
        cx = row_x + i * (chip + gap)
        draw.rounded_rectangle(
            [(cx, y), (cx + chip, y + chip)], radius=13, fill=colour
        )

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
    # `python3 tool/feature_graphic.py es fr` builds only those locales;
    # `og` builds the web link preview.
    for locale in sys.argv[1:] or COPY:
        if locale == "og":
            print(f"  ✓ {build('en', OG_W, OG_H, OG_OUT)}")
        else:
            print(f"  ✓ {build(locale)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
