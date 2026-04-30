#!/usr/bin/env bash
set -euo pipefail

TARGET_DIR="${1:-${CODEX_HOME:-$HOME/.codex}/repos}"
mkdir -p "$TARGET_DIR"

clone_or_checkout() {
  local name="$1"
  local url="$2"
  local commit="$3"
  local path="$TARGET_DIR/$name"

  if [[ -e "$path" && ! -d "$path/.git" ]]; then
    echo "跳过 $name：目标已存在但不是 Git 仓库: $path" >&2
    return 1
  fi

  if [[ ! -d "$path/.git" ]]; then
    git clone "$url" "$path"
  fi

  git -C "$path" fetch --all --tags --prune
  git -C "$path" checkout "$commit"
}

clone_or_checkout ".tmux" "https://github.com/gpakosz/.tmux.git" "87dcd13a28aeb5f18baee630e24b3f5765ae3a4f"
clone_or_checkout "Skill_Seekers-development" "https://github.com/yusufkaraaslan/Skill_Seekers.git" "26638b248279a3b001b651475e0f28975f5ff069"
clone_or_checkout "claude-official-skills" "https://github.com/anthropics/skills.git" "1ed29a03dc852d30fa6ef2ca53a67dc2c2c563"
clone_or_checkout "tmux" "https://github.com/tmux/tmux.git" "615c27c11789948df2db09e113e882f82dfb3e1c"

if [[ -d "$TARGET_DIR/Skill_Seekers-development/.git" ]]; then
  git -C "$TARGET_DIR/Skill_Seekers-development" submodule update --init --recursive
fi

echo "外部依赖已准备完成: $TARGET_DIR"
