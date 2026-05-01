# Scripts

本目录按平台组织安装和维护脚本。

## 目录

- `linux/`：Linux/macOS Bash 脚本。
- `windows/`：Windows PowerShell 脚本。
- `README.md`：统一说明；除本文档外，脚本文件都放在平台目录。

## Linux / macOS

安装或同步 skills 与 references：

```bash
./scripts/linux/install.sh --prune
```

默认同时安装全局 `~/.codex/AGENTS.md`，原文件会自动备份。若只同步 skills/references：

```bash
./scripts/linux/install.sh --prune --no-global-agents
```

一键拉取仓库并安装：

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/spw6893-ui/vibecoding_essential/main/scripts/linux/one-click-install.sh)" -- --prune
```

补齐外部依赖仓库：

```bash
./scripts/linux/bootstrap-external-repos.sh
```

## Windows PowerShell

安装或同步 skills 与 references：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\windows\install.ps1 -Prune
```

默认同时安装全局 `$HOME\.codex\AGENTS.md`，原文件会自动备份。若只同步 skills/references：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\windows\install.ps1 -Prune -NoGlobalAgents
```

一键拉取仓库并安装：

```powershell
$p = Join-Path $env:TEMP "mycodex-one-click-install.ps1"; iwr -UseBasicParsing https://raw.githubusercontent.com/spw6893-ui/vibecoding_essential/main/scripts/windows/one-click-install.ps1 -OutFile $p; powershell -ExecutionPolicy Bypass -File $p -Prune
```

补齐外部依赖仓库：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\windows\bootstrap-external-repos.ps1
```

## 验证

```bash
./scripts/linux/verify.sh
```

## 说明

- 安装脚本同步 `skills/`、`references/` 和全局 `AGENTS.md`。
- 安装脚本不会覆盖 `~/.codex/config.toml`。
- 如全局 `AGENTS.md` 已存在且内容不同，会先备份为 `AGENTS.md.backup.<timestamp>`。
- `--prune` 会删除本仓库明确裁掉的旧 skill 残留。
- 一次安装后，后续项目会直接读取 `~/.codex/skills` 和 `~/.codex/AGENTS.md`，通常不需要重复安装。
