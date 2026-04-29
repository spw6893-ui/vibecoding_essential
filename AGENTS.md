# mycodex 协作规则

本仓库是 PPW 的个人 Codex 配置与技能仓库。

## 修改规则

- 默认中文说明和中文文档。
- 技能数量宁少勿多，新增前先判断是否可以并入现有 skill。
- 活跃 skill 放 `skills/<name>/SKILL.md`。
- 长参考资料放 `skills/<name>/references/` 或 `refs/<source>/`。
- 不提交 `auth.json`、`.env`、SQLite、日志、shell 快照。
- 修改后运行 `./scripts/verify.sh`。

## 提交规则

- 使用语义化提交信息。
- 一次提交只做一类变更：新增 skill、裁剪 skill、更新资料、脚本调整。

