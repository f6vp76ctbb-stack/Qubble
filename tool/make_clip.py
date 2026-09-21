#!/usr/bin/env python3
"""Encodes the rendered clip frames into the video assets an App campaign takes.

    flutter test tool/generate_clip.dart   # -> store-assets/raw/clip/<locale>/
    python3 tool/make_clip.py              # -> store-assets/ads/<locale>/clip-*.mp4

App campaigns accept landscape (16:9), portrait (9:16) and square (1:1), and
serve where the shape fits, so all three are worth having from one render
(<https://support.google.com/google-ads/answer/17091671>).

The source frames are 1080x1920 portrait. The other two shapes are derived
rather than re-rendered:

Both derive from the same square crop around the board, which is measured from
a frame rather than assumed — the board does not sit in the middle of the
screen, it sits below the header, and how far below depends on what the HUD is
showing. 16:9 then pads that square sideways onto the theme's own background
colour. Scaling the whole portrait frame into a 16:9 box instead would leave
the board a third of its size in the middle of a letterbox.

Requires ffmpeg and Pillow.
"""

from __future__ import annotations

import os
import shutil
import subprocess
import sys
from glob import glob

from PIL import Image

RAW = "store-assets/raw/clip"
OUT = "store-assets/ads"
FPS = 30

# Neon's background, from lib/ui/theme.dart via caption_screenshots.PALETTE.
# The pad has to be the board's own backdrop or the letterbox reads as a bug.
PAD = "0x07070C"

# A row of flat backdrop spans at most this much grey; anything wider is the
# board, the HUD or a particle. Same threshold as tool/ad_creatives.py.
FLAT_RANGE = 12

# The board is the tallest run of content on the screen; the HUD rows and the
# tray are shorter. Anything under this is not it.
MIN_BOARD = 300

# Air kept above the board when the HUD is cut away, so the top edge does
# not sit flush against the board's own frame.
HEADROOM = 40

# The in-game ambient loop, self-synthesised and CC0 (assets/CREDITS.md).
MUSIC = "assets/audio/music.wav"
# Under the video, not over it: the loop is background, and an ad that
# opens loud gets muted before the first clear lands.
MUSIC_GAIN = 0.45
# Fade the last 1.5 s so the clip does not end on a cut-off note.
FADE_AT = 10.5


def board_band(frame: str) -> tuple[int, int]:
    """First and last row of the board, in source pixels.

    The board is the tallest run of content on the screen; the HUD rows and the
    tray are shorter. Measuring beats assuming — the board does not sit in the
    middle of the screen, and how far down it starts depends on what the HUD is
    showing.
    """
    grey = Image.open(frame).convert("L")
    bands: list[list[int]] = []
    for y in range(grey.height):
        lo, hi = grey.crop((0, y, grey.width, y + 1)).getextrema()
        if hi - lo <= FLAT_RANGE:
            continue
        if bands and y - bands[-1][1] <= 1:
            bands[-1][1] = y
        else:
            bands.append([y, y])
    tall = [b for b in bands if b[1] - b[0] >= MIN_BOARD]
    if not tall:
        return 0, grey.height - 1
    band = max(tall, key=lambda b: b[1] - b[0])
    return band[0], band[1]


def encode(locale: str, name: str, vf: str | None) -> str:
    os.makedirs(f"{OUT}/{locale}", exist_ok=True)
    path = f"{OUT}/{locale}/clip-{name}.mp4"
    cmd = [
        "ffmpeg", "-y", "-loglevel", "error",
        "-framerate", str(FPS),
        "-i", f"{RAW}/{locale}/frame-%04d.png",
    ]
    # The game's own ambient loop, under the video. A silent clip is a dead
    # clip on the social placements, and this is the only track that is
    # unambiguously clear to use: assets/CREDITS.md has it as self-synthesised
    # and CC0, so no licence question follows the ad around.
    if os.path.exists(MUSIC):
        cmd += ["-stream_loop", "-1", "-i", MUSIC]
    if vf:
        cmd += ["-vf", vf]
    cmd += [
        "-c:v", "libx264", "-preset", "slow", "-crf", "20",
        "-pix_fmt", "yuv420p", "-movflags", "+faststart",
    ]
    if os.path.exists(MUSIC):
        cmd += [
            "-af", f"volume={MUSIC_GAIN},afade=t=out:st={FADE_AT}:d=1.5",
            "-c:a", "aac", "-b:a", "128k", "-ar", "44100", "-shortest",
        ]
    cmd.append(path)
    subprocess.run(cmd, check=True)
    return path


def build(locale: str) -> list[str]:
    frames = sorted(glob(f"{RAW}/{locale}/frame-*.png"))
    if not frames:
        raise SystemExit(
            f"no frames in {RAW}/{locale} — run: flutter test tool/generate_clip.dart"
        )
    w, h = Image.open(frames[0]).size
    seconds = len(frames) / FPS
    if not 10 <= seconds <= 60:
        raise SystemExit(
            f"{locale}: {seconds:.1f}s is outside the 10-60 s an App campaign accepts"
        )

    # Everything above the board is cut away, and it is not a framing
    # preference. At a high combo the score row runs out of width and the score
    # value breaks across three lines — a real layout bug on the narrow end of
    # Android, and one that needs an app release to fix. An ad cannot wait for
    # that release, and it should not be the thing that shows the bug off.
    #
    # What is left is the board and the tray, which is what the clip is selling
    # anyway. The padding colour is the board's own backdrop, so the bands read
    # as screen rather than as letterbox.
    top, bottom = board_band(frames[len(frames) // 2])
    cut = max(0, top - HEADROOM)
    tall_h = h - cut

    # The square centres the board inside itself rather than reusing the
    # header cut, which would leave the tail of the fever bar sliced along the
    # top edge — a sliver of a bar reads as a rendering fault, not as a HUD.
    side = w
    square_top = max(0, min(h - side, top - max(0, (side - (bottom - top)) // 2)))
    square = f"crop={side}:{side}:0:{square_top}"

    built = [
        encode(
            locale,
            "9x16",
            f"crop={w}:{tall_h}:0:{cut},pad={w}:{h}:0:({h}-ih)/2:color={PAD}",
        ),
        encode(locale, "16x9", f"{square},pad={h}:{side}:({h}-iw)/2:0:color={PAD}"),
        encode(locale, "1x1", square),
    ]
    print(f"{locale}: {len(frames)} frames, {seconds:.1f}s, board y={top}-{bottom}, cut at {cut}")
    for p in built:
        print(f"  {os.path.getsize(p) / 1e6:5.2f} MB  {p}")
    return built


def main() -> int:
    if not shutil.which("ffmpeg"):
        print("ffmpeg not found", file=sys.stderr)
        return 1
    locales = sorted(
        d for d in os.listdir(RAW) if os.path.isdir(os.path.join(RAW, d))
    ) if os.path.isdir(RAW) else []
    if not locales:
        raise SystemExit(
            f"no {RAW}/<locale> directories — run: flutter test tool/generate_clip.dart"
        )
    for locale in locales:
        build(locale)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
