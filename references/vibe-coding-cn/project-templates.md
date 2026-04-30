# vibe-coding-cn 项目模板摘录

来源：`/home/ppw/mycodex/repos/vibe-coding-cn`

本文件只保留对 PPW Codex 工作流有复用价值的项目框架建议。上游仓库还包含大量案例、外部仓库、交易/代理类技能与个人化配置，当前不纳入活跃 skill。

## 使用时机

- 新建项目，需要建议目录结构、初始文件和 `.gitignore`。
- 接手项目，需要判断目录是否清晰、是否缺少测试/文档/配置分层。
- 需要生成 GitHub issue / PR 模板或轻量 CI 标签规则。
- 需要把“需求 → 计划 → 实施 → 验证 → 复盘”固化成可审计流程。

## 推荐项目骨架

### Python Web/API

适合 FastAPI、Flask、REST API、后台服务。

```text
project/
├── README.md
├── pyproject.toml
├── requirements.txt
├── .env.example
├── .gitignore
├── AGENTS.md
├── docs/
│   ├── api.md
│   ├── architecture.md
│   └── development.md
├── scripts/
├── tests/
│   ├── conftest.py
│   ├── unit/
│   └── integration/
└── src/
    ├── main.py
    ├── config.py
    ├── api/
    ├── core/
    ├── data/
    └── external/
```

建议分层：`api -> service/core -> repository/data -> database/external`。

### 数据科学 / 量化 / AI 研究

适合数据采集、分析、回测、模型训练、研究型项目。

```text
project/
├── README.md
├── pyproject.toml
├── .env.example
├── configs/
├── notebooks/
├── docs/
├── scripts/
├── tests/
├── src/
│   ├── data/
│   ├── models/
│   ├── core/
│   └── utils/
├── data/       # git ignore
├── models/     # git ignore
└── logs/       # git ignore
```

注意：用户已明确不需要 `ccxt`、`coingecko`、`cryptofeed`、`hummingbot`、`polymarket`、`proxychains` 这类交易/代理运行时 skill。若项目涉及数据或量化，只给通用数据工程结构，不主动引入这些依赖。

### Monorepo / 微服务

适合多服务、多应用、多语言或基础设施一起管理的项目。

```text
project-monorepo/
├── README.md
├── docker-compose.yml
├── AGENTS.md
├── docs/
├── scripts/
├── services/
│   ├── user-service/
│   ├── data-service/
│   └── app-service/
├── packages/或assets/
├── infrastructure/
└── monitoring/
```

原则：全局脚本只做编排；服务内部保持独立依赖、测试和 Dockerfile；跨服务共享代码放 `packages/` 或明确的 `assets/common/`。

### Full-stack Web

适合前后端分离、SaaS、管理后台、Dashboard。

```text
project/
├── README.md
├── docker-compose.yml
├── AGENTS.md
├── docs/
├── frontend/
│   ├── package.json
│   ├── public/
│   └── src/
└── backend/
    ├── pyproject.toml
    ├── Dockerfile
    ├── src/
    └── tests/
```

如使用 HeroUI/Next.js，优先调用 `heroui-pro`；如需要视觉方向或设计系统，优先调用 `ui-ux-pro-max`。

## 默认文件建议

### `.gitignore`

```gitignore
__pycache__/
*.py[cod]
.venv/
venv/
.env
.env.*
node_modules/
dist/
build/
data/
models/
logs/
*.log
*.sqlite
*.sqlite-shm
*.sqlite-wal
*.duckdb
.DS_Store
```

### Python 依赖基线

优先使用 `pyproject.toml`；简单脚本项目可只用 `requirements.txt`。

```toml
[project]
name = "project-name"
version = "0.1.0"
description = "Project description"
dependencies = []

[project.optional-dependencies]
dev = ["pytest", "ruff", "mypy"]

[build-system]
requires = ["setuptools", "wheel"]
build-backend = "setuptools.build_meta"
```

FastAPI 项目常见依赖：`fastapi`、`uvicorn[standard]`、`pydantic`、`sqlalchemy`、`alembic`、`python-dotenv`、`pytest`。

## GitHub 协作模板

### PR 模板要点

PR 描述至少包含：

- 类型：Bug 修复、功能增加、重构、文档、其他。
- 目的：解决什么问题，核心改动是什么。
- 关联 Issue：`Closes #123`、`Fixes #456` 或 `Related to #789`。
- 测试步骤：安装、测试命令、手动验证路径。
- 检查清单：测试通过、文档更新、commit message 有意义、风格一致。

### Issue 模板要点

- Bug：问题描述、重现步骤、预期行为、实际行为、环境、附加信息。
- Feature：要解决的问题、期望方案、替代方案、附加信息。
- Documentation：问题描述、建议方案、涉及文档范围。

## Codex 配置基线

上游 `assets/config/.codex/` 提供 `config.toml` 与 `AGENTS.md` 示例。当前策略：

- 只作为参考，不直接覆盖 `/home/ppw/.codex/config.toml` 或 `/home/ppw/.codex/AGENTS.md`。
- 个人路径、模型迁移、MCP server、激进人格提示必须人工审查后再迁移。
- 项目级配置优先放 `.codex/config.toml`，全局配置只保留长期通用设置。

## 自动开发闭环模板

上游 `assets/documents/workflow/auto-dev-loop/` 的核心是五步：

1. 需求输入：把模糊需求锁定成无歧义规格。
2. 执行计划：把规格拆成任务 DAG、测试、回滚、监控计划。
3. 实施变更：按计划最小化修改代码和配置。
4. 验证发布：收集测试、构建、静态检查和发布证据。
5. 总控循环：成功则归档，失败则带证据回到计划阶段。

适合做复杂任务的思维框架；不建议原样引入状态机脚本作为活跃 skill，除非有明确长任务自动化需求。

## 新项目检查清单

- [ ] `README.md` 说明目标、启动方式、测试方式。
- [ ] `.env.example` 只写变量名和示例占位，不提交真实密钥。
- [ ] `.gitignore` 覆盖数据、日志、缓存、密钥、构建产物。
- [ ] `AGENTS.md` 写项目级约束、常用命令、架构说明。
- [ ] `docs/architecture.md` 记录模块边界和数据流。
- [ ] `tests/` 至少包含核心路径的最小测试。
- [ ] `scripts/` 只放可复现脚本，不写死个人绝对路径。
- [ ] Git 初始提交前检查 `git status --short` 和敏感文件。

## 采纳原则

- 对新项目：从最小骨架开始，不一次性铺满所有目录。
- 对旧项目：先映射现状，再补缺失文档/测试，不强行重排目录。
- 对模板：只复制结构和检查清单，不复制上游个人化路径、极端人格提示或已裁剪技能。
