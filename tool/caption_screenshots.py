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

# Thai: likewise drawn by the phone, in Noto Sans Thai (`apt install
# fonts-noto-core`). That face carries Thai and nothing else — no digits, no
# full stop — so it is paired with Nunito for the rest (FallbackFont).
THAI_FONT = "/usr/share/fonts/truetype/noto/NotoSansThai-{}.ttf"

# Every locale whose captions are not drawn in Nunito.
SCRIPT_LOCALES = set(CJK_FACES) | {"th"}

# Japanese runs without spaces, so wrap() breaks it between characters — but
# never right before one of these (kinsoku: closing punctuation and small kana
# may not start a line).
NO_LINE_START = set("、。，．・：；？！ー）」』】〕ぁぃぅぇぉっゃゅょァィゥェォッャュョ")
# Thai vowel signs and tone marks attach to the consonant before them.
NO_LINE_START |= set("ะัาำิีึืฺุู็่้๊๋์ํ๎")

# Straight from lib/ui/theme.dart, so every frame agrees with the app it shows.
PALETTE = {
    "classic": ((0x0F, 0x10, 0x30), (0x4F, 0xE0, 0xC6)),
    "neon": ((0x07, 0x07, 0x0C), (0x39, 0xFF, 0x14)),
    "ocean": ((0x06, 0x26, 0x3A), (0x35, 0xD0, 0xBA)),
    "wood": ((0x24, 0x18, 0x11), (0xD9, 0xA0, 0x5B)),
    "sunset": ((0x1E, 0x10, 0x30), (0xFF, 0x7E, 0x5F)),
    "forest": ((0x0C, 0x1F, 0x14), (0x7B, 0xE3, 0x82)),
}

# stem -> (layout, theme, source capture, keep the header band above the board)
#
# The header carries score and best. Only the Daily Challenge takes it: every
# other mode draws a full-width "New pieces (video)" button between the header
# and the board, and a crop that reaches up for the score has to bring that
# along — a video call-to-action is the last thing frame 2 should be selling.
# The Daily hides it (game_screen.dart gates it on `!isDaily`), so there the
# score row crops clean. The rest read better tight to the board anyway, where
# the blocks are twice the size in a search thumbnail.
FRAMES = [
    ("1-clear", "hero", "classic", "1-clear", False),
    ("2-combo", "hero", "neon", "2-combo", False),
    ("3-daily", "hero", "ocean", "3-daily", True),
    ("4-themes", "collage", "sunset", None, False),
    ("5-puzzle", "screen", "wood", "4-puzzle", False),
    ("6-offline", "statement", "classic", "6-home", False),
]

# Top of the header band, in capture pixels: below the coin chip, above SCORE.
HEADER_TOP = 125

# The 2x2 tiles for the collage frame, in reading order.
COLLAGE = ["theme-classic", "theme-neon", "theme-sunset", "theme-forest"]
# Labels under the tiles, per locale: the names the app shows for those four
# themes in that language (themeName in lib/ui/l10n_maps.dart). German keeps
# the English names, as the app does.
COLLAGE_LABELS = {
    "en": ["Classic", "Neon", "Sunset", "Forest"],
    "de": ["Classic", "Neon", "Sunset", "Forest"],
    "es": ["Clásico", "Neón", "Atardecer", "Bosque"],
    "fr": ["Classique", "Néon", "Coucher de soleil", "Forêt"],
    "id": ["Klasik", "Neon", "Senja", "Hutan"],
    "it": ["Classico", "Neon", "Tramonto", "Foresta"],
    "pt": ["Clássico", "Neon", "Pôr do sol", "Floresta"],
    "tr": ["Klasik", "Neon", "Gün batımı", "Orman"],
    "nl": ["Klassiek", "Neon", "Zonsondergang", "Bos"],
    "pl": ["Klasyczny", "Neon", "Zachód słońca", "Las"],
    "vi": ["Cổ điển", "Neon", "Hoàng hôn", "Rừng xanh"],
    "ja": ["クラシック", "ネオン", "サンセット", "フォレスト"],
    "ko": ["클래식", "네온", "선셋", "포레스트"],
    "th": ["คลาสสิก", "นีออน", "พระอาทิตย์ตก", "ป่าไม้"],
    "zh": ["经典", "霓虹", "夕阳", "森林"],
    "zh_Hant": ["經典", "霓虹", "夕陽", "森林"],
}

# Every claim here has to survive a reading of the code, because a screenshot
# that overstates the app is a Misrepresentation case, not a marketing choice.
# "solvable" is safe: PuzzleGenerator builds each level solvable by
# construction and the solver verifies it (lib/game/puzzle.dart). "One move"
# rather than "one tap": pieces are dragged.
CAPTIONS = {
    "en": {
        "1-clear": ("Fill a line.\nWatch it blow.", "One move, one satisfying clear"),
        "2-combo": ("Clear a column.\nThen chain it.", "Combos multiply everything you clear"),
        "3-daily": ("A new board\nevery day", "Same puzzle for everyone. Build a streak."),
        "4-themes": ("Eight themes.\nPick your mood.", "Wood, neon, ocean, forest and more"),
        "5-puzzle": ("Every puzzle\nhas a solution", "Checked by the solver, not left to chance"),
        "6-offline": ("No forced ads.\nEver.", "No sign-up, no interruptions. Plays on a plane."),
    },
    "de": {
        "1-clear": ("Reihe voll.\nReihe weg.", "Ein Zug, ein befriedigendes Clear"),
        "2-combo": ("Spalte weg.\nDann verketten.", "Combos vervielfachen jedes Clear"),
        "3-daily": ("Jeden Tag\nein neues Board", "Für alle dasselbe Puzzle. Bau deinen Streak."),
        "4-themes": ("Acht Themes.\nDeine Stimmung.", "Holz, Neon, Ozean, Wald und mehr"),
        "5-puzzle": ("Jedes Rätsel\nist lösbar", "Vom Solver geprüft, nicht dem Zufall überlassen"),
        "6-offline": ("Keine Zwangs-\nwerbung.", "Keine Anmeldung, keine Unterbrechung. Läuft im Flugzeug."),
    },
    # The six languages added on 2026-09-23 translate the English captions
    # claim for claim; nothing here says more than the English line does.
    "es": {
        "1-clear": ("Llena una línea.\nMira cómo estalla.", "Un movimiento, una limpieza satisfactoria"),
        "2-combo": ("Limpia una columna.\nY encadena.", "Los combos multiplican todo lo que limpias"),
        "3-daily": ("Un tablero nuevo\ncada día", "El mismo desafío para todos. Construye tu racha."),
        "4-themes": ("Ocho temas.\nElige tu estilo.", "Madera, neón, océano, bosque y más"),
        "5-puzzle": ("Cada rompecabezas\ntiene solución", "Verificado por el solucionador, no por azar"),
        "6-offline": ("Sin anuncios\nobligatorios. Nunca.", "Sin registro, sin interrupciones. Se juega en el avión."),
    },
    "fr": {
        "1-clear": ("Remplis une ligne.\nRegarde-la exploser.", "Un coup, un effacement satisfaisant"),
        "2-combo": ("Efface une colonne.\nPuis enchaîne.", "Les combos multiplient tout ce que tu effaces"),
        "3-daily": ("Une nouvelle grille\nchaque jour", "Le même défi pour tous. Construis ta série."),
        "4-themes": ("Huit thèmes.\nSelon ton humeur.", "Bois, néon, océan, forêt et plus encore"),
        "5-puzzle": ("Chaque puzzle\na sa solution", "Vérifié par le solveur, pas laissé au hasard"),
        "6-offline": ("Aucune pub imposée.\nJamais.", "Sans inscription, sans interruption. Même en avion."),
    },
    "id": {
        "1-clear": ("Penuhi satu garis.\nLihat meledak.", "Satu langkah, satu pembersihan yang memuaskan"),
        "2-combo": ("Bersihkan kolom.\nLalu rangkai.", "Kombo melipatgandakan semua yang kamu bersihkan"),
        "3-daily": ("Papan baru\nsetiap hari", "Tantangan sama untuk semua. Bangun runtunanmu."),
        "4-themes": ("Delapan tema.\nSesuai suasana.", "Kayu, neon, samudra, hutan, dan lainnya"),
        "5-puzzle": ("Setiap teka-teki\nada solusinya", "Diperiksa pemecah otomatis, bukan untung-untungan"),
        "6-offline": ("Tanpa iklan paksa.\nSelamanya.", "Tanpa daftar, tanpa gangguan. Bisa main di pesawat."),
    },
    "it": {
        "1-clear": ("Riempi una linea.\nGuardala esplodere.", "Una mossa, un’eliminazione che appaga"),
        "2-combo": ("Elimina una colonna.\nPoi concatena.", "Le combo moltiplicano tutto ciò che elimini"),
        "3-daily": ("Una griglia nuova\nogni giorno", "La stessa sfida per tutti. Costruisci la tua serie."),
        "4-themes": ("Otto temi.\nScegli il tuo stile.", "Legno, neon, oceano, foresta e altro"),
        "5-puzzle": ("Ogni puzzle\nha una soluzione", "Verificato dal risolutore, non lasciato al caso"),
        "6-offline": ("Niente pubblicità\nobbligatoria. Mai.", "Niente registrazione, niente interruzioni. Anche in aereo."),
    },
    "pt": {
        "1-clear": ("Complete a linha.\nVeja explodir.", "Uma jogada, uma limpeza satisfatória"),
        "2-combo": ("Limpe uma coluna.\nDepois encadeie.", "Combos multiplicam tudo o que você limpa"),
        "3-daily": ("Um tabuleiro novo\ntodo dia", "O mesmo desafio para todos. Crie sua sequência."),
        "4-themes": ("Oito temas.\nEscolha seu estilo.", "Madeira, neon, oceano, floresta e mais"),
        "5-puzzle": ("Todo quebra-cabeça\ntem solução", "Verificado pelo solucionador, não pela sorte"),
        "6-offline": ("Sem anúncios\nobrigatórios. Nunca.", "Sem cadastro, sem interrupções. Funciona no avião."),
    },
    "tr": {
        "1-clear": ("Satırı doldur.\nPatlamasını izle.", "Tek hamle, tatmin edici bir temizlik"),
        "2-combo": ("Sütunu temizle.\nSonra zincirle.", "Kombolar temizlediğin her şeyi katlar"),
        "3-daily": ("Her gün\nyeni bir tahta", "Herkes için aynı bulmaca. Serini kur."),
        "4-themes": ("Sekiz tema.\nModuna göre seç.", "Ahşap, neon, okyanus, orman ve dahası"),
        "5-puzzle": ("Her bulmacanın\nbir çözümü var", "Çözücüyle doğrulandı, şansa bırakılmadı"),
        "6-offline": ("Zorunlu reklam yok.\nAsla.", "Kayıt yok, kesinti yok. Uçakta bile oynanır."),
    },
    "nl": {
        "1-clear": ("Vul een lijn.\nZie hem knallen.", "Eén zet, één heerlijke clear"),
        "2-combo": ("Wis een kolom.\nEn rijg door.", "Combo's vermenigvuldigen alles wat je wegspeelt"),
        "3-daily": ("Elke dag\neen nieuw bord", "Dezelfde puzzel voor iedereen. Bouw een reeks."),
        "4-themes": ("Acht thema's.\nKies je sfeer.", "Hout, neon, oceaan, bos en meer"),
        "5-puzzle": ("Elke puzzel\nis oplosbaar", "Gecontroleerd door de solver, niet aan het toeval overgelaten"),
        "6-offline": ("Geen verplichte\nadvertenties. Nooit.", "Geen account, geen onderbrekingen. Speelt in het vliegtuig."),
    },
    "pl": {
        "1-clear": ("Wypełnij linię.\nPatrz, jak wybucha.", "Jeden ruch, jedno satysfakcjonujące czyszczenie"),
        "2-combo": ("Wyczyść kolumnę.\nPotem łącz combo.", "Combo mnoży wszystko, co czyścisz"),
        "3-daily": ("Nowa plansza\ncodziennie", "To samo wyzwanie dla wszystkich. Buduj serię."),
        "4-themes": ("Osiem motywów.\nWybierz nastrój.", "Drewno, neon, ocean, las i więcej"),
        "5-puzzle": ("Każda łamigłówka\nma rozwiązanie", "Sprawdzone przez solver, nie dzieło przypadku"),
        "6-offline": ("Bez wymuszonych\nreklam. Nigdy.", "Bez rejestracji, bez przerw. Działa w samolocie."),
    },
    "vi": {
        "1-clear": ("Lấp đầy một hàng.\nNgắm nó nổ tung.", "Một nước đi, một pha xóa đã mắt"),
        "2-combo": ("Xóa một cột.\nRồi nối combo.", "Combo nhân lên mọi thứ bạn xóa"),
        "3-daily": ("Mỗi ngày\nmột bàn mới", "Cùng thử thách cho mọi người. Xây chuỗi ngày."),
        "4-themes": ("Tám chủ đề.\nChọn theo tâm trạng.", "Gỗ, neon, đại dương, rừng xanh và hơn nữa"),
        "5-puzzle": ("Câu đố nào\ncũng có lời giải", "Bộ giải đã kiểm tra, không phó mặc may rủi"),
        "6-offline": ("Không bao giờ ép\nxem quảng cáo.", "Không đăng ký, không gián đoạn. Chơi cả trên máy bay."),
    },
    # "Combos multiply" is said as "the longer the combo, the more points": the
    # multiplier climbs in half steps (lib/game/scoring.dart), and a literal
    # "doubles" would overstate it.
    "ja": {
        "1-clear": ("1列そろえて、\nパッと消す。", "1手で、気持ちいいほど消える"),
        "2-combo": ("列を消して、\nコンボをつなぐ。", "コンボが続くほど、得点アップ"),
        "3-daily": ("毎日、\n新しい盤面", "みんな同じ盤面に挑戦。連続記録を伸ばそう。"),
        "4-themes": ("8つのテーマ。\n気分で選ぼう。", "ウッド、ネオン、オーシャン、フォレストなど"),
        "5-puzzle": ("どのパズルにも\n答えがある", "ソルバーで確認済み。運まかせじゃない。"),
        "6-offline": ("強制広告は\n一切なし。", "登録なし、中断なし。機内でも遊べる。"),
    },
    "ko": {
        "1-clear": ("한 줄을 채우면\n펑 사라져요.", "한 수에 시원하게 지우기"),
        "2-combo": ("세로줄을 지우고\n콤보를 이어요.", "콤보가 길어질수록 점수가 커져요"),
        "3-daily": ("매일\n새로운 보드", "모두가 같은 퍼즐에 도전. 연속 기록을 이어가세요."),
        "4-themes": ("8가지 테마.\n기분대로 골라요.", "우드, 네온, 오션, 포레스트 등"),
        "5-puzzle": ("모든 퍼즐에는\n답이 있어요", "솔버로 검증, 운에 맡기지 않아요"),
        "6-offline": ("강제 광고는\n절대 없어요.", "가입 없이, 끊김 없이. 비행기에서도 플레이."),
    },
    # Thai has no spaces between words, only between phrases, and wrap() breaks
    # at spaces — so every line here is short enough to need no break at all.
    "th": {
        "1-clear": ("เติมให้เต็มแถว\nแล้วดูมันระเบิด", "วางครั้งเดียว เคลียร์สะใจ"),
        "2-combo": ("เคลียร์คอลัมน์\nแล้วต่อคอมโบ", "ยิ่งต่อคอมโบนาน คะแนนยิ่งพุ่ง"),
        "3-daily": ("กระดานใหม่\nทุกวัน", "ทุกคนเจอโจทย์เดียวกัน สะสมวันต่อเนื่อง"),
        "4-themes": ("8 ธีม\nเลือกตามอารมณ์", "ไม้ นีออน มหาสมุทร ป่าไม้ และอื่น ๆ"),
        "5-puzzle": ("ทุกปริศนา\nมีทางออก", "ตรวจด้วยตัวแก้โจทย์ ไม่ได้ขึ้นกับดวง"),
        "6-offline": ("ไม่มีโฆษณาบังคับ\nตลอดไป", "ไม่ต้องสมัคร ไม่มีขัดจังหวะ เล่นบนเครื่องบินได้"),
    },
    # Row and column: in Taiwan 行 is a column and 列 a row — the reverse of
    # the mainland — so each script says it its own way.
    "zh": {
        "1-clear": ("填满一行，\n瞬间消除。", "一步到位，消得超爽快"),
        "2-combo": ("消除一列，\n再打出连击。", "连击越长，得分越高"),
        "3-daily": ("每天\n都有新棋盘", "所有人挑战同一题，累积连续天数。"),
        "4-themes": ("8 种主题，\n随心情挑选。", "木纹、霓虹、海洋、森林等等"),
        "5-puzzle": ("每道谜题\n都有解", "经过求解程序验证，不靠运气。"),
        "6-offline": ("零强制广告。\n永远如此。", "免注册、不打断，飞机上也能玩。"),
    },
    "zh_Hant": {
        "1-clear": ("填滿一排，\n瞬間消除。", "一步到位，消得超爽快"),
        "2-combo": ("消掉直行，\n再串起連擊。", "連擊越長，得分越高"),
        "3-daily": ("每天\n都有新棋盤", "所有人挑戰同一題，累積連續天數。"),
        "4-themes": ("8 種主題，\n隨心情挑選。", "木紋、霓虹、海洋、森林等等"),
        "5-puzzle": ("每道謎題\n都有解", "經過解題程式驗證，不靠運氣。"),
        "6-offline": ("零強制廣告。\n永遠如此。", "免註冊、不中斷，飛機上也能玩。"),
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
}


class FallbackFont:
    """A script face with Nunito behind it for the characters it lacks.

    Pillow has no font fallback. This splits a string into runs by which font
    has each character, measures them one after another and draws them on one
    shared baseline — enough for "8 ธีม" or "x2" inside a Thai caption.
    """

    def __init__(self, path: str, primary: ImageFont.FreeTypeFont,
                 fallback: ImageFont.FreeTypeFont):
        self.primary, self.fallback = primary, fallback
        self._chars = _cmap(path)

    def runs(self, text: str):
        """(font, run) pairs in order; a run never mixes fonts."""
        out: list[tuple[ImageFont.FreeTypeFont, str]] = []
        for ch in text:
            font = self.primary if ord(ch) in self._chars else self.fallback
            if out and out[-1][0] is font:
                out[-1] = (font, out[-1][1] + ch)
            else:
                out.append((font, ch))
        return out


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
    if locale == "th":
        path = THAI_FONT.format(cut)
        if not os.path.exists(path):
            sys.exit(f"{path} is missing — apt install fonts-noto-core")
        return FallbackFont(path, ImageFont.truetype(path, size), _nunito(size, weight))
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
    smudge. Shrinks the type rather than spilling past three lines.
    """
    draw = ImageDraw.Draw(canvas)
    while size > 56:
        font = _weighted(size, HEADLINE_WEIGHT, locale)
        lines = wrap(draw, headline, font, W - 2 * MARGIN)
        if len(lines) <= 3:
            break
        size -= 6
    font = _weighted(size, HEADLINE_WEIGHT, locale)
    lines = wrap(draw, headline, font, W - 2 * MARGIN)

    # CJK glyphs fill the whole em box and Noto Sans CJK sits lower in it
    # than Nunito, so at Nunito's leading the lines and the subline touch.
    leading = 1.3 if locale in SCRIPT_LOCALES else 1.14
    y = 108
    for line in lines:
        draw_text(draw, (MARGIN, y), line, font, TEXT)
        y += round(size * leading)

    y += 14
    sub_font = _weighted(38, SUB_WEIGHT, locale)
    for line in wrap(draw, subline, sub_font, W - 2 * MARGIN):
        draw_text(draw, (MARGIN, y), line, sub_font, MUTED)
        y += 50

    y += 26
    draw.rounded_rectangle([(MARGIN, y), (MARGIN + 148, y + 8)], radius=4, fill=accent)
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


def collage(canvas, tiles, labels, accent, headline, subline, locale):
    """Four real boards, one per theme, tiled 2x2.

    Replaces the old theme frame, which was a screenshot of the settings list —
    five "Tap to activate" rows, selling a menu instead of a game.
    """
    bottom = draw_caption(canvas, headline, subline, accent, locale)
    gap, label_gap = 26, 56
    side = 40
    top, floor = bottom + 56, H - 70
    cell = min(
        (W - 2 * side - gap) // 2,
        (floor - top - gap - 2 * label_gap) // 2,
    )
    block_w = 2 * cell + gap
    block_h = 2 * (cell + label_gap) + gap
    x0 = (W - block_w) // 2
    y0 = place_y(top, floor, block_h)
    label_font = _weighted(34, HEADLINE_WEIGHT, locale)
    for i, (tile, label) in enumerate(zip(tiles, labels)):
        art = rounded(tile.resize((cell, cell), Image.LANCZOS), 26)
        x = x0 + (i % 2) * (cell + gap)
        y = y0 + (i // 2) * (cell + label_gap + gap)
        canvas = shadow_paste(canvas, art, x, y, 26)
        draw_text(ImageDraw.Draw(canvas), (x + 4, y + cell + 12), label, label_font, MUTED)
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
    for item in proof:
        draw.ellipse([(MARGIN, y + 12), (MARGIN + 18, y + 30)], fill=accent)
        draw_text(draw, (MARGIN + 40, y), item, line_font, TEXT)
        y += 68

    art = crop_board(capture, rect) if rect else capture
    top, floor = y + 52, H - 60
    art = fit(art, W - 2 * 104, floor - top)
    art = rounded(art, 40)
    y = place_y(top, floor, art.height)
    return shadow_paste(canvas, art, (W - art.width) // 2, y, 40)


def build(locale: str) -> int:
    raw = os.path.join(RAW_DIR, locale)
    if not os.path.isdir(raw):
        print(f"skipping {locale}: no captures in {raw}")
        return 0

    tiles = []
    for stem in COLLAGE:
        path = os.path.join(RAW_DIR, "en", f"{stem}.png")
        if not os.path.exists(path):
            print(f"  ! missing collage tile {path}", file=sys.stderr)
            return 1
        rect = board_rect("en", stem)
        img = Image.open(path).convert("RGB")
        tiles.append(crop_board(img, rect, pad_ratio=0.02) if rect else img)

    made = 0
    for stem, layout, theme, source, header in FRAMES:
        headline, subline = CAPTIONS[locale][stem]
        _, accent = PALETTE[theme]
        canvas = plate(stem, theme).convert("RGBA")

        if layout == "collage":
            canvas = collage(
                canvas, tiles, COLLAGE_LABELS[locale], accent, headline, subline,
                locale,
            )
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
    wanted = sys.argv[1:] or list(CAPTIONS)
    for locale in wanted:
        print(f"\nFraming {locale} screenshots …")
        if build(locale):
            return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
