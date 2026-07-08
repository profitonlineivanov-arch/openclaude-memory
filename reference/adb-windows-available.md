---
name: ADB available on Windows
description: ADB installed at /d/Programs/Android/Sdk/platform-tools/adb on this Windows machine; device shows offline until RSA key confirmed on phone
type: reference
---

ADB (`Android Debug Bridge`) is available on this Windows laptop at `/d/Programs/Android/Sdk/platform-tools/adb` (part of Android SDK).

When smartphone connected via USB:
- Initial state: **offline** (device detected but ADB daemon not started)
- After `adb kill-server && adb start-server`: **unauthorized** (RSA key not yet confirmed)
- Confirm "Разрешить отладку по USB?" dialog on phone → state becomes **device**
- Files accessible via `adb shell` and `adb pull` after authorization

Useful for transferring files from phone's Download folder (e.g. Wikipedia broken links scan results), accessing app logs, etc. without user manually copying files.

This is a Windows-side capability — Termux on Android does NOT have ADB (see `feedback/device-log-access-termux.md`).

User may need guidance to check phone screen for RSA authorization dialog when state shows "unauthorized".

**ADB does NOT have access to Termux internals** — crucial limitation discovered 2026-07-06:
- ADB shell runs as `/system/bin/sh` (Android system shell), NOT Termux's shell
- `adb shell run-as com.termux` → **"package not debuggable"** (Termux is not a debug build)
- `/data/data/com.termux/files/usr/bin/node` → **Permission denied** (sandboxed app data)
- Node/npm NOT in system PATH — they exist only inside Termux sandbox
- Cannot install npm packages or manage OpenClaude on phone via ADB
- **Conclusion**: Any Termux-side setup (installing ruflo, openclaude, node packages) requires user to open Termux app and type commands directly. ADB can only access `/sdcard/Download/` (shared storage) — not Termux's app data.

**MSYS2/Git Bash path translation issue**: when running ADB from Git Bash, paths starting with `/` get auto-translated to Windows paths (e.g. `/sdcard/Download/` becomes `C:/Program Files/Git/sdcard/Download/`). Fixes:
- `adb shell` commands: use single quotes — `adb shell 'ls /sdcard/Download/'`
- `adb pull`/`adb push`: prefix with `MSYS_NO_PATHCONV=1` — `MSYS_NO_PATHCONV=1 adb pull /sdcard/Download/file.txt "C:/Users/Admin/Desktop/"`

**ADB input text works but unreliable for Termux (2026-07-06):** `adb shell input text "command"` CAN successfully type into Termux terminal — confirmed working for `bash /sdcard/Download/extract_ruflo2.sh` (full log with extract/copy/link/verify completed, 4min run). But reliability is inconsistent: same command format sometimes delivers, sometimes doesn't. Key events between keystrokes may get eaten by Android's input system when phone is mid-operation.

**Best practice for ADB input text:**
- Send in separate ADB calls: first `input keyevent KEYCODE_ENTER` (to get fresh prompt), then `input text "command"`, then `input keyevent KEYCODE_ENTER`
- Tap first: `input tap 360 1500` (screen center-bottom) before typing helps focus terminal
- Ctrl+U to clear line before new command: `input keyevent KEYCODE_CTRL_LEFT && input keyevent KEYCODE_U`
- Use `input keyevent KEYCODE_ENTER` as a separate command call, not chained with &&
- Keep commands short and without special characters

ADB remains most reliable for: file transfer to `/sdcard/Download/`, screenshots (`screencap`), and system-level commands. For Termux-side operations, `!` commands in OpenClaude chat are the most reliable path when user has Termux open.
