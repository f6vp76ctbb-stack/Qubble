#!/usr/bin/env python3
"""Writes the Play Console import for Qubble's achievements.

    python3 tool/play_games_icons.py     # icons first
    python3 tool/play_games_import.py    # writes store-assets/play-games/import/
                                         # and qubble-achievements-import.zip
                                         # with the IMPORT_LOCALES translations
    python3 tool/play_games_import.py de-DE fr-FR   # only these translations
    python3 tool/play_games_import.py --all         # every app language

Format from Google's "Import achievements" guide
(https://developer.android.com/games/pgs/integrate-achievements#zip-file):
a flat zip, CSV files without a header row, no commas inside a value, each
file under 1 MB.

- AchievementsMetadata.csv: Name,Description,Incremental,Steps,Initial
  State,Points,List Order. Name and Description are the default locale
  (en-US).
- AchievementsLocalizations.csv: Name,Localized name,Localized
  description,locale — one row per achievement and Play language, from the
  app's own translations (lib/l10n). The default locale is not allowed here,
  and every locale must be added to the game project before the import:
  the Console rejects the whole file otherwise ("Sprache nicht
  unterstützt", listed per achievement, not per language). The first
  import with all 59 failed that way, so the default is IMPORT_LOCALES, a
  short list of widely spoken languages (owner, 02.10.2026); pass other
  codes to change it.
- AchievementsIconsMappings.csv: Name,icon file.

Names and descriptions are the app's texts, so the Play Games profile and
the game say the same. Thousands separators ("1,000") are dropped because
a comma would split the value.

Which achievements are incremental must match kPlayGamesIncremental in
lib/services/play_games.dart; test/services/play_games_test.dart checks it.
"""
import json
import os
import re
import sys
import zipfile

sys.path.insert(0, os.path.dirname(__file__))
from export_play_metadata import APP_LANGUAGE  # noqa: E402

ICONS = "store-assets/play-games"
OUT = "store-assets/play-games/import"
ZIP = "store-assets/play-games/qubble-achievements-import.zip"
DEFAULT_LOCALE = "en-US"

# The translations the zip carries by default (owner, 02.10.2026: "only the
# most common standard languages the game has"). Each must be added to the
# Play Games project before the import (ANLEITUNG.md step 2).
IMPORT_LOCALES = [
    "de-DE", "es-419", "es-ES", "fr-FR", "it-IT", "pt-BR",
    "nl-NL", "pl-PL", "tr-TR", "ja-JP", "ko-KR", "zh-CN",
]

# (Qubble id, points, steps if incremental). Order = lib/game/achievements.dart
# = list order in Play Games. Points: multiples of 5, at most 200 each; the
# total (680) stays well under Google's cap to leave room for more.
ACHIEVEMENTS = [
    ("first_game", 5, None),
    ("games_25", 20, 25),
    ("games_100", 50, 100),
    ("score_1k", 10, None),
    ("score_5k", 20, None),
    ("score_10k", 40, None),
    ("score_25k", 80, None),
    ("lines_100", 10, 100),
    ("lines_1000", 50, 1000),
    ("combo_5", 15, None),
    ("combo_10", 60, None),
    ("level_10", 30, 10),
    ("level_20", 60, 20),
    ("streak_7", 30, None),
    ("streak_30", 100, None),
    ("puzzles_10", 40, 10),
    ("pieces_5000", 60, 5000),
]


def arb_key(aid):
    return "achievement" + "".join(p[:1].upper() + p[1:] for p in aid.split("_"))


def clean(text):
    text = re.sub(r"(\d),(\d)", r"\1\2", text)
    if "," in text or '"' in text or "\n" in text:
        raise SystemExit(f"cannot go into the CSV unchanged: {text!r}")
    return text


def texts(app_language):
    arb = json.load(open(f"lib/l10n/app_{app_language}.arb", encoding="utf-8"))
    return {
        aid: (clean(arb[arb_key(aid) + "Title"]), clean(arb[arb_key(aid) + "Body"]))
        for aid, _, _ in ACHIEVEMENTS
    }


def main(argv):
    assert sum(p for _, p, _ in ACHIEVEMENTS) <= 1000
    assert all(p % 5 == 0 and 5 <= p <= 200 for _, p, _ in ACHIEVEMENTS)
    assert all(s is None or 0 < s <= 10000 for _, _, s in ACHIEVEMENTS)

    default = texts(APP_LANGUAGE[DEFAULT_LOCALE])
    names = [default[aid][0] for aid, _, _ in ACHIEVEMENTS]
    assert len(set(names)) == len(names), "names must be unique"

    os.makedirs(OUT, exist_ok=True)
    meta, local, icons = [], [], []
    for order, (aid, points, steps) in enumerate(ACHIEVEMENTS, start=1):
        name, description = default[aid]
        meta.append(",".join([
            name, description,
            "True" if steps else "False", str(steps) if steps else "",
            "Revealed", str(points), str(order),
        ]))
        icon = f"achievement_{aid}.png"
        if not os.path.exists(os.path.join(ICONS, icon)):
            raise SystemExit(f"missing {icon}: run tool/play_games_icons.py")
        icons.append(f"{name},{icon}")

    wanted = argv or IMPORT_LOCALES
    if wanted == ["--all"]:
        wanted = list(APP_LANGUAGE)
    unknown = [c for c in wanted if c not in APP_LANGUAGE]
    if unknown:
        raise SystemExit(f"no app translation for {unknown}")
    locales = [c for c in APP_LANGUAGE if c in wanted and c != DEFAULT_LOCALE]
    for code in locales:
        t = texts(APP_LANGUAGE[code])
        localized = [t[aid][0] for aid, _, _ in ACHIEVEMENTS]
        assert len(set(localized)) == len(localized), f"{code}: names repeat"
        for aid, _, _ in ACHIEVEMENTS:
            local.append(",".join([default[aid][0], t[aid][0], t[aid][1], code]))

    files = {
        "AchievementsMetadata.csv": meta,
        "AchievementsLocalizations.csv": local,
        "AchievementsIconsMappings.csv": icons,
    }
    for fname, rows in files.items():
        with open(os.path.join(OUT, fname), "w", encoding="utf-8", newline="\n") as f:
            f.write("\n".join(rows) + "\n")

    # Fixed timestamps: the same input gives the same zip, byte for byte.
    def add(z, path, name):
        info = zipfile.ZipInfo(name, date_time=(2026, 1, 1, 0, 0, 0))
        info.compress_type = zipfile.ZIP_DEFLATED
        with open(path, "rb") as f:
            z.writestr(info, f.read())

    with zipfile.ZipFile(ZIP, "w") as z:
        for fname in files:
            add(z, os.path.join(OUT, fname), fname)
        for aid, _, _ in ACHIEVEMENTS:
            icon = f"achievement_{aid}.png"
            add(z, os.path.join(ICONS, icon), icon)
    for info in zipfile.ZipFile(ZIP).infolist():
        assert info.file_size < 1024 * 1024, info.filename

    print(f"{len(meta)} achievements, {len(locales)} locales "
          f"({len(local)} translations) -> {ZIP}")
    print("locales:", " ".join(locales))


if __name__ == "__main__":
    main(sys.argv[1:])
