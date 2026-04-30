# Long Examples

## 用例 1：巡检 + 自动救援脚本（bash）

```bash
#!/usr/bin/env bash
# 巡检所有窗口，标注输出并对 (y/n) 提示自动回车
set -euo pipefail

for w in $(tmux list-windows -a -F '#S:#I'); do
  panes=$(tmux list-panes -t "$w" -F '#S:#I.#P')
  for p in $panes; do
    log=$(tmux capture-pane -t "$p" -p -S -80)
    printf '--- [%s] ---\n%s\n' "$p" "$log"
    if echo "$log" | grep -qi "(y/n)"; then
      tmux send-keys -t "$p" "y" Enter
      echo "[action] sent y to $p"
    fi
  done
done
```
- 运行：保存为 `scan_and_rescue.sh`，`chmod +x` 后执行；建议放在 commander 窗口运行。
- 验收：匹配的 pane 自动继续，其他 pane 不受影响。

## 用例 2：批量录制 + 审计

```bash
#!/usr/bin/env bash
# 对 ai-hub 会话所有 pane 开启 pipe-pane 记录
set -euo pipefail

for p in $(tmux list-panes -a -F '#S:#I.#P #{session_name}' | awk '$2=="ai-hub"{print $1}'); do
  tmux pipe-pane -t "$p" -o "cat >> /tmp/${p//[:.]/-}.log"
done
echo "audit pipes enabled under /tmp/*-ai-hub-*.log"
```
- 用于长跑任务或多 AI 协作时保留证据；任务结束后记得 `tmux pipe-pane -t <p> -o cat` 关闭。

## 用例 3：刷新 oh-my-tmux 参考资料

> 目的：在需要更全面文档时，查看本地固定版本的上游仓库更新，再手动筛选稳定内容进 `references/`。

```bash
repo_root="$(git rev-parse --show-toplevel)"
git -C "$repo_root/assets/repos/.tmux" fetch --all --tags --prune
git -C "$repo_root/assets/repos/.tmux" log --oneline -5
git -C "$repo_root/assets/repos/tmux" fetch --all --tags --prune
git -C "$repo_root/assets/repos/tmux" log --oneline -5
```
- 只把稳定、可验证、常用的快捷键/配置项手工合并到 `references/api.md` 或 `references/troubleshooting.md`，不要直接导入整份上游 README。

## 用例 4：多 AI 工作台一键启动（命令行版）

```bash
tmux new-session -d -s ai-hub -n commander 'bash'
for w in worker1 worker2 worker3; do
  tmux new-window -t ai-hub -n "$w" 'kiro-cli chat'
done
tmux select-window -t ai-hub:commander
tmux attach -t ai-hub
```
- 进入后执行用例 1 的巡检脚本即可形成「指挥+工人」模式。
