#!/usr/bin/env python3
"""Fills the Play Console's release-notes template.

The Console's "What's new" box takes every language at once, as

    <de-DE>
    …notes…
    </de-DE>

and prefills it with one placeholder block per language the store listing has.
Paste that prefilled text into a file and run

    python3 tool/play_release_notes.py template.txt > filled.txt

Each block is filled from docs/release-notes/<version>-<app language>.txt for
the version in pubspec.yaml. Play codes map to app languages as in
tool/export_play_metadata.py. A Play language the app does not speak has no
notes of its own; it gets the English ones and a warning on stderr, so it is
never filled silently.
"""

from __future__ import annotations

import os
import re
import sys

sys.path.insert(0, os.path.dirname(__file__))
from export_play_metadata import APP_LANGUAGE, VERSION  # noqa: E402

# Play's limit for the field, per language (test/release_notes_test.dart).
LIMIT = 500


def notes_for(play: str) -> str:
    app = APP_LANGUAGE.get(play)
    if app is None:
        print(f"{play}: the app has no translation, filled with English",
              file=sys.stderr)
        app = "en"
    path = f"docs/release-notes/{VERSION}-{app}.txt"
    text = open(path, encoding="utf-8").read().strip()
    if len(text) > LIMIT:
        raise SystemExit(f"{path}: {len(text)} characters, limit is {LIMIT}")
    return text


def main() -> int:
    if len(sys.argv) != 2:
        print(__doc__, file=sys.stderr)
        return 2
    template = open(sys.argv[1], encoding="utf-8").read()
    codes = re.findall(r"^<([A-Za-z0-9-]+)>\s*$", template, re.M)
    if not codes:
        print("no <code> blocks found in the template", file=sys.stderr)
        return 1
    for code in codes:
        print(f"<{code}>\n{notes_for(code)}\n</{code}>")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
