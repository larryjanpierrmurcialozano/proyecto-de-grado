"""Auto-save Git commits watcher.

Usage: run from the repo root:
    python auto_save_git.py

This script polls the workspace for file changes (excluding common ignores)
and makes small incremental commits with message `autosave: <timestamp>`.

It avoids committing `.git` and virtualenv folders. It's a simple, dependency-
free solution compatible with Windows.
"""
import os
import sys
import time
import subprocess
from datetime import datetime

# Configuration
POLL_INTERVAL = 2.0  # seconds
DEBOUNCE_SECONDS = 1.0
ROOT = os.path.abspath(os.path.dirname(__file__))
IGNORED_DIRS = {'.git', '.venv', 'venv', '__pycache__', '.vscode', 'node_modules'}
IGNORED_EXT = {'.pyc', '.pyo', '.dll', '.exe'}


def is_ignored(path):
    parts = path.split(os.sep)
    for p in parts:
        if p in IGNORED_DIRS:
            return True
    _, ext = os.path.splitext(path)
    if ext in IGNORED_EXT:
        return True
    return False


def scan_files():
    files = {}
    for dirpath, dirnames, filenames in os.walk(ROOT):
        # modify dirnames in-place to prune ignored directories
        dirnames[:] = [d for d in dirnames if d not in IGNORED_DIRS]
        for f in filenames:
            full = os.path.join(dirpath, f)
            rel = os.path.relpath(full, ROOT)
            if is_ignored(rel):
                continue
            try:
                mtime = os.path.getmtime(full)
            except OSError:
                continue
            files[rel] = mtime
    return files


def git_commit(changed_paths):
    # Stage changes (add and remove) but respect .gitignore
    try:
        # Add changed files
        subprocess.check_call(['git', 'add', '-A', '--'])
        msg = f"autosave: {datetime.now().isoformat(timespec='seconds')} - {', '.join(changed_paths)}"
        subprocess.check_call(['git', 'commit', '-m', msg])
        print(f"[autosave] committed {len(changed_paths)} paths")
    except subprocess.CalledProcessError as e:
        # no changes to commit or other git error
        # print minimal info and continue
        print(f"[autosave] git command failed: {e}")


def main():
    print("Auto-save Git watcher starting in:", ROOT)
    prev = scan_files()
    last_commit = 0.0
    try:
        while True:
            time.sleep(POLL_INTERVAL)
            curr = scan_files()
            changed = []
            # detect modified or new files
            for path, m in curr.items():
                if path not in prev or prev[path] != m:
                    changed.append(path)
            # detect deleted files
            for path in set(prev) - set(curr):
                changed.append(path)

            if changed:
                now = time.time()
                if now - last_commit >= DEBOUNCE_SECONDS:
                    print(f"Changes detected: {len(changed)} files")
                    git_commit(sorted(set(changed)))
                    last_commit = now
                else:
                    # debounce: wait for next loop
                    pass
            prev = curr
    except KeyboardInterrupt:
        print('\nAuto-save watcher stopped by user')


if __name__ == '__main__':
    # Ensure running inside a git repo
    try:
        subprocess.check_call(['git', 'rev-parse', '--is-inside-work-tree'], stdout=subprocess.DEVNULL)
    except subprocess.CalledProcessError:
        print('Not inside a git repository. Run this script from the repository root.')
        sys.exit(1)
    main()
