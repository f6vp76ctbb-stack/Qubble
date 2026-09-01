#!/usr/bin/env python3
"""Flags plugins whose Android code could be broken by R8.

Run after any dependency change:  python3 tool/r8_risk_scan.py

R8 is on for release builds (android/app/build.gradle.kts). It renames and
removes anything it cannot see a reference to, and there are three ways a
plugin can be reached without a reference R8 recognises:

  * Gson, which maps JSON keys onto FIELD NAMES. Renamed fields silently stop
    deserialising.
  * androidx.startup, which names its Initializers in <meta-data> — an
    attribute AGP does not treat as a class reference.
  * Class.forName on a name that arrives at runtime.

None of these fails the build. They fail on a device, usually after a reboot
or on the first launch, which is the worst place to find out.

WHAT THIS DOES NOT COVER: only the Flutter plugin's own Android sources are
scanned, not the transitive AARs beneath them (play-services, the Firebase
Android SDK, the billing client). Those ship their own consumer rules, which
is why a "no rules" verdict here is a prompt to look, not a finding on its own.
Every hit needs reading before it is believed — this script has produced three
false alarms for every real one.
"""
import glob
import os
import re
import sys

CACHE = os.path.expanduser("~/.pub-cache/hosted/pub.dev")

PATTERNS = {
    "gson": re.compile(r"\bnew Gson\(|\bGson\b|TypeToken"),
    "startup": re.compile(r"androidx\.startup|Initializer<"),
    "forName": re.compile(r"Class\.forName"),
}


def android_packages() -> list[str]:
    """Packages in pubspec.lock that ship Android sources."""
    lock = open("pubspec.lock", encoding="utf-8").read()
    out = []
    for path in sorted(glob.glob(f"{CACHE}/*/android")):
        pkg = path.split("/")[-2]
        name = pkg.rsplit("-", 1)[0]
        if re.search(r"\n  " + re.escape(name) + r":\n", lock):
            out.append(pkg)
    return out


def scan(pkg: str) -> dict:
    root = f"{CACHE}/{pkg}/android"
    has_rules = bool(
        glob.glob(f"{root}/**/*proguard*", recursive=True)
        + glob.glob(f"{root}/**/*.pro", recursive=True)
    )
    hits: dict[str, list[str]] = {k: [] for k in PATTERNS}
    for ext in ("java", "kt"):
        for f in glob.glob(f"{root}/src/**/*.{ext}", recursive=True):
            # Test sources are not shipped and are a standing source of noise.
            if re.search(r"/(test|androidTest)/", f):
                continue
            text = open(f, encoding="utf-8", errors="ignore").read()
            for key, pattern in PATTERNS.items():
                if pattern.search(text):
                    hits[key].append(os.path.relpath(f, root))
    return {"rules": has_rules, "hits": {k: v for k, v in hits.items() if v}}


def main() -> int:
    rules = open("android/app/proguard-rules.pro", encoding="utf-8").read()
    flagged = 0

    for pkg in android_packages():
        result = scan(pkg)
        if not result["hits"]:
            continue
        # Is anything in this package already kept?
        root_pkg = pkg.rsplit("-", 1)[0]
        covered = root_pkg in rules or any(
            token in rules
            for token in ("com.dexterous", "androidx.startup", "com.google.gson")
        )
        flagged += 1
        print(f"\n{pkg}")
        print(f"  eigene Consumer-Regeln: {'ja' if result['rules'] else 'nein'}")
        for kind, files in result["hits"].items():
            print(f"  {kind}: {', '.join(sorted(set(files))[:3])}")
        if not covered:
            print("  -> keine passende Keep-Regel gefunden; pruefen")

    if flagged == 0:
        print("Keine Reflexions-Muster in den Plugin-Quellen gefunden.")
    else:
        print(
            f"\n{flagged} Paket(e) mit Mustern. Jeder Treffer will gelesen "
            "werden — siehe audit/08-r8-risiko.md fuer die Bewertung der "
            "aktuellen."
        )
    return 0


if __name__ == "__main__":
    sys.exit(main())
