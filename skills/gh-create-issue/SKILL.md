---
name: gh-create-issue
description: 用 gh CLI 从 PRD、产品需求或用户描述创建 GitHub issue。自动判断简单 issue 还是 epic + sub-issues，适合需求拆解、验收标准、优先级、依赖关系和 PM 级任务管理。
---

# GitHub Issue Creator

Create structured GitHub issues with automatic complexity assessment and PM-level task breakdown.

## Purpose

Transform requirements or PRD documents into well-structured GitHub issues. For simple tasks, create a single focused issue. For complex tasks, create an epic issue with properly scoped sub-issues, complete with labels, priorities, and dependency tracking.

## When to Use

Trigger this skill when:
- User provides a PRD document or feature requirements
- User requests "create issue for [description]"
- User asks to break down a complex feature into trackable tasks
- User mentions "epic", "sub-issues", or "task breakdown"

## Workflow

### Phase 0: Repository & Label Readiness

Before creating issues:

1. Verify repository context:
   ```bash
   gh repo view --json nameWithOwner,url
   git remote -v
   ```
2. Check existing labels to avoid duplicates or incompatible naming:
   ```bash
   gh label list --limit 100
   ```
3. Create missing standard labels only when needed; if the repo uses a different taxonomy, follow the repo's existing labels.

Issue bodies should be implementation-ready for `gh-issue-implement` and review-ready for `gh-pr-review`.

### Phase 1: Complexity Assessment

Analyze the request to determine task complexity:

**Simple Task Indicators:**
- Single feature or bug fix
- Affects 1-3 files
- Clear acceptance criteria
- No cross-team dependencies
- Completable in one session

**Complex Task Indicators:**
- Multiple features or architectural changes
- Affects 4+ files or services
- Cross-team coordination needed
- Unclear requirements or multiple approaches
- Needs phased rollout

**Decision:** If 2+ complex indicators present, proceed with Epic mode. Otherwise, use Simple mode.

### Phase 2A: Simple Issue Creation

For simple tasks:

1. **Gather Requirements**：
   - Problem statement and user impact
   - Expected outcome and scope
   - Acceptance criteria (testable)
   - Technical constraints

2. **Structure Issue:**
   ```markdown
   ## Problem Statement
   [Why this matters and who is impacted]

   ## Proposed Solution
   [High-level approach]

   ## Acceptance Criteria
   - [ ] [Testable criterion 1]
   - [ ] [Testable criterion 2]

   ## Implementation Notes
   - Suggested files/components:
   - Suggested verification:
   - Rollout/migration notes:

   ## Technical Notes
   [Constraints, dependencies, risks]

   ## Definition of Done
   - [ ] Acceptance criteria are met
   - [ ] Tests or verification commands are documented
   - [ ] Docs/config updates are included if needed
   ```

3. **Create Issue:**
   ```bash
   gh issue create --title "[Type] Brief description" \
     --body "<markdown body>" \
     --label "type:feature,priority:p1"
   ```

4. Return the created issue URL.

### Phase 2B: Epic Issue Creation

For complex tasks:

1. **Requirements Discovery:**
   - 如关键信息缺失，直接向用户提出最多 2 个必要澄清问题；能合理推断时先按假设推进，并在 issue 中标注假设
   - Identify affected components and teams
   - Define success metrics
   - Load `references/pm-methodology.md` for detailed guidance

2. **Task Decomposition:**
   - Break down into independently deliverable sub-tasks
   - Each sub-task should be completable in 1-3 days
   - Identify dependencies between sub-tasks
   - Assign priorities (P0/P1/P2/P3)

3. **Create Epic Label:**
   ```bash
   # Generate unique epic identifier
   EPIC_NAME="epic:$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | cut -c1-20)"
   gh label create "$EPIC_NAME" --description "Epic: $TITLE" --color "0366d6" || true
   ```

4. **Create Epic Issue:**
   ```markdown
   ## Overview
   [High-level description]

   ## Goals
   - [Primary goal]
   - [Secondary goals]

   ## Sub-Issues
   [Will be populated after sub-issues are created]

   ## Success Criteria
   - [Measurable outcome 1]
   - [Measurable outcome 2]

   ## Dependency Order
   [Blocking order and parallelizable work]

   ## Technical Notes
   [Architecture decisions, constraints, risks]

   ## Definition of Done
   - [ ] All linked sub-issues are closed
   - [ ] Final integration verification passes
   - [ ] Release/rollout notes are documented
   ```

   ```bash
   EPIC_NUMBER=$(gh issue create --title "[Epic] $TITLE" \
     --body "<markdown body>" \
     --label "epic,priority:p1" \
     --json number -q .number)
   ```

5. **Create Sub-Issues:**
   For each sub-task:
   ```bash
   gh issue create --title "[Sub-task] $SUBTASK_TITLE" \
     --body "Part of #$EPIC_NUMBER\n\n$SUBTASK_BODY" \
     --label "$EPIC_NAME,type:feature,priority:p2"
   ```

   Track created sub-issue numbers.

   Each sub-issue body should include:
   - Parent epic link: `Part of #$EPIC_NUMBER`
   - Scope boundary and non-goals
   - Acceptance criteria
   - Suggested verification command
   - Dependencies: `Blocked by #N` or `Can run in parallel`

6. **Update Epic with Sub-Issue Links:**
   ```bash
   # Build sub-issues list
   SUB_ISSUES_LIST="## Sub-Issues\n"
   for issue in $SUB_ISSUE_NUMBERS; do
     SUB_ISSUES_LIST+="- [ ] #$issue - [Title] (Priority, Dependencies)\n"
   done

   # Update epic body
   gh issue edit $EPIC_NUMBER --body "<updated markdown with sub-issues>"
   ```

7. Return epic URL and summary of created sub-issues.

### Phase 3: Validation

Before finalizing:
- Verify all issues have clear acceptance criteria
- Confirm dependencies are documented
- Ensure labels are appropriate
- For epics: validate sub-issue scope and order
- Confirm each issue has enough detail for `gh-issue-implement` to start without rereading the original PRD
- Confirm review/merge expectations are visible enough for `gh-pr-review`

## Output Contract

Final response should include:

- Created issue URLs.
- For epic mode: parent epic URL plus sub-issue table with priority and dependency.
- Assumptions recorded in the issue body.
- Suggested next command, usually `implement issue #N` or `review PR #N` after implementation.

## Label Strategy

**Standard Labels:**
- `epic` - Parent issue
- `epic:<name>` - Links sub-issues to epic
- `priority:p0/p1/p2/p3` - Priority level
- `type:feature/bug/enhancement/refactor` - Issue type
- `area:<component>` - Affected codebase area

Create labels as needed:
```bash
gh label create "priority:p1" --description "High priority" --color "d93f0b" || true
```

## Error Handling

- If `gh` command fails, surface stderr and stop
- If requirements are unclear, ask concise clarification questions; if safe, proceed with explicit assumptions
- If epic creation fails, fall back to simple issue mode
- Maximum 2 clarification rounds before proceeding with best assumptions

## References

For detailed PM methodology, task breakdown strategies, and prioritization frameworks, refer to `references/pm-methodology.md`.
