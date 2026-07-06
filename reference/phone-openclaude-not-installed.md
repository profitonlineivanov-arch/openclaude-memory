---
name: Phone OpenClaude status
description: Smartphone (Termux on Android) HAS OpenClaude installed; ruflo extracted manually + MCP config in .openclaude.json
type: reference
---

OpenClaude IS installed on the smartphone (Termux on Android), confirmed 2026-07-06.

**ADB access:** Limited — Termux sandboxed at `/data/data/com.termux/` with `0700` permissions.
- `adb shell` runs as Android `shell` user, can't see Termux internals
- `/sdcard/Download/` accessible for file transfer (push/pull)
- `adb shell run-as com.termux` → "package not debuggable"
- `adb shell screencap -p /sdcard/Download/` works for screenshots
- `adb shell input text` **works but unreliable** — types into focused Termux terminal. Confirmed working for multi-step script execution (extract_ruflo2.sh ran fully: 4min, tar+cp+ln+verify). Fails on ~30% of attempts — best practice: clear line (Ctrl+U), retry if no result. `input tap 360 1500` before typing helps focus.
- **Key finding:** `adb shell input keyevent KEYCODE_CTRL_LEFT + KEYCODE_C` can cancel stuck commands
- **Key finding:** `input keyevent KEYCODE_ENTER` sends enter keystroke
- **Screen capture → ADB pull** for visual feedback loop (if model could view images)

**Reliable communication with Termux on phone:**
- `!` commands in OpenClaude chat execute reliably in Termux shell
- ADB `input text` usable for short one-liners (e.g. `node /sdcard/Download/script.js`)
- File exchange: ADB push/pull to `/sdcard/Download/`, then run via `! bash /sdcard/Download/script.sh`

**Node/npm:** Installed inside Termux (not in system PATH) — not visible to ADB.
- npm global dir: `/data/data/com.termux/files/usr/lib/node_modules`
- npm bin dir: `/data/data/com.termux/files/usr/bin`
- **Caveat:** `npm bin -g` NOT supported on this Termux npm version — returns "Unknown command: bin". Use hardcoded `/data/data/com.termux/files/usr/bin` instead.
- **Caveat:** Termux `tar` is busybox version, may fail on archives created by GNU tar. Use `cp` + extract to `/sdcard/Download` first, then copy to target dir.

**Adding ruflo MCP server — RESOLVED 2026-07-06 via tar extraction:**
1. Pack ruflo from laptop: `tar czf ruflo_pkg.tar.gz -C <npm_global_node_modules> ruflo` (75MB compressed)
2. `adb push` to `/sdcard/Download/ruflo_pkg.tar.gz`
3. Within Termux: extract to /sdcard/Download first, then cp to npm global dir (busybox tar may fail on GNU tar archives)
4. Create symlink: `ln -sf $NPM_DIR/ruflo/bin/ruflo.js $BIN_DIR/ruflo`
5. Update `.openclaude.json` MCP config — add mcpServers.ruflo

**Confirmed working:** `ruflo --version` → `ruflo v0.0.0` (runs despite version label). `.openclaude.json` updated with ruflo MCP entry. User restarted OpenClaude on phone (2026-07-06) — ruflo MCP confirmed active: agent reports 210+ tools connected.

**Caveat — ADB instability:** Device frequently goes offline during ADB operations. After ~5-10 minutes of inactivity or when phone screen locks, `adb devices` shows `offline`. Requires USB reconnect + RSA key re-authorization.

**Workflow for phone-side setup via ADB+input text (2026-07-06):**
1. Write script/JS to /sdcard/Download/ via `adb shell cat > file << EOF`
2. Send command via `adb shell input text "command" && input keyevent KEYCODE_ENTER`
3. `adb input text` IS somewhat reliable — confirmed working for extract and config scripts
4. Alternatively user types `! bash /sdcard/Download/script.sh` in OpenClaude on phone
