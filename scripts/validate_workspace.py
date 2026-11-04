#!/usr/bin/env python3
"""Check distributable structure and installation without external services."""
from pathlib import Path
from urllib.parse import unquote
import json
import re
import tempfile
from install_workspace import install

root = Path(__file__).resolve().parents[1]
errors = []
for name in ["CLAUDE.md", "AGENTS.md", "README.md", "LICENSE", "vault/Workspace Config.md", "vault/AGENTS.md"]:
    if not (root / name).is_file(): errors.append(f"Missing {name}")
json.loads((root / "claude/settings.json").read_text())
for p in root.rglob("*.md"):
    text = p.read_text()
    if re.search(r"originSessionId:|/Users/|[A-Z]{2,}-\d+", text):
        errors.append(f"Identifying leftover: {p.relative_to(root)}")
    link_text = re.sub(r"```.*?```", "", text, flags=re.S)
    link_text = re.sub(r"`[^`]*`", "", link_text)
    for target in re.findall(r"(?<!!)\[[^]\n]*\]\(([^)\n]+)\)", link_text):
        if "://" in target or target.startswith(("#", "mailto:", "<")) or "<" in target: continue
        target = unquote(target.split("#")[0])
        if target and not (p.parent / target).exists():
            errors.append(f"Broken link in {p.relative_to(root)}: {target}")
with tempfile.TemporaryDirectory(prefix="pm-workspace-check-") as tmp:
    destination = Path(tmp) / "workspace with spaces"
    install(destination)
    assert (destination / "CLAUDE.md").read_bytes() == (root / "CLAUDE.md").read_bytes()
    assert (destination / "Discovery/_template.md").is_file()
    assert not (destination / ".claude").exists()
    sentinel = destination / "owner-note.md"
    sentinel.write_text("preserve me")
    try:
        install(destination)
        errors.append("Installer overwrote an existing destination")
    except FileExistsError:
        assert sentinel.read_text() == "preserve me"
try:
    install(root / "local-workspace")
    errors.append("Installer allowed real work inside public repository")
except ValueError:
    pass
if errors:
    raise SystemExit("\n".join(errors))
print("PASS: structure, local Markdown links, known leftovers, fresh install and overwrite refusal")
