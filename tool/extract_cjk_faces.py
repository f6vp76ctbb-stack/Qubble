#!/usr/bin/env python3
"""Writes the Simplified and Traditional Chinese cuts of Noto Sans CJK as
standalone fonts for tool/generate_screenshots.dart.

    python3 tool/extract_cjk_faces.py   # -> build/fonts/NotoSansCJK{SC,TC}-*.otf

The system ships Noto Sans CJK as one collection per weight (JP, KR, SC, TC,
HK cuts in one file), and Flutter's FontLoader only ever reads a collection's
first face — the Japanese cut. Chinese drawn in it shows Japanese character
forms, which a Chinese reader notices at once. The generator runs this itself
when the files are missing. Needs fontTools and `apt install fonts-noto-cjk`;
the output is for rendering only and is never bundled or committed.
"""

from __future__ import annotations

import os
import sys

from fontTools.ttLib import TTCollection

SOURCE = "/usr/share/fonts/opentype/noto/NotoSansCJK-{}.ttc"
OUT_DIR = "build/fonts"
# Face index in the collection -> file tag.
FACES = {2: "SC", 3: "TC"}


def main() -> int:
    os.makedirs(OUT_DIR, exist_ok=True)
    for weight in ("Regular", "Bold"):
        path = SOURCE.format(weight)
        if not os.path.exists(path):
            print(f"{path} is missing — apt install fonts-noto-cjk", file=sys.stderr)
            return 1
        collection = TTCollection(path, lazy=True)
        for index, tag in FACES.items():
            font = collection.fonts[index]
            name = font["name"].getDebugName(4)
            if f" {tag}" not in name:
                print(f"face {index} of {path} is {name}, not {tag}", file=sys.stderr)
                return 1
            out = os.path.join(OUT_DIR, f"NotoSansCJK{tag}-{weight}.otf")
            font.save(out)
            print(f"  ✓ {out}  ({name})")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
