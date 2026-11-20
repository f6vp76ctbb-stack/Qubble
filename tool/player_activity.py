#!/usr/bin/env python3
"""How many players reach Qubble's online features, from public data.

Reads the Firestore collections the app itself reads without signing in
(`firebase/firestore.rules`: `allow read: if true`) and counts documents by
the week they were created:

- `names`             — a player claimed a display name (asked after run 2-4)
- `leaderboard`       — first score submitted to the endless leaderboard
- `puzzleLeaderboard` — first puzzle-star entry
- `dailyLeaderboard/{day}/entries` — players who sent a Daily result that day

It prints counts and dates only — never a name, a uid or a score.

This is a lower bound on activity: only players who chose a name and were
online show up. It does not count installs (Play Console) or sessions
(Firebase Analytics). Usage:

    python3 tool/player_activity.py [first-day YYYY-MM-DD]
"""

from __future__ import annotations

import collections
import datetime as dt
import json
import pathlib
import re
import sys
import urllib.parse
import urllib.request

ROOT = pathlib.Path(__file__).resolve().parent.parent
CONFIG = ROOT / "lib/services/firebase_config.dart"


def _config() -> tuple[str, str]:
    text = CONFIG.read_text(encoding="utf-8")
    project = re.search(r"projectId = '([^']+)'", text).group(1)
    key = re.search(r"apiKey = '([^']+)'", text).group(1)
    return project, key


def _list(base: str, key: str, path: str) -> list[dict]:
    docs: list[dict] = []
    token = None
    while True:
        query = {"key": key, "pageSize": "300"}
        if token:
            query["pageToken"] = token
        url = f"{base}/{path}?{urllib.parse.urlencode(query)}"
        with urllib.request.urlopen(url, timeout=30) as response:
            data = json.load(response)
        docs += data.get("documents", [])
        token = data.get("nextPageToken")
        if not token:
            return docs


def _week(stamp: str) -> str:
    day = dt.date.fromisoformat(stamp[:10])
    year, week, _ = day.isocalendar()
    return f"{year}-W{week:02d}"


def main() -> None:
    first = dt.date.fromisoformat(sys.argv[1]) if len(sys.argv) > 1 else dt.date(2026, 9, 29)
    project, key = _config()
    base = f"https://firestore.googleapis.com/v1/projects/{project}/databases/(default)/documents"

    for collection in ("names", "leaderboard", "puzzleLeaderboard"):
        docs = _list(base, key, collection)
        created = sorted(d["createTime"] for d in docs)
        updated = sorted(d["updateTime"] for d in docs)
        weeks = collections.Counter(_week(c) for c in created)
        print(f"{collection}: {len(docs)} total")
        if created:
            print(f"  newest created {created[-1][:10]}, newest update {updated[-1][:10]}")
        for week, n in sorted(weeks.items()):
            print(f"  {week}: +{n}")

    print("dailyLeaderboard entries per day (days with entries only):")
    day, today, total = first, dt.date.today(), 0
    while day <= today:
        n = len(_list(base, key, f"dailyLeaderboard/{day.isoformat()}/entries"))
        if n:
            print(f"  {day.isoformat()}: {n}")
        total += n
        day += dt.timedelta(days=1)
    print(f"  total since {first.isoformat()}: {total}")


if __name__ == "__main__":
    main()
