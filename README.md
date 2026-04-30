# mycodex

PPW 的个人 Codex 仓库。

它只放长期有用的东西：

- `skills/`：当前保留的 Codex skills
- `references/`：从外部仓库提炼出来的少量参考资料，不保存完整上游镜像
- `config/`：Codex 配置示例与当前机器配置快照
- `docs/`：来源、裁剪记录、维护说明
- `scripts/`：安装和同步脚本

## 当前 Skill

- `ppw-codex-engineer`：个人工程路由、项目脚手架和工程模板导航
- `product-spec-workflow`：PRD、需求确认、测试用例、原型提示词
- `gh-create-issue`：从 PRD/需求创建 GitHub issue 或 epic
- `auto-skill`：创建和维护 skills
- `ddd-doc-steward`：文档单一可信源
- `headless-cli`：无头 CLI 自动化
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
`references/gh-flow/` 保留 GitHub issue-to-PR / PR review 原始流程作为参考，不作为活跃技能暴露。

## 安装

### 一键安装

默认方式，适合公开或私有仓库，只要当前机器的 `git` 有访问权限：

```bash
git clone https://github.com/spw6893-ui/vibecoding_essential.git ~/.codex/repos/vibecoding_essential 2>/dev/null || git -C ~/.codex/repos/vibecoding_essential pull --ff-only
bash ~/.codex/repos/vibecoding_essential/scripts/install.sh --prune
```

如果要同时补齐部分 skill 需要的外部依赖仓库：

```bash
bash ~/.codex/repos/vibecoding_essential/scripts/bootstrap-external-repos.sh
```

如果仓库改成公开仓库，也可以用 raw 脚本一条命令安装：

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/spw6893-ui/vibecoding_essential/main/scripts/one-click-install.sh)" -- --prune
```

安装后重开 Codex 会话，让技能发现列表刷新。

### 本地仓库安装

```bash
./scripts/install.sh
```

默认安装到 `${CODEX_HOME:-$HOME/.codex}`。安装只同步 `skills/` 和 `references/`，不会覆盖你的 `~/.codex/config.toml` 或 `~/.codex/AGENTS.md`。

当前机器的全局 Codex 配置快照保存在 `config/codex/`。其中 `global-agents.snapshot.md` 是 `~/.codex/AGENTS.md` 的备份副本，不作为本仓库运行规则；不会被 `install.sh` 自动写回。

如果要删除之前裁掉的旧 skill 残留：

```bash
./scripts/install.sh --prune
```

如果要补齐部分 skill 需要的外部依赖仓库：

```bash
./scripts/bootstrap-external-repos.sh
```

## 维护原则

- 少而精，避免 skill 数量膨胀。
- 新 skill 必须有明确高频用途，否则只放进 `references/`。
- `SKILL.md` 保持短，长模板放 `references/`。
- 不提交密钥、日志、SQLite 状态库、shell 快照。
- 外部来源要记录在 `docs/sources.md`，但不要提交完整外部仓库或运行状态。
- Skill 能力盘点与候选合并建议见 `docs/skills-capabilities.md`。
- `/home/ppw/ppw-codex-kit` 已归档，后续只维护本仓库。
