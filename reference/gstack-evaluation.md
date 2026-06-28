---
name: gstack Evaluation
description: garrytan/gstack evaluated — not compatible with Termux/OpenClaude, but workflow patterns useful
type: reference
---

**gstack** (garrytan/gstack) — AI software engineering framework by Y Combinator CEO Garry Tan. 23+ specialist roles, structured pipeline Think→Plan→Build→Review→Test→Ship→Reflect. 116K+ stars on GitHub.

**Evaluated 2026-06-26 — verdict: NOT directly applicable in this environment.**

Reasons:
1. **Bun runtime** — gstack requires Bun (TypeScript runtime). Bun doesn't run on Termux (aarch64 Android, Bionic libc)
2. **Playwright + Chromium** — gstack uses headless Chromium for browser automation. Termux can't run glibc Chromium
3. **OpenClaude ≠ Claude Code** — gstack is built as Claude Code plugin (hooks into its tool call/state system). OpenClaude uses different provider architecture
4. **Server not feasible** — gstack daemon needs persistent Chromium process. Remote server 45.146.164.144 has no display/browser

**What IS usable:**
- Workflow concept (Think→Plan→Build→Review→Test→Ship→Reflect) — good discipline to apply manually
- Specialist checklist patterns — e.g., CEO review forcing questions, security review OWASP checklists, code review completeness gates
- Cross-model second opinion principle (gstack's `/codex` uses OpenAI Codex for independent review) — Bluesminds provider can serve same role
- User agreed to create OpenClaude skills (/review, /plan, /secaudit, /spec) based on gstack concepts — but fetching original prompts blocked by GitHub being inaccessible from Termux network. Need to write adapted versions from knowledge instead of copying 1:1.

**File:** https://github.com/garrytan/gstack
