#!/usr/bin/env python3
"""Install a local workspace without changing global configuration."""
import argparse
import shutil
from pathlib import Path

def install(destination):
    source = Path(__file__).resolve().parents[1]
    destination = Path(destination).expanduser().resolve()
    if destination == source or source in destination.parents:
        raise ValueError("Choose a destination outside this repository")
    if destination.exists():
        raise FileExistsError(f"Destination already exists: {destination}")
    shutil.copytree(source / "vault", destination, ignore=shutil.ignore_patterns(".DS_Store", ".obsidian"))
    shutil.copy2(source / "CLAUDE.md", destination / "CLAUDE.md")
    return destination

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("destination")
    args = parser.parse_args()
    try:
        print(install(args.destination))
    except (OSError, ValueError) as error:
        parser.exit(1, f"Installation stopped: {error}\n")
