#!/usr/bin/env python3
"""Turns the frames from tool/generate_video.dart into the finished clip.

    flutter test tool/generate_video.dart   # frames + events -> build/video/classic/
    python3 tool/encode_video.py            # -> store-assets/video/qubble-gameplay.mp4

    QUBBLE_CLIP=neon flutter test tool/generate_video.dart
    python3 tool/encode_video.py neon       # -> store-assets/video/qubble-neon.mp4

What it adds to the rendered gameplay, and nothing else:

* **An end card** — icon, wordmark and the brand chips, no words, so the one
  clip serves every store language. It fades in after the last move; the
  audit's concept (audit/05-aso.md §6) keeps the logo out of the opening.
* **The sound track** — the game's own sound effects, each at the frame and
  pitch the game asked for (generate_video.dart records them), over the game's
  own music loop. All of it is self-made and in assets/CREDITS.md.

Needs Pillow and an ffmpeg with libx264. `pip install imageio-ffmpeg` provides
one; this script finds it there first, then falls back to `ffmpeg` on PATH.
"""

from __future__ import annotations

import json
import os
import shutil
import subprocess
import sys

from PIL import Image, ImageDraw

from caption_screenshots import PALETTE, _weighted, rounded, shadow_paste
from feature_graphic import CHIPS, TEXT, background

CLIP = sys.argv[1] if len(sys.argv) > 1 else "classic"
FRAMES = f"build/video/{CLIP}"
# The first clip keeps its original name: it is the one linked as the
# listing's promo video.
OUT = ("store-assets/video/qubble-gameplay.mp4" if CLIP == "classic"
       else f"store-assets/video/qubble-{CLIP}.mp4")
ICON = "store-assets/app-icon-512.png"
W, H = 1080, 1920

FADE_FRAMES = 12  # 0.4 s from the last move into the end card
HOLD_FRAMES = 66  # 2.2 s on the end card

SFX = {
    "place": "assets/audio/place.wav",
    "clear": "assets/audio/clear.wav",
    "combo": "assets/audio/combo.wav",
    "feverBurst": "assets/audio/fever.wav",
    "levelUp": "assets/audio/levelup.wav",
    "gameOver": "assets/audio/gameover.wav",
}
MUSIC = "assets/audio/music.wav"
MUSIC_VOLUME = 0.30  # the app plays it at 0.24 under the effects


def ffmpeg() -> str:
    try:
        import imageio_ffmpeg  # type: ignore

        return imageio_ffmpeg.get_ffmpeg_exe()
    except ImportError:
        found = shutil.which("ffmpeg")
        if not found:
            sys.exit("no ffmpeg: pip install imageio-ffmpeg")
        return found


def end_card() -> Image.Image:
    """Icon, wordmark and brand chips on the store banner's background."""
    canvas = background(W, H).convert("RGBA")
    icon_size = 420
    icon = Image.open(ICON).convert("RGB").resize((icon_size, icon_size), Image.LANCZOS)
    icon_y = H // 2 - icon_size + 40
    canvas = shadow_paste(canvas, rounded(icon, 92), (W - icon_size) // 2, icon_y, 92)
    draw = ImageDraw.Draw(canvas)

    word_font = _weighted(170, 800)
    word = "Qubble"
    word_w = draw.textlength(word + ".", font=word_font)
    x = (W - word_w) / 2
    y = icon_y + icon_size + 70
    draw.text((x, y), word, font=word_font, fill=TEXT)
    draw.text(
        (x + draw.textlength(word, font=word_font), y),
        ".",
        font=word_font,
        fill=PALETTE["classic"][1],
    )

    chip, gap = 64, 20
    row_w = len(CHIPS) * chip + (len(CHIPS) - 1) * gap
    cy = y + 260
    for i, colour in enumerate(CHIPS):
        cx = (W - row_w) // 2 + i * (chip + gap)
        draw.rounded_rectangle([(cx, cy), (cx + chip, cy + chip)], radius=18, fill=colour)
    return canvas.convert("RGB")


def frame_path(index: int) -> str:
    return os.path.join(FRAMES, f"frame_{index:05d}.png")


def main() -> int:
    meta_path = os.path.join(FRAMES, "events.json")
    if not os.path.exists(meta_path):
        print(f"{meta_path} missing — run `flutter test tool/generate_video.dart` first",
              file=sys.stderr)
        return 1
    meta = json.load(open(meta_path))
    fps, frames, events = meta["fps"], meta["frames"], meta["events"]

    # Append the fade and the end card as further frames, so ffmpeg reads one
    # plain numbered sequence.
    card = end_card()
    last = Image.open(frame_path(frames)).convert("RGB")
    n = frames
    for i in range(1, FADE_FRAMES + 1):
        n += 1
        Image.blend(last, card, i / FADE_FRAMES).save(frame_path(n))
    for _ in range(HOLD_FRAMES):
        n += 1
        card.save(frame_path(n))
    duration = n / fps

    # One input per sound event, delayed to its frame and pitched the way the
    # game pitched it (asetrate changes speed and pitch together, which is
    # exactly what the app's setPlaybackRate does).
    inputs = ["-framerate", str(fps), "-i", os.path.join(FRAMES, "frame_%05d.png"),
              "-stream_loop", "-1", "-i", MUSIC]
    filters = [f"[1:a]aresample=44100,volume={MUSIC_VOLUME},atrim=0:{duration:.3f}[m]"]
    labels = ["[m]"]
    for k, e in enumerate(events):
        path = SFX.get(e["sfx"])
        if path is None:
            continue
        inputs += ["-i", path]
        idx = 2 + k
        delay = round(e["frame"] / fps * 1000)
        rate = round(22050 * float(e["pitch"]))
        filters.append(
            f"[{idx}:a]asetrate={rate},aresample=44100,adelay={delay}|{delay}[s{k}]"
        )
        labels.append(f"[s{k}]")
    fade_start = max(0.0, duration - 1.0)
    filters.append(
        f"{''.join(labels)}amix=inputs={len(labels)}:normalize=0:duration=first,"
        f"afade=t=out:st={fade_start:.3f}:d=1.0,alimiter=limit=0.95[a]"
    )

    os.makedirs(os.path.dirname(OUT), exist_ok=True)
    cmd = [ffmpeg(), "-y", "-hide_banner", "-loglevel", "error", *inputs,
           "-filter_complex", ";".join(filters),
           "-map", "0:v", "-map", "[a]",
           "-c:v", "libx264", "-preset", "slow", "-crf", "20", "-pix_fmt", "yuv420p",
           "-r", str(fps), "-c:a", "aac", "-b:a", "160k", "-ac", "2",
           "-movflags", "+faststart", "-t", f"{duration:.3f}", OUT]
    subprocess.run(cmd, check=True)
    size = os.path.getsize(OUT) / 1024 / 1024
    print(f"  ✓ {OUT}  ({duration:.1f} s, {size:.1f} MB)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
