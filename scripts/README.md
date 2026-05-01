# Scripts

本目录按平台组织安装和维护脚本。

## 目录

- `linux/`：Linux/macOS Bash 脚本。
- `windows/`：Windows PowerShell 脚本。
- 根目录脚本：兼容入口，只转发到对应平台目录，避免旧命令失效。

## Linux / macOS

安装或同步 skills 与 references：

```bash
./scripts/linux/install.sh --prune
```

一键拉取仓库并安装：

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/spw6893-ui/vibecoding_essential/main/scripts/one-click-install.sh)" -- --prune
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

一键拉取仓库并安装：

```powershell
$p = Join-Path $env:TEMP "mycodex-one-click-install.ps1"; iwr -UseBasicParsing https://raw.githubusercontent.com/spw6893-ui/vibecoding_essential/main/scripts/one-click-install.ps1 -OutFile $p; powershell -ExecutionPolicy Bypass -File $p -Prune
```

补齐外部依赖仓库：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\windows\bootstrap-external-repos.ps1
```

## 兼容入口

以下旧命令仍可用：

```bash
./scripts/install.sh --prune
./scripts/bootstrap-external-repos.sh
```

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install.ps1 -Prune
powershell -ExecutionPolicy Bypass -File .\scripts\bootstrap-external-repos.ps1
```

## 说明

- 安装脚本只同步 `skills/` 与 `references/`。
- 安装脚本不会覆盖 `~/.codex/config.toml` 或 `~/.codex/AGENTS.md`。
- `--prune` 会删除本仓库明确裁掉的旧 skill 残留。
