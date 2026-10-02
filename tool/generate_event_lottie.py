#!/usr/bin/env python3
"""Writes the animation for the Play Store Halloween event (Lottie JSON).

Play's "promotional content" takes an optional animation in place of the
primary image. Google's animated-asset guidelines ask for Lottie JSON, at
most 200 KB, 60 fps, at most 6 seconds, 16:9, a seamless loop, and no text,
no UI-like elements and no rounded corners on the asset.

The scene is the one `tool/generate_event_images.dart` paints for the
landscape image: a jack-o'-lantern of ghost blocks on the pumpkin theme's
board, three pieces, the moon and stars. Here the ghosts float (as the ghost
skin does in the game), the moon glows and the stars twinkle. The ghost's
shape and colours follow `_paintGhost` in `lib/ui/widgets/cell_style.dart`.

    python3 tool/generate_event_lottie.py

Output: store-assets/event-halloween/halloween-animation.json
"""

from __future__ import annotations

import json
import math
import os
import random

OUT = "store-assets/event-halloween/halloween-animation.json"

W, H = 1920, 1080
FPS = 60
FRAMES = 240  # 4 s; every motion repeats a whole number of times in it
BOB_PERIOD = 120  # frames per float cycle, as the loop needs
KAPPA = 0.5523  # cubic handle length for a quarter circle

# Pumpkin theme (lib/ui/theme.dart).
BACK_TOP, BACK_BOTTOM = "221335", "0B0710"
BOARD_BG = "1D1226"
EMPTY = "4A3656"
ORANGE, PURPLE, GREEN = "FF8A1F", "A066FF", "8FE35C"
EYE = "1B1024"

BOARD = [
    "...GG...",
    ".OOOOOO.",
    "OOOOOOOO",
    "O..OO..O",
    "OOOOOOOO",
    "O.O..O.O",
    ".OOOOOO.",
    "........",
]


def rgb(hex6: str) -> list[float]:
    return [int(hex6[i:i + 2], 16) / 255 for i in (0, 2, 4)]


def lerp(a: list[float], b: list[float], t: float) -> list[float]:
    return [x + (y - x) * t for x, y in zip(a, b)]


def lighten(c: list[float], t: float) -> list[float]:
    return lerp(c, [1, 1, 1], t)


def darken(c: list[float], t: float) -> list[float]:
    return lerp(c, [0, 0, 0], t)


def r1(v):
    if isinstance(v, dict):
        return {k: r1(x) for k, x in v.items()}
    if isinstance(v, list):
        return [r1(x) for x in v]
    if isinstance(v, bool):
        return v
    return round(v, 2)


def static(v):
    return {"a": 0, "k": r1(v)}


def linear_keys(values: list[tuple[int, list[float]]]):
    keys = []
    for i, (t, v) in enumerate(values):
        k = {"t": t, "s": r1(v)}
        if i < len(values) - 1:
            k["i"] = {"x": 1, "y": 1}
            k["o"] = {"x": 0, "y": 0}
        keys.append(k)
    return {"a": 1, "k": keys}


def eased_keys(values: list[tuple[int, list[float]]]):
    keys = []
    for i, (t, v) in enumerate(values):
        k = {"t": t, "s": r1(v)}
        if i < len(values) - 1:
            k["i"] = {"x": 0.58, "y": 1}
            k["o"] = {"x": 0.42, "y": 0}
        keys.append(k)
    return {"a": 1, "k": keys}


def transform(**kw):
    return {
        "ty": "tr",
        "p": kw.get("p", static([0, 0])),
        "a": kw.get("a", static([0, 0])),
        "s": kw.get("s", static([100, 100])),
        "r": static(0),
        "o": kw.get("o", static(100)),
    }


def fill(color: list[float], opacity: float = 100):
    return {"ty": "fl", "c": static(color + [1]), "o": static(opacity), "r": 1}


def lin_gradient(start, end, c0, c1):
    return {
        "ty": "gf", "o": static(100), "r": 1, "t": 1,
        "s": static(start), "e": static(end),
        "g": {"p": 2, "k": static([0] + c0 + [1] + c1)},
    }


def radial_glow(center, radius, color, alpha):
    """A radial gradient from `alpha` in the middle to transparent."""
    return {
        "ty": "gf", "o": static(100), "r": 1, "t": 2,
        "s": static(center), "e": static([center[0] + radius, center[1]]),
        "h": static(0), "a": static(0),
        "g": {"p": 2, "k": static([0] + color + [1] + color + [0, alpha, 1, 0])},
    }


def rect(cx, cy, w, h, radius=0):
    return {"ty": "rc", "d": 1, "p": static([cx, cy]), "s": static([w, h]),
            "r": static(radius)}


def ellipse(cx, cy, w, h):
    return {"ty": "el", "d": 1, "p": static([cx, cy]), "s": static([w, h])}


def group(items, name="g", tr=None):
    return {"ty": "gr", "nm": name, "it": items + [tr or transform()]}


def shape_layer(ind, name, shapes, p=None, o=None, s=None, a=None):
    return {
        "ddd": 0, "ind": ind, "ty": 4, "nm": name, "sr": 1,
        "ks": {
            "o": o or static(100), "r": static(0),
            "p": p or static([0, 0, 0]), "a": a or static([0, 0, 0]),
            "s": s or static([100, 100, 100]),
        },
        "ao": 0, "shapes": shapes, "ip": 0, "op": FRAMES, "st": 0, "bm": 0,
    }


def precomp_layer(ind, name, ref, size, p, scale=100):
    return {
        "ddd": 0, "ind": ind, "ty": 0, "nm": name, "refId": ref, "sr": 1,
        "ks": {
            "o": static(100), "r": static(0), "p": p,
            "a": static([size / 2, size / 2, 0]),
            "s": static([scale, scale, 100]),
        },
        "ao": 0, "w": round(size), "h": round(size),
        "ip": 0, "op": FRAMES, "st": 0, "bm": 0,
    }


def ghost_path(s: float):
    """The ghost of `_paintGhost`, in a cell of side `s` with its top-left at
    the origin: a round head, straight sides and a hem of three lobes."""
    left, top, right, bottom = 0.12 * s, 0.1 * s, 0.88 * s, 0.94 * s
    bw = right - left
    r = bw / 2
    cx = left + r
    hem = (bottom - top) * 0.14
    lobe = bw / 3
    v = [
        [left, bottom - hem],
        [left, top + r],
        [cx, top],
        [right, top + r],
        [right, bottom - hem],
        [right - lobe, bottom - hem],
        [right - 2 * lobe, bottom - hem],
    ]
    i = [[0, 0] for _ in v]
    o = [[0, 0] for _ in v]
    k = KAPPA * r
    o[1], i[2] = [0, -k], [-k, 0]
    o[2], i[3] = [k, 0], [0, -k]
    # Lobes: quadratic curves (as in the game), written as cubic handles.
    for n, (a_idx, b_idx) in enumerate([(4, 5), (5, 6), (6, 0)]):
        x0 = right - n * lobe
        sway = math.sin(n) * hem * 0.35
        q = [x0 - lobe / 2, bottom + hem + sway]
        pa, pb = v[a_idx], v[b_idx]
        o[a_idx] = [(q[0] - pa[0]) * 2 / 3, (q[1] - pa[1]) * 2 / 3]
        i[b_idx] = [(q[0] - pb[0]) * 2 / 3, (q[1] - pb[1]) * 2 / 3]
    return {"ty": "sh", "ks": static({"i": i, "o": o, "v": v, "c": True})}, (
        left, top, right, bottom)


def ghost_asset(ref: str, color: list[float], s: float, blink_at: int | None):
    path, (left, top, right, bottom) = ghost_path(s)
    bw, bh = right - left, bottom - top
    body = group([
        path,
        lin_gradient([s / 2, top], [s / 2, bottom],
                     lighten(color, 0.72), lighten(color, 0.38)),
    ], "body")
    eye_y = top + bh * 0.42
    eyes = [
        ellipse(left + bw * x, eye_y, bw * 0.17, bh * 0.2) for x in (0.33, 0.67)
    ]
    eye_tr = transform(a=static([s / 2, eye_y]), p=static([s / 2, eye_y]))
    if blink_at is not None:
        t = blink_at
        eye_tr["s"] = eased_keys([
            (0, [100, 100]), (t, [100, 100]), (t + 5, [100, 15]),
            (t + 10, [100, 100]), (FRAMES, [100, 100]),
        ])
    face = [
        group(eyes + [fill(rgb(EYE))], "eyes", eye_tr),
        group([ellipse(s / 2, top + bh * 0.66, bw * 0.14, bh * 0.11),
               fill(rgb(EYE))], "mouth"),
    ]
    layer = shape_layer(1, "ghost", face + [body])
    return {"id": ref, "w": round(s), "h": round(s), "layers": [layer]}


def bob(x: float, y: float, phase: float, amp: float, period: int = BOB_PERIOD):
    """Float up and down, sampled every 15 frames; seamless over FRAMES."""
    keys = []
    for t in range(0, FRAMES + 1, 15):
        dy = math.sin(2 * math.pi * t / period + phase) * amp
        keys.append((t, [x, y + dy, 0]))
    return linear_keys(keys)


def main() -> int:
    rnd = random.Random(31)
    colors = {"O": rgb(ORANGE), "P": rgb(PURPLE), "G": rgb(GREEN)}

    # Board geometry, as in the landscape image.
    side = 820.0
    bx, by = W * 0.33 - side / 2, (H - side) / 2
    pad = side * 0.035
    cell = (side - 2 * pad) / 8
    gap = cell * 0.08
    s = cell - gap  # a block's side

    assets = []
    variants: dict[str, list[str]] = {}
    for key, blinks in (("O", [None, 70, 190]), ("G", [None, 130]),
                        ("P", [None, 40])):
        variants[key] = []
        for n, b in enumerate(blinks):
            ref = f"ghost_{key}{n}"
            assets.append(ghost_asset(ref, colors[key], s, b))
            variants[key].append(ref)

    layers = []
    ind = 1

    def add(layer):
        nonlocal ind
        layer["ind"] = ind
        ind += 1
        layers.append(layer)

    # Front to back: Lottie draws the first layer on top.
    # --- Pieces on the right, each floating as one.
    pieces = [
        ("P", 1180, 330, [(0, 0), (0, 1), (0, 2), (1, 1)], 0.0),
        ("G", 1520, 520, [(0, 0), (1, 0), (2, 0), (2, 1)], 2.1),
        ("O", 1230, 640, [(0, 0), (0, 1), (1, 0), (1, 1)], 4.2),
    ]
    pcell = 92.0
    pgap = pcell * 0.08
    ps = pcell - pgap
    piece_layers = []
    for key, px, py, cells, phase in pieces:
        color = colors[key]
        for n, (r, c) in enumerate(cells):
            cx = px + c * pcell + pcell / 2
            cy = py + r * pcell + pcell / 2
            ref = variants[key][(n + r) % len(variants[key])]
            piece_layers.append(precomp_layer(
                0, f"piece {key} ghost", ref, s,
                bob(cx, cy, phase, 9, 240), ps / s * 100))
        backs = [rect(px + c * pcell + pcell / 2, py + r * pcell + pcell / 2,
                      ps, ps, ps * 0.22) for r, c in cells]
        piece_layers.append(shape_layer(
            0, f"piece {key} blocks",
            [group(backs + [fill(darken(color, 0.62))])],
            p=bob(0, 0, phase, 9, 240)))
        # Soft glow behind the piece.
        rows = max(r for r, _ in cells) + 1
        cols = max(c for _, c in cells) + 1
        gx, gy = px + cols * pcell / 2, py + rows * pcell / 2
        piece_layers.append(shape_layer(0, f"piece {key} glow", [group([
            ellipse(gx, gy, pcell * 3.4, pcell * 3.4),
            radial_glow([gx, gy], pcell * 1.7, color, 0.22),
        ])]))
    for layer in piece_layers:
        add(layer)

    # --- Board ghosts, floating each at its own phase.
    inner_x, inner_y = bx + pad, by + pad
    ghost_layers, backs = [], {"O": [], "G": [], "P": []}
    empties = []
    for r in range(8):
        for c in range(8):
            cx = inner_x + c * cell + cell / 2
            cy = inner_y + r * cell + cell / 2
            ch = BOARD[r][c]
            if ch == ".":
                empties.append(rect(cx, cy, s, s, s * 0.22))
                continue
            backs[ch].append(rect(cx, cy, s, s, s * 0.22))
            phase = (r + c) * 0.5 + rnd.random() * 0.3
            ref = variants[ch][rnd.randrange(len(variants[ch]))]
            ghost_layers.append(precomp_layer(
                0, f"ghost {r},{c}", ref, s, bob(cx, cy, phase, s * 0.07)))
    for layer in ghost_layers:
        add(layer)
    for key, items in backs.items():
        if items:
            add(shape_layer(0, f"blocks {key}",
                            [group(items + [fill(darken(colors[key], 0.62))])]))
    add(shape_layer(0, "empty cells", [group(empties + [fill(rgb(EMPTY))])]))
    add(shape_layer(0, "board", [group([
        rect(bx + side / 2, by + side / 2, side, side, side * 0.05),
        fill(rgb(BOARD_BG)),
    ])]))
    add(shape_layer(0, "board shadow", [group([
        rect(bx + side / 2, by + side / 2 + 18, side + 24, side + 24,
             side * 0.06),
        fill([0, 0, 0], 45),
    ])]))

    # --- Moon with a breathing glow.
    mx, my, mr = W * 0.86, H * 0.2, 95.0
    crater = rgb("F1DDA6")
    add(shape_layer(0, "moon", [
        group([ellipse(mx - mr * 0.3, my - mr * 0.2, mr * 0.36, mr * 0.36),
               ellipse(mx + mr * 0.32, my + mr * 0.25, mr * 0.24, mr * 0.24),
               ellipse(mx + mr * 0.05, my + mr * 0.45, mr * 0.16, mr * 0.16),
               fill(crater)], "craters"),
        group([ellipse(mx, my, mr * 2, mr * 2), fill(rgb("FFF1C9"))], "disc"),
    ]))
    add(shape_layer(
        0, "moon glow",
        [group([ellipse(0, 0, mr * 3.6, mr * 3.6),
                radial_glow([0, 0], mr * 1.8, rgb("FFE6A8"), 0.45)])],
        p=static([mx, my, 0]),
        s=eased_keys([(0, [100, 100, 100]), (120, [112, 112, 100]),
                      (240, [100, 100, 100])])))

    # --- Stars in three sets that twinkle out of step.
    for n in range(3):
        dots = []
        for _ in range(30):
            x, y = rnd.random() * W, rnd.random() * H * 0.7
            d = 1080 * (0.003 + rnd.random() * 0.005)
            dots.append(ellipse(x, y, d, d))
        t0 = n * 80
        keys = {0: [85], FRAMES: [85], t0 + 40: [20], t0 + 80: [85]}
        keys = sorted((t, v) for t, v in keys.items() if t <= FRAMES)
        add(shape_layer(0, f"stars {n}",
                        [group(dots + [fill([1, 1, 1])])],
                        o=eased_keys(keys)))

    # --- Fog and sky.
    # A round glow that fades out before its edge, stretched wide.
    fog_r = H * 0.34
    add(shape_layer(0, "fog", [group([
        ellipse(0, 0, fog_r * 2, fog_r * 2),
        radial_glow([0, 0], fog_r, rgb(PURPLE), 0.3),
    ], "fog", transform(p=static([W / 2, H * 1.04]), s=static([380, 100])))]))
    add(shape_layer(0, "sky", [group([
        rect(W / 2, H / 2, W, H),
        lin_gradient([W / 2, 0], [W / 2, H], rgb(BACK_TOP), rgb(BACK_BOTTOM)),
    ])]))

    anim = {
        "v": "5.7.4", "fr": FPS, "ip": 0, "op": FRAMES, "w": W, "h": H,
        "nm": "Qubble Halloween", "ddd": 0, "assets": assets, "layers": layers,
    }
    os.makedirs(os.path.dirname(OUT), exist_ok=True)
    data = json.dumps(anim, separators=(",", ":"))
    with open(OUT, "w", encoding="utf-8") as f:
        f.write(data)
    print(f"{OUT}: {len(data.encode()) / 1024:.1f} KB, {len(layers)} layers, "
          f"{FRAMES / FPS:.1f} s at {FPS} fps")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
