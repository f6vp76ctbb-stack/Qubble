#!/usr/bin/env python3
"""Turns the frames from tool/generate_video.dart into the finished clip.

    flutter test tool/generate_video.dart   # frames + events -> build/video/classic/
    python3 tool/encode_video.py            # -> store-assets/video/qubble-gameplay.mp4

    QUBBLE_CLIP=neon flutter test tool/generate_video.dart
    python3 tool/encode_video.py neon       # -> store-assets/video/qubble-neon.mp4

    flutter test tool/generate_showreel.dart   # scenes -> build/video/showreel/scene-NN/
    python3 tool/encode_video.py showreel      # -> store-assets/video/qubble-showreel.mp4

    QUBBLE_PROMO_LOCALE=de flutter test tool/generate_promo.dart
    python3 tool/encode_video.py promo-de      # -> store-assets/video/qubble-promo-de.mp4

    QUBBLE_REEL=turbo flutter test tool/generate_reels.dart
    QUBBLE_HOOK="wait for it" python3 tool/encode_video.py reel-turbo
                                               # -> store-assets/video/qubble-reel-turbo.mp4

The showreel is a row of short scenes cut hard against each other; this
script strings them into one sequence before doing what it does for any clip.

What it adds to the rendered gameplay, and nothing else:

* **An end card** — icon, wordmark and three Qubbies (the app's own drawings,
  from the screenshot captures; the brand chips if those are not there), no
  words, so the one clip serves every store language. It fades in after the
  last move; the audit's concept (audit/05-aso.md §6) keeps the logo out of
  the opening.
* **The sound track** — the game's own sound effects, each at the frame and
  pitch the game asked for (generate_video.dart records them), over the game's
  own music loop. All of it is self-made and in assets/CREDITS.md.
* **A hook line, social reels only** — `QUBBLE_HOOK` puts one line of text
  over the first seconds of a `reel-*` clip (`QUBBLE_HOOK_SECONDS`, default
  2.5). Never on a store clip: those carry no words, so one clip serves every
  language, and Google wants the opening to be the app.

Needs Pillow and an ffmpeg with libx264. `pip install imageio-ffmpeg` provides
one; this script finds it there first, then falls back to `ffmpeg` on PATH.
"""

from __future__ import annotations

import glob
import json
import os
import shutil
import subprocess
import sys

from PIL import Image, ImageDraw, ImageFilter

from caption_screenshots import (
    PALETTE,
    RAW_DIR,
    _weighted,
    fit,
    portrait,
    rounded,
    shadow_paste,
)
from feature_graphic import QUBBIES, TEXT, background

# The tray colours from the Classic theme, as a brand strip.
CHIPS = [
    (0x7C, 0x6B, 0xFF),
    (0x4F, 0xE0, 0xC6),
    (0xF5, 0xF6, 0xFF),
    (0xFF, 0x6F, 0xB0),
    (0xFF, 0xC2, 0x4B),
]

CLIP = sys.argv[1] if len(sys.argv) > 1 else "classic"
FRAMES = f"build/video/{CLIP}"
# The first clip keeps its original name: it is the one linked as the
# listing's promo video.
OUT = ("store-assets/video/qubble-gameplay.mp4" if CLIP == "classic"
       else f"store-assets/video/qubble-{CLIP}.mp4")
# Cut from scenes: the showreel, the store promo (one per language,
# `promo-de` etc., from tool/generate_promo.dart) and the social reels
# (`reel-turbo` etc., from tool/generate_reels.dart).
REEL = CLIP.startswith("reel-")
CUT = CLIP == "showreel" or CLIP.startswith("promo-") or REEL
HOOK = os.environ.get("QUBBLE_HOOK", "").strip() if REEL else ""
HOOK_SECONDS = float(os.environ.get("QUBBLE_HOOK_SECONDS", "2.5"))
# Top of the line, in frame pixels. The default lays it over the score row,
# below the bar the platforms draw at the top; a clip whose upper board is
# empty in the opening can put it there instead.
HOOK_Y = int(os.environ.get("QUBBLE_HOOK_Y", "165"))
SCENES = f"{FRAMES}/scene-*"
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

    cy = y + 260
    have_qubbies = all(
        os.path.exists(os.path.join(RAW_DIR, "en", f"pet-{pet}.png")) for pet in QUBBIES
    )
    if not have_qubbies:
        chip, gap = 64, 20
        row_w = len(CHIPS) * chip + (len(CHIPS) - 1) * gap
        for i, colour in enumerate(CHIPS):
            cx = (W - row_w) // 2 + i * (chip + gap)
            draw.rounded_rectangle(
                [(cx, cy), (cx + chip, cy + chip)], radius=18, fill=colour
            )
        return canvas.convert("RGB")

    # The three of the feature graphic, side by side on one ground line.
    figures = [fit(portrait(pet), 300, 230) for pet in QUBBIES]
    gap = 36
    row_w = sum(f.width for f in figures) + gap * (len(figures) - 1)
    ground = cy + 250
    x = (W - row_w) // 2
    for figure in figures:
        fy = ground - figure.height
        contact = Image.new("RGBA", canvas.size, (0, 0, 0, 0))
        ImageDraw.Draw(contact).ellipse(
            [(x + figure.width * 0.12, ground - 16),
             (x + figure.width * 0.88, ground + 14)],
            fill=(0, 0, 0, 170),
        )
        canvas = Image.alpha_composite(
            canvas, contact.filter(ImageFilter.GaussianBlur(10))
        )
        canvas.alpha_composite(figure, (x, fy))
        x += figure.width + gap
    return canvas.convert("RGB")


def frame_path(index: int) -> str:
    return os.path.join(FRAMES, f"frame_{index:05d}.png")


def collect_scenes() -> None:
    """Strings the showreel's scenes into one numbered sequence in FRAMES,
    with every sound moved to its place in the whole."""
    scenes = sorted(glob.glob(SCENES))
    if not scenes:
        sys.exit(f"no scenes in {FRAMES} — run tool/generate_showreel.dart "
                 "or tool/generate_promo.dart first")
    for old in glob.glob(os.path.join(FRAMES, "frame_*.png")):
        os.remove(old)
    total, events, fps = 0, [], None
    for scene in scenes:
        meta = json.load(open(os.path.join(scene, "events.json")))
        fps = fps or meta["fps"]
        for i in range(1, meta["frames"] + 1):
            shutil.copyfile(os.path.join(scene, f"frame_{i:05d}.png"),
                            frame_path(total + i))
        events += [{**e, "frame": e["frame"] + total} for e in meta["events"]]
        total += meta["frames"]
    json.dump({"fps": fps, "frames": total, "events": events},
              open(os.path.join(FRAMES, "events.json"), "w"), indent=2)
    print(f"  {len(scenes)} scenes, {total} frames")


def hook_overlay(frames: int, fps: int) -> None:
    """Writes [HOOK] over the opening frames: one line, white on a dark pill,
    high on the screen — below the platforms' top bar, clear of the captions
    and buttons they lay over the lower third."""
    font = _weighted(66, 900)
    probe = ImageDraw.Draw(Image.new("RGB", (1, 1)))
    size = 66
    while probe.textlength(HOOK, font=font) > W - 200 and size > 40:
        size -= 4
        font = _weighted(size, 900)
    tw = probe.textlength(HOOK, font=font)
    pad_x, pad_y = 44, 26
    box_w, box_h = round(tw + 2 * pad_x), size + 2 * pad_y
    x0, y0 = (W - box_w) // 2, HOOK_Y
    count = min(frames, round(HOOK_SECONDS * fps))
    fade = 6
    for i in range(1, count + 1):
        alpha = min(1.0, (count - i + 1) / fade)
        frame = Image.open(frame_path(i)).convert("RGBA")
        layer = Image.new("RGBA", frame.size, (0, 0, 0, 0))
        draw = ImageDraw.Draw(layer)
        draw.rounded_rectangle([(x0, y0), (x0 + box_w, y0 + box_h)], box_h // 2,
                               fill=(12, 10, 28, round(205 * alpha)))
        draw.text((W / 2, y0 + box_h / 2), HOOK, font=font,
                  fill=(255, 255, 255, round(255 * alpha)), anchor="mm")
        Image.alpha_composite(frame, layer).convert("RGB").save(frame_path(i))
    print(f"  hook over {count} frames: {HOOK!r}")


def main() -> int:
    if CUT:
        collect_scenes()
    meta_path = os.path.join(FRAMES, "events.json")
    if not os.path.exists(meta_path):
        print(f"{meta_path} missing — run `flutter test tool/generate_video.dart` first",
              file=sys.stderr)
        return 1
    meta = json.load(open(meta_path))
    fps, frames, events = meta["fps"], meta["frames"], meta["events"]
    if HOOK:
        hook_overlay(frames, fps)

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
