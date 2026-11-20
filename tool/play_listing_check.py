#!/usr/bin/env python3
"""What Google Play's public web page shows for Qubble, and where it ranks.

Reads https://play.google.com (reachable from the cloud sessions since
20.11.2026) without signing in:

- the listing per locale: download bracket, category and tag chips, whether
  a rating is shown, how many images carry Play's "AI" label (set by the
  AI-content self-declaration in Play Console, Google help 17262077), and
  the "Updated on" date;
- for a few search terms, Qubble's position among the results the web page
  returns (about 20 — "not in the first 20" is all a miss means).

Usage:  python3 tool/play_listing_check.py
"""

from __future__ import annotations

import html
import re
import urllib.parse
import urllib.request

PACKAGE = "com.thinkube.qubble"
AGENT = "Mozilla/5.0 (Linux; Android 14) AppleWebKit/537.36 Chrome/124 Mobile Safari/537.36"
LOCALES = [("en", "US"), ("de", "DE"), ("pt", "BR"), ("es", "MX")]
SEARCHES = [
    ("qubble", "en", "US"),
    ("block puzzle", "en", "US"),
    ("block puzzle offline", "en", "US"),
    ("block puzzle pet", "en", "US"),
    ("blockpuzzle offline", "de", "DE"),
    ("block puzzle", "pt", "BR"),
]


def _get(url: str) -> str:
    request = urllib.request.Request(url, headers={"User-Agent": AGENT})
    with urllib.request.urlopen(request, timeout=40) as response:
        return response.read().decode("utf-8", "replace")


def _visible_lines(page: str) -> list[str]:
    text = re.sub(r"<script.*?</script>|<style.*?</style>", " ", page, flags=re.S)
    text = re.sub(r"<[^>]+>", "\n", text)
    lines = (html.unescape(line).strip() for line in text.split("\n"))
    return [line for line in lines if line]


def listing(hl: str, gl: str) -> None:
    page = _get(f"https://play.google.com/store/apps/details?id={PACKAGE}&hl={hl}&gl={gl}")
    lines = _visible_lines(page)
    downloads = re.findall(r">([0-9][0-9,.\s]*(?:[KMB]|Mio\.|Mrd\.)?\s*\+)<", page)[:1]
    categories = sorted(set(re.findall(r"/store/apps/category/(GAME_[A-Z_]+)", page)))
    ai_labels = len(re.findall(r"</i>AI</div>", page))
    # Play's structured data carries "aggregateRating" only once the app has
    # enough ratings to show a score (checked against Woodoku, 20.11.2026).
    rating = re.search(r'"aggregateRating":\{[^}]*"ratingValue":"([0-9.]+)","ratingCount":"(\d+)"', page)
    rated = f"{float(rating.group(1)):.1f} from {rating.group(2)}" if rating else "none"
    # The chips follow the "Updated on" date (localised label, so find the date line).
    chips: list[str] = []
    for i, line in enumerate(lines):
        if re.fullmatch(r"(\w{3} \d{1,2}, \d{4}|\d{1,2}\.\d{1,2}\.\d{4}|\d{1,2}/\d{1,2}/\d{4}|\d{1,2} de \w+ de \d{4})", line):
            for chip in lines[i + 1 : i + 12]:
                if chip in ("arrow_forward", "Data safety", "Datensicherheit") or len(chip) > 40 or chip.endswith("."):
                    break
                chips.append(chip)
            break
    print(f"{hl}-{gl}: downloads {downloads[0] if downloads else '?'}, "
          f"category {categories}, chips {chips[:8]}, AI labels {ai_labels}, "
          f"rating {rated}")


def search(term: str, hl: str, gl: str) -> None:
    query = urllib.parse.urlencode({"q": term, "c": "apps", "hl": hl, "gl": gl})
    page = _get(f"https://play.google.com/store/search?{query}")
    ids: list[str] = []
    for match in re.finditer(r"/store/apps/details\?id=([A-Za-z0-9_.]+)", page):
        if match.group(1) not in ids:
            ids.append(match.group(1))
    position = ids.index(PACKAGE) + 1 if PACKAGE in ids else None
    where = f"#{position}" if position else f"not in the first {len(ids)}"
    print(f"search '{term}' ({hl}-{gl}): {where}")


def main() -> None:
    for hl, gl in LOCALES:
        listing(hl, gl)
    for term, hl, gl in SEARCHES:
        search(term, hl, gl)


if __name__ == "__main__":
    main()
