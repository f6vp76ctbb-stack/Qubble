#!/usr/bin/env python3
"""Lays out every store listing the way fastlane's `supply` reads it.

    python3 tool/export_play_metadata.py   # -> build/play-metadata/android/<code>/

Optional. The listings can be entered by hand in the Play Console, one
language at a time; this writes the same texts, screenshots, feature graphic
and "What's new" notes into the directory layout `supply` uploads through the
Play Developer API in one go:

    <code>/title.txt, short_description.txt, full_description.txt
    <code>/images/featureGraphic.png
    <code>/images/phoneScreenshots/1.png … 6.png   (shown in filename order)
    <code>/changelogs/default.txt

Field and folder names are fastlane's own (supply/lib/supply.rb:
AVAILABLE_METADATA_FIELDS, IMAGES_TYPES, SCREENSHOT_TYPES, and the
changelogs/default.txt fallback in its docs).

The language codes are the ones in store-assets/store-listing.csv. They are
the usual Play codes but have not been checked against the console; the API
rejects a code it does not know, so a wrong one fails loudly instead of
landing in the wrong listing. Uploading needs a Play service-account key —
a secret; .gitignore keeps *service-account*.json out of the repo.
"""

from __future__ import annotations

import csv
import glob
import os
import shutil
import sys

CSV = "store-assets/store-listing.csv"
OUT = "build/play-metadata/android"
NOTES = "docs/release-notes/next-{}.txt"

# Play code -> the app's language code, which names the image folder under
# store-assets/ and the release-note file.
APP_LANGUAGE = {
    "en-US": "en", "de-DE": "de",
    "es-419": "es", "es-ES": "es", "pt-BR": "pt", "pt-PT": "pt", "fr-FR": "fr", "it-IT": "it",
    "tr-TR": "tr", "id": "id", "vi": "vi", "pl-PL": "pl", "nl-NL": "nl",
    "uk": "uk", "ms": "ms", "ro": "ro", "cs-CZ": "cs", "hu-HU": "hu", "sv-SE": "sv", "iw-IL": "he", "hr": "hr", "bg": "bg", "fi-FI": "fi", "no-NO": "nb", "da-DK": "da", "el-GR": "el", "sk": "sk", "ja-JP": "ja", "ko-KR": "ko", "th": "th",
    "zh-CN": "zh", "zh-TW": "zh_Hant", "zh-HK": "zh_Hant", "ar": "ar",
    "hi-IN": "hi",
}


def main() -> int:
    rows = list(csv.DictReader(open(CSV, encoding="utf-8")))
    shutil.rmtree(OUT, ignore_errors=True)
    for row in rows:
        code = row["language_code"]
        app = APP_LANGUAGE.get(code)
        if app is None:
            print(f"{code}: no image folder mapped in APP_LANGUAGE", file=sys.stderr)
            return 1
        shots = sorted(glob.glob(f"store-assets/{app}/screenshot-*.png"))
        banner = f"store-assets/{app}/feature-graphic-1024x500.png"
        notes = NOTES.format(app)
        missing = [p for p in (banner, notes) if not os.path.exists(p)]
        if len(shots) != 6 or missing:
            print(f"{code}: {len(shots)} screenshots, missing {missing}", file=sys.stderr)
            return 1

        base = os.path.join(OUT, code)
        os.makedirs(os.path.join(base, "images", "phoneScreenshots"))
        os.makedirs(os.path.join(base, "changelogs"))
        for field in ("title", "short_description", "full_description"):
            with open(os.path.join(base, f"{field}.txt"), "w", encoding="utf-8") as f:
                f.write(row[field])
        shutil.copy(banner, os.path.join(base, "images", "featureGraphic.png"))
        for i, shot in enumerate(shots, start=1):
            shutil.copy(shot, os.path.join(base, "images", "phoneScreenshots", f"{i}.png"))
        shutil.copy(notes, os.path.join(base, "changelogs", "default.txt"))
        print(f"  ✓ {base}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
