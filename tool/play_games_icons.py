#!/usr/bin/env python3
"""Renders the Play Games Services icons: one per achievement, one per
leaderboard.

    python3 tool/play_games_icons.py   # writes store-assets/play-games/

Google's quality checklist for Play Games Services (2.4): every achievement
needs its own icon, 512 x 512 PNG/JPEG on a transparent background. The
leaderboard page asks for a square 512 x 512 PNG or JPEG and recommends a
custom one per leaderboard instead of the game icon.

Every icon is a badge: a ring in the tier's colour (bronze, silver, gold; the
top tier of a category, the one that unlocks an animated skin, gets a
rainbow ring) around a symbol built from the game's own blocks. Category
symbol plus tier colour make each icon unique. No text and no numerals.

Colours come from lib/ui/theme.dart so the icons and the game agree.
"""
import colorsys
import math
import os

from PIL import Image, ImageDraw

SIZE = 512
OUT = "store-assets/play-games"
SCALE = 4  # drawn large, scaled down: smooth edges without anti-aliasing

BG = (25, 27, 64, 255)          # GridColors.boardBackground
EMPTY = (66, 68, 103, 255)      # GridColors.emptyCell
TEAL = (79, 224, 198, 255)      # GridColors.placed
INDIGO = (124, 107, 255, 255)   # traySlots[0]
PINK = (255, 111, 176, 255)     # traySlots[2]
GOLD = (255, 194, 75, 255)      # GridColors.fever

TIERS = {
    "bronze": (205, 127, 50, 255),
    "silver": (196, 204, 220, 255),
    "gold": GOLD,
}

# 7 x 7 block symbols. A letter is a block in that colour, "." is empty.
PALETTE = {"T": TEAL, "I": INDIGO, "P": PINK, "G": GOLD, "e": EMPTY}

SYMBOLS = {
    "games": [  # play
        "T......",
        "TTT....",
        "TTTTT..",
        "TTTTTTT",
        "TTTTT..",
        "TTT....",
        "T......",
    ],
    "highscore": [  # trophy
        "GGGGGGG",
        "G.GGG.G",
        "G.GGG.G",
        ".GGGGG.",
        "..GGG..",
        "...G...",
        ".GGGGG.",
    ],
    "lines": [  # two cleared rows between leftovers
        "e.ee.e.",
        "ee.e.ee",
        "TTTTTTT",
        "TTTTTTT",
        "e.eee.e",
        ".ee.e.e",
        "e.e.ee.",
    ],
    "combo": [  # lightning
        "...PPPP",
        "..PPPP.",
        ".PPPP..",
        "PPPPPPP",
        "...PPP.",
        "..PP...",
        ".P.....",
    ],
    "level": [  # arrow up
        "...I...",
        "..III..",
        ".IIIII.",
        "IIIIIII",
        "..III..",
        "..III..",
        "..III..",
    ],
    "streak": [  # calendar
        ".P...P.",
        "PPPPPPP",
        "I.....I",
        "I.T.T.I",
        "I.....I",
        "I.T.T.I",
        "IIIIIII",
    ],
    "puzzles": [  # jigsaw piece
        "..TT...",
        "..TT...",
        "TTTTTT.",
        "TTTTTTT",
        "TTTTTT.",
        "..TT...",
        "..TT...",
    ],
    "pieces": [  # pieces on a board
        "III....",
        ".I...P.",
        ".....P.",
        "TT..PP.",
        "TT.....",
        "....GGG",
        "....G..",
    ],
    # Leaderboards.
    "board_best": [  # podium
        ".......",
        "..GGG..",
        "..GGG..",
        "TTGGG..",
        "TTGGGPP",
        "TTGGGPP",
        "TTGGGPP",
    ],
    "board_streak": [  # flame
        "...P...",
        "..PP...",
        "..PPP.P",
        ".PPPPPP",
        "PPPGPPP",
        "PPGGGPP",
        ".PGGGP.",
    ],
}

# Qubble achievement id -> (symbol, tier). Order = lib/game/achievements.dart.
ACHIEVEMENTS = [
    ("first_game", "games", "bronze"),
    ("games_25", "games", "silver"),
    ("games_100", "games", "top"),
    ("score_1k", "highscore", "bronze"),
    ("score_5k", "highscore", "silver"),
    ("score_10k", "highscore", "gold"),
    ("score_25k", "highscore", "top"),
    ("lines_100", "lines", "bronze"),
    ("lines_1000", "lines", "top"),
    ("combo_5", "combo", "bronze"),
    ("combo_10", "combo", "top"),
    ("level_10", "level", "bronze"),
    ("level_20", "level", "top"),
    ("streak_7", "streak", "bronze"),
    ("streak_30", "streak", "top"),
    ("puzzles_10", "puzzles", "top"),
    ("pieces_5000", "pieces", "top"),
]

LEADERBOARDS = [
    ("leaderboard_best_score", "board_best"),
    ("leaderboard_daily_streak", "board_streak"),
]


def shade(c, f):
    return tuple(max(0, min(255, int(v * f))) for v in c[:3]) + (c[3],)


def ring(d, cx, cy, r, width, tier):
    if tier != "top":
        d.ellipse([cx - r, cy - r, cx + r, cy + r], fill=TIERS[tier])
        return
    # Rainbow: thin wedges sweeping the hue once around.
    steps = 360
    for i in range(steps):
        rgb = colorsys.hsv_to_rgb(i / steps, 0.62, 1.0)
        col = tuple(int(v * 255) for v in rgb) + (255,)
        d.pieslice([cx - r, cy - r, cx + r, cy + r],
                   i - 90, i - 89 + 1.5, fill=col)


def block(d, x, y, s, col):
    rad = s * 0.22
    d.rounded_rectangle([x, y, x + s, y + s], radius=rad, fill=shade(col, 0.72))
    d.rounded_rectangle([x, y, x + s, y + s * 0.88], radius=rad, fill=col)
    # Highlight, like the game's default block.
    d.rounded_rectangle([x + s * 0.16, y + s * 0.12, x + s * 0.56, y + s * 0.3],
                        radius=s * 0.09, fill=shade(col, 1.25))


def symbol(d, name, cx, cy, span):
    rows = SYMBOLS[name]
    n = len(rows)
    cell = span / n
    gap = cell * 0.12
    x0 = cx - span / 2
    y0 = cy - span / 2
    for r, line in enumerate(rows):
        for c, ch in enumerate(line):
            if ch == ".":
                continue
            block(d, x0 + c * cell + gap / 2, y0 + r * cell + gap / 2,
                  cell - gap, PALETTE[ch])


def badge(sym, tier):
    s = SIZE * SCALE
    img = Image.new("RGBA", (s, s), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    c = s / 2
    outer = s * 0.48
    ring(d, c, c, outer, s * 0.05, tier)
    inner = outer - s * 0.045
    d.ellipse([c - inner, c - inner, c + inner, c + inner], fill=BG)
    symbol(d, sym, c, c, s * 0.5)
    return img.resize((SIZE, SIZE), Image.LANCZOS)


def board_icon(sym):
    s = SIZE * SCALE
    img = Image.new("RGBA", (s, s), (0, 0, 0, 0))
    d = ImageDraw.Draw(img)
    d.rounded_rectangle([0, 0, s - 1, s - 1], radius=s * 0.19, fill=BG)
    symbol(d, sym, s / 2, s / 2, s * 0.62)
    return img.resize((SIZE, SIZE), Image.LANCZOS)


def main():
    os.makedirs(OUT, exist_ok=True)
    for aid, sym, tier in ACHIEVEMENTS:
        badge(sym, tier).save(os.path.join(OUT, f"achievement_{aid}.png"))
    for name, sym in LEADERBOARDS:
        board_icon(sym).save(os.path.join(OUT, f"{name}.png"))
    print(f"wrote {len(ACHIEVEMENTS) + len(LEADERBOARDS)} icons to {OUT}/")


if __name__ == "__main__":
    main()
