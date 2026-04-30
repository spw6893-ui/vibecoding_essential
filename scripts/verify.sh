#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

bash -n scripts/install.sh

if find skills -path '*/agents/openai.yaml' -print | grep -q .; then
  echo "发现 agents/openai.yaml，当前策略是不暴露用户页面入口" >&2
  find skills -path '*/agents/openai.yaml' -print
  exit 1
fi

if find skills refs -name '__pycache__' -o -name '*.pyc' -o -name '.DS_Store' -o -name '._*' -o -name '__MACOSX' | grep -q .; then
  echo "发现缓存或系统垃圾文件，请清理后再提交" >&2
  find skills refs -name '__pycache__' -o -name '*.pyc' -o -name '.DS_Store' -o -name '._*' -o -name '__MACOSX'
  exit 1
fi

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

if git ls-files 2>/dev/null | grep -E '(^|/)(auth\.json|history\.jsonl|installation_id|[^/]*\.sqlite(-shm|-wal)?|\.env(\..*)?|logs?/|shell_snapshots/)' >/dev/null; then
  echo "发现疑似敏感文件，请检查 git ls-files 输出" >&2
  git ls-files | grep -E '(^|/)(auth\.json|history\.jsonl|installation_id|[^/]*\.sqlite(-shm|-wal)?|\.env(\..*)?|logs?/|shell_snapshots/)'
  exit 1
fi

echo "verify ok"
