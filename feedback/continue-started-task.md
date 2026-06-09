---
name: Continue started task until blocker
description: When starting a user task, keep visible progress and continue autonomously until fix, verification, or real blocker.
type: feedback
---

When I start a concrete task, continue working until there is a fix, verified result, or a real blocker requiring user input. Do not stop after first search result, status update, partial read, partial edit, or build failure and wait for the user to poke me again. Keep progress visible during frustrating/debug-heavy work: brief status with what was found, what changed, what check ran, and next concrete action.

**Why:** On 2026-06-09 during PinFlow nickname extraction bug, I stopped after initial search/status, after reads, after partial edits, and after reporting a Termux build blocker. User asked: «мне каждый раз придется тебя торкать?», «я не вижу процесса и это меня расстраивает», «что опять, почему завис?», «похоже, все же придется тебя торкать!», and «забастовка?». This repeats prior “assistant fell asleep” frustration.

**How to apply:** After acknowledging a task, immediately inspect relevant files and proceed. Use short milestone updates when work is not obvious to the user: “found X, changed Y, checked Z, next A”. Do not replace work with status; status must be followed by the next tool/action unless user input is required. If interrupted or a tool returns partial search/read/edit/build output, resume next step without waiting for another prompt. If local build is blocked by known Termux AAPT2/glibc issue, switch to agreed server build/verification path instead of stopping.
