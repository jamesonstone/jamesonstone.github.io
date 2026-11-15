#!/usr/bin/env python3
"""Write committed social preview cards for the static site.

GitHub Pages does not run this script. Run it after adding or retitling a post,
then commit assets/images/social/. Requires Pillow.
"""

import re
import sys
from pathlib import Path

try:
    from PIL import Image, ImageDraw, ImageFont
    from PIL.PngImagePlugin import PngInfo
except ImportError:
    sys.stderr.write("generate_social_cards: install Pillow (python3 -m pip install Pillow)\n")
    raise SystemExit(1)

ROOT = Path(__file__).resolve().parents[1]
FONT_PATH = ROOT / "scripts" / "social_cards" / "fonts" / "Manrope-Variable.ttf"
POSTS_DIR = ROOT / "_posts"
OUTPUT_DIR = ROOT / "assets" / "images" / "social"

WIDTH = 1200
HEIGHT = 630
MARGIN_X = 96

BG = (251, 250, 244)
INK = (36, 33, 28)
MUTED = (104, 100, 88)
TEAL = (11, 99, 88)
LINE = (222, 215, 201)

POST_NAME = re.compile(r"\A\d{4}-\d{2}-\d{2}-(.+)\.md\Z")
FRONT_MATTER = re.compile(r"\A---\n(.*?)\n---\n", re.S)


def parse_scalar(value):
    value = value.strip()
    if len(value) >= 2 and value[0] == value[-1] and value[0] in "\"'":
        return value[1:-1]
    return value


def front_matter(text):
    match = FRONT_MATTER.match(text)
    if not match:
        raise SystemExit("generate_social_cards: missing front matter")
    data = {}
    for line in match.group(1).splitlines():
        if not line or line[:1].isspace() or ":" not in line:
            continue
        key, value = line.split(":", 1)
        data[key.strip()] = parse_scalar(value)
    return data


def site_fields():
    data = {}
    for line in Path(ROOT, "_config.yml").read_text(encoding="utf-8").splitlines():
        if not line or line[:1].isspace() or line.startswith("#") or ":" not in line:
            continue
        key, value = line.split(":", 1)
        data[key.strip()] = parse_scalar(value)
    title = data.get("title", "").strip()
    description = data.get("description", "").strip()
    if not title or not description:
        raise SystemExit("generate_social_cards: _config.yml needs title and description")
    return title, description


def load_font(size, weight):
    font = ImageFont.truetype(FONT_PATH, size)
    font.set_variation_by_axes([weight])
    return font


def text_width(font, text, tracking):
    if not text:
        return 0
    width = sum(font.getlength(character) for character in text)
    if len(text) > 1 and tracking:
        width += tracking * (len(text) - 1)
    return width


def wrap_text(text, font, max_width, tracking):
    lines = []
    current = ""
    for word in text.split():
        trial = word if not current else f"{current} {word}"
        if text_width(font, trial, tracking) <= max_width:
            current = trial
            continue
        if current:
            lines.append(current)
        current = word
    if current:
        lines.append(current)
    return lines


def line_box(font):
    ascent, descent = font.getmetrics()
    return ascent + descent


def draw_tracked(draw, text, x, y, font, fill, tracking):
    cursor = x
    for character in text:
        draw.text((cursor, y), character, font=font, fill=fill, anchor="lt")
        cursor += font.getlength(character) + tracking


def fit_title(text, max_width, max_size, min_size, max_lines, weight=600):
    chosen = None
    for size in range(max_size, min_size - 1, -2):
        font = load_font(size, weight)
        tracking = 0
        lines = wrap_text(text, font, max_width, tracking)
        chosen = (font, lines, tracking)
        if len(lines) <= max_lines:
            return chosen
    return chosen


def new_canvas():
    image = Image.new("RGB", (WIDTH, HEIGHT), BG)
    draw = ImageDraw.Draw(image)
    draw.rectangle((36, 36, WIDTH - 37, HEIGHT - 37), outline=LINE)
    return image, draw


def save_card(image, path, title):
    info = PngInfo()
    info.add_text("Title", title)
    path.parent.mkdir(parents=True, exist_ok=True)
    image.save(path, format="PNG", optimize=True, pnginfo=info)


def render_post(title, site_name):
    image, draw = new_canvas()
    max_width = WIDTH - (MARGIN_X * 2)
    eyebrow_font = load_font(20, 650)
    eyebrow_tracking = 3.4
    title_font, lines, title_tracking = fit_title(title, max_width, 78, 46, 3)
    if len(lines) > 4:
        title_font, lines, title_tracking = fit_title(title, max_width, 46, 40, 5)

    eyebrow_height = line_box(eyebrow_font)
    title_height = line_box(title_font) + 6
    block_height = eyebrow_height + 26 + 3 + 36 + (title_height * len(lines))
    y = max(84, (HEIGHT - block_height) // 2)

    draw_tracked(draw, site_name.upper(), MARGIN_X, y, eyebrow_font, TEAL, eyebrow_tracking)
    y += eyebrow_height + 26
    draw.rectangle((MARGIN_X, y, MARGIN_X + 64, y + 3), fill=TEAL)
    y += 3 + 36
    for line in lines:
        draw_tracked(draw, line, MARGIN_X, y, title_font, INK, title_tracking)
        y += title_height
    return image


def render_default(title, description):
    image, draw = new_canvas()
    max_width = WIDTH - (MARGIN_X * 2)
    title_font = load_font(84, 600)
    title_tracking = 0
    body_font, body_lines, body_tracking = fit_title(description, max_width, 28, 22, 2, weight=500)

    title_height = line_box(title_font)
    body_height = line_box(body_font) + 4
    block_height = 3 + 36 + title_height + 28 + (body_height * len(body_lines))
    y = max(100, (HEIGHT - block_height) // 2)

    draw.rectangle((MARGIN_X, y, MARGIN_X + 64, y + 3), fill=TEAL)
    y += 3 + 36
    draw_tracked(draw, title, MARGIN_X, y, title_font, INK, title_tracking)
    y += title_height + 28
    for line in body_lines:
        draw_tracked(draw, line, MARGIN_X, y, body_font, MUTED, body_tracking)
        y += body_height
    return image


def posts():
    found = []
    for path in sorted(POSTS_DIR.glob("*.md")):
        match = POST_NAME.match(path.name)
        if not match:
            raise SystemExit(f"generate_social_cards: invalid post filename: {path.name}")
        data = front_matter(path.read_text(encoding="utf-8"))
        title = data.get("title", "").strip()
        if not title:
            raise SystemExit(f"generate_social_cards: missing title: {path.name}")
        found.append((match.group(1), title))
    return found


def main():
    if not FONT_PATH.is_file():
        raise SystemExit(f"generate_social_cards: missing font: {FONT_PATH}")
    site_name, description = site_fields()
    save_card(render_default(site_name, description), OUTPUT_DIR / "default.png", site_name)
    expected = set()
    for slug, title in posts():
        expected.add(f"{slug}.png")
        save_card(render_post(title, site_name), OUTPUT_DIR / "posts" / f"{slug}.png", title)
    posts_dir = OUTPUT_DIR / "posts"
    for path in posts_dir.glob("*.png"):
        if path.name not in expected:
            path.unlink()
    print(f"generate_social_cards: wrote {len(expected)} post cards and the default card")


if __name__ == "__main__":
    main()
