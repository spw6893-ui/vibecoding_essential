---
name: gh-pr-review
description: 用 gh CLI 审查 GitHub PR、检查 CI、定位问题并按需修复。触发于用户要求 review PR #N、检查/合并 PR、review issue:N 批量 PR；使用 Codex 代码审查格式和验证前置，不依赖 codeagent。
---

# GitHub PR Review

对 GitHub PR 做工程化审查、CI 分析和必要修复。默认先审查和验证，不自动合并；只有用户明确要求 merge 时才执行合并。

## 前置条件

- 当前目录必须是目标 Git 仓库。
- 需要可用的 `gh` CLI，并已登录目标 GitHub 账号。
- 开始前检查 `git status --short`，不要混入无关本地改动。
- 对外部贡献者 PR，谨慎运行不可信脚本；优先读 diff、读 CI 日志。

## 输入模式

- 单 PR：`#123`、`PR 123`、`review PR #123`。
- Epic 批量：`issue:45`，从 epic/sub-issue 中找关联 PR。
- 未提供编号：先用 `gh pr list --json number,title,author,updatedAt,state` 列出候选并让用户选择。

## 单 PR 工作流

### 1. 获取 PR 上下文

```bash
gh pr view <number> --json number,title,body,author,baseRefName,headRefName,mergeable,mergeStateStatus,url
gh pr diff <number>
gh pr checks <number> --watch
```

如 PR body 包含 `Closes #N`、`Fixes #N`，再读取关联 issue：

```bash
gh issue view <number> --json title,body,comments,labels,url
```

### 2. 代码审查

如需要本地查看文件，先 checkout PR：

```bash
gh pr checkout <number>
git status --short
```

checkout 后仍要保护本地未授权改动；如果出现冲突或脏工作区，停止并说明。

按 code review mindset 输出发现，优先找：

- 正确性：逻辑错误、边界条件、空值、状态竞争。
- 安全：鉴权、输入校验、敏感数据、注入、权限扩大。
- 兼容性：API/DB schema/配置/迁移/公开行为变化。
- 测试：缺少回归测试、只测 happy path、CI 未覆盖。
- 可维护性：职责混杂、重复实现、异常处理缺失。
- PR 合约：是否满足 issue 的 acceptance criteria、Definition of Done、rollout/migration notes。

严重度：

- `Critical`：必须修复，可能导致安全/数据/生产事故。
- `High`：明显 bug、回归或 CI 阻塞。
- `Medium`：测试缺口、可维护性风险。
- `Low`：小改进，不阻塞合并。

### 3. CI 分析

如 checks 失败，读取失败日志：

```bash
gh run view <run-id> --log-failed
```

先按 `AGENTS.md` 系统排障规则定位根因，不猜测式修复。

### 4. 修复策略

默认只审查，不直接改 PR。只有用户要求“修掉/帮我改/merge 前处理”时：

- checkout PR 分支或创建本地修复分支。
- 一次修一个根因，补测试。
- 运行相关验证。
- 提交并 push 到允许写入的分支；无权限时给 patch 建议。
- 连续 3 次修复失败，停止并汇报卡点。

修复提交前必须：

```bash
git diff --check
git status --short
```

### 5. Review 输出

如果只是审查，最终回复按以下顺序：

- Findings：按严重度排序，含文件/行号或 diff 位置。
- Open questions：只有真实需要确认时列出。
- Verification：说明已查看的 PR 信息、CI 状态、是否运行本地测试。
- Summary：简短说明总体结论。

如果需要在 GitHub 上提交 review：

```bash
gh pr review <number> --comment --body-file <review-body>
```

Review body 建议结构：

```markdown
## Review Summary

## Findings
- [High] file:line - ...

## Verification
- `gh pr checks <number> --watch`
- local tests: ...

## Recommendation
- Request changes / Comment / Approve
```

只有用户明确要求 approve 时，且没有阻塞问题、CI 通过或用户接受风险，才：

```bash
gh pr review <number> --approve --body-file <review-body>
```

## Epic 批量模式

对 `issue:N`：

- 读取 epic issue。
- 从 body/comments 中找 `#123`、`Closes #123`、sub-issue 清单。
- 对每个 sub-issue 查关联 PR：

```bash
gh pr list --search "linked:issue:<sub-issue>" --json number,title,state,url
```

- 逐个 PR 执行单 PR 工作流。
- 最终给出表格：sub-issue、PR、CI、review 结论、是否阻塞。

## 合并规则

只有用户明确要求 merge 才合并。合并前必须确认：

- 阻塞 findings 已解决或用户明确接受。
- CI 通过，或失败原因被用户明确豁免。
- 无 merge conflict。
- merge strategy 明确；默认 squash。
- PR 不是 draft，或用户明确要求合并 draft 之外的等价流程。
- 本地没有待提交修复。

执行：

```bash
gh pr merge <number> --squash --delete-branch
```

## 停止条件

- `gh` 无权限或 PR 不可访问。
- PR diff 太大，需要分批审查。
- CI 日志不足以定位，需要用户授权或更多信息。
- 合并存在冲突、权限不足或策略不明确。
- 发现安全/数据高风险问题，必须先让用户确认处理方向。
