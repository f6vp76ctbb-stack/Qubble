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
import re
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

# Japanese and Korean: Nunito has no kana, kanji or hangul, so the phone draws
# them in its own CJK font — on Android, Noto Sans CJK. The frames use the same
# (`apt install fonts-noto-cjk`; for rendering here only, never bundled). The
# collection holds one face per region; the value is the one to use.
CJK_FONT = "/usr/share/fonts/opentype/noto/NotoSansCJK-{}.ttc"
# 0 = JP cut, 1 = KR cut, 2 = Simplified Chinese, 3 = Traditional Chinese.
CJK_FACES = {"ja": 0, "ko": 1, "zh": 2, "zh_Hant": 3}

# Thai and Hindi: likewise drawn by the phone, here in Noto Sans Thai and
# Noto Sans Devanagari (`apt install fonts-noto-core`). Neither face has Latin
# letters (Thai not even digits), so each is paired with Nunito for the rest
# (FallbackFont).
THAI_FONT = "/usr/share/fonts/truetype/noto/NotoSansThai-{}.ttf"
DEVANAGARI_FONT = "/usr/share/fonts/truetype/noto/NotoSansDevanagari-{}.ttf"
# Tamil, Telugu, Gujarati, Kannada, Malayalam, Punjabi (Gurmukhi) and Bengali:
# their Noto Sans faces, likewise without Latin letters.
TAMIL_FONT = "/usr/share/fonts/truetype/noto/NotoSansTamil-{}.ttf"
TELUGU_FONT = "/usr/share/fonts/truetype/noto/NotoSansTelugu-{}.ttf"
GUJARATI_FONT = "/usr/share/fonts/truetype/noto/NotoSansGujarati-{}.ttf"
KANNADA_FONT = "/usr/share/fonts/truetype/noto/NotoSansKannada-{}.ttf"
MALAYALAM_FONT = "/usr/share/fonts/truetype/noto/NotoSansMalayalam-{}.ttf"
GURMUKHI_FONT = "/usr/share/fonts/truetype/noto/NotoSansGurmukhi-{}.ttf"
BENGALI_FONT = "/usr/share/fonts/truetype/noto/NotoSansBengali-{}.ttf"
# Hebrew: Noto Sans Hebrew, which has no Latin letters either.
HEBREW_FONT = "/usr/share/fonts/truetype/noto/NotoSansHebrew-{}.ttf"
FALLBACK_FONTS = {"th": THAI_FONT, "hi": DEVANAGARI_FONT, "he": HEBREW_FONT,
                  "mr": DEVANAGARI_FONT, "ne": DEVANAGARI_FONT,
                  "ta": TAMIL_FONT, "te": TELUGU_FONT,
                  "gu": GUJARATI_FONT, "kn": KANNADA_FONT,
                  "ml": MALAYALAM_FONT, "pa": GURMUKHI_FONT,
                  "bn": BENGALI_FONT}

# Greek: Nunito has a few Greek letters (µ, Δ, Ω) but not the alphabet, so the
# phone draws the rest with its own font. Noto Sans stands in for it here — for
# Greek letters only; Latin letters and digits stay in Nunito, as on the phone.
GREEK_FONT = "/usr/share/fonts/truetype/noto/NotoSans-{}.ttf"
GREEK_BLOCKS = [(0x0370, 0x03FF), (0x1F00, 0x1FFF)]

# Arabic and Urdu: Noto Sans Arabic (`apt install fonts-noto-core`), which
# has the Urdu letters too. It has Arabic digits and punctuation but no Latin
# letters, so neither copy uses any.
ARABIC_FONT = "/usr/share/fonts/truetype/noto/NotoSansArabic-{}.ttf"
ARABIC_SCRIPT = {"ar", "ur"}

# Every locale whose captions are not drawn in Nunito.
SCRIPT_LOCALES = set(CJK_FACES) | set(FALLBACK_FONTS) | ARABIC_SCRIPT

# Laid out from the right: text right-aligned, bullets and rules on the right.
RTL_LOCALES = {"ar", "he", "ur"}

# Japanese runs without spaces, so wrap() breaks it between characters — but
# never right before one of these (kinsoku: closing punctuation and small kana
# may not start a line).
NO_LINE_START = set("、。，．・：；？！ー）」』】〕ぁぃぅぇぉっゃゅょァィゥェォッャュョ")
# Thai vowel signs and tone marks attach to the consonant before them, and so
# do Devanagari vowel signs, virama and nasal marks.
NO_LINE_START |= set("ะัาำิีึืฺุู็่้๊๋์ํ๎")
NO_LINE_START |= {chr(c) for c in [*range(0x0900, 0x0904), *range(0x093A, 0x0950),
                                   *range(0x0951, 0x0958), 0x0962, 0x0963]}
# The other Indic scripts' vowel signs and viramas likewise.
NO_LINE_START |= {chr(c) for c in [*range(0x0BBE, 0x0BCE), 0x0BD7]}
NO_LINE_START |= {chr(c) for c in [*range(0x0C00, 0x0C04), *range(0x0C3E, 0x0C4E),
                                   0x0C55, 0x0C56]}
NO_LINE_START |= {chr(c) for c in [*range(0x0A81, 0x0A84), *range(0x0ABC, 0x0ACE),
                                   0x0AE2, 0x0AE3]}
NO_LINE_START |= {chr(c) for c in [*range(0x0C81, 0x0C84), *range(0x0CBC, 0x0CCE),
                                   0x0CD5, 0x0CD6, 0x0CE2, 0x0CE3]}
NO_LINE_START |= {chr(c) for c in [*range(0x0D00, 0x0D04), 0x0D3B, 0x0D3C,
                                   *range(0x0D3E, 0x0D4E), 0x0D57, 0x0D62, 0x0D63]}
NO_LINE_START |= {chr(c) for c in [*range(0x0A01, 0x0A04), 0x0A3C,
                                   *range(0x0A3E, 0x0A4E), 0x0A51, 0x0A70, 0x0A71,
                                   0x0A75]}
NO_LINE_START |= {chr(c) for c in [*range(0x0981, 0x0984), 0x09BC,
                                   *range(0x09BE, 0x09CE), 0x09D7, 0x09E2, 0x09E3,
                                   0x09FE]}

# (background, accent) of every theme, read straight from lib/ui/theme.dart so
# every frame agrees with the app it shows — and a new theme needs no copy here.
def _theme_palette() -> dict[str, tuple[tuple[int, int, int], tuple[int, int, int]]]:
    src = open("lib/ui/theme.dart", encoding="utf-8").read()
    src = src[src.index("const List<ThemeEntry> kThemeCatalog"):]
    named = {"kDefaultThemeId": "classic", "kHalloweenThemeId": "pumpkin"}

    def rgb(chunk, field):
        value = re.search(field + r":\s*Color\(0x[0-9A-Fa-f]{2}([0-9A-Fa-f]{6})\)", chunk)
        h = value.group(1)
        return tuple(int(h[i:i + 2], 16) for i in (0, 2, 4))

    palette = {}
    for chunk in src.split("ThemeEntry(")[1:]:
        raw = re.search(r"id:\s*('(\w+)'|(\w+))", chunk)
        theme_id = raw.group(2) or named[raw.group(3)]
        palette[theme_id] = (rgb(chunk, "background"), rgb(chunk, "placed"))
    return palette


PALETTE = _theme_palette()

# stem -> (layout, theme, source capture, keep the header band above the board)
#
# Owner, 02.10.2026: the gallery leads with how many ways the game can look.
# Frames 1 to 5 are about the designs — a mosaic of whole looks, the clear in
# a look that is not the default, the skins, the themes, the accessories —
# and the last three keep the Daily, the puzzles and the no-forced-ads claim.
#
# The header carries score and best. Only the Daily Challenge takes it: every
# other mode draws a full-width "New pieces (video)" button between the header
# and the board, and a crop that reaches up for the score has to bring that
# along — a video call-to-action is the last thing a frame should be selling.
# The Daily hides it (game_screen.dart gates it on `!isDaily`), so there the
# score row crops clean.
FRAMES = [
    ("1-designs", "mosaic", "classic", None, False),
    ("2-clear", "hero", "candy", "1-clear", False),
    ("3-skins", "skins", "aurora", None, False),
    ("4-themes", "themes", "sunset", None, False),
    ("5-extras", "extras", "forest", None, False),
    ("6-daily", "hero", "glacier", "3-daily", True),
    ("7-puzzle", "screen", "wood", "4-puzzle", False),
    ("8-offline", "statement", "classic", "6-home", False),
]

# Top of the header band, in capture pixels: below the coin chip, above SCORE.
HEADER_TOP = 125

# The tiles of the design frames, in reading order. Raw captures from
# tool/generate_screenshots.dart; their labels are the names the app shows
# (store-assets/raw/<locale>/designs.json), never typed in here.
MOSAIC = [f"look-{i}" for i in range(1, 10)]
SKIN_TILES = ["jelly", "crystal", "marble", "prism", "plasma", "fizz",
              "pixel", "liquid", "stardust"]
THEME_TILES = ["classic", "neon", "candy", "ocean", "volcano", "glacier",
               "wood", "sunset", "forest"]
ACCESSORY_TILES = ["crown", "flower", "snowCap", "sparkle", "dewdrop", "cobweb"]
# What frame 2 shows, named under the headline (generate_screenshots.dart).
CLEAR_LOOK = {"theme": "candy", "skin": "jelly", "burst": "confetti"}

# Every claim here has to survive a reading of the code, because a screenshot
# that overstates the app is a Misrepresentation case, not a marketing choice.
# "solvable" is safe: PuzzleGenerator builds each level solvable by
# construction and the solver verifies it (lib/game/puzzle.dart). "One move"
# rather than "one tap": pieces are dragged.
CAPTIONS = {
    "en": {
        "2-clear": ("Fill a line.\nWatch it blow.", "One move, one satisfying clear"),
        "6-daily": ("A new board\nevery day", "Same puzzle for everyone. Build a streak."),
        "4-themes": ("Eight themes.\nPick your mood.", "Wood, neon, ocean, forest and more"),
        "7-puzzle": ("Every puzzle\nhas a solution", "Checked by the solver, not left to chance"),
        "8-offline": ("No forced ads.\nEver.", "No sign-up, no interruptions. Plays on a plane."),
    },
    "de": {
        "2-clear": ("Reihe voll.\nReihe weg.", "Ein Zug, ein befriedigendes Clear"),
        "6-daily": ("Jeden Tag\nein neues Board", "Für alle dasselbe Puzzle. Bau deinen Streak."),
        "4-themes": ("Acht Themes.\nDeine Stimmung.", "Holz, Neon, Ozean, Wald und mehr"),
        "7-puzzle": ("Jedes Rätsel\nist lösbar", "Vom Solver geprüft, nicht dem Zufall überlassen"),
        "8-offline": ("Keine Zwangs-\nwerbung.", "Keine Anmeldung, keine Unterbrechung. Läuft im Flugzeug."),
    },
    # The six languages added on 2026-09-23 translate the English captions
    # claim for claim; nothing here says more than the English line does.
    "es": {
        "2-clear": ("Llena una línea.\nMira cómo estalla.", "Un movimiento, una limpieza satisfactoria"),
        "6-daily": ("Un tablero nuevo\ncada día", "El mismo desafío para todos. Construye tu racha."),
        "4-themes": ("Ocho temas.\nElige tu estilo.", "Madera, neón, océano, bosque y más"),
        "7-puzzle": ("Cada rompecabezas\ntiene solución", "Verificado por el solucionador, no por azar"),
        "8-offline": ("Sin anuncios\nobligatorios. Nunca.", "Sin registro, sin interrupciones. Se juega en el avión."),
    },
    "fr": {
        "2-clear": ("Remplis une ligne.\nRegarde-la exploser.", "Un coup, un effacement satisfaisant"),
        "6-daily": ("Une nouvelle grille\nchaque jour", "Le même défi pour tous. Construis ta série."),
        "4-themes": ("Huit thèmes.\nSelon ton humeur.", "Bois, néon, océan, forêt et plus encore"),
        "7-puzzle": ("Chaque puzzle\na sa solution", "Vérifié par le solveur, pas laissé au hasard"),
        "8-offline": ("Aucune pub imposée.\nJamais.", "Sans inscription, sans interruption. Même en avion."),
    },
    "id": {
        "2-clear": ("Penuhi satu garis.\nLihat meledak.", "Satu langkah, satu pembersihan yang memuaskan"),
        "6-daily": ("Papan baru\nsetiap hari", "Tantangan sama untuk semua. Bangun runtunanmu."),
        "4-themes": ("Delapan tema.\nSesuai suasana.", "Kayu, neon, samudra, hutan, dan lainnya"),
        "7-puzzle": ("Setiap teka-teki\nada solusinya", "Diperiksa pemecah otomatis, bukan untung-untungan"),
        "8-offline": ("Tanpa iklan paksa.\nSelamanya.", "Tanpa daftar, tanpa gangguan. Bisa main di pesawat."),
    },
    "it": {
        "2-clear": ("Riempi una linea.\nGuardala esplodere.", "Una mossa, un’eliminazione che appaga"),
        "6-daily": ("Una griglia nuova\nogni giorno", "La stessa sfida per tutti. Costruisci la tua serie."),
        "4-themes": ("Otto temi.\nScegli il tuo stile.", "Legno, neon, oceano, foresta e altro"),
        "7-puzzle": ("Ogni puzzle\nha una soluzione", "Verificato dal risolutore, non lasciato al caso"),
        "8-offline": ("Niente pubblicità\nobbligatoria. Mai.", "Niente registrazione, niente interruzioni. Anche in aereo."),
    },
    "pt": {
        "2-clear": ("Complete a linha.\nVeja explodir.", "Uma jogada, uma limpeza satisfatória"),
        "6-daily": ("Um tabuleiro novo\ntodo dia", "O mesmo desafio para todos. Crie sua sequência."),
        "4-themes": ("Oito temas.\nEscolha seu estilo.", "Madeira, neon, oceano, floresta e mais"),
        "7-puzzle": ("Todo quebra-cabeça\ntem solução", "Verificado pelo solucionador, não pela sorte"),
        "8-offline": ("Sem anúncios\nobrigatórios. Nunca.", "Sem cadastro, sem interrupções. Funciona no avião."),
    },
    "tr": {
        "2-clear": ("Satırı doldur.\nPatlamasını izle.", "Tek hamle, tatmin edici bir temizlik"),
        "6-daily": ("Her gün\nyeni bir tahta", "Herkes için aynı bulmaca. Serini kur."),
        "4-themes": ("Sekiz tema.\nModuna göre seç.", "Ahşap, neon, okyanus, orman ve dahası"),
        "7-puzzle": ("Her bulmacanın\nbir çözümü var", "Çözücüyle doğrulandı, şansa bırakılmadı"),
        "8-offline": ("Zorunlu reklam yok.\nAsla.", "Kayıt yok, kesinti yok. Uçakta bile oynanır."),
    },
    "nl": {
        "2-clear": ("Vul een lijn.\nZie hem knallen.", "Eén zet, één heerlijke clear"),
        "6-daily": ("Elke dag\neen nieuw bord", "Dezelfde puzzel voor iedereen. Bouw een reeks."),
        "4-themes": ("Acht thema's.\nKies je sfeer.", "Hout, neon, oceaan, bos en meer"),
        "7-puzzle": ("Elke puzzel\nis oplosbaar", "Gecontroleerd door de solver, niet aan het toeval overgelaten"),
        "8-offline": ("Geen verplichte\nadvertenties. Nooit.", "Geen account, geen onderbrekingen. Speelt in het vliegtuig."),
    },
    "pl": {
        "2-clear": ("Wypełnij linię.\nPatrz, jak wybucha.", "Jeden ruch, jedno satysfakcjonujące czyszczenie"),
        "6-daily": ("Nowa plansza\ncodziennie", "To samo wyzwanie dla wszystkich. Buduj serię."),
        "4-themes": ("Osiem motywów.\nWybierz nastrój.", "Drewno, neon, ocean, las i więcej"),
        "7-puzzle": ("Każda łamigłówka\nma rozwiązanie", "Sprawdzone przez solver, nie dzieło przypadku"),
        "8-offline": ("Bez wymuszonych\nreklam. Nigdy.", "Bez rejestracji, bez przerw. Działa w samolocie."),
    },
    "vi": {
        "2-clear": ("Lấp đầy một hàng.\nNgắm nó nổ tung.", "Một nước đi, một pha xóa đã mắt"),
        "6-daily": ("Mỗi ngày\nmột bàn mới", "Cùng thử thách cho mọi người. Xây chuỗi ngày."),
        "4-themes": ("Tám chủ đề.\nChọn theo tâm trạng.", "Gỗ, neon, đại dương, rừng xanh và hơn nữa"),
        "7-puzzle": ("Câu đố nào\ncũng có lời giải", "Bộ giải đã kiểm tra, không phó mặc may rủi"),
        "8-offline": ("Không bao giờ ép\nxem quảng cáo.", "Không đăng ký, không gián đoạn. Chơi cả trên máy bay."),
    },
    # "Combos multiply" is said as "the longer the combo, the more points": the
    # multiplier climbs in half steps (lib/game/scoring.dart), and a literal
    # "doubles" would overstate it.
    "ja": {
        "2-clear": ("1列そろえて、\nパッと消す。", "1手で、気持ちいいほど消える"),
        "6-daily": ("毎日、\n新しい盤面", "みんな同じ盤面に挑戦。連続記録を伸ばそう。"),
        "4-themes": ("8つのテーマ。\n気分で選ぼう。", "ウッド、ネオン、オーシャン、フォレストなど"),
        "7-puzzle": ("どのパズルにも\n答えがある", "ソルバーで確認済み。運まかせじゃない。"),
        "8-offline": ("強制広告は\n一切なし。", "登録なし、中断なし。機内でも遊べる。"),
    },
    "ko": {
        "2-clear": ("한 줄을 채우면\n펑 사라져요.", "한 수에 시원하게 지우기"),
        "6-daily": ("매일\n새로운 보드", "모두가 같은 퍼즐에 도전. 연속 기록을 이어가세요."),
        "4-themes": ("8가지 테마.\n기분대로 골라요.", "우드, 네온, 오션, 포레스트 등"),
        "7-puzzle": ("모든 퍼즐에는\n답이 있어요", "솔버로 검증, 운에 맡기지 않아요"),
        "8-offline": ("강제 광고는\n절대 없어요.", "가입 없이, 끊김 없이. 비행기에서도 플레이."),
    },
    # Thai has no spaces between words, only between phrases, and wrap() breaks
    # at spaces — so every line here is short enough to need no break at all.
    "th": {
        "2-clear": ("เติมให้เต็มแถว\nแล้วดูมันระเบิด", "วางครั้งเดียว เคลียร์สะใจ"),
        "6-daily": ("กระดานใหม่\nทุกวัน", "ทุกคนเจอโจทย์เดียวกัน สะสมวันต่อเนื่อง"),
        "4-themes": ("8 ธีม\nเลือกตามอารมณ์", "ไม้ นีออน มหาสมุทร ป่าไม้ และอื่น ๆ"),
        "7-puzzle": ("ทุกปริศนา\nมีทางออก", "ตรวจด้วยตัวแก้โจทย์ ไม่ได้ขึ้นกับดวง"),
        "8-offline": ("ไม่มีโฆษณาบังคับ\nตลอดไป", "ไม่ต้องสมัคร ไม่มีขัดจังหวะ เล่นบนเครื่องบินได้"),
    },
    # Row and column: in Taiwan 行 is a column and 列 a row — the reverse of
    # the mainland — so each script says it its own way.
    "zh": {
        "2-clear": ("填满一行，\n瞬间消除。", "一步到位，消得超爽快"),
        "6-daily": ("每天\n都有新棋盘", "所有人挑战同一题，累积连续天数。"),
        "4-themes": ("8 种主题，\n随心情挑选。", "木纹、霓虹、海洋、森林等等"),
        "7-puzzle": ("每道谜题\n都有解", "经过求解程序验证，不靠运气。"),
        "8-offline": ("零强制广告。\n永远如此。", "免注册、不打断，飞机上也能玩。"),
    },
    "zh_Hant": {
        "2-clear": ("填滿一排，\n瞬間消除。", "一步到位，消得超爽快"),
        "6-daily": ("每天\n都有新棋盤", "所有人挑戰同一題，累積連續天數。"),
        "4-themes": ("8 種主題，\n隨心情挑選。", "木紋、霓虹、海洋、森林等等"),
        "7-puzzle": ("每道謎題\n都有解", "經過解題程式驗證，不靠運氣。"),
        "8-offline": ("零強制廣告。\n永遠如此。", "免註冊、不中斷，飛機上也能玩。"),
    },
    # No Latin letters: Noto Sans Arabic has none, and a mixed line would need
    # bidirectional runs across two fonts.
    "ar": {
        "2-clear": ("املأ صفًا\nوشاهده ينفجر.", "حركة واحدة، ومسح ممتع"),
        "6-daily": ("لوحة جديدة\nكل يوم", "التحدي نفسه للجميع. ابنِ سلسلة أيامك."),
        "4-themes": ("8 سمات.\nاختر ما يناسب مزاجك.", "الخشب والنيون والمحيط والغابة والمزيد"),
        "7-puzzle": ("لكل لغز\nحل", "تحقق منه برنامج الحل، لا مكان للحظ"),
        "8-offline": ("بلا إعلانات إجبارية.\nأبدًا.", "بلا تسجيل وبلا مقاطعات. العب حتى في الطائرة."),
    },
    "uk": {
        "2-clear": ("Заповни лінію.\nІ вона вибухне.", "Один хід — і приємне очищення"),
        "6-daily": ("Нове поле\nщодня", "Однаковий виклик для всіх. Тримай серію."),
        "4-themes": ("Вісім тем.\nНа будь-який смак.", "Дерево, неон, океан, ліс та інші"),
        "7-puzzle": ("Кожна головоломка\nмає розв’язок", "Перевірено розв’язувачем, а не залишено на удачу"),
        "8-offline": ("Без примусової\nреклами. Ніколи.", "Без реєстрації, без перерв. Грає навіть у літаку."),
    },
    "hi": {
        "2-clear": ("लाइन भरें।\nऔर धमाका देखें।", "एक चाल, एक मज़ेदार क्लियर"),
        "6-daily": ("हर दिन\nनया बोर्ड", "सबके लिए एक ही चुनौती। अपना सिलसिला बनाएँ।"),
        "4-themes": ("8 थीम।\nमूड के हिसाब से चुनें।", "लकड़ी, नियॉन, समुद्र, जंगल और भी बहुत कुछ"),
        "7-puzzle": ("हर पहेली\nहल हो सकती है", "सॉल्वर से जाँची गई, किस्मत के भरोसे नहीं"),
        "8-offline": ("ज़बरदस्ती के विज्ञापन\nकभी नहीं।", "न साइन-अप, न रुकावट। हवाई जहाज़ में भी खेलें।"),
    },
    "ms": {
        "2-clear": ("Penuhkan baris.\nLihat ia meletup.", "Satu langkah, satu kepuasan"),
        "6-daily": ("Papan baharu\nsetiap hari", "Cabaran yang sama untuk semua. Kekalkan rentetan."),
        "4-themes": ("Lapan tema.\nIkut mood anda.", "Kayu, neon, lautan, hutan dan banyak lagi"),
        "7-puzzle": ("Setiap teka-teki\nboleh diselesaikan", "Disemak oleh penyelesai, bukan nasib"),
        "8-offline": ("Tiada iklan paksa.\nSampai bila-bila.", "Tanpa daftar, tanpa gangguan. Boleh main dalam kapal terbang."),
    },
    "ro": {
        "2-clear": ("Umple o linie.\nȘi uite-o cum dispare.", "O mutare, o eliminare pe cinste"),
        "6-daily": ("O tablă nouă\nîn fiecare zi", "Aceeași provocare pentru toți. Ține-ți seria."),
        "4-themes": ("Opt teme.\nDupă cum ai chef.", "Lemn, neon, ocean, pădure și altele"),
        "7-puzzle": ("Fiecare puzzle\nare rezolvare", "Verificat de un rezolvator, nu lăsat la noroc"),
        "8-offline": ("Fără reclame forțate.\nNiciodată.", "Fără cont, fără întreruperi. Merge și în avion."),
    },
    "cs": {
        "2-clear": ("Zaplň řadu.\nA sleduj, jak zmizí.", "Jeden tah, jedno parádní smazání"),
        "6-daily": ("Každý den\nnová deska", "Stejná výzva pro všechny. Drž sérii."),
        "4-themes": ("Osm motivů.\nPodle nálady.", "Dřevo, neon, oceán, les a další"),
        "7-puzzle": ("Každá hádanka\nmá řešení", "Ověřeno řešitelem, ne ponecháno náhodě"),
        "8-offline": ("Žádné vynucené\nreklamy. Nikdy.", "Bez registrace, bez přerušení. Hraje i v letadle."),
    },
    "hu": {
        "2-clear": ("Tölts ki egy sort.\nÉs már el is tűnt.", "Egy lépés, és tiszta a sor"),
        "6-daily": ("Minden nap\núj tábla", "Mindenkinek ugyanaz a feladvány. Építs sorozatot."),
        "4-themes": ("Nyolc téma.\nHangulat szerint.", "Fa, neon, óceán, erdő és még több"),
        "7-puzzle": ("Minden rejtvény\nmegoldható", "Megoldóprogram ellenőrzi, nem a véletlen"),
        "8-offline": ("Nincs kényszerített\nreklám. Soha.", "Regisztráció és megszakítás nélkül. Repülőn is megy."),
    },
    "sv": {
        "2-clear": ("Fyll en rad.\nSe den försvinna.", "Ett drag, en härlig rensning"),
        "6-daily": ("Ett nytt bräde\nvarje dag", "Samma pussel för alla. Bygg en svit."),
        "4-themes": ("Åtta teman.\nVälj ditt humör.", "Trä, neon, hav, skog och mer"),
        "7-puzzle": ("Varje pussel\nhar en lösning", "Kontrollerat av en lösare, inte lämnat åt slumpen"),
        "8-offline": ("Ingen påtvingad\nreklam. Aldrig.", "Ingen registrering, inga avbrott. Funkar på planet."),
    },
    "af": {
        "2-clear": ("Vul 'n lyn.\nKyk hoe dit bars.", "Een skuif, een bevredigende skoonmaak"),
        "6-daily": ("Elke dag\n'n nuwe bord", "Dieselfde puzzel vir almal. Bou 'n reeks."),
        "4-themes": ("Agt temas.\nNa jou bui.", "Hout, Neon, Oseaan, Woud en meer"),
        "7-puzzle": ("Elke puzzel\nhet 'n oplossing", "Deur 'n oplosser nagegaan, nie geluk nie"),
        "8-offline": ("Nooit verpligte\nadvertensies nie.", "Geen registrasie, geen onderbrekings. Werk selfs in die vliegtuig."),
    },
    "bs": {
        "2-clear": ("Popuni red.\nI gledaj kako nestaje.", "Jedan potez, jedno sjajno brisanje"),
        "6-daily": ("Nova ploča\nsvaki dan", "Ista zagonetka za sve. Gradi niz."),
        "4-themes": ("Osam tema.\nPo tvom raspoloženju.", "Drvo, neon, ocean, šuma i još"),
        "7-puzzle": ("Svaka zagonetka\nima rješenje", "Provjereno algoritmom, ne prepušteno slučaju"),
        "8-offline": ("Bez nametnutih\noglasa. Nikad.", "Bez registracije, bez prekida. Radi i u avionu."),
    },
    "mk": {
        "2-clear": ("Пополни ред.\nГледај како пука.", "Еден потег, едно задоволително бришење"),
        "6-daily": ("Секој ден\nнова табла", "Иста загатка за сите. Гради низа."),
        "4-themes": ("Осум теми.\nПо твое расположение.", "Дрво, Неон, Океан, Шума и други"),
        "7-puzzle": ("Секоја загатка\nима решение", "Проверено од програма, не среќа"),
        "8-offline": ("Никогаш\nзадолжителни реклами.", "Без регистрација, без прекини. Се игра и во авион."),
    },
    "sq": {
        "2-clear": ("Mbush një vijë.\nShiko si shpërthen.", "Një lëvizje, një pastrim i kënaqshëm"),
        "6-daily": ("Çdo ditë\nnjë fushë e re", "E njëjta enigmë për të gjithë. Ndërto serinë."),
        "4-themes": ("Tetë tema.\nSipas humorit.", "Dru, Neon, Oqean, Pyll e të tjera"),
        "7-puzzle": ("Çdo enigmë\nka zgjidhje", "E kontrolluar nga zgjidhësi, jo fat"),
        "8-offline": ("Kurrë reklama\ntë detyruara.", "Pa regjistrim, pa ndërprerje. Luhet edhe në avion."),
    },
    "kk": {
        "2-clear": ("Қатарды толтырыңыз.\nЖарылысты көріңіз.", "Бір жүріс, бір жағымды тазалау"),
        "6-daily": ("Күн сайын\nжаңа тақта", "Бәріне бір пазл. Серия жинаңыз."),
        "4-themes": ("Сегіз тақырып.\nКөңіл-күйге сай.", "Ағаш, Неон, Мұхит, Орман және т.б."),
        "7-puzzle": ("Әр пазлдың\nшешімі бар", "Бағдарлама тексерген, сәттілік емес"),
        "8-offline": ("Мәжбүрлі жарнама\nешқашан жоқ.", "Тіркелу жоқ, кедергі жоқ. Ұшақта да ойналады."),
    },
    "ne": {
        "2-clear": ("लाइन भर्नुहोस्।\nफुटेको हेर्नुहोस्।", "एक चाल, एउटा सन्तोषजनक सफाइ"),
        "6-daily": ("हरेक दिन\nनयाँ बोर्ड", "सबैका लागि उही पजल। स्ट्रिक बनाउनुहोस्।"),
        "4-themes": ("आठ थिम।\nमुड अनुसार।", "काठ, नियोन, समुद्र, जङ्गल र अरू"),
        "7-puzzle": ("हरेक पजलको\nसमाधान छ", "सल्भरले जाँचेको, भाग्य होइन"),
        "8-offline": ("जबरजस्ती विज्ञापन\nकहिल्यै छैन।", "साइन-अप छैन, अवरोध छैन। हवाईजहाजमा पनि चल्छ।"),
    },
    "mr": {
        "2-clear": ("ओळ भरा.\nफुटताना पाहा.", "एक चाल, एक समाधानकारक सफाई"),
        "6-daily": ("दररोज\nनवा बोर्ड", "सर्वांसाठी एकच पझल. स्ट्रीक वाढवा."),
        "4-themes": ("आठ थीम.\nमूडनुसार.", "लाकूड, निऑन, सागर, जंगल आणि आणखी"),
        "7-puzzle": ("प्रत्येक पझलला\nउत्तर आहे", "सॉल्व्हरने तपासलेले, नशीब नाही"),
        "8-offline": ("सक्तीची जाहिरात\nकधीच नाही.", "साइन-अप नाही, व्यत्यय नाही. विमानातही चालते."),
    },
    "bn": {
        "2-clear": ("লাইন ভরুন।\nফাটতে দেখুন।", "একটি চাল, একটি তৃপ্তিদায়ক সাফ"),
        "6-daily": ("প্রতিদিন\nনতুন বোর্ড", "সবার জন্য একই পাজল। স্ট্রিক গড়ুন।"),
        "4-themes": ("আটটি থিম।\nমেজাজ অনুযায়ী।", "কাঠ, নিয়ন, সমুদ্র, অরণ্য ও আরও"),
        "7-puzzle": ("প্রতিটি পাজলের\nসমাধান আছে", "সলভার যাচাই করেছে, ভাগ্য নয়"),
        "8-offline": ("জোর করে বিজ্ঞাপন\nকখনও নয়।", "সাইন-আপ নেই, বাধা নেই। বিমানেও চলে।"),
    },
    "pa": {
        "2-clear": ("ਲਾਈਨ ਭਰੋ।\nਫਟਦੀ ਦੇਖੋ।", "ਇੱਕ ਚਾਲ, ਇੱਕ ਮਜ਼ੇਦਾਰ ਸਫ਼ਾਈ"),
        "6-daily": ("ਹਰ ਰੋਜ਼\nਨਵਾਂ ਬੋਰਡ", "ਸਾਰਿਆਂ ਲਈ ਇੱਕੋ ਪਹੇਲੀ। ਲੜੀ ਬਣਾਓ।"),
        "4-themes": ("ਅੱਠ ਥੀਮ।\nਮੂਡ ਮੁਤਾਬਕ।", "ਲੱਕੜ, ਨਿਓਨ, ਸਮੁੰਦਰ, ਜੰਗਲ ਅਤੇ ਹੋਰ"),
        "7-puzzle": ("ਹਰ ਪਹੇਲੀ ਦਾ\nਹੱਲ ਹੈ", "ਸੌਲਵਰ ਨੇ ਜਾਂਚਿਆ, ਕਿਸਮਤ ਨਹੀਂ"),
        "8-offline": ("ਜ਼ਬਰਦਸਤੀ ਇਸ਼ਤਿਹਾਰ\nਕਦੇ ਨਹੀਂ।", "ਸਾਈਨ-ਅੱਪ ਨਹੀਂ, ਰੁਕਾਵਟ ਨਹੀਂ। ਜਹਾਜ਼ ਵਿੱਚ ਵੀ ਚੱਲਦੀ ਹੈ।"),
    },
    "ml": {
        "2-clear": ("വരി നിറയ്ക്കൂ.\nപൊട്ടുന്നത് കാണൂ.", "ഒരു നീക്കം, തൃപ്തികരമായ ഒരു മായ്ക്കൽ"),
        "6-daily": ("എല്ലാ ദിവസവും\nപുതിയ ബോർഡ്", "എല്ലാവർക്കും ഒരേ പസിൽ. സ്ട്രീക്ക് കെട്ടിപ്പടുക്കൂ."),
        "4-themes": ("എട്ട് തീമുകൾ.\nമൂഡിന് ഇണങ്ങിയത്.", "തടി, നിയോൺ, സമുദ്രം, കാട് എന്നിവയും മറ്റും"),
        "7-puzzle": ("ഓരോ പസിലിനും\nപരിഹാരമുണ്ട്", "സോൾവർ പരിശോധിച്ചത്, ഭാഗ്യമല്ല"),
        "8-offline": ("നിർബന്ധിത പരസ്യം\nഒരിക്കലുമില്ല.", "സൈൻ-അപ്പ് ഇല്ല, തടസ്സമില്ല. വിമാനത്തിലും കളിക്കാം."),
    },
    "kn": {
        "2-clear": ("ಸಾಲು ತುಂಬಿಸಿ.\nಸಿಡಿಯುವುದನ್ನು ನೋಡಿ.", "ಒಂದು ನಡೆ, ಒಂದು ತೃಪ್ತಿಕರ ತೆರವು"),
        "6-daily": ("ಪ್ರತಿದಿನ\nಹೊಸ ಬೋರ್ಡ್", "ಎಲ್ಲರಿಗೂ ಒಂದೇ ಪಜಲ್. ಸರಣಿ ಕಟ್ಟಿ."),
        "4-themes": ("ಎಂಟು ಥೀಮ್‌ಗಳು.\nಮನಸ್ಥಿತಿಗೆ ತಕ್ಕಂತೆ.", "ಮರ, ನಿಯಾನ್, ಸಾಗರ, ಅರಣ್ಯ ಮತ್ತು ಇನ್ನಷ್ಟು"),
        "7-puzzle": ("ಪ್ರತಿ ಪಜಲ್‌ಗೂ\nಪರಿಹಾರವಿದೆ", "ಸಾಲ್ವರ್ ಪರಿಶೀಲಿಸಿದೆ, ಅದೃಷ್ಟವಲ್ಲ"),
        "8-offline": ("ಬಲವಂತದ ಜಾಹೀರಾತು\nಎಂದಿಗೂ ಇಲ್ಲ.", "ಸೈನ್-ಅಪ್ ಇಲ್ಲ, ಅಡಚಣೆ ಇಲ್ಲ. ವಿಮಾನದಲ್ಲೂ ಆಡಬಹುದು."),
    },
    "gu": {
        "2-clear": ("લાઇન ભરો.\nફૂટતી જુઓ.", "એક ચાલ, એક સંતોષકારક સફાઈ"),
        "6-daily": ("દરરોજ\nનવું બોર્ડ", "બધા માટે એક જ પઝલ. સ્ટ્રીક બનાવો."),
        "4-themes": ("આઠ થીમ્સ.\nમૂડ પ્રમાણે.", "લાકડું, નિયોન, સમુદ્ર, જંગલ અને વધુ"),
        "7-puzzle": ("દરેક પઝલનો\nઉકેલ છે", "સૉલ્વરે ચકાસેલું, નસીબ પર નહીં"),
        "8-offline": ("ફરજિયાત જાહેરાત\nક્યારેય નહીં.", "સાઇન-અપ નહીં, વિક્ષેપ નહીં. વિમાનમાં પણ ચાલે."),
    },
    "te": {
        "2-clear": ("లైన్‌ను నింపండి.\nపేలడం చూడండి.", "ఒక కదలిక, ఒక సంతృప్తికరమైన క్లియర్"),
        "6-daily": ("ప్రతిరోజూ\nకొత్త బోర్డు", "అందరికీ ఒకే పజిల్. వరుసను పెంచుకోండి."),
        "4-themes": ("ఎనిమిది థీమ్‌లు.\nమీ మూడ్‌కు తగ్గట్టు.", "చెక్క, నియాన్, సముద్రం, అడవి ఇంకా ఎన్నో"),
        "7-puzzle": ("ప్రతి పజిల్‌కూ\nపరిష్కారం ఉంది", "సాల్వర్ పరీక్షించింది, అదృష్టం కాదు"),
        "8-offline": ("బలవంతపు ప్రకటనలు\nఎప్పుడూ లేవు.", "సైన్-అప్ లేదు, అంతరాయం లేదు. విమానంలోనూ పనిచేస్తుంది."),
    },
    "ta": {
        "2-clear": ("வரிசையை நிரப்புங்கள்.\nவெடிப்பதைப் பாருங்கள்.", "ஒரு நகர்வு, ஒரு திருப்தியான அழிப்பு"),
        "6-daily": ("தினமும்\nபுதிய பலகை", "அனைவருக்கும் அதே புதிர். தொடரை வளருங்கள்."),
        "4-themes": ("எட்டு தீம்கள்.\nமனநிலைக்கேற்ப.", "மரம், நியான், கடல், காடு மற்றும் பல"),
        "7-puzzle": ("ஒவ்வொரு புதிருக்கும்\nதீர்வு உண்டு", "தீர்வி சரிபார்த்தது, அதிர்ஷ்டம் அல்ல"),
        "8-offline": ("கட்டாய விளம்பரம்\nஒருபோதும் இல்லை.", "பதிவு இல்லை, இடையூறு இல்லை. விமானத்திலும் இயங்கும்."),
    },
    "sr": {
        "2-clear": ("Попуни ред.\nИ гледај прасак.", "Један потез, једно пријатно брисање"),
        "6-daily": ("Нова табла\nсваког дана", "Иста загонетка за све. Гради низ."),
        "4-themes": ("Осам тема.\nИзабери расположење.", "Дрво, неон, океан, шума и још"),
        "7-puzzle": ("Свака загонетка\nима решење", "Проверио програм, а не случај"),
        "8-offline": ("Без наметнутих\nогласа. Никад.", "Без регистрације и прекида. Ради и у авиону."),
    },
    "sl": {
        "2-clear": ("Zapolni vrstico.\nIn ta eksplodira.", "Ena poteza, eno prijetno čiščenje"),
        "6-daily": ("Nova plošča\nvsak dan", "Ista uganka za vse. Gradi niz."),
        "4-themes": ("Osem tem.\nIzberi razpoloženje.", "Les, neon, ocean, gozd in več"),
        "7-puzzle": ("Vsaka uganka\nima rešitev", "Preveril reševalnik, ne naključje"),
        "8-offline": ("Brez vsiljenih\noglasov. Nikoli.", "Brez registracije in prekinitev. Deluje tudi na letalu."),
    },
    "lv": {
        "2-clear": ("Aizpildi līniju.\nUn tā uzsprāgst.", "Viens gājiens, viena patīkama tīrīšana"),
        "6-daily": ("Jauns laukums\nkatru dienu", "Viena mīkla visiem. Audzē sēriju."),
        "4-themes": ("Astoņas tēmas.\nIzvēlies noskaņu.", "Koks, neons, okeāns, mežs un vēl"),
        "7-puzzle": ("Katrai mīklai\nir atrisinājums", "Pārbaudījis risinātājs, nevis nejaušība"),
        "8-offline": ("Bez piespiedu\nreklāmām. Nekad.", "Bez reģistrācijas un traucējumiem. Darbojas lidmašīnā."),
    },
    "et": {
        "2-clear": ("Täida rida.\nJa see plahvatab.", "Üks käik, üks rahuldav tühjendus"),
        "6-daily": ("Uus laud\niga päev", "Sama väljakutse kõigile. Kasvata seeriat."),
        "4-themes": ("Kaheksa teemat.\nVali oma meeleolu.", "Puit, neoon, ookean, mets ja palju muud"),
        "7-puzzle": ("Igal mõistatusel\non lahendus", "Kontrollinud lahendaja, mitte juhus"),
        "8-offline": ("Sundreklaame pole.\nMitte kunagi.", "Ilma registreerimise ja katkestusteta. Töötab lennukis."),
    },
    "lt": {
        "2-clear": ("Užpildyk liniją.\nStebėk, kaip sprogsta.", "Vienas ėjimas, vienas malonus išvalymas"),
        "6-daily": ("Nauja lenta\nkiekvieną dieną", "Tas pats iššūkis visiems. Kurk seriją."),
        "4-themes": ("Aštuonios temos.\nPagal nuotaiką.", "Mediena, neonas, vandenynas, miškas ir kt."),
        "7-puzzle": ("Kiekvienas galvosūkis\nturi sprendimą", "Patikrinta sprendimų programos, ne atsitiktinumo"),
        "8-offline": ("Jokios privalomos\nreklamos. Niekada.", "Be registracijos, be trukdžių. Veikia lėktuve."),
    },
    "az": {
        "2-clear": ("Xətti doldur.\nPartlamasına bax.", "Bir gediş, bir xoş təmizlik"),
        "6-daily": ("Hər gün\nyeni lövhə", "Hamı üçün eyni tapmaca. Seriya qur."),
        "4-themes": ("Səkkiz mövzu.\nƏhvalına görə seç.", "Taxta, neon, okean, meşə və daha çoxu"),
        "7-puzzle": ("Hər tapmacanın\nhəlli var", "Təsadüfə yox, həll proqramına yoxlanılıb"),
        "8-offline": ("Məcburi reklam yoxdur.\nHeç vaxt.", "Qeydiyyatsız, fasiləsiz. Təyyarədə də oynanılır."),
    },
    "uz": {
        "2-clear": ("Qatorni to‘ldiring.\nPortlashini ko‘ring.", "Bitta yurish, bitta yoqimli tozalash"),
        "6-daily": ("Har kuni\nyangi maydon", "Hamma uchun bir xil sinov. Seriya yarating."),
        "4-themes": ("Sakkizta mavzu.\nKayfiyatga qarab.", "Yog‘och, neon, okean, o‘rmon va boshqalar"),
        "7-puzzle": ("Har bir boshqotirma\nyechimga ega", "Tasodifga emas, yechuvchi dasturga tekshirilgan"),
        "8-offline": ("Majburiy reklama yo‘q.\nHech qachon.", "Ro‘yxatdan o‘tishsiz, uzilishlarsiz. Samolyotda ham."),
    },
    "sw": {
        "2-clear": ("Jaza mstari.\nUtazame ukilipuka.", "Hatua moja, usafishaji mmoja wa kuridhisha"),
        "6-daily": ("Ubao mpya\nkila siku", "Fumbo lilelile kwa wote. Jenga mfululizo."),
        "4-themes": ("Mandhari manane.\nChagua hisia yako.", "Mbao, neoni, bahari, msitu na zaidi"),
        "7-puzzle": ("Kila fumbo\nlina suluhisho", "Limekaguliwa na kitatuzi, si bahati"),
        "8-offline": ("Hakuna matangazo\nya lazima. Kamwe.", "Bila kujisajili, bila kukatizwa. Hucheza ndani ya ndege."),
    },
    "ca": {
        "2-clear": ("Omple una línia.\nMira com esclata.", "Un moviment, una neteja satisfactòria"),
        "6-daily": ("Un tauler nou\ncada dia", "El mateix repte per a tothom. Fes ratxa."),
        "4-themes": ("Vuit temes.\nTria el teu estil.", "Fusta, neó, oceà, bosc i més"),
        "7-puzzle": ("Cada trencaclosques\nté solució", "Verificat pel solucionador, no per l'atzar"),
        "8-offline": ("Sense anuncis\nobligatoris. Mai.", "Sense registre ni interrupcions. Es juga a l'avió."),
    },
    "ur": {
        "2-clear": ("لائن بھریں۔\nاور وہ غائب۔", "ایک چال، ایک مزیدار صفائی"),
        "6-daily": ("ہر روز\nنیا بورڈ", "سب کے لیے ایک ہی پہیلی۔ سلسلہ بنائیں۔"),
        "4-themes": ("آٹھ تھیمز۔\nجیسا موڈ ہو۔", "لکڑی، نیون، سمندر، جنگل اور بہت کچھ"),
        "7-puzzle": ("ہر پہیلی کا\nحل موجود ہے", "سولور نے جانچا، قسمت پر نہیں چھوڑا"),
        "8-offline": ("زبردستی کے اشتہار نہیں۔\nکبھی نہیں۔", "نہ سائن اپ، نہ رکاوٹ۔ جہاز میں بھی چلتا ہے۔"),
    },
    "fil": {
        "2-clear": ("Punuin ang linya.\nPanoorin itong mawala.", "Isang galaw, isang sulit na clear"),
        "6-daily": ("Bagong board\naraw-araw", "Parehong puzzle para sa lahat. Bumuo ng streak."),
        "4-themes": ("Walong tema.\nPiliin ang mood mo.", "Kahoy, neon, karagatan, gubat at iba pa"),
        "7-puzzle": ("Bawat puzzle\nay may solusyon", "Sinuri ng solver, hindi iniasa sa suwerte"),
        "8-offline": ("Walang sapilitang ad.\nKailanman.", "Walang sign-up, walang abala. Gumagana sa eroplano."),
    },
    "he": {
        "2-clear": ("ממלאים שורה.\nוהיא נעלמת.", "מהלך אחד, ניקוי אחד מספק"),
        "6-daily": ("לוח חדש\nבכל יום", "אותה חידה לכולם. בונים רצף."),
        "4-themes": ("שמונה ערכות נושא.\nלכל מצב רוח.", "עץ, ניאון, אוקיינוס, יער ועוד"),
        "7-puzzle": ("לכל חידה\nיש פתרון", "נבדק מראש על ידי פותר, לא נשאר למזל"),
        "8-offline": ("בלי מודעות כפויות.\nאף פעם.", "בלי הרשמה, בלי הפרעות. עובד גם בטיסה."),
    },
    "hr": {
        "2-clear": ("Popuni red.\nI gledaj kako nestaje.", "Jedan potez, jedno sjajno brisanje"),
        "6-daily": ("Nova ploča\nsvaki dan", "Ista zagonetka za sve. Gradi niz."),
        "4-themes": ("Osam tema.\nPo tvom raspoloženju.", "Drvo, neon, ocean, šuma i još"),
        "7-puzzle": ("Svaka zagonetka\nima rješenje", "Provjereno algoritmom, ne prepušteno slučaju"),
        "8-offline": ("Bez nametnutih\noglasa. Nikad.", "Bez registracije, bez prekida. Radi i u avionu."),
    },
    "bg": {
        "2-clear": ("Запълни ред.\nИ той изчезва.", "Един ход, едно приятно изчистване"),
        "6-daily": ("Нова дъска\nвсеки ден", "Един и същ пъзел за всички. Гради серия."),
        "4-themes": ("Осем теми.\nПо твой вкус.", "Дърво, неон, океан, гора и още"),
        "7-puzzle": ("Всеки пъзел\nима решение", "Проверено от алгоритъм, не от късмета"),
        "8-offline": ("Без принудителни\nреклами. Никога.", "Без регистрация, без прекъсвания. Играе и в самолета."),
    },
    "fi": {
        "2-clear": ("Täytä rivi.\nKatso, kun se katoaa.", "Yksi siirto, yksi tyydyttävä tyhjennys"),
        "6-daily": ("Uusi lauta\njoka päivä", "Sama pulma kaikille. Kasvata putkeasi."),
        "4-themes": ("Kahdeksan teemaa.\nFiiliksen mukaan.", "Puu, neon, meri, metsä ja muita"),
        "7-puzzle": ("Jokaiseen pulmaan\non ratkaisu", "Ratkaisijan tarkistama, ei sattuman varassa"),
        "8-offline": ("Ei pakotettuja\nmainoksia. Koskaan.", "Ei rekisteröitymistä, ei keskeytyksiä. Toimii lentokoneessa."),
    },
    "nb": {
        "2-clear": ("Fyll en rad.\nSe den forsvinne.", "Ett trekk, én tilfredsstillende rydding"),
        "6-daily": ("Et nytt brett\nhver dag", "Samme puslespill for alle. Bygg en serie."),
        "4-themes": ("Åtte temaer.\nVelg humøret.", "Tre, neon, hav, skog og mer"),
        "7-puzzle": ("Hvert puslespill\nhar en løsning", "Sjekket av en løser, ikke overlatt til tilfeldighetene"),
        "8-offline": ("Ingen påtvungne\nannonser. Aldri.", "Ingen registrering, ingen avbrudd. Virker på flyet."),
    },
    "da": {
        "2-clear": ("Fyld en række.\nSe den forsvinde.", "Ét træk, én tilfredsstillende rydning"),
        "6-daily": ("Et nyt bræt\nhver dag", "Samme puslespil for alle. Byg en stime."),
        "4-themes": ("Otte temaer.\nVælg dit humør.", "Træ, neon, hav, skov og mere"),
        "7-puzzle": ("Hvert puslespil\nhar en løsning", "Tjekket af en løser, ikke overladt til tilfældet"),
        "8-offline": ("Ingen tvungne\nreklamer. Aldrig.", "Ingen tilmelding, ingen afbrydelser. Virker i flyet."),
    },
    "el": {
        "2-clear": ("Γέμισε μια σειρά.\nΔες τη να χάνεται.", "Μία κίνηση, ένα ικανοποιητικό καθάρισμα"),
        "6-daily": ("Κάθε μέρα\nνέο ταμπλό", "Ίδιος γρίφος για όλους. Χτίσε σερί."),
        "4-themes": ("Οκτώ θέματα.\nΓια κάθε διάθεση.", "Ξύλο, νέον, ωκεανός, δάσος και άλλα"),
        "7-puzzle": ("Κάθε γρίφος\nέχει λύση", "Ελεγμένο από λύτη, όχι αφημένο στην τύχη"),
        "8-offline": ("Καμία διαφήμιση\nμε το ζόρι. Ποτέ.", "Χωρίς εγγραφή, χωρίς διακοπές. Παίζει και στο αεροπλάνο."),
    },
    "sk": {
        "2-clear": ("Zaplň rad.\nA sleduj, ako zmizne.", "Jeden ťah, jedno parádne zmazanie"),
        "6-daily": ("Každý deň\nnová plocha", "Rovnaká výzva pre všetkých. Drž sériu."),
        "4-themes": ("Osem motívov.\nPodľa nálady.", "Drevo, neón, oceán, les a ďalšie"),
        "7-puzzle": ("Každá hádanka\nmá riešenie", "Overené riešiteľom, nie ponechané náhode"),
        "8-offline": ("Žiadne vynútené\nreklamy. Nikdy.", "Bez registrácie, bez prerušení. Hrá aj v lietadle."),
    },
}

# The three proof lines on the statement frame.
#
# The third line used to claim the player's data never leaves the device, and
# the frame-6 subline used to deny having a backend. Both are false: the
# leaderboard writes name and score to Cloud Firestore
# (lib/services/leaderboard.dart:133-166), and docs/DATA-SAFETY.md declares
# five shared data types. Google cross-checks the listing against that
# declaration, so those two lines were the highest-risk text in the whole
# store entry. test/store_claims_test.dart now fails on either of them, in
# this file and in store-assets/store-listing.csv — which is why they are
# described here rather than quoted.
#
# What survives a reading of the code: the GAME needs no network (no gameplay
# call anywhere), the player never creates an account (anonymous auth only, no
# visible login), and PROGRESS really is local — highscore, coins, levels and
# puzzle stars all live in shared_preferences with no cloud save. Only a
# leaderboard entry leaves the device, and only when the player submits one.
PROOF = {
    "en": ["Plays fully offline", "No account, ever", "Progress stays on your phone"],
    "de": ["Komplett offline", "Nie ein Konto nötig", "Fortschritt bleibt auf dem Handy"],
    "es": ["Se juega sin conexión", "Nunca hace falta una cuenta", "Tu progreso se queda en tu teléfono"],
    "fr": ["Jouable hors ligne", "Jamais de compte", "Ta progression reste sur ton téléphone"],
    "id": ["Main sepenuhnya offline", "Tidak perlu akun", "Progres tersimpan di ponselmu"],
    "it": ["Si gioca offline", "Mai un account", "I progressi restano sul telefono"],
    "pt": ["Totalmente offline", "Nunca precisa de conta", "O progresso fica no seu celular"],
    "tr": ["Tamamen çevrimdışı", "Hesap asla gerekmez", "İlerlemen telefonunda kalır"],
    "nl": ["Volledig offline te spelen", "Nooit een account nodig", "Voortgang blijft op je telefoon"],
    "pl": ["Działa całkowicie offline", "Nigdy nie potrzeba konta", "Postęp zostaje w telefonie"],
    "vi": ["Chơi hoàn toàn ngoại tuyến", "Không bao giờ cần tài khoản", "Tiến trình nằm trên điện thoại"],
    "ja": ["完全オフラインで遊べる", "アカウント登録は不要", "進行状況は端末に保存"],
    "ko": ["완전 오프라인 플레이", "계정이 필요 없어요", "진행 상황은 휴대폰에 저장"],
    "th": ["เล่นแบบออฟไลน์ได้ทั้งหมด", "ไม่ต้องมีบัญชี", "ความคืบหน้าอยู่ในโทรศัพท์ของคุณ"],
    "zh": ["完全离线也能玩", "不需要账号", "进度保存在你的手机上"],
    "zh_Hant": ["完全離線也能玩", "不需要帳號", "進度保存在你的手機上"],
    "ar": ["تعمل دون إنترنت بالكامل", "لا حاجة إلى حساب أبدًا", "تقدمك محفوظ على هاتفك"],
    "uk": ["Повністю офлайн", "Жодного облікового запису", "Прогрес лишається на телефоні"],
    "hi": ["पूरी तरह ऑफ़लाइन खेलें", "कोई अकाउंट नहीं चाहिए", "प्रगति आपके फ़ोन पर रहती है"],
    "ms": ["Main sepenuhnya luar talian", "Tidak perlu akaun", "Kemajuan kekal dalam telefon anda"],
    "ro": ["Se joacă complet offline", "Niciodată nevoie de cont", "Progresul rămâne pe telefon"],
    "cs": ["Hraje se úplně offline", "Nikdy nepotřebuješ účet", "Postup zůstává v telefonu"],
    "hu": ["Teljesen offline játszható", "Soha nem kell fiók", "A haladás a telefonodon marad"],
    "sv": ["Spelas helt offline", "Aldrig något konto", "Framstegen stannar i telefonen"],
    "af": ["Speel heeltemal aflyn", "Nooit 'n rekening nodig nie", "Vordering bly op jou foon"],
    "bs": ["Igra se potpuno offline", "Nikad ne treba račun", "Napredak ostaje na telefonu"],
    "mk": ["Играј целосно без интернет", "Никогаш не треба сметка", "Напредокот останува на телефонот"],
    "sq": ["Luaj plotësisht pa internet", "Kurrë s’duhet llogari", "Përparimi mbetet në telefonin tënd"],
    "kk": ["Толығымен офлайн ойнаңыз", "Аккаунт ешқашан қажет емес", "Прогресс телефоныңызда қалады"],
    "ne": ["पूर्ण रूपमा अफलाइन खेल्नुहोस्", "खाता कहिल्यै चाहिँदैन", "प्रगति तपाईंकै फोनमा रहन्छ"],
    "mr": ["पूर्णपणे ऑफलाइन खेळा", "खात्याची कधीच गरज नाही", "प्रगती तुमच्या फोनवरच राहते"],
    "bn": ["পুরোপুরি অফলাইনে খেলুন", "অ্যাকাউন্ট কখনও লাগে না", "অগ্রগতি আপনার ফোনেই থাকে"],
    "pa": ["ਪੂਰੀ ਤਰ੍ਹਾਂ ਆਫ਼ਲਾਈਨ ਖੇਡੋ", "ਖਾਤੇ ਦੀ ਕਦੇ ਲੋੜ ਨਹੀਂ", "ਤਰੱਕੀ ਤੁਹਾਡੇ ਫ਼ੋਨ ਉੱਤੇ ਹੀ ਰਹਿੰਦੀ ਹੈ"],
    "ml": ["പൂർണമായും ഓഫ്‌ലൈനായി കളിക്കൂ", "അക്കൗണ്ട് ഒരിക്കലും വേണ്ട", "പുരോഗതി നിങ്ങളുടെ ഫോണിൽ തന്നെ"],
    "kn": ["ಸಂಪೂರ್ಣ ಆಫ್‌ಲೈನ್‌ನಲ್ಲಿ ಆಡಿ", "ಖಾತೆ ಎಂದಿಗೂ ಬೇಕಿಲ್ಲ", "ಪ್ರಗತಿ ನಿಮ್ಮ ಫೋನ್‌ನಲ್ಲೇ ಇರುತ್ತದೆ"],
    "gu": ["સંપૂર્ણ ઑફલાઇન રમો", "એકાઉન્ટની ક્યારેય જરૂર નહીં", "પ્રગતિ તમારા ફોનમાં જ રહે"],
    "te": ["పూర్తిగా ఆఫ్‌లైన్‌లో ఆడవచ్చు", "ఖాతా ఎప్పుడూ అవసరం లేదు", "ప్రగతి మీ ఫోన్‌లోనే ఉంటుంది"],
    "ta": ["முழுவதும் ஆஃப்லைனில் விளையாடலாம்", "கணக்கு ஒருபோதும் தேவையில்லை", "முன்னேற்றம் உங்கள் போனிலேயே"],
    "sr": ["Игра се потпуно офлајн", "Налог никад није потребан", "Напредак остаје на телефону"],
    "sl": ["Igra povsem brez povezave", "Račun ni nikoli potreben", "Napredek ostane v telefonu"],
    "lv": ["Spēlē pilnīgi bezsaistē", "Konts nekad nav vajadzīgs", "Progress paliek telefonā"],
    "et": ["Mängib täiesti võrguühenduseta", "Kontot pole kunagi vaja", "Edenemine jääb telefoni"],
    "lt": ["Žaidžiama visiškai be interneto", "Paskyros niekada nereikia", "Pažanga lieka telefone"],
    "az": ["Tam oflayn oynanılır", "Heç vaxt hesab lazım deyil", "İrəliləyiş telefonunda qalır"],
    "uz": ["To‘liq oflayn o‘ynaladi", "Hech qachon hisob kerak emas", "Natijalar telefoningizda qoladi"],
    "sw": ["Huchezwa bila intaneti kabisa", "Hakuna akaunti, kamwe", "Maendeleo hubaki kwenye simu yako"],
    "ca": ["Es juga sense connexió", "Mai no cal cap compte", "El progrés es queda al telèfon"],
    "ur": ["مکمل طور پر آف لائن چلتا ہے", "اکاؤنٹ کی کبھی ضرورت نہیں", "پیش رفت آپ کے فون میں رہتی ہے"],
    "fil": ["Nalalaro nang buong offline", "Hindi kailangan ng account", "Nasa phone mo ang progreso"],
    "he": ["אפשר לשחק בלי אינטרנט", "אף פעם לא צריך חשבון", "ההתקדמות נשמרת בטלפון"],
    "hr": ["Igra se potpuno offline", "Nikad ne treba račun", "Napredak ostaje na mobitelu"],
    "bg": ["Играе се изцяло офлайн", "Никога не е нужен профил", "Напредъкът остава в телефона"],
    "fi": ["Pelattavissa täysin offline", "Ei koskaan tiliä", "Edistyminen pysyy puhelimessa"],
    "nb": ["Spilles helt offline", "Aldri noen konto", "Framgangen blir på telefonen"],
    "da": ["Spilles helt offline", "Aldrig en konto", "Fremskridt bliver på telefonen"],
    "el": ["Παίζεται εντελώς χωρίς σύνδεση", "Ποτέ δεν χρειάζεται λογαριασμός", "Η πρόοδος μένει στο κινητό σου"],
    "sk": ["Hrá sa úplne offline", "Nikdy nepotrebuješ účet", "Postup zostáva v telefóne"],
}

# The design frames (owner, 02.10.2026). Placeholders come from
# store-assets/raw/<locale>/designs.json, which the generator writes from the
# catalogs and the app's own translations:
#   {themes} {skins} {animated} {accessories} {bursts}  how many there are
#   {theme:id} {skin:id} {burst:id} {accessory:id}       a design's app name
# So a count is never typed in (frame 4 used to say "Eight themes" long after
# there were twelve) and a name always matches the Designs screen.
#   1-designs  headline, subline (the counts follow as a row of numbers)
#   shown      frame 2's subline starts with it, then the look's app names
#   3-skins    headline, subline
#   4-themes   headline only; the subline stays the one in CAPTIONS
#   5-extras   headline, subline
#
# The number words agree with the counts below (Polish "12 motywów" but
# "23 skórki", Arabic "23 مظهرًا"). When a count changes, the grammar has to
# be checked again, so build() stops until WRITTEN_FOR is updated.
WRITTEN_FOR = {"themes": 12, "skins": 23, "animated": 12, "accessories": 6,
               "bursts": 6}

DESIGN_CAPTIONS = {
    "en": {
        "1-designs": ("Your board.\nYour style.", "Mix and match themes, skins and accessories"),
        "shown": "Shown:",
        "3-skins": ("{skins} block skins", "{animated} of them are animated"),
        "4-themes": "{themes} themes.\nPick your mood.",
        "5-extras": ("The finishing\ntouch", "{accessories} accessories and {bursts} explosions"),
    },
    "de": {
        "1-designs": ("Dein Brett.\nDein Stil.", "Themes, Skins und Zubehör nach Lust kombinieren"),
        "shown": "Im Bild:",
        "3-skins": ("{skins} Block-Skins", "{animated} davon sind animiert"),
        "4-themes": "{themes} Themes.\nDeine Stimmung.",
        "5-extras": ("Das gewisse\nExtra", "{accessories} Zubehörteile und {bursts} Explosionen"),
    },
    "es": {
        "1-designs": ("Tu tablero.\nTu estilo.", "Combina temas, skins y accesorios a tu gusto"),
        "shown": "En la imagen:",
        "3-skins": ("{skins} skins de bloques", "{animated} tienen animación"),
        "4-themes": "{themes} temas.\nElige tu estilo.",
        "5-extras": ("El toque\nfinal", "{accessories} accesorios y {bursts} explosiones"),
    },
    "fr": {
        "1-designs": ("Ta grille.\nTon style.", "Combine thèmes, skins et accessoires à ta guise"),
        "shown": "Sur l'image :",
        "3-skins": ("{skins} skins de blocs", "Dont {animated} animés"),
        "4-themes": "{themes} thèmes.\nSelon ton humeur.",
        "5-extras": ("La touche\nfinale", "{accessories} accessoires et {bursts} explosions"),
    },
    "id": {
        "1-designs": ("Papanmu.\nGayamu.", "Padukan tema, skin, dan aksesori sesukamu"),
        "shown": "Dalam gambar:",
        "3-skins": ("{skins} skin balok", "{animated} di antaranya bergerak"),
        "4-themes": "{themes} tema.\nSesuai suasana.",
        "5-extras": ("Sentuhan\nakhir", "{accessories} aksesori dan {bursts} ledakan"),
    },
    "it": {
        "1-designs": ("La tua griglia.\nIl tuo stile.", "Combina temi, skin e accessori come vuoi"),
        "shown": "Nell'immagine:",
        "3-skins": ("{skins} skin dei blocchi", "{animated} sono animate"),
        "4-themes": "{themes} temi.\nScegli il tuo stile.",
        "5-extras": ("Il tocco\nfinale", "{accessories} accessori e {bursts} esplosioni"),
    },
    "pt": {
        "1-designs": ("Seu tabuleiro.\nSeu estilo.", "Combine temas, skins e acessórios do seu jeito"),
        "shown": "Na imagem:",
        "3-skins": ("{skins} skins de blocos", "{animated} delas são animadas"),
        "4-themes": "{themes} temas.\nEscolha seu estilo.",
        "5-extras": ("O toque\nfinal", "{accessories} acessórios e {bursts} explosões"),
    },
    "tr": {
        "1-designs": ("Senin tahtan.\nSenin tarzın.", "Temaları, görünümleri ve aksesuarları dilediğin gibi birleştir"),
        "shown": "Görselde:",
        "3-skins": ("{skins} blok görünümü", "{animated} tanesi hareketli"),
        "4-themes": "{themes} tema.\nModuna göre seç.",
        "5-extras": ("Son\ndokunuş", "{accessories} aksesuar ve {bursts} patlama"),
    },
    "nl": {
        "1-designs": ("Jouw bord.\nJouw stijl.", "Combineer thema's, skins en accessoires naar wens"),
        "shown": "In beeld:",
        "3-skins": ("{skins} blokskins", "Daarvan zijn er {animated} geanimeerd"),
        "4-themes": "{themes} thema's.\nKies je sfeer.",
        "5-extras": ("De finishing\ntouch", "{accessories} accessoires en {bursts} explosies"),
    },
    "pl": {
        "1-designs": ("Twoja plansza.\nTwój styl.", "Łącz motywy, skórki i dodatki, jak chcesz"),
        "shown": "Na obrazku:",
        "3-skins": ("{skins} skórki klocków", "{animated} z nich jest animowanych"),
        "4-themes": "{themes} motywów.\nWybierz nastrój.",
        "5-extras": ("Ostatni\nszlif", "{accessories} dodatków i {bursts} wybuchów"),
    },
    "vi": {
        "1-designs": ("Bàn chơi của bạn.\nPhong cách của bạn.", "Phối chủ đề, giao diện khối và phụ kiện theo ý bạn"),
        "shown": "Trong ảnh:",
        "3-skins": ("{skins} giao diện khối", "{animated} trong số đó có hoạt ảnh"),
        "4-themes": "{themes} chủ đề.\nChọn theo tâm trạng.",
        "5-extras": ("Điểm nhấn\ncuối cùng", "{accessories} phụ kiện và {bursts} hiệu ứng nổ"),
    },
    "ja": {
        "1-designs": ("あなたの盤面。\nあなたのスタイル。", "テーマ、スキン、アクセサリーを自由に組み合わせ"),
        "shown": "画像：",
        "3-skins": ("{skins}種のブロックスキン", "うち{animated}種はアニメーション付き"),
        "4-themes": "{themes}のテーマ。\n気分で選ぼう。",
        "5-extras": ("仕上げの\nひと工夫", "アクセサリー{accessories}種、爆発エフェクト{bursts}種"),
    },
    "ko": {
        "1-designs": ("나만의 보드.\n나만의 스타일.", "테마, 스킨, 액세서리를 마음대로 조합"),
        "shown": "이미지:",
        "3-skins": ("블록 스킨 {skins}종", "그중 {animated}종은 움직여요"),
        "4-themes": "{themes}가지 테마.\n기분대로 골라요.",
        "5-extras": ("마무리는\n디테일로", "액세서리 {accessories}종, 폭발 효과 {bursts}종"),
    },
    "th": {
        "1-designs": ("กระดานของคุณ\nสไตล์ของคุณ", "จับคู่ธีม สกิน และเครื่องประดับได้ตามใจ"),
        "shown": "ในภาพ:",
        "3-skins": ("สกินบล็อก {skins} แบบ", "มี {animated} แบบที่เคลื่อนไหวได้"),
        "4-themes": "{themes} ธีม\nเลือกตามอารมณ์",
        "5-extras": ("เติมความ\nพิเศษ", "เครื่องประดับ {accessories} แบบ และเอฟเฟกต์ระเบิด {bursts} แบบ"),
    },
    "zh": {
        "1-designs": ("你的棋盘，\n你的风格。", "主题、方块造型和配饰随心搭配"),
        "shown": "图中：",
        "3-skins": ("{skins} 款方块造型", "其中 {animated} 款带动画"),
        "4-themes": "{themes} 种主题，\n随心情挑选。",
        "5-extras": ("点睛\n之笔", "{accessories} 款配饰和 {bursts} 种爆炸特效"),
    },
    "zh_Hant": {
        "1-designs": ("你的棋盤，\n你的風格。", "主題、方塊造型和配飾隨心搭配"),
        "shown": "圖中：",
        "3-skins": ("{skins} 款方塊造型", "其中 {animated} 款帶動畫"),
        "4-themes": "{themes} 種主題，\n隨心情挑選。",
        "5-extras": ("畫龍\n點睛", "{accessories} 款配飾和 {bursts} 種爆炸特效"),
    },
    "ar": {
        "1-designs": ("لوحتك.\nأسلوبك.", "نسّق السمات ومظاهر المكعبات والإكسسوارات كما تحب"),
        "shown": "في الصورة:",
        "3-skins": ("{skins} مظهرًا للمكعبات", "{animated} منها متحركة"),
        "4-themes": "{themes} سمة.\nاختر ما يناسب مزاجك.",
        "5-extras": ("اللمسة\nالأخيرة", "{accessories} إكسسوارات و{bursts} انفجارات"),
    },
    "uk": {
        "1-designs": ("Твоє поле.\nТвій стиль.", "Поєднуй теми, скіни й аксесуари як хочеш"),
        "shown": "На зображенні:",
        "3-skins": ("{skins} скіни блоків", "{animated} з них анімовані"),
        "4-themes": "{themes} тем.\nНа будь-який смак.",
        "5-extras": ("Останній\nштрих", "{accessories} аксесуарів і {bursts} вибухів"),
    },
    "hi": {
        "1-designs": ("आपका बोर्ड।\nआपका स्टाइल।", "थीम, स्किन और एक्सेसरी अपनी पसंद से मिलाएँ"),
        "shown": "चित्र में:",
        "3-skins": ("{skins} ब्लॉक स्किन", "इनमें से {animated} एनिमेटेड हैं"),
        "4-themes": "{themes} थीम।\nमूड के हिसाब से चुनें।",
        "5-extras": ("आख़िरी\nटच", "{accessories} एक्सेसरी और {bursts} विस्फोट"),
    },
    "ms": {
        "1-designs": ("Papan anda.\nGaya anda.", "Padankan tema, skin dan aksesori sesuka hati"),
        "shown": "Dalam gambar:",
        "3-skins": ("{skins} skin blok", "{animated} daripadanya beranimasi"),
        "4-themes": "{themes} tema.\nIkut mood anda.",
        "5-extras": ("Sentuhan\nakhir", "{accessories} aksesori dan {bursts} letupan"),
    },
    "ro": {
        "1-designs": ("Tabla ta.\nStilul tău.", "Combină teme, skinuri și accesorii după plac"),
        "shown": "În imagine:",
        "3-skins": ("{skins} de skinuri pentru blocuri", "{animated} dintre ele sunt animate"),
        "4-themes": "{themes} teme.\nDupă cum ai chef.",
        "5-extras": ("Ultima\natingere", "{accessories} accesorii și {bursts} explozii"),
    },
    "cs": {
        "1-designs": ("Tvoje deska.\nTvůj styl.", "Kombinuj motivy, vzhledy kostek a doplňky podle chuti"),
        "shown": "Na obrázku:",
        "3-skins": ("{skins} vzhledů kostek", "{animated} z nich je animovaných"),
        "4-themes": "{themes} motivů.\nPodle nálady.",
        "5-extras": ("Poslední\ntečka", "{accessories} doplňků a {bursts} výbuchů"),
    },
    "hu": {
        "1-designs": ("A te táblád.\nA te stílusod.", "Kombináld kedved szerint a témákat, kinézeteket és kiegészítőket"),
        "shown": "A képen:",
        "3-skins": ("{skins} blokk-kinézet", "Ebből {animated} animált"),
        "4-themes": "{themes} téma.\nHangulat szerint.",
        "5-extras": ("Az utolsó\nsimítás", "{accessories} kiegészítő és {bursts} robbanás"),
    },
    "sv": {
        "1-designs": ("Ditt bräde.\nDin stil.", "Kombinera teman, skins och tillbehör som du vill"),
        "shown": "På bilden:",
        "3-skins": ("{skins} blockskins", "{animated} av dem är animerade"),
        "4-themes": "{themes} teman.\nVälj ditt humör.",
        "5-extras": ("Pricken\növer i", "{accessories} tillbehör och {bursts} explosioner"),
    },
    "af": {
        "1-designs": ("Jou bord.\nJou styl.", "Meng temas, blokvoorkomste en bykomstighede soos jy wil"),
        "shown": "Op die prent:",
        "3-skins": ("{skins} blokvoorkomste", "{animated} daarvan is geanimeer"),
        "4-themes": "{themes} temas.\nNa jou bui.",
        "5-extras": ("Die laaste\nafronding", "{accessories} bykomstighede en {bursts} ontploffings"),
    },
    "bs": {
        "1-designs": ("Tvoja ploča.\nTvoj stil.", "Kombinuj teme, izglede blokova i dodatke po želji"),
        "shown": "Na slici:",
        "3-skins": ("{skins} izgleda blokova", "{animated} ih je animirano"),
        "4-themes": "{themes} tema.\nPo tvom raspoloženju.",
        "5-extras": ("Završni\ndodir", "{accessories} dodataka i {bursts} eksplozija"),
    },
    "mk": {
        "1-designs": ("Твојата табла.\nТвојот стил.", "Комбинирај теми, изгледи и додатоци по желба"),
        "shown": "На сликата:",
        "3-skins": ("{skins} изгледи на блоковите", "{animated} од нив се анимирани"),
        "4-themes": "{themes} теми.\nПо твое расположение.",
        "5-extras": ("Завршен\nдопир", "{accessories} додатоци и {bursts} експлозии"),
    },
    "sq": {
        "1-designs": ("Fusha jote.\nStili yt.", "Kombino temat, stilet e blloqeve dhe aksesorët si të duash"),
        "shown": "Në foto:",
        "3-skins": ("{skins} stile blloqesh", "{animated} prej tyre janë të animuara"),
        "4-themes": "{themes} tema.\nSipas humorit.",
        "5-extras": ("Prekja\nfinale", "{accessories} aksesorë dhe {bursts} shpërthime"),
    },
    "kk": {
        "1-designs": ("Сіздің тақтаңыз.\nСіздің стиліңіз.", "Тақырыптарды, скиндерді және аксессуарларды қалауыңызша үйлестіріңіз"),
        "shown": "Суретте:",
        "3-skins": ("{skins} блок скині", "Олардың {animated}-і анимацияланған"),
        "4-themes": "{themes} тақырып.\nКөңіл-күйге сай.",
        "5-extras": ("Соңғы\nштрих", "{accessories} аксессуар және {bursts} жарылыс"),
    },
    "ne": {
        "1-designs": ("तपाईंको बोर्ड।\nतपाईंको शैली।", "थिम, स्किन र सहायक सामग्री मन परेजस्तो मिलाउनुहोस्"),
        "shown": "तस्बिरमा:",
        "3-skins": ("{skins} ब्लक स्किन", "तीमध्ये {animated} एनिमेटेड छन्"),
        "4-themes": "{themes} थिम।\nमुड अनुसार।",
        "5-extras": ("अन्तिम\nस्पर्श", "{accessories} सहायक सामग्री र {bursts} विस्फोट"),
    },
    "mr": {
        "1-designs": ("तुमचा बोर्ड.\nतुमची स्टाइल.", "थीम, स्किन आणि अ‍ॅक्सेसरी हव्या तशा जुळवा"),
        "shown": "चित्रात:",
        "3-skins": ("{skins} ब्लॉक स्किन", "त्यापैकी {animated} अ‍ॅनिमेटेड आहेत"),
        "4-themes": "{themes} थीम.\nमूडनुसार.",
        "5-extras": ("शेवटचा\nटच", "{accessories} अ‍ॅक्सेसरी आणि {bursts} स्फोट"),
    },
    "bn": {
        "1-designs": ("আপনার বোর্ড।\nআপনার স্টাইল।", "থিম, স্কিন আর অ্যাক্সেসরি ইচ্ছেমতো মেলান"),
        "shown": "ছবিতে:",
        "3-skins": ("{skins}টি ব্লক স্কিন", "এর মধ্যে {animated}টি অ্যানিমেটেড"),
        "4-themes": "{themes}টি থিম।\nমেজাজ অনুযায়ী।",
        "5-extras": ("শেষ\nছোঁয়া", "{accessories}টি অ্যাক্সেসরি আর {bursts}টি বিস্ফোরণ"),
    },
    "pa": {
        "1-designs": ("ਤੁਹਾਡਾ ਬੋਰਡ।\nਤੁਹਾਡਾ ਸਟਾਈਲ।", "ਥੀਮ, ਸਕਿਨ ਅਤੇ ਐਕਸੈਸਰੀਜ਼ ਆਪਣੀ ਮਰਜ਼ੀ ਨਾਲ ਮਿਲਾਓ"),
        "shown": "ਤਸਵੀਰ ਵਿੱਚ:",
        "3-skins": ("{skins} ਬਲਾਕ ਸਕਿਨ", "ਇਨ੍ਹਾਂ ਵਿੱਚੋਂ {animated} ਐਨੀਮੇਟਡ ਹਨ"),
        "4-themes": "{themes} ਥੀਮ।\nਮੂਡ ਮੁਤਾਬਕ।",
        "5-extras": ("ਆਖ਼ਰੀ\nਛੋਹ", "{accessories} ਐਕਸੈਸਰੀਜ਼ ਅਤੇ {bursts} ਧਮਾਕੇ"),
    },
    "ml": {
        "1-designs": ("നിങ്ങളുടെ ബോർഡ്.\nനിങ്ങളുടെ സ്റ്റൈൽ.", "തീമുകളും സ്കിന്നുകളും ആക്‌സസറികളും ഇഷ്ടംപോലെ ചേർക്കൂ"),
        "shown": "ചിത്രത്തിൽ:",
        "3-skins": ("{skins} ബ്ലോക്ക് സ്കിന്നുകൾ", "അതിൽ {animated} എണ്ണം ആനിമേറ്റഡ്"),
        "4-themes": "{themes} തീമുകൾ.\nമൂഡിന് ഇണങ്ങിയത്.",
        "5-extras": ("അവസാന\nമിനുക്ക്", "{accessories} ആക്‌സസറികളും {bursts} സ്ഫോടനങ്ങളും"),
    },
    "kn": {
        "1-designs": ("ನಿಮ್ಮ ಬೋರ್ಡ್.\nನಿಮ್ಮ ಶೈಲಿ.", "ಥೀಮ್, ಸ್ಕಿನ್ ಮತ್ತು ಆಕ್ಸೆಸರಿಗಳನ್ನು ಇಷ್ಟದಂತೆ ಹೊಂದಿಸಿ"),
        "shown": "ಚಿತ್ರದಲ್ಲಿ:",
        "3-skins": ("{skins} ಬ್ಲಾಕ್ ಸ್ಕಿನ್‌ಗಳು", "ಅವುಗಳಲ್ಲಿ {animated} ಅನಿಮೇಟೆಡ್"),
        "4-themes": "{themes} ಥೀಮ್‌ಗಳು.\nಮನಸ್ಥಿತಿಗೆ ತಕ್ಕಂತೆ.",
        "5-extras": ("ಕೊನೆಯ\nಸ್ಪರ್ಶ", "{accessories} ಆಕ್ಸೆಸರಿಗಳು ಮತ್ತು {bursts} ಸ್ಫೋಟಗಳು"),
    },
    "gu": {
        "1-designs": ("તમારું બોર્ડ.\nતમારી સ્ટાઇલ.", "થીમ, સ્કિન અને એક્સેસરીઝ મનગમતી રીતે જોડો"),
        "shown": "ચિત્રમાં:",
        "3-skins": ("{skins} બ્લૉક સ્કિન્સ", "તેમાંથી {animated} એનિમેટેડ છે"),
        "4-themes": "{themes} થીમ્સ.\nમૂડ પ્રમાણે.",
        "5-extras": ("છેલ્લો\nસ્પર્શ", "{accessories} એક્સેસરીઝ અને {bursts} વિસ્ફોટ"),
    },
    "te": {
        "1-designs": ("మీ బోర్డు.\nమీ స్టైల్.", "థీమ్‌లు, స్కిన్‌లు, యాక్సెసరీలను నచ్చినట్టు కలపండి"),
        "shown": "చిత్రంలో:",
        "3-skins": ("{skins} బ్లాక్ స్కిన్‌లు", "వాటిలో {animated} యానిమేటెడ్"),
        "4-themes": "{themes} థీమ్‌లు.\nమీ మూడ్‌కు తగ్గట్టు.",
        "5-extras": ("చివరి\nమెరుగు", "{accessories} యాక్సెసరీలు, {bursts} పేలుళ్లు"),
    },
    "ta": {
        "1-designs": ("உங்கள் பலகை.\nஉங்கள் ஸ்டைல்.", "தீம்கள், தோற்றங்கள், அணிகலன்களை விருப்பம்போல் சேருங்கள்"),
        "shown": "படத்தில்:",
        "3-skins": ("{skins} பிளாக் தோற்றங்கள்", "அவற்றில் {animated} அசையும்"),
        "4-themes": "{themes} தீம்கள்.\nமனநிலைக்கேற்ப.",
        "5-extras": ("இறுதித்\nதொடுதல்", "{accessories} அணிகலன்கள், {bursts} வெடிப்புகள்"),
    },
    "sr": {
        "1-designs": ("Твоја табла.\nТвој стил.", "Комбинуј теме, изгледе блокова и додатке по жељи"),
        "shown": "На слици:",
        "3-skins": ("{skins} изгледа блокова", "{animated} их је анимирано"),
        "4-themes": "{themes} тема.\nИзабери расположење.",
        "5-extras": ("Завршни\nдодир", "{accessories} додатака и {bursts} експлозија"),
    },
    "sl": {
        "1-designs": ("Tvoja plošča.\nTvoj slog.", "Kombiniraj teme, videze blokov in dodatke po želji"),
        "shown": "Na sliki:",
        "3-skins": ("{skins} videzi blokov", "{animated} jih je animiranih"),
        "4-themes": "{themes} tem.\nIzberi razpoloženje.",
        "5-extras": ("Pika\nna i", "{accessories} dodatkov in {bursts} eksplozij"),
    },
    "lv": {
        "1-designs": ("Tavs laukums.\nTavs stils.", "Apvieno tēmas, izskatus un aksesuārus pēc patikas"),
        "shown": "Attēlā:",
        "3-skins": ("{skins} bloku izskati", "{animated} no tiem ir animēti"),
        "4-themes": "{themes} tēmas.\nIzvēlies noskaņu.",
        "5-extras": ("Pēdējais\npieskāriens", "{accessories} aksesuāri un {bursts} sprādzieni"),
    },
    "et": {
        "1-designs": ("Sinu laud.\nSinu stiil.", "Kombineeri teemasid, välimusi ja aksessuaare oma maitse järgi"),
        "shown": "Pildil:",
        "3-skins": ("{skins} klotside välimust", "Neist {animated} on animeeritud"),
        "4-themes": "{themes} teemat.\nVali oma meeleolu.",
        "5-extras": ("Viimane\nlihv", "{accessories} aksessuaari ja {bursts} plahvatust"),
    },
    "lt": {
        "1-designs": ("Tavo lenta.\nTavo stilius.", "Derink temas, išvaizdas ir priedus kaip nori"),
        "shown": "Paveikslėlyje:",
        "3-skins": ("{skins} blokų išvaizdos", "{animated} iš jų – animuotos"),
        "4-themes": "{themes} temų.\nPagal nuotaiką.",
        "5-extras": ("Paskutinis\nakcentas", "{accessories} priedai ir {bursts} sprogimai"),
    },
    "az": {
        "1-designs": ("Sənin lövhən.\nSənin üslubun.", "Mövzuları, görünüşləri və aksesuarları istədiyin kimi birləşdir"),
        "shown": "Şəkildə:",
        "3-skins": ("{skins} blok görünüşü", "Onlardan {animated}-i animasiyalıdır"),
        "4-themes": "{themes} mövzu.\nƏhvalına görə seç.",
        "5-extras": ("Son\ntoxunuş", "{accessories} aksesuar və {bursts} partlayış"),
    },
    "uz": {
        "1-designs": ("Sizning maydoningiz.\nSizning uslubingiz.", "Mavzular, skinlar va aksessuarlarni xohlaganingizcha uyg‘unlashtiring"),
        "shown": "Rasmda:",
        "3-skins": ("{skins} ta blok skini", "Ulardan {animated} tasi animatsiyali"),
        "4-themes": "{themes} ta mavzu.\nKayfiyatga qarab.",
        "5-extras": ("Yakuniy\nsayqal", "{accessories} ta aksessuar va {bursts} ta portlash"),
    },
    "sw": {
        "1-designs": ("Ubao wako.\nMtindo wako.", "Changanya mandhari, mitindo ya vitalu na mapambo upendavyo"),
        "shown": "Kwenye picha:",
        "3-skins": ("Mitindo {skins} ya vitalu", "{animated} kati yake ina mwendo"),
        "4-themes": "Mandhari {themes}.\nChagua hisia yako.",
        "5-extras": ("Mguso wa\nmwisho", "Mapambo {accessories} na milipuko {bursts}"),
    },
    "ca": {
        "1-designs": ("El teu tauler.\nEl teu estil.", "Combina temes, skins i accessoris com vulguis"),
        "shown": "A la imatge:",
        "3-skins": ("{skins} skins de blocs", "{animated} tenen animació"),
        "4-themes": "{themes} temes.\nTria el teu estil.",
        "5-extras": ("El toc\nfinal", "{accessories} accessoris i {bursts} explosions"),
    },
    "ur": {
        "1-designs": ("آپ کا بورڈ۔\nآپ کا انداز۔", "تھیمز، اسکنز اور لوازمات اپنی مرضی سے ملائیں"),
        "shown": "تصویر میں:",
        "3-skins": ("{skins} بلاک اسکنز", "ان میں سے {animated} اینیمیٹڈ ہیں"),
        "4-themes": "{themes} تھیمز۔\nجیسا موڈ ہو۔",
        "5-extras": ("آخری\nٹچ", "{accessories} لوازمات اور {bursts} دھماکے"),
    },
    "fil": {
        "1-designs": ("Board mo.\nEstilo mo.", "Pagsamahin ang mga tema, skin at accessory ayon sa gusto mo"),
        "shown": "Nasa larawan:",
        "3-skins": ("{skins} na skin ng block", "{animated} sa mga ito ay gumagalaw"),
        "4-themes": "{themes} na tema.\nPiliin ang mood mo.",
        "5-extras": ("Ang huling\nhaplos", "{accessories} na accessory at {bursts} na pagsabog"),
    },
    "he": {
        "1-designs": ("הלוח שלך.\nהסגנון שלך.", "משלבים ערכות נושא, מראות ואביזרים כרצונכם"),
        "shown": "בתמונה:",
        "3-skins": ("{skins} מראות לבלוקים", "{animated} מהם מונפשים"),
        "4-themes": "{themes} ערכות נושא.\nלכל מצב רוח.",
        "5-extras": ("הנגיעה\nהאחרונה", "{accessories} אביזרים ו־{bursts} פיצוצים"),
    },
    "hr": {
        "1-designs": ("Tvoja ploča.\nTvoj stil.", "Kombiniraj teme, izglede blokova i dodatke po želji"),
        "shown": "Na slici:",
        "3-skins": ("{skins} izgleda blokova", "{animated} ih je animirano"),
        "4-themes": "{themes} tema.\nPo tvom raspoloženju.",
        "5-extras": ("Završni\ndodir", "{accessories} dodataka i {bursts} eksplozija"),
    },
    "bg": {
        "1-designs": ("Твоята дъска.\nТвоят стил.", "Комбинирай теми, облици и аксесоари по свой вкус"),
        "shown": "На снимката:",
        "3-skins": ("{skins} облика на блокчетата", "{animated} от тях са анимирани"),
        "4-themes": "{themes} теми.\nПо твой вкус.",
        "5-extras": ("Последен\nщрих", "{accessories} аксесоара и {bursts} експлозии"),
    },
    "fi": {
        "1-designs": ("Sinun lautasi.\nSinun tyylisi.", "Yhdistele teemoja, ulkoasuja ja asusteita mielesi mukaan"),
        "shown": "Kuvassa:",
        "3-skins": ("{skins} palikoiden ulkoasua", "Niistä {animated} on animoituja"),
        "4-themes": "{themes} teemaa.\nFiiliksen mukaan.",
        "5-extras": ("Viimeinen\nsilaus", "{accessories} asustetta ja {bursts} räjähdystä"),
    },
    "nb": {
        "1-designs": ("Ditt brett.\nDin stil.", "Kombiner temaer, skins og tilbehør som du vil"),
        "shown": "På bildet:",
        "3-skins": ("{skins} blokkskins", "{animated} av dem er animerte"),
        "4-themes": "{themes} temaer.\nVelg humøret.",
        "5-extras": ("Prikken\nover i-en", "{accessories} typer tilbehør og {bursts} eksplosjoner"),
    },
    "da": {
        "1-designs": ("Dit bræt.\nDin stil.", "Kombinér temaer, skins og tilbehør, som du vil"),
        "shown": "På billedet:",
        "3-skins": ("{skins} blokskins", "{animated} af dem er animerede"),
        "4-themes": "{themes} temaer.\nVælg dit humør.",
        "5-extras": ("Prikken\nover i'et", "{accessories} slags tilbehør og {bursts} eksplosioner"),
    },
    "el": {
        "1-designs": ("Το ταμπλό σου.\nΤο στυλ σου.", "Συνδύασε θέματα, εμφανίσεις και αξεσουάρ όπως θες"),
        "shown": "Στην εικόνα:",
        "3-skins": ("{skins} εμφανίσεις τουβλακιών", "Οι {animated} έχουν κίνηση"),
        "4-themes": "{themes} θέματα.\nΓια κάθε διάθεση.",
        "5-extras": ("Η τελευταία\nπινελιά", "{accessories} αξεσουάρ και {bursts} εκρήξεις"),
    },
    "sk": {
        "1-designs": ("Tvoja plocha.\nTvoj štýl.", "Kombinuj motívy, vzhľady kociek a doplnky podľa chuti"),
        "shown": "Na obrázku:",
        "3-skins": ("{skins} vzhľadov kociek", "{animated} z nich je animovaných"),
        "4-themes": "{themes} motívov.\nPodľa nálady.",
        "5-extras": ("Posledná\nbodka", "{accessories} doplnkov a {bursts} výbuchov"),
    },
}


class FallbackFont:
    """A script face with Nunito behind it for the characters it lacks.

    Pillow has no font fallback. This splits a string into runs by which font
    has each character, measures them one after another and draws them on one
    shared baseline — enough for "8 ธีม" or "x2" inside a Thai caption.
    """

    def __init__(self, path: str, primary: ImageFont.FreeTypeFont,
                 fallback: ImageFont.FreeTypeFont, only=None, rtl=False):
        self.primary, self.fallback = primary, fallback
        # Right to left: the runs go down from the right, so a sentence's
        # full stop (a Nunito run after the Hebrew one) lands on its left.
        # Drawn in reading order, the Hebrew captions came out as
        # "ניקוי אחד מספק,מהלך אחד" — halves swapped, comma adrift.
        self.rtl = rtl
        self._chars = _cmap(path)
        if only:
            # The script face draws only these blocks, even where it has more.
            self._chars = {c for c in self._chars
                           if any(lo <= c <= hi for lo, hi in only)}

    def runs(self, text: str):
        """(font, run) pairs in order; a run never mixes fonts."""
        out: list[tuple[ImageFont.FreeTypeFont, str]] = []
        for ch in text:
            font = self.primary if ord(ch) in self._chars else self.fallback
            if out and out[-1][0] is font:
                out[-1] = (font, out[-1][1] + ch)
            else:
                out.append((font, ch))
        return out[::-1] if self.rtl else out


_cmaps: dict[str, set[int]] = {}


def _cmap(path: str) -> set[int]:
    if path not in _cmaps:
        from fontTools.ttLib import TTFont

        _cmaps[path] = set(TTFont(path).getBestCmap())
    return _cmaps[path]


def text_length(draw, text: str, font) -> float:
    """draw.textlength that also understands a FallbackFont."""
    if isinstance(font, FallbackFont):
        return sum(draw.textlength(run, font=f) for f, run in font.runs(text))
    return draw.textlength(text, font=font)


def draw_text(draw, xy, text: str, font, fill) -> None:
    """draw.text with the top at xy[1], for a FallbackFont too."""
    if not isinstance(font, FallbackFont):
        draw.text(xy, text, font=font, fill=fill)
        return
    x, y = xy
    baseline = y + font.primary.getmetrics()[0]
    for f, run in font.runs(text):
        draw.text((x, baseline), run, font=f, fill=fill, anchor="ls")
        x += draw.textlength(run, font=f)


def _nunito(size: int, weight: int) -> ImageFont.FreeTypeFont:
    font = ImageFont.truetype(FONT, size)
    try:
        font.set_variation_by_axes([weight])
    except (AttributeError, OSError):
        pass  # Static build of the font, or a Pillow without variation support.
    return font


def _weighted(size: int, weight: int, locale: str = "en"):
    """Nunito at an explicit weight on its variable-font axis.

    For a locale in CJK_FACES, Noto Sans CJK instead, and for Thai, Noto Sans
    Thai in front of Nunito: Bold for anything heavier than medium, Regular
    below.
    """
    cut = "Bold" if weight >= 600 else "Regular"
    face = CJK_FACES.get(locale)
    if face is not None:
        path = CJK_FONT.format(cut)
        if not os.path.exists(path):
            sys.exit(f"{path} is missing — apt install fonts-noto-cjk")
        return ImageFont.truetype(path, size, index=face)
    if locale in ARABIC_SCRIPT:
        path = ARABIC_FONT.format(cut)
        if not os.path.exists(path):
            sys.exit(f"{path} is missing — apt install fonts-noto-core")
        return ImageFont.truetype(path, size)
    if locale == "el":
        path = GREEK_FONT.format(cut)
        if not os.path.exists(path):
            sys.exit(f"{path} is missing — apt install fonts-noto-core")
        return FallbackFont(path, ImageFont.truetype(path, size),
                            _nunito(size, weight), only=GREEK_BLOCKS)
    if locale in FALLBACK_FONTS:
        path = FALLBACK_FONTS[locale].format(cut)
        if not os.path.exists(path):
            sys.exit(f"{path} is missing — apt install fonts-noto-core")
        return FallbackFont(path, ImageFont.truetype(path, size),
                            _nunito(size, weight), rtl=locale in RTL_LOCALES)
    return _nunito(size, weight)


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


def _break_run(draw, word: str, font, max_width: int) -> list[str]:
    """Splits a run with no spaces (Japanese) between characters."""
    parts, part = [], ""
    for ch in word:
        too_wide = text_length(draw, part + ch, font) > max_width
        if part and too_wide and ch not in NO_LINE_START:
            parts.append(part)
            part = ch
        else:
            part += ch
    parts.append(part)
    return parts


def wrap(draw, text: str, font, max_width: int) -> list[str]:
    """Greedy word wrap, honouring explicit newlines in the caption."""
    lines = []
    for paragraph in text.split("\n"):
        line = ""
        for word in paragraph.split():
            pieces = [word]
            if text_length(draw, word, font) > max_width:
                pieces = _break_run(draw, word, font, max_width)
            for i, piece in enumerate(pieces):
                probe = f"{line} {piece}".strip()
                if i == 0 and (text_length(draw, probe, font) <= max_width or not line):
                    line = probe
                else:
                    lines.append(line)
                    line = piece
        lines.append(line)
    return lines


def draw_caption(canvas, headline, subline, accent, locale, size=88):
    """Headline block at the top, with an accent rule under it.

    Top-stacked and large on purpose: most people only ever see the frame as a
    ~200 px thumbnail, where a bottom caption in body-copy sizes is a grey
    smudge. Shrinks the type rather than breaking a line the copy did not.
    """
    draw = ImageDraw.Draw(canvas)
    # The copy sets its own line breaks. Another one from the wrap leaves a
    # word dangling on a line of its own and pushes the art down — the
    # French, Bulgarian and Romanian headlines had one — so the type shrinks
    # first, and past the smallest size the copy has to get shorter.
    written = headline.count("\n") + 1
    while size > 56:
        font = _weighted(size, HEADLINE_WEIGHT, locale)
        lines = wrap(draw, headline, font, W - 2 * MARGIN)
        if len(lines) <= written:
            break
        size -= 6
    font = _weighted(size, HEADLINE_WEIGHT, locale)
    lines = wrap(draw, headline, font, W - 2 * MARGIN)
    if len(lines) > written:
        sys.exit(f"{locale}: {headline!r} wraps to {len(lines)} lines, "
                 f"written as {written} — shorten it in CAPTIONS")

    # CJK glyphs fill the whole em box and Noto Sans CJK sits lower in it
    # than Nunito, so at Nunito's leading the lines and the subline touch.
    leading = 1.3 if locale in SCRIPT_LOCALES else 1.14
    rtl = locale in RTL_LOCALES
    y = 108
    for line in lines:
        x = W - MARGIN - text_length(draw, line, font) if rtl else MARGIN
        draw_text(draw, (x, y), line, font, TEXT)
        y += round(size * leading)

    y += 14
    sub_font = _weighted(38, SUB_WEIGHT, locale)
    for line in wrap(draw, subline, sub_font, W - 2 * MARGIN):
        x = W - MARGIN - text_length(draw, line, sub_font) if rtl else MARGIN
        draw_text(draw, (x, y), line, sub_font, MUTED)
        y += 50

    y += 26
    rule_x = W - MARGIN - 148 if rtl else MARGIN
    draw.rounded_rectangle([(rule_x, y), (rule_x + 148, y + 8)], radius=4, fill=accent)
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


def hero(canvas, capture, rect, accent, headline, subline, locale, header=False):
    """Board crop, as large as the frame allows.

    Near the full width on purpose: the board is what a browser is judging, and
    at thumbnail size a comfortable margin costs more than it buys.
    """
    bottom = draw_caption(canvas, headline, subline, accent, locale)
    top, floor = bottom + 60, H - 70
    art = fit(crop_board(capture, rect, header=header), W - 2 * 24, floor - top)
    art = rounded(art, 40)
    y = place_y(top, floor, art.height)
    return shadow_paste(canvas, art, (W - art.width) // 2, y, 40)


def screen(canvas, capture, accent, headline, subline, locale):
    """Whole screen, for the modes whose layout is the point."""
    bottom = draw_caption(canvas, headline, subline, accent, locale)
    top, floor = bottom + 56, H - 70
    art = fit(capture, W - 2 * 96, floor - top)
    art = rounded(art, 44)
    y = place_y(top, floor, art.height)
    return shadow_paste(canvas, art, (W - art.width) // 2, y, 44)


def _fitted_font(draw, text: str, size: int, weight: int, locale: str, max_w: int):
    """The font for [text] at [size], shrunk until it fits [max_w]."""
    font = _weighted(size, weight, locale)
    while size > 18 and text_length(draw, text, font) > max_w:
        size -= 2
        font = _weighted(size, weight, locale)
    return font


def _tile_grid(canvas, tiles, labels, cols, top, floor, locale, side=40, gap=26,
               below=0):
    """Lays [tiles] out in a grid between [top] and [floor], each with its
    label centred underneath (or none), leaving [below] pixels under the grid
    for whatever follows it. Returns the canvas and the grid's bottom edge."""
    rows = -(-len(tiles) // cols)
    label_h = 58 if labels else 0
    aspect = tiles[0].height / tiles[0].width
    cell_w = (W - 2 * side - (cols - 1) * gap) // cols
    cell_w = min(cell_w, int((floor - top - below - (rows - 1) * gap
                              - rows * label_h) / rows / aspect))
    cell_h = round(cell_w * aspect)
    block_w = cols * cell_w + (cols - 1) * gap
    block_h = rows * (cell_h + label_h) + (rows - 1) * gap
    x0 = (W - block_w) // 2
    y0 = place_y(top, floor, block_h + below)
    for i, tile in enumerate(tiles):
        art = rounded(tile.resize((cell_w, cell_h), Image.LANCZOS), 24)
        x = x0 + (i % cols) * (cell_w + gap)
        y = y0 + (i // cols) * (cell_h + label_h + gap)
        canvas = shadow_paste(canvas, art, x, y, 24)
        if labels:
            draw = ImageDraw.Draw(canvas)
            label = labels[i]
            font = _fitted_font(draw, label, 32, HEADLINE_WEIGHT, locale, cell_w)
            lx = x + (cell_w - text_length(draw, label, font)) / 2
            draw_text(draw, (lx, y + cell_h + 12), label, font, MUTED)
    return canvas, y0 + block_h


def grid(canvas, tiles, labels, cols, accent, headline, subline, locale):
    """Real boards, one design each, with the app's name for it underneath."""
    bottom = draw_caption(canvas, headline, subline, accent, locale)
    canvas, _ = _tile_grid(canvas, tiles, labels, cols, bottom + 56, H - 70, locale)
    return canvas


def mosaic(canvas, tiles, facts, accent, headline, subline, locale):
    """The opener: nine whole looks — theme, skin and accessory together —
    and the catalog sizes underneath, labelled with the Designs screen's own
    tab names."""
    bottom = draw_caption(canvas, headline, subline, accent, locale)
    stats_h = 150
    canvas, grid_bottom = _tile_grid(canvas, tiles, None, 3, bottom + 48, H - 60,
                                     locale, side=36, gap=18, below=56 + stats_h)
    draw = ImageDraw.Draw(canvas)
    counts, tabs = facts["counts"], facts["tabs"]
    items = [(counts[k], tabs[k]) for k in ("themes", "skins", "accessories", "bursts")]
    if locale in RTL_LOCALES:
        items.reverse()
    col_w = (W - 2 * 36) // len(items)
    y = grid_bottom + 56
    number_font = _weighted(80, 900, locale)
    for i, (count, label) in enumerate(items):
        cx = 36 + i * col_w + col_w / 2
        number = str(count)
        draw_text(draw, (cx - text_length(draw, number, number_font) / 2, y),
                  number, number_font, accent)
        # A long tab name ("Εμφανίσεις τουβλακιών") takes a second line
        # rather than shrinking to a size nobody can read in a thumbnail.
        size, lines = 32, [label]
        font = _weighted(size, HEADLINE_WEIGHT, locale)
        while size > 28 and text_length(draw, label, font) > col_w - 16:
            size -= 2
            font = _weighted(size, HEADLINE_WEIGHT, locale)
        if text_length(draw, label, font) > col_w - 16:
            lines = wrap(draw, label, font, col_w - 16)
        for n, line in enumerate(lines):
            line_font = _fitted_font(draw, line, size, HEADLINE_WEIGHT, locale,
                                     col_w - 16)
            draw_text(draw, (cx - text_length(draw, line, line_font) / 2,
                             y + 100 + n * round(size * 1.3)),
                      line, line_font, TEXT)
    return canvas


def statement(canvas, capture, rect, accent, headline, subline, proof, locale):
    """The differentiator frame: big claim, three proof lines, smaller art.

    Qubble's one advantage over the top of this genre is that it does not
    interrupt you. That deserves its own composition rather than a caption
    bolted onto another board shot.
    """
    bottom = draw_caption(canvas, headline, subline, accent, locale, size=96)
    draw = ImageDraw.Draw(canvas)
    y = bottom + 64
    line_font = _weighted(40, SUB_WEIGHT, locale)
    rtl = locale in RTL_LOCALES
    for item in proof:
        dot = W - MARGIN - 18 if rtl else MARGIN
        draw.ellipse([(dot, y + 12), (dot + 18, y + 30)], fill=accent)
        x = W - MARGIN - 40 - text_length(draw, item, line_font) if rtl else MARGIN + 40
        draw_text(draw, (x, y), item, line_font, TEXT)
        y += 68

    art = crop_board(capture, rect) if rect else capture
    top, floor = y + 52, H - 60
    art = fit(art, W - 2 * 104, floor - top)
    art = rounded(art, 40)
    y = place_y(top, floor, art.height)
    return shadow_paste(canvas, art, (W - art.width) // 2, y, 40)


def design_facts(locale: str) -> dict:
    """Counts and app names, as the generator wrote them for [locale]."""
    return json.load(open(os.path.join(RAW_DIR, locale, "designs.json"),
                          encoding="utf-8"))


def _fill(text: str, facts: dict) -> str:
    """Puts the counts and app names into a caption (see DESIGN_CAPTIONS)."""
    tables = {"theme": "themes", "skin": "skins", "burst": "bursts",
              "accessory": "accessories"}
    text = re.sub(r"\{(theme|skin|burst|accessory):(\w+)\}",
                  lambda m: facts[tables[m.group(1)]][m.group(2)], text)
    return text.format(**facts["counts"])


def frame_captions(locale: str, facts: dict) -> dict[str, tuple[str, str]]:
    """Headline and subline of every frame in FRAMES, filled in."""
    base, design = CAPTIONS[locale], DESIGN_CAPTIONS[locale]
    # Noto Sans Arabic has no middle dot; the Arabic comma reads naturally.
    dot = "، " if locale in ARABIC_SCRIPT else " · "
    look = dot.join(
        f"{{{kind}:{CLEAR_LOOK[kind]}}}" for kind in ("theme", "skin", "burst")
    )
    # A full-width colon (CJK) carries its own spacing.
    gap = "" if design["shown"].endswith("：") else " "
    captions = {
        "1-designs": design["1-designs"],
        "2-clear": (base["2-clear"][0], design["shown"] + gap + look),
        "3-skins": design["3-skins"],
        "4-themes": (design["4-themes"], base["4-themes"][1]),
        "5-extras": design["5-extras"],
        "6-daily": base["6-daily"],
        "7-puzzle": base["7-puzzle"],
        "8-offline": base["8-offline"],
    }
    return {stem: (_fill(h, facts), _fill(s, facts))
            for stem, (h, s) in captions.items()}


def tile(stem: str, region: tuple[int, int] | None = None) -> Image.Image:
    """A board-only capture, cropped to the board — or, with [region] as
    (columns, rows), to that many cells from its top-left corner, where the
    blocks sit closest and an accessory is big enough to see."""
    path = os.path.join(RAW_DIR, "en", f"{stem}.png")
    if not os.path.exists(path):
        sys.exit(f"missing design tile {path} — run tool/generate_screenshots.dart")
    img = Image.open(path).convert("RGB")
    x, y, w, h = board_rect("en", stem)
    if region is None:
        return crop_board(img, (x, y, w, h), pad_ratio=0.02)
    cell = w / 8
    cols, rows = region
    return img.crop((x, y, round(x + cols * cell), round(y + rows * cell)))


def build(locale: str) -> int:
    raw = os.path.join(RAW_DIR, locale)
    if not os.path.isdir(raw):
        print(f"skipping {locale}: no captures in {raw}")
        return 0
    facts = design_facts(locale)
    if facts["counts"] != WRITTEN_FOR:
        sys.exit(f"the catalogs now have {facts['counts']}, the captions were "
                 f"written for {WRITTEN_FOR}: check every DESIGN_CAPTIONS line "
                 "whose number word depends on the count, then update WRITTEN_FOR")
    captions = frame_captions(locale, facts)

    made = 0
    for stem, layout, theme, source, header in FRAMES:
        headline, subline = captions[stem]
        _, accent = PALETTE[theme]
        canvas = plate(stem, theme).convert("RGBA")

        if layout == "mosaic":
            canvas = mosaic(canvas, [tile(t) for t in MOSAIC], facts, accent,
                            headline, subline, locale)
        elif layout == "skins":
            canvas = grid(canvas, [tile(f"skin-{t}") for t in SKIN_TILES],
                          [facts["skins"][t] for t in SKIN_TILES], 3, accent,
                          headline, subline, locale)
        elif layout == "themes":
            canvas = grid(canvas, [tile(f"theme-{t}") for t in THEME_TILES],
                          [facts["themes"][t] for t in THEME_TILES], 3, accent,
                          headline, subline, locale)
        elif layout == "extras":
            canvas = grid(canvas,
                          [tile(f"accessory-{t}", (5, 4)) for t in ACCESSORY_TILES],
                          [facts["accessories"][t] for t in ACCESSORY_TILES], 2,
                          accent, headline, subline, locale)
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
                    canvas, capture, rect, accent, headline, subline, locale,
                    header,
                )
            elif layout == "screen":
                canvas = screen(canvas, capture, accent, headline, subline, locale)
            else:
                canvas = statement(
                    canvas, capture, rect, accent, headline, subline,
                    PROOF[locale], locale,
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
    # `python3 tool/caption_screenshots.py es fr` frames only those locales,
    # so adding a language does not rewrite the images already uploaded.
    wanted = sys.argv[1:] or list(DESIGN_CAPTIONS)
    for locale in wanted:
        print(f"\nFraming {locale} screenshots …")
        if build(locale):
            return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
