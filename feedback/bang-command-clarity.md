---
name: `!` command clarity
description: User doesn't intuitively understand that `!` commands run in their terminal, not by AI
type: feedback
---

User expects commands listed in chat to be executed by me automatically, not typed with `!` prefix in their terminal.

**Why:** User said "Не понял, ты это сделал или я должен сделать?" (I don't understand, did you do it or should I?) when told to "вставь эти команды через `!`". The `!` convention is not obvious — user thought I had already run the commands.

**How to apply:** When giving multi-step instructions with `!` commands:
1. State explicitly: "Напиши **мне** эту команду с `!`" or "Введи в чат: `! команда`"
2. Or for single commands: ask "Дернуть `! команду`?" (offers to execute via their terminal)
3. Better yet: ask "Дёрнуть?" before providing the command — user just says "да"

**Cross-device scenario (2026-07-06):** User is on laptop, phone with Termux/OpenClaude is a separate physical device. When I say "вставь эти команды через `!`", user can't copy-paste across devices. Solutions:
- **Even short single commands are too much typing on phone** — user said "это не проще, это очень сложно" when asked to type one command. Default to laptop-side execution.
- Use ADB for what it CAN do: push scripts/files to `/sdcard/Download/`, then send to Termux via `input text` (unreliable — key events may not reach terminal properly)
- Use ADB via `am startservice com.termux/.app.RunCommandService` (requires RUN_COMMAND permission, fails on non-rooted devices)
- Best: ask "Дёрнуть с телефона или сделать с ноутбука?" to clarify context first
