#!/usr/bin/env python3
"""Lays out every store listing the way fastlane's `supply` reads it.

    python3 tool/export_play_metadata.py   # -> build/play-metadata/android/<code>/

Optional. The listings can be entered by hand in the Play Console, one
language at a time; this writes the same texts, screenshots, feature graphic
and "What's new" notes into the directory layout `supply` uploads through the
Play Developer API in one go:

    <code>/title.txt, short_description.txt, full_description.txt
    <code>/images/featureGraphic.png
    <code>/images/phoneScreenshots/1.png … 8.png   (shown in filename order)
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
import re
import shutil
import sys

CSV = "store-assets/store-listing.csv"
OUT = "build/play-metadata/android"
# The release notes of the version in pubspec.yaml, one file per app language.
VERSION = re.search(
    r"^version:\s*([0-9.]+)\+", open("pubspec.yaml", encoding="utf-8").read(), re.M
).group(1)
NOTES = "docs/release-notes/" + VERSION + "-{}.txt"

# Play code -> the app's language code, which names the image folder under
# store-assets/ and the release-note file. Four listings are written by hand
# (owner, 09.11.2026); every other store language is translated by the Play
# Console and deliberately has no file here.
APP_LANGUAGE = {
    "en-US": "en",
    "de-DE": "de",
    "es-419": "es",
    "pt-BR": "pt",
}

# Further Play languages that take a hand-written listing as it is: Spain
# reads the same Spanish. Only laid out when asked for (--with-copies), so the
# default upload touches exactly the four listings above.
COPIES = {
    "es-ES": "es-419",
}


def main() -> int:
    rows = list(csv.DictReader(open(CSV, encoding="utf-8")))
    if "--with-copies" in sys.argv[1:]:
        by_code = {row["language_code"]: row for row in rows}
        for target, source in COPIES.items():
            rows.append({**by_code[source], "language_code": target, "_images": source})
    shutil.rmtree(OUT, ignore_errors=True)
    for row in rows:
        code = row["language_code"]
        app = APP_LANGUAGE.get(row.get("_images", code))
        if app is None:
            print(f"{code}: no image folder mapped in APP_LANGUAGE", file=sys.stderr)
            return 1
        shots = sorted(glob.glob(f"store-assets/{app}/screenshot-*.png"))
        banner = f"store-assets/{app}/feature-graphic-1024x500.png"
        notes = NOTES.format(app)
        missing = [p for p in (banner, notes) if not os.path.exists(p)]
        if len(shots) != 8 or missing:
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
