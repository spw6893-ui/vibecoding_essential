# Skills 能力盘点

本文档记录当前 `mycodex` 活跃 skills，以及候选仓库 `obra/superpowers`、`mineskystudio/code-guardrails-skill` 的能力评估。

## 当前活跃 Skills

| Skill | 核心能力 | 典型触发 | 备注 |
|---|---|---|---|
| `ppw-codex-engineer` | 个人工程路由：Codex 配置治理、项目框架模板、工程模板导航、数据服务模板选择、专用 skill 分发 | mycodex 维护、个人 skill 整理、项目初始化、scaffold/boilerplate、数据服务骨架 | 不作为普通实现/修复/审查默认入口；常驻工程规则放 `AGENTS.md` |
| `product-spec-workflow` | PRD、需求确认、验收标准、测试用例、QA 计划、原型提示词 | 写 PRD、整理需求、产品到研发交付 | 聚合替代 myclaude 多个原生产品 skill |
| `gh-create-issue` | 从 PRD/需求创建 GitHub issue 或 epic + sub-issues | 创建 issue、拆任务、需求入 GitHub | 只保留 issue 创建；实现/评审流程暂放 references |
| `ddd-doc-steward` | 文档驱动开发，生成/更新 SSOT 文档并做一致性检查 | 文档与代码同步、补齐架构/集成/功能文档 | 强调证据，无法推导时标注待确认 |
| `harness` | 多会话长任务检查点、恢复、依赖管理 | 长任务、跨会话、失败恢复 | 更偏长周期任务治理 |
| `heroui-pro` | HeroUI/NextUI Pro 组件库、Next.js App Router 集成、组件搜索 | HeroUI、NextUI、Dashboard、SaaS、AI chat、落地页 | 活跃保留；含本地组件资源 |
| `ui-ux-pro-max` | UI/UX 知识库、设计系统生成、配色/字体/UX/技术栈建议 | UI 设计、视觉优化、落地页、Dashboard、移动端 | 可配合 `heroui-pro` 使用 |
| `postgresql` | PostgreSQL 使用、SQL、DDL/DML、索引、EXPLAIN、权限、性能 | PostgreSQL 设计/排障/优化 | 通用数据库 skill |
| `timescaledb` | TimescaleDB hypertable、time_bucket、连续聚合、压缩、保留策略 | 时间序列数据库 | 建立在 PostgreSQL 之上 |
| `telegram-dev` | Telegram Bot API、Mini Apps、webhook、键盘、支付、initData 验证 | Telegram Bot/Mini App 开发 | 注意 token 与用户数据安全 |
| `twscrape` | Twitter/X 公共数据抓取、账号池、异步搜索、限流排障 | 抓取公开 X/Twitter 数据 | 保留但不自动引入代理/交易类 skill |
| `tmux-autopilot` | tmux session/window/pane 读取、广播、救援和自动化操控 | tmux 巡检、多 Agent 协作、卡死救援 | 适合终端协作场景 |
| `sop-generator` | 把零散资料整理成 SOP/作业指导书/流程说明 | 写 SOP、流程、操作规程 | 偏文档交付 |

## 候选：obra/superpowers

来源：`https://github.com/obra/superpowers.git`，本地：`repos/superpowers`，当前 commit `6efe32c`。

`superpowers` 是一套完整软件开发方法论，不是单个轻量 skill。它强制“先 brainstorm/spec，再 plan，再 worktree，再 TDD/subagent 执行，再 review，再 finish”。优点是纪律强，缺点是对当前 `mycodex` 来说活跃安装会显著增加 skill 数量和流程摩擦。

| Skill | 能力 | 适合吸收方式 |
|---|---|---|
| `using-superpowers` | 强制每次对话先检查相关 skill，避免绕过流程 | 不建议原样安装；会与当前 Codex 系统 skill 选择规则重复且过强 |
| `brainstorming` | 创意/功能开发前澄清需求、比较方案、写设计 spec | 可把“复杂功能先设计再实现”原则沉淀到 `AGENTS.md` 或产品/计划类专项 skill |
| `writing-plans` | 基于 spec 写逐步实施计划，包含精确文件、测试、命令、commit | 值得吸收为复杂任务计划模板 |
| `executing-plans` | 读取计划并逐任务执行，遇阻停止 | 与当前执行方式重叠；可做参考 |
| `subagent-driven-development` | 每个独立任务派 fresh subagent，两阶段 review | 仅当用户明确要求多代理/并行时使用；不应默认强制 |
| `dispatching-parallel-agents` | 多个独立问题并行派代理调查/修复 | 当前系统已有 subagent 规则；可吸收独立域拆分判断 |
| `test-driven-development` | RED-GREEN-REFACTOR，先写失败测试，再最小实现 | 值得吸收为 bugfix/feature 的高风险路径规则 |
| `systematic-debugging` | 四阶段根因排障：调查、模式、假设、验证 | 更适合沉淀到 `AGENTS.md`，必要时再独立成排障 skill |
| `verification-before-completion` | 未运行新鲜验证命令前不得声称完成/通过 | 已与当前工作方式高度一致；可强化进质量门槛 |
| `requesting-code-review` | 完成任务/合并前请求代码审查 | 可作为 review 输出习惯参考 |
| `receiving-code-review` | 面对 review 不盲从，先验证反馈有效性 | 可吸收为审查反馈处理规则 |
| `using-git-worktrees` | 开 feature 前创建隔离 worktree 和分支 | 不默认安装；当前用户未要求 worktree 工作流 |
| `finishing-a-development-branch` | 完成后验证、选择 merge/PR/保留/丢弃 | 可作为分支收尾参考 |
| `writing-skills` | 用 TDD 思路写 skill，先 pressure test 再写/改 skill | 与系统 `skill-creator` 重叠；只做参考 |

### 对 superpowers 的建议

- 不建议把 14 个 skill 全部活跃安装，会让 skill 列表膨胀并引入过强的“必须先设计/必须 worktree/必须用户审批”流程。
- 建议把以下原则沉淀到 `AGENTS.md` 或专项 skill：系统排障、验证前置、复杂任务先 spec/plan、TDD 红绿循环、并行任务只在独立域时派 subagent。
- 如后续用户明确想用完整 Superpowers 方法论，再考虑安装为独立 plugin，而不是拆散混入当前 skills。

## 来源：mineskystudio/code-guardrails-skill

来源：`https://github.com/mineskystudio/code-guardrails-skill`，本地：`repos/code-guardrails-skill`，当前 commit `fd952e0`。

| Skill | 能力 | 适合吸收方式 |
|---|---|---|
| `code-guardrails` | 代码修改前的轻量工程护栏：架构边界、setup 边界、功能范围、取舍披露、bugfix 最小根因、重构边界、高风险先澄清 | 不再作为 active skill；高频硬规则保留在 `AGENTS.md` |

### code-guardrails 的关键规则

- Tiny edits 默认不增加流程，除非触及数据、鉴权、prompt、公开 API 或架构。
- Feature delivery 检查模块边界、功能范围和工程取舍。
- Setup/tooling 不引入新框架、包管理器、服务、缓存或运行时，除非现有栈无法满足。
- Bug fix 先复现可复现问题，修最小原因，必要时补回归测试。
- Refactor 默认保持行为，不混入格式化、依赖升级或功能工作。
- 高风险歧义先问清：敏感数据、auth、payment、prompt safety、公开 API、数据迁移/删除/覆盖。

### 对 code-guardrails 的处理

- 不保留为 active skill，避免普通编码规则挤占 skill 列表。
- `AGENTS.md` 保留默认硬规则，确保普通编码任务也受到最小护栏约束。
- 如未来需要显式审查模式，再重新做一个更聚焦的 review/guardrails skill。

## 候选：Python / Rust / Go 语言类 Skills

Web 搜索到的语言类 skill 主要集中在 GitHub 上的 Claude/Codex skill 集合和个人最佳实践包，常见形态是 `python-*`、`rust-*`、`go-*`、`golang-pro`、`fastapi-*`、`polyglot-task-automation`。它们更像“语言规范清单”，不是强工具能力。

| 语言 | 常见能力 | 是否建议活跃安装 |
|---|---|---|
| Python | uv/venv、ruff、mypy、pytest、FastAPI、包结构、类型注解、异常处理 | 暂不安装；当前由项目模板、真实配置和按需官方文档覆盖 |
| Rust | Cargo、Clippy、rustfmt、Tokio async、错误处理、所有权/生命周期、并发测试 | 暂不安装；除非后续长期写 Rust 服务或 CLI |
| Go | gofmt/go vet、golangci-lint、context、goroutine/channel、table-driven tests、race detector | 暂不安装；更适合写到具体 Go 项目的 `AGENTS.md` |
| Polyglot | 多语言构建、lint、test、release 命令统一调度 | 暂不安装；触发面过宽，容易和 Codex 本身工程能力重复 |

### 对语言类 skill 的建议

- 不把 Python/Rust/Go 做成全局 active skill；这些规则太通用，会增加触发噪声。
- 如果某个项目明确是 Python/Rust/Go，优先读取该项目的 `pyproject.toml`、`Cargo.toml`、`go.mod`、CI、Makefile 和本地 `AGENTS.md`，按项目事实执行。
- 如果后续确实需要沉淀，建议放 `references/language-notes/`，或在具体项目仓库内放项目级 `AGENTS.md`，不要污染个人全局 skill 列表。
- 只有高复用、工具链明确、触发边界窄的语言能力，才值得升级成 active skill。

## 已吸收的全局规则

以下候选能力已沉淀到 `AGENTS.md`，不新增 active skill：

- `code-guardrails` 的最小护栏选择：小改动不加流程，高风险变更先澄清，feature/setup/bugfix/refactor 分别套用最小约束。
- `superpowers/systematic-debugging` 的系统排障：先根因、再假设、再最小验证，连续失败时停止打补丁并重新评估架构。
- `superpowers/verification-before-completion` 的验证前置：没有新鲜命令输出和退出码证据，不声称完成、修好或通过。

保留策略：继续保持活跃 skill 数不变，避免把普通工程纪律包装成全局触发 skill。
