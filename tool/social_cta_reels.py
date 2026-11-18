"""Builds CTA reels for Qubble from existing clips: hook (0-3 s), CTA pill, end card.

usage: python3 tool/social_cta_reels.py . store-assets/video [name ...]

Needs ffmpeg, Pillow and the Poppins font (google-fonts; another folder via
QUBBLE_FONT_DIR). Clips that have
a hook get the hook for 3 s and a "FREE on Google Play" pill afterwards;
the re-cut clips keep their own labels and only get the end card.
"""
import json, os, subprocess, sys, tempfile
from pathlib import Path
from PIL import Image, ImageDraw, ImageFont

REPO = Path(sys.argv[1]); OUT = Path(sys.argv[2]); OUT.mkdir(parents=True, exist_ok=True)
VID = REPO / "store-assets/video"
TMP = Path(tempfile.mkdtemp(prefix="qubble-cta-"))
FONTS = Path(os.environ.get("QUBBLE_FONT_DIR", "/usr/share/fonts/truetype/google-fonts"))
BOLD = str(FONTS / "Poppins-Bold.ttf")
MED = str(FONTS / "Poppins-Medium.ttf")
W, H = 1080, 1920
YELLOW = (255, 210, 63, 255)
WHITE = (255, 255, 255, 255)
END = 2.6  # end-card seconds

# name, source clip, start, length (None = whole clip, keep original), hook lines
REELS = [
    ("funki", "qubble-sunset", 8.0, 9.5, ["This dragon burns", "every line you clear"]),
    ("optik", "qubble-forest", 8.0, 9.5, ["An owl.", "With a laser."]),
    ("firstpet", "qubble-gameplay", 8.0, 9.5, ["Play 3 runs,", "get a free pet"]),
    ("zapp", "qubble-neon", 8.0, 9.5, ["A thunderbird that", "zaps every line"]),
    ("challenge", "qubble-candy", 12.0, 9.5, ["One puzzle a day,", "same for everyone"]),
    ("frosti", "qubble-glacier", 8.0, 9.5, ["A penguin that", "freezes every line"]),
    ("pyra", "qubble-volcano", 8.0, 9.5, ["The legendary pet:", "a phoenix"]),
    ("prisma", "qubble-classic-prisma", 8.0, 9.5, ["This unicorn clears", "in rainbows"]),
    ("glim", "qubble-wood", 12.0, 9.5, ["Cozy wood board,", "combo x12"]),
    # 27./28.11.: nearly full boards from tool/generate_reels.dart (clutch4/5)
    ("almost-full-funki", "qubble-reel-clutch4", 0.0, 3.2, ["Board 70 % full.", "One piece clears 3 lines"]),
    ("almost-full-frosti", "qubble-reel-clutch5", 0.0, 3.2, ["Board 72 % full.", "One piece clears 3 lines"]),
    # existing scheduled clips: keep as cut, only append pill + end card
    ("watch-the-cat", "qubble-watch-the-cat", 0.0, None, None),
    ("fire-or-ice", "qubble-fire-or-ice", 0.0, None, None),
    ("sound-on", "qubble-sound-on", 0.0, None, None),
]


def font(path, size):
    return ImageFont.truetype(path, size)


def centered(d, y, text, f, fill, stroke=0):
    w = d.textlength(text, font=f)
    d.text(((W - w) / 2, y), text, font=f, fill=fill, stroke_width=stroke, stroke_fill=(0, 0, 0, 255))


def hook_png(lines, path):
    im = Image.new("RGBA", (W, H), (0, 0, 0, 0)); d = ImageDraw.Draw(im)
    f = font(BOLD, 74)
    lh = 96; top = 70; h = lh * len(lines) + 60
    d.rounded_rectangle((50, top, W - 50, top + h), 36, fill=(14, 10, 30, 225))
    for i, ln in enumerate(lines):
        centered(d, top + 26 + i * lh, ln, f, YELLOW if i == len(lines) - 1 else WHITE)
    im.save(path)


def pill_png(path):
    im = Image.new("RGBA", (W, H), (0, 0, 0, 0)); d = ImageDraw.Draw(im)
    f = font(BOLD, 44)
    t = "FREE on Google Play  ·  Android"
    tw = d.textlength(t, font=f); pad = 40
    x0 = (W - tw) / 2 - pad; y0 = H - 150
    d.rounded_rectangle((x0, y0, W - x0, y0 + 88), 44, fill=(255, 210, 63, 240))
    centered(d, y0 + 14, t, f, (20, 14, 40, 255))
    im.save(path)


def endcard_png(bg, path):
    im = Image.open(bg).convert("RGBA").resize((W, H)); d = ImageDraw.Draw(im)
    centered(d, 150, "Play it FREE", font(BOLD, 104), WHITE)
    centered(d, 290, "on Google Play", font(BOLD, 84), YELLOW)
    # button
    f = font(BOLD, 56); t = "Link in bio  >"
    tw = d.textlength(t, font=f); x0 = (W - tw) / 2 - 60
    d.rounded_rectangle((x0, 440, W - x0, 560), 60, fill=(255, 210, 63, 255))
    centered(d, 462, t, f, (20, 14, 40, 255))
    centered(d, H - 190, "Android  ·  plays offline  ·  no forced ads", font(MED, 40), WHITE)
    im.convert("RGB").save(path)


def dur(p):
    return float(subprocess.check_output(["ffprobe", "-v", "error", "-show_entries", "format=duration",
                                          "-of", "csv=p=0", str(p)]).strip())


def run(cmd):
    subprocess.run(cmd, check=True)


def main():
    # end-card background: last frame of the pets reel (logo + three Qubbies)
    bg = TMP / "endbg.png"
    run(["ffmpeg", "-loglevel", "error", "-y", "-sseof", "-0.2", "-i", str(VID / "qubble-reel-pets.mp4"),
         "-frames:v", "1", str(bg)])
    endcard_png(bg, TMP / "end.png")
    pill_png(TMP / "pill.png")
    meta = {}
    only = set(sys.argv[3:])
    for name, src, start, length, hook in REELS:
        if only and name not in only:
            continue
        srcp = VID / f"{src}.mp4"
        if length is None:
            length = dur(srcp)
        total = length + END
        out = OUT / f"qubble-cta-{name}.mp4"
        inputs = ["-ss", str(start), "-t", str(length), "-i", str(srcp),
                  "-loop", "1", "-t", str(END), "-i", str(TMP / "end.png"),
                  "-loop", "1", "-t", str(length), "-i", str(TMP / "pill.png")]
        fc = ("[0:v]scale=1080:1920,setsar=1,fps=30,format=yuv420p[v0];"
              "[1:v]scale=1080:1920,setsar=1,fps=30,format=yuv420p,"
              "zoompan=z='min(1+0.0009*on,1.06)':d=1:s=1080x1920:fps=30[e];")
        # no pill on the re-cut clips: their own labels (e.g. "replay") sit at the bottom
        pill_on = "gte(t,3.0)" if hook else "0"
        fc += f"[v0][2:v]overlay=0:0:enable='{pill_on}'[v1];"
        last = "v1"
        if hook:
            hook_png(hook, TMP / f"hook-{name}.png")
            inputs += ["-loop", "1", "-t", "3.2", "-i", str(TMP / f"hook-{name}.png")]
            fc += f"[v1][3:v]overlay=0:0:enable='lt(t,3.2)'[v2];"
            last = "v2"
        fc += (f"[{last}][e]concat=n=2:v=1:a=0[v];"
               f"[0:a]apad=whole_dur={total},atrim=0:{total},"
               f"afade=t=out:st={length - 0.4}:d={END + 0.4}[a]")
        run(["ffmpeg", "-loglevel", "error", "-y", *inputs, "-filter_complex", fc,
             "-map", "[v]", "-map", "[a]", "-c:v", "libx264", "-preset", "veryfast", "-crf", "20",
             "-pix_fmt", "yuv420p", "-c:a", "aac", "-b:a", "160k", "-movflags", "+faststart",
             "-t", str(total), str(out)])
        meta[name] = {"file": out.name, "duration": round(dur(out), 2), "endcard_at": round(length, 2)}
        print(name, meta[name], flush=True)
    print(json.dumps(meta, indent=1))


if __name__ == "__main__":
    main()
