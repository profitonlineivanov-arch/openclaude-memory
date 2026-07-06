---
name: Sync only sessions, not memory/configs
description: GitHub sync scope narrowed — only session data, no .md memory, no device-specific configs/models (2026-07-06)
type: feedback
---

**Sync scope change (2026-07-06):** Memory (.md) sync via GitHub should be replaced with session-only sync.

**Why:** User has different local setups on phone (gemma2:2b + qwen3:4b via Ollama, no GPU, Termux) and laptop (qwen2.5:7b, RTX 3050, Windows). Memory files about local provider setup, model configs, device-specific setup DON'T apply cross-device. Syncing them creates merge conflicts and noise.

**User requirement (2026-07-06):** Start session on phone → close → continue on laptop → resume on phone. Full session continuity across devices.

**Session storage layout:**
- `~/.openclaude/sessions/<pid>.json` — metadata (pid, sessionId, cwd, startedAt, status, updatedAt)
- `~/.openclaude/history.jsonl` — ALL conversation history across ALL sessions (1482 lines, 363KB). Single monolithic file — merge conflict risk on concurrent writes
- `~/.openclaude/session-env/<uuid>/` — 73 dirs, all empty, not used

**How to apply:**
- Device-specific memory (Ollama local providers, platform-specific feedback) — keep local only, don't push to shared GitHub
- Only session/conversation state should sync between devices
- Implement OpenClaude session export/import via shared git repo
- Existing merge conflict in memory repo — resolve by keeping phone-side (HEAD) version

**Approach options (pending user choice):**
- Git branch per device — each device writes own branch, shared sessions in separate files
- Export/import individual sessions — before close, export to JSON → git push → on other device git pull → restore
- Ruflo session MCP tools — session_export, session_import, session_save, session_restore available