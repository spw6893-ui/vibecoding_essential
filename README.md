# mycodex

PPW 的个人 Codex 仓库。

它只放长期有用的东西：

- `skills/`：当前保留的 Codex skills
- `references/`：从外部仓库提炼出来的少量参考资料，不保存完整上游镜像
- `config/`：Codex 配置示例与当前机器配置快照
- `docs/`：能力盘点与维护说明
- `scripts/`：安装和同步脚本

## 当前 Skill

- `ppw-codex-engineer`：个人工程路由、项目脚手架和工程模板导航
- `product-spec-workflow`：PRD、需求确认、测试用例、原型提示词
- `gh-create-issue`：从 PRD/需求创建 GitHub issue 或 epic
- `gh-issue-implement`：实现 GitHub issue 并创建 PR
- `gh-pr-review`：审查 GitHub PR、检查 CI 并按需修复/合并
- `ddd-doc-steward`：文档单一可信源
- `harness`：长任务检查点和恢复
- `heroui-pro`：HeroUI/NextUI Pro 组件库与 Next.js 集成
- `postgresql`：PostgreSQL
- `timescaledb`：TimescaleDB
- `ui-ux-pro-max`：UI/UX 设计知识库和设计系统生成器
- `sop-generator`：SOP/流程文档
- `telegram-dev`：Telegram Bot / Mini Apps
- `tmux-autopilot`：tmux 自动化
- `twscrape`：Twitter/X 数据抓取

`myclaude` 的 PRD、测试、原型提示词等内容已提炼进 `product-spec-workflow`，不再保留原始 skill 副本。
`gh-flow` 三件套覆盖 issue 创建、issue 实现和 PR review；`references/gh-flow/` 保留上游原始流程作为参考。

## 安装

### Linux / macOS

默认方式，适合公开或私有仓库，只要当前机器的 `git` 有访问权限：

```bash
git clone https://github.com/spw6893-ui/vibecoding_essential.git ~/.codex/repos/vibecoding_essential 2>/dev/null || git -C ~/.codex/repos/vibecoding_essential pull --ff-only
bash ~/.codex/repos/vibecoding_essential/scripts/linux/install.sh --prune
```

如果要同时补齐部分 skill 需要的外部依赖仓库：

```bash
bash ~/.codex/repos/vibecoding_essential/scripts/linux/bootstrap-external-repos.sh
```

如果仓库改成公开仓库，也可以用 raw 脚本一条命令安装：

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/spw6893-ui/vibecoding_essential/main/scripts/linux/one-click-install.sh)" -- --prune
```

### Windows PowerShell

默认方式，适合公开或私有仓库，只要当前 PowerShell 能通过 `git` 访问仓库：

```powershell
git clone https://github.com/spw6893-ui/vibecoding_essential.git "$HOME\.codex\repos\vibecoding_essential" 2>$null; if ($LASTEXITCODE -ne 0) { git -C "$HOME\.codex\repos\vibecoding_essential" pull --ff-only }
powershell -ExecutionPolicy Bypass -File "$HOME\.codex\repos\vibecoding_essential\scripts\windows\install.ps1" -Prune
```

如果要同时补齐部分 skill 需要的外部依赖仓库：

```powershell
powershell -ExecutionPolicy Bypass -File "$HOME\.codex\repos\vibecoding_essential\scripts\windows\bootstrap-external-repos.ps1"
```

如果仓库改成公开仓库，也可以用 raw 脚本一条命令安装：

```powershell
$p = Join-Path $env:TEMP "mycodex-one-click-install.ps1"; iwr -UseBasicParsing https://raw.githubusercontent.com/spw6893-ui/vibecoding_essential/main/scripts/windows/one-click-install.ps1 -OutFile $p; powershell -ExecutionPolicy Bypass -File $p -Prune
```

安装后重开 Codex 会话，让技能发现列表刷新。

### 本地仓库安装

```bash
./scripts/linux/install.sh --prune
```

Windows:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\windows\install.ps1 -Prune
```

默认安装到 `${CODEX_HOME:-$HOME/.codex}`，Windows 下默认是 `$HOME\.codex`。安装只同步 `skills/` 和 `references/`，不会覆盖你的 `config.toml` 或 `AGENTS.md`。

当前机器的全局 Codex 配置快照保存在 `config/codex/`。其中 `global-agents.snapshot.md` 是 `~/.codex/AGENTS.md` 的备份副本，不作为本仓库运行规则；不会被 `install.sh` 自动写回。

如果要删除之前裁掉的旧 skill 残留：

```bash
./scripts/linux/install.sh --prune
```

如果要补齐部分 skill 需要的外部依赖仓库：

```bash
./scripts/linux/bootstrap-external-repos.sh
```

Windows 对应命令：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\windows\bootstrap-external-repos.ps1
```

## 维护原则

- 少而精，避免 skill 数量膨胀。
- 新 skill 必须有明确高频用途，否则只放进 `references/`；创建或维护 skill 优先用系统 `skill-creator`。
- `SKILL.md` 保持短，长模板放 `references/`。
- 不提交密钥、日志、SQLite 状态库、shell 快照。
- Skill 能力盘点与候选合并建议见 `docs/skills-capabilities.md`。
- Codex plugin 安装建议见 `docs/codex-plugins-guide.md`。
- `/home/ppw/ppw-codex-kit` 已归档，后续只维护本仓库。
