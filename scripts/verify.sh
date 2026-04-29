#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

bash -n scripts/install.sh

count="$(find skills -mindepth 2 -maxdepth 2 -name SKILL.md | wc -l)"
echo "skills: $count"

for f in skills/*/SKILL.md; do
  test -n "$(sed -n '2s/^name: //p' "$f")" || {
    echo "missing name: $f" >&2
    exit 1
  }
  test -n "$(sed -n '3s/^description: //p' "$f")" || {
    echo "missing description: $f" >&2
    exit 1
  }
done

if git ls-files 2>/dev/null | grep -E 'auth|history|sqlite|\.env|log/' >/dev/null; then
  echo "发现疑似敏感文件，请检查 git ls-files 输出" >&2
  git ls-files | grep -E 'auth|history|sqlite|\.env|log/'
  exit 1
fi

echo "verify ok"

