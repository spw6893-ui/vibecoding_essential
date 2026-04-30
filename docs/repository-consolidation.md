# 仓库整合记录

## 结论

`/home/ppw/mycodex` 是唯一继续维护的主仓库。

`/home/ppw/ppw-codex-kit` 是早期仓库，职责是“镜像一份 codex-home 并安装到 ~/.codex”。它已经被 `mycodex` 取代，不再作为活跃维护源。

## 为什么保留 mycodex

- 结构更清晰：`skills/`、`refs/`、`docs/`、`scripts/`、`config/`。
- 活跃 skill 更新更多：包含 `gh-create-issue`、`heroui-pro`、`ui-ux-pro-max`、`harness` 等后续整理结果。
- 已隐藏 UI metadata：当前策略禁止 `skills/*/agents/openai.yaml`，避免用户页面暴露。
- 已记录候选来源：`superpowers`、`code-guardrails-skill`、`vibe-coding-cn` 等都已在 `docs/sources.md` 和 `docs/skills-capabilities.md` 中登记。

## 从 ppw-codex-kit 迁入的内容

- `config/config.example.toml`：安全的 Codex 配置示例。
- `scripts/bootstrap-external-repos.sh`：外部依赖仓库 bootstrap 脚本。
- 旧仓库职责说明和裁剪历史：整合进本文档、`docs/pruned.md`、`docs/sources.md`。

## 没有迁入的内容

- `codex-home/skills/`：旧 skill 镜像，包含过时内容和 `agents/openai.yaml`，不再迁回。
- `codex-home/references/vibe-coding-cn/`：当前 `refs/vibe-coding-cn/` 已覆盖并新增 `project-templates.md`。
- `codex-home/config/AGENTS.md`：当前全局 AGENTS 已由用户环境提供，不从旧仓库覆盖。
- 旧的 `manifests/`：信息已由 `README.md`、`docs/pruned.md`、`docs/skills-capabilities.md` 替代。

## 后续规则

- 新增 skill、refs、docs、scripts 均只进 `mycodex`。
- 安装只使用 `mycodex/scripts/install.sh`。
- 外部仓库只放 `mycodex/repos/`，保持 ignored，不提交嵌套 Git 历史。
- 如需要保留旧仓库，可改名为 `ppw-codex-kit.archived` 或只保留 README 指向 `mycodex`。
