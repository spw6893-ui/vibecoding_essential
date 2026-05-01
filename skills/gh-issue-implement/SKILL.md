---
name: gh-issue-implement
description: 用 gh CLI 实现 GitHub issue 并创建 PR。触发于用户要求实现/修复/work on issue #N、把 GitHub issue 做成代码变更、从 issue 到 PR 的闭环；使用 Codex 原生代码修改、测试验证和 gh pr create，不依赖 dev/codeagent。
---

# GitHub Issue Implement

把 GitHub issue 转成可验证代码变更和 PR。此 skill 只负责 issue-to-PR 工作流编排；实际代码修改遵循仓库 `AGENTS.md`、项目测试命令和当前会话工具规则。

## 前置条件

- 当前目录必须是目标 Git 仓库。
- 需要可用的 `gh` CLI，并已登录目标 GitHub 账号。
- 不要覆盖用户未授权的本地改动；开始前检查 `git status --short`。
- 不要在需求不清时硬做；高风险或范围歧义先问用户。

## 工作流

### 1. 获取 issue 上下文

```bash
gh issue view <number> --json number,title,body,labels,comments,assignees,url
```

提取：

- 问题背景和目标用户影响。
- 验收标准、复现步骤、约束条件。
- 评论中的补充需求或变更。
- label 暗示的类型、优先级、影响区域。

### 2. 探索代码与制定最小计划

- 用 `rg`、测试文件、配置文件和现有实现定位影响面。
- 将验收标准拆成 3-7 个可执行步骤。
- 找到应运行的验证命令；没有现成命令时，先给出最小验证方式。
- 如果 issue 过大，建议拆分或只做当前 PR 的明确范围。

### 3. 创建或确认工作分支

如果当前不在合适分支：

```bash
git switch -c issue-<number>-<short-slug>
```

如已有用户改动，先确认是否与本 issue 相关；无关改动不得纳入提交。

### 4. 实现与验证

- 按最小计划修改代码。
- Bug fix 先复现或定位证据，再修根因。
- 有复发风险时补回归测试。
- 运行与本 issue 相关的测试、lint、build 或 smoke test。
- 对本 `mycodex` 仓库，默认验证命令是 `./scripts/linux/verify.sh`；对其他项目按项目文档执行。

### 5. 可选进度评论

只在长任务、阻塞或用户要求时评论 issue：

```bash
gh issue comment <number> --body "Progress: ..."
```

评论要短，说明已完成、阻塞点或下一步，不刷屏。

### 6. 提交与创建 PR

提交前再次检查：

```bash
git status --short
git diff --stat
```

提交示例：

```bash
git add <files>
git commit -m "fix: implement issue #<number>"
git push -u origin HEAD
```

PR body 必须包含：

```markdown
## Summary
- ...

## Testing
- ...

Closes #<number>
```

创建 PR：

```bash
gh pr create --title "<type>: <issue title>" --body-file <body-file>
```

## 输出要求

最终回复包含：

- Issue 和 PR 链接。
- 主要改动摘要。
- 已运行的验证命令和结果。
- 未完成项、风险或需要用户决策的点。

## 停止条件

遇到以下情况停止并说明：

- `gh` 无权限或无法读取 issue。
- 需求与现有本地改动冲突。
- 涉及敏感数据、鉴权、支付、数据迁移或公开 API 且需求不明确。
- 验证连续失败且无法定位根因。
- 需要用户决定拆分、延期或改变方案。
