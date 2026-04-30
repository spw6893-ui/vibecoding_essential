# 工程项目模板

本文件用于快速初始化或整理工程项目。目标不是生成“大而全”的脚手架，而是先给出最小可运行、可测试、可维护的项目骨架，再按真实需求扩展。

## 使用时机

- 新建项目，需要建议目录结构、初始文件和 `.gitignore`。
- 接手项目，需要判断目录是否清晰、是否缺少测试/文档/配置分层。
- 需要生成 GitHub issue / PR 模板或轻量 CI 标签规则。
- 需要把“需求 → 计划 → 实施 → 验证 → 复盘”固化成可审计流程。

## 使用方式

1. 先按“模板选择矩阵”选择最接近的项目类型。
2. 只创建当前 1-2 周会用到的目录，不创建空壳大而全结构。
3. 先补 `README.md`、`.env.example`、`.gitignore`、`AGENTS.md`、`scripts/verify.sh`。
4. 再补核心源码目录和最小测试。
5. 首次提交前运行 `scripts/verify.sh`，并检查 `git status --short`。

## 模板选择矩阵

| 项目类型 | 选择条件 | 最小骨架 | 默认验证 |
|---|---|---|---|
| Python Web/API | 有 HTTP API、后台服务、Webhook、管理接口 | `src/`、`tests/`、`docs/`、`scripts/` | `python -m compileall src` + `pytest` |
| 数据科学 / AI / 研究 | 以数据处理、实验、模型、分析为主 | `src/data`、`src/models`、`configs`、`notebooks` | `python -m compileall src` + 核心数据函数测试 |
| Monorepo / 微服务 | 多服务、多语言、多 app 或共享包 | `services/`、`packages/`、`docs/`、`scripts/` | 每个服务独立 verify + 根目录聚合 verify |
| Full-stack Web | 前后端分离、Dashboard、SaaS、管理后台 | `frontend/`、`backend/`、`docs/` | 前端 lint/build + 后端测试 |
| Dataset-first 数据服务 | 核心交付物是长期稳定 dataset | 见 `dataset-service-template.md` | contract/registry/collect/write/validate 门禁 |

## 推荐项目骨架

### Python Web/API

适合 FastAPI、Flask、REST API、后台服务。

```text
project/
├── README.md
├── pyproject.toml
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
    └── <package_name>/
        ├── __init__.py
        ├── main.py
        ├── config.py
        ├── api/
        ├── core/
        ├── data/
        └── external/
```

建议分层：`api -> service/core -> repository/data -> database/external`。
如果只是一次性脚本，不要套 Web/API 骨架；用 `scripts/` + `src/<package_name>/` 即可。

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
│   └── <package_name>/
│       ├── data/
│       ├── models/
│       ├── core/
│       └── utils/
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
├── packages/
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

优先使用 `pyproject.toml`；只有需要兼容旧部署平台时才额外保留 `requirements.txt`。

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

### `README.md` 最小结构

````markdown
# Project Name

一句话说明项目目标。

## Quickstart

```bash
python -m venv .venv
source .venv/bin/activate
pip install -e ".[dev]"
./scripts/verify.sh
```

## Commands

- Run: `...`
- Test: `./scripts/verify.sh`
- Lint/format: `...`

## Structure

- `src/`：核心代码
- `tests/`：测试
- `docs/`：架构和决策文档
- `scripts/`：可复现脚本
````

### `AGENTS.md` 最小结构

```markdown
# 项目协作规则

## 项目目标

用 2-4 句话说明项目做什么、不做什么。

## 常用命令

- 安装：`...`
- 验证：`./scripts/verify.sh`
- 运行：`...`

## 架构边界

- `src/<package>/api`：入口适配层
- `src/<package>/core`：业务逻辑
- `src/<package>/data`：数据访问
- `src/<package>/external`：外部服务适配

## 修改要求

- 先读现有结构，不凭猜测新增模块。
- 默认最小可行修改。
- 修改后运行 `./scripts/verify.sh`。
```

### `scripts/verify.sh` 最小模板

```bash
#!/usr/bin/env bash
set -euo pipefail

PYTHON="${PYTHON:-python3}"

"$PYTHON" -m compileall src
"$PYTHON" -m pytest
```

### `.env.example` 要求

```dotenv
APP_ENV=development
LOG_LEVEL=INFO
DATABASE_URL=postgresql://user:password@localhost:5432/app
```

只写变量名、格式和占位值，不写真实 token、密码、cookie、私钥。

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

## 落地顺序

### 新项目

1. 写 `README.md`，明确目标、非目标、运行方式。
2. 写 `.gitignore` 和 `.env.example`，先挡住敏感文件。
3. 写 `AGENTS.md`，明确项目边界、命令和验证方式。
4. 建 `src/` 和 `tests/`，只放第一个核心路径需要的模块。
5. 写 `scripts/verify.sh`，让验证命令稳定可复现。
6. 首次提交后再扩展 docs、CI、Docker、部署文件。

### 旧项目

1. 先画出现有目录到职责的映射，不直接重排。
2. 补 `README.md`、`AGENTS.md`、`scripts/verify.sh`。
3. 找出无主目录、重复入口、硬编码路径和敏感文件风险。
4. 只在有明确收益时移动目录，并保留兼容入口或迁移说明。

## 新项目检查清单

- [ ] `README.md` 说明目标、启动方式、测试方式。
- [ ] `.env.example` 只写变量名和示例占位，不提交真实密钥。
- [ ] `.gitignore` 覆盖数据、日志、缓存、密钥、构建产物。
- [ ] `AGENTS.md` 写项目级约束、常用命令、架构说明。
- [ ] `docs/architecture.md` 记录模块边界和数据流。
- [ ] `tests/` 至少包含核心路径的最小测试。
- [ ] `scripts/` 只放可复现脚本，不写死个人绝对路径。
- [ ] `scripts/verify.sh` 可在干净环境中运行。
- [ ] Git 初始提交前检查 `git status --short` 和敏感文件。

## 验收标准

- 任何人读 `README.md` 后能在 10 分钟内跑起最小验证。
- `AGENTS.md` 能回答“怎么改、怎么测、哪些边界不能碰”。
- `.env.example` 覆盖运行必需配置，但不包含真实秘密。
- `scripts/verify.sh` 是唯一推荐验证入口，避免口头命令漂移。
- 目录结构能解释清楚每层职责，没有长期空目录和无主模块。

## 采纳原则

- 对新项目：从最小骨架开始，不一次性铺满所有目录。
- 对旧项目：先映射现状，再补缺失文档/测试，不强行重排目录。
- 对模板：只复制结构和检查清单，不复制上游个人化路径、极端人格提示或已裁剪技能。
