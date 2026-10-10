#!/usr/bin/env python3
"""Expose the selected Nova palette as tmux user options."""

import json
import subprocess
import sys
from pathlib import Path

socket, appearance = sys.argv[1:3]
slug = "nova-light" if appearance == "light" else "nova-dark"
path = Path.home() / ".config/nova.nvim/extras/palettes/nova.json"

try:
    palettes = json.loads(path.read_text(encoding="utf-8"))["palettes"]
    colors = next(item["colors"] for item in palettes if item["slug"] == slug)
except (OSError, ValueError, KeyError, StopIteration) as error:
    sys.exit(f"Cannot load {slug} from {path}: {error}")

for name in ("selection", "comment", "foreground", "yellow", "red", "blue"):
    subprocess.run(
        ["tmux", "-S", socket, "set-option", "-g", f"@nova-{name}", colors[name]],
        check=True,
    )
