#!/usr/bin/env python3
"""The viral reels of 28.11.2026: a run from tool/generate_reels.dart, with
captions that tell its story, and nothing after the last move.

    QUBBLE_REEL=chase flutter test tool/generate_reels.dart
    python3 tool/social_viral_reels.py chase
                                  # -> store-assets/video/qubble-viral-chase.mp4

Why this shape (store-assets/social/README.md "Auswertung 28.11."): the reel
that did best on Instagram, "combo chase" (5,704 views, 7.2 s of 9.8 s watched
on average), opened on the game in motion, asked one question, answered it
on screen and stopped. The reels that opened on a still board, a chat or a
title were swiped away after 1.3–1.9 s; the CTA reels lost viewers on their
silent end card. So:

* the game fills the frame from the first frame, scaled under a caption band;
* captions change with what happens — and every number in them (combo, how
  full the board is) is read from the run's story.json, so a caption can
  only say what the frame shows;
* no end card: the clip ends a second after the last clear. The way to the
  store is the caption, the bio link and the story's link sticker.

Sound: the game's own effects at the frame and pitch the game asked for,
over the game's music loop, as in tool/encode_video.py.
"""

from __future__ import annotations

import json
import os
import subprocess
import sys

from PIL import Image, ImageDraw

from caption_screenshots import _weighted
from encode_video import MUSIC, MUSIC_VOLUME, SFX, ffmpeg

W, H = 1080, 1920
# The platforms lay their own bar over the top ~110 px and their caption and
# buttons over the bottom fifth; the band starts below the bar.
BAND_TOP = 112
CROP_TOP = 120          # the coin pill above the score row is left out
GAME_Y = 372            # the game starts here, scaled to fill the rest
# The opening caption stays at least this long (frames at 30 fps): a hook
# cut after 0.6–0.8 s cannot be read.
HOOK_MIN = 54
YELLOW = (255, 204, 77)
WHITE = (255, 255, 255)
SOFT = (255, 255, 255, 150)


def story_of(reel: str) -> tuple[str, list[dict], dict]:
    scene = f"build/video/reel-{reel}/scene-01"
    story = json.load(open(os.path.join(scene, "story.json")))
    meta = json.load(open(os.path.join(scene, "events.json")))
    return scene, story, meta


def first(story: list[dict], test) -> dict:
    return next(e for e in story if test(e))


def captions(reel: str, story: list[dict]) -> list[tuple[int, str, str]]:
    """(from frame, white line, yellow line) — numbers from the story only."""
    start, end = story[0], story[-1]
    clears = [e for e in story if e["lines"] > 0]
    if reel == "chase":
        peak = end["combo"]
        mid = first(story, lambda e: e["combo"] >= start["combo"] + 4)
        late = first(story, lambda e: e["combo"] >= peak - 2)
        return [
            (0, "CAN THIS COMBO", f"HIT ×{peak}?"),
            (mid["frame"], "KEEP IT", "GOING."),
            (late["frame"], "DON'T", "BREAK IT."),
            (end["frame"], f"×{peak}.", "THERE IT IS."),
        ]
    if reel == "catmeme":
        # The opening line stands alone, since the first flight comes before
        # anyone has read it; the count runs on the clears after it.
        later = [e for e in clears if e["frame"] >= HOOK_MIN]
        return [
            (0, "MY CAT EVERY TIME", "I CLEAR A LINE:"),
            (later[0]["frame"], "EVERY.", ""),
            (later[1]["frame"], "EVERY.", "SINGLE."),
            (later[2]["frame"], "EVERY. SINGLE.", "TIME."),
            (later[len(later) * 2 // 3]["frame"], "SHE TAKES", "ALL THE CREDIT."),
            (clears[-1]["frame"], "KIKI. YOUR FIRST", "QUBBIE IS FREE."),
        ]
    if reel == "soundon":
        # The combo sound rises with the combo up to x11 (pitch 1.6, the cap
        # in GameController.place) and a fever burst has a sound of its own,
        # so the caption says it climbs, not that every clear is higher.
        peak = end["combo"]
        return [
            (0, "SOUND ON.", "LISTEN TO THE COMBO."),
            (max(clears[2]["frame"], HOOK_MIN), "HEAR IT", "CLIMB?"),
            (end["frame"], f"×{peak}.", "SATISFYING, RIGHT?"),
        ]
    if reel == "rescue":
        mid = first(story, lambda e: e["fill"] <= (start["fill"] + end["fill"]) // 2)
        return [
            (0, f"{start['fill']} % FULL.", "CAN IT BE SAVED?"),
            (max(mid["frame"], HOOK_MIN), "KEEP", "CLEARING."),
            (end["frame"], f"{start['fill']} % TO {end['fill']} %.", "SAVED."),
        ]
    if reel == "allclear2":
        assert end["allClear"], "the all-clear reel must end on an empty board"
        return [
            (0, "CAN 2 PIECES", "EMPTY THIS BOARD?"),
            (end["frame"], "ALL CLEAR.", "NOTHING LEFT."),
        ]
    raise SystemExit(f"no captions for {reel}")


def band(caption: tuple[int, str, str], bg: tuple[int, int, int], alpha: float) -> Image.Image:
    """The caption band above the game: brand line, then the caption."""
    layer = Image.new("RGBA", (W, GAME_Y), bg + (255,))
    draw = ImageDraw.Draw(layer)
    small = _weighted(30, 800)
    draw.text((64, BAND_TOP), "QUBBLE  ·  BLOCK PUZZLE  ·  FREE ON GOOGLE PLAY",
              font=small, fill=SOFT)
    _, white, yellow = caption
    size = 88
    for text in (white, yellow):
        while text and draw.textlength(text, font=_weighted(size, 900)) > W - 128:
            size -= 4
    font = _weighted(size, 900)
    a = round(255 * alpha)
    y = BAND_TOP + 52
    draw.text((64, y), white, font=font, fill=WHITE[:3] + (a,))
    if yellow:
        draw.text((64, y + size + 6), yellow, font=font, fill=YELLOW + (a,))
    return layer


def compose(reel: str) -> str:
    scene, story, meta = story_of(reel)
    fps, frames, events = meta["fps"], meta["frames"], meta["events"]
    caps = captions(reel, story)
    out_dir = f"build/video/viral-{reel}"
    os.makedirs(out_dir, exist_ok=True)
    scale = (H - GAME_Y) / (1920 - CROP_TOP)
    gw = round(W * scale)
    gx = (W - gw) // 2
    for i in range(1, frames + 1):
        frame = Image.open(os.path.join(scene, f"frame_{i:05d}.png")).convert("RGB")
        bg = frame.getpixel((6, 1000))
        game = frame.crop((0, CROP_TOP, W, 1920)).resize((gw, H - GAME_Y), Image.LANCZOS)
        canvas = Image.new("RGB", (W, H), bg)
        canvas.paste(game, (gx, GAME_Y))
        k = i - 1
        current = [c for c in caps if c[0] <= k][-1]
        since = k - current[0]
        alpha = min(1.0, (since + 1) / 3)  # a quick fade, so a change is seen
        canvas.paste(band(current, bg, alpha), (0, 0))
        canvas.save(os.path.join(out_dir, f"frame_{i:05d}.png"))
    duration = frames / fps

    inputs = ["-framerate", str(fps), "-i", os.path.join(out_dir, "frame_%05d.png"),
              "-stream_loop", "-1", "-i", MUSIC]
    filters = [f"[1:a]aresample=44100,volume={MUSIC_VOLUME},atrim=0:{duration:.3f}[m]"]
    labels = ["[m]"]
    for k, e in enumerate(events):
        path = SFX.get(e["sfx"])
        if path is None:
            continue
        inputs += ["-i", path]
        delay = round(e["frame"] / fps * 1000)
        rate = round(22050 * float(e["pitch"]))
        filters.append(
            f"[{2 + k}:a]asetrate={rate},aresample=44100,adelay={delay}|{delay}[s{k}]")
        labels.append(f"[s{k}]")
    filters.append(
        f"{''.join(labels)}amix=inputs={len(labels)}:normalize=0:duration=first,"
        f"afade=t=out:st={max(0.0, duration - 0.6):.3f}:d=0.6,alimiter=limit=0.95[a]")
    out = f"store-assets/video/qubble-viral-{reel}.mp4"
    subprocess.run([ffmpeg(), "-y", "-hide_banner", "-loglevel", "error", *inputs,
                    "-filter_complex", ";".join(filters), "-map", "0:v", "-map", "[a]",
                    "-c:v", "libx264", "-preset", "slow", "-crf", "20",
                    "-pix_fmt", "yuv420p", "-r", str(fps), "-c:a", "aac", "-b:a", "160k",
                    "-ac", "2", "-movflags", "+faststart", "-t", f"{duration:.3f}", out],
                   check=True)
    print(f"  ✓ {out} ({duration:.1f} s); captions:")
    for start, white, yellow in caps:
        print(f"    {start / fps:5.2f} s  {white} / {yellow}")
    return out


if __name__ == "__main__":
    for name in sys.argv[1:] or ["chase"]:
        compose(name)
