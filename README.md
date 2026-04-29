# mycodex

PPW 的个人 Codex 仓库。

它只放长期有用的东西：

- `skills/`：当前保留的 Codex skills
- `refs/`：从外部仓库提炼出来的参考资料
- `docs/`：来源、裁剪记录、维护说明
- `scripts/`：安装和同步脚本

## 当前 Skill

- `ppw-codex-engineer`：个人工程协作入口
- `myclaude-product-workflow`：PRD、需求确认、测试用例、原型提示词
- `auto-skill`：创建和维护 skills
- `browser`：Chrome DevTools Protocol 浏览器自动化
- `codeagent`：codeagent-wrapper 多后端任务执行说明
- `ddd-doc-steward`：文档单一可信源
- `dev`：轻量端到端开发工作流
- `do`：结构化功能开发编排
- `headless-cli`：无头 CLI 自动化
- `harness`：长任务检查点和恢复
- `omo`：多智能体路由工作流
- `postgresql`：PostgreSQL
- `product-requirements`：交互式 PRD 生成
- `prototype-prompt-generator`：UI/UX 原型提示词生成
- `skill-install`：GitHub skill 安装流程
- `sparv`：Specify → Plan → Act → Review → Vault 工作流
- `timescaledb`：TimescaleDB
- `sop-generator`：SOP/流程文档
- `telegram-dev`：Telegram Bot / Mini Apps
- `tmux-autopilot`：tmux 自动化
- `twscrape`：Twitter/X 数据抓取
- `test-cases`：从 PRD/需求生成测试用例

## 安装

```bash
./scripts/install.sh
```

默认安装到 `${CODEX_HOME:-$HOME/.codex}`。

如果要删除之前裁掉的旧 skill 残留：

```bash
./scripts/install.sh --prune
```

安装后重开 Codex 会话，让技能发现列表刷新。

## 维护原则

- 少而精，避免 skill 数量膨胀。
- 新 skill 必须有明确高频用途，否则只放进 `refs/`。
- `SKILL.md` 保持短，长模板放 `references/`。
- 不提交密钥、日志、SQLite 状态库、shell 快照。
- 外部来源要记录在 `docs/sources.md`。
