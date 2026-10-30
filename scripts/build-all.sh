#!/bin/bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
export PATH="$ROOT/node_modules/.bin:$PATH"
cd "$ROOT/demo-a-new-module" && antora playbook-old.yml
cd "$ROOT/demo-b-two-components" && antora playbook-old.yml && antora playbook-new.yml
cd "$ROOT/demo-c-new-repo/existing-docs" && antora playbook-old.yml
cd "$ROOT/demo-c-new-repo/new-site" && antora playbook.yml
echo "All demos built."
