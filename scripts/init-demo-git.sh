#!/bin/bash
# Nested folders must be git repos so Antora can use url: .
# GitHub does not store those nested .git directories; run this after clone.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
GIT="${GIT:-git}"
for d in \
  demo-a-new-module \
  demo-b-two-components \
  demo-c-new-repo/existing-docs \
  demo-c-new-repo/new-site
do
  dir="$ROOT/$d"
  if [ ! -d "$dir/.git" ]; then
    "$GIT" -C "$dir" init
    "$GIT" -C "$dir" add .
    "$GIT" -C "$dir" commit -m "Local Antora content source for $d"
    echo "Initialized $d"
  else
    echo "Already a git repo: $d"
  fi
done
