---
name: Do it yourself — user rejects manual steps
description: When told to type commands, user says "делай сам, находи тулсы/плагины" — insists AI solve everything autonomously
type: feedback
---

User explicitly rejects being told to type commands manually on the phone.

**Why:** User finds typing commands on phone cumbersome, especially multi-step sequences. Each manual step risks errors (path translation, escaping, wrong window focus). User prefers AI to handle everything transparently.

**Incidents:**
1. 2026-07-06: "Не получается у меня ничего. Делай сам все. Находи тулсы, плагины какие-либо, но задачу нужно тебе выполнить самомому." → After multiple failed attempts to type `bash /sdcard/Download/*.sh` commands.
2. 2026-07-06: "Не лезь в телефон, там своя настройка" → When I tried to check phone's config via ADB/input text after user wanted session sync.
3. 2026-07-06: "Я не должен производить отдельных команд" → When explaining session sync needs settings.json hooks.
4. 2026-07-06: "Трудно в памяти посмотреть???" → User furious when I asked to confirm details that were ALREADY documented in memory files. Lesson: READ MEMORY FIRST. Don't ask user to re-confirm what's already persisted.

**ADB input text reliability (2026-07-06):**
`adb shell input text` — CONFIRMED UNRELIABLE for Termux commands. Multiple attempts showed ~50% miss rate even with `input tap` + `input text` + KEYCODE_ENTER sequence. Phone screen state, soft keyboard interfering, or Termux session state causes intermittent failures.

**Workarounds that work:**
- `adb push` files to `/sdcard/Download/` — 100% reliable
- `adb shell` read/write — 100% reliable
- `am start` to focus Termux activity — reliable
- `input tap` + `input text` — ~50% success, improve with multiple attempts
- User typing single `! command` in phone OpenClaude — 100% reliable (but requires user action — avoid)

**How to apply:** Default approach for phone operations: write script to `/sdcard/Download/`, send via `input text` once, check result. If failed — retry with `am start` focus + tap. If still failed after 2 attempts — accept limitation and present user ONE command. Do not keep retrying.

**Escalation:** If user says "не получается" or "сложно" about phone-side steps — pivot immediately to a fully autonomous approach. Do not suggest manual workarounds again in this session.

**Corollary:** When user says "не лезь в телефон" — focus entirely on the laptop/server side. The phone has its own OpenClaude instance with its own configuration. Respect device boundaries.
