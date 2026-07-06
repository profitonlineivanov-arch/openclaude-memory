---
name: Termux Dev Environment
description: Installed tools in Termux on Android — JDK 17, Android SDK (API 34), Python 3, Node.js 22, ffmpeg, yt-dlp, proot-distro
type: reference
---

Окружение Termux на Android (проверено 2026-06-02):

| Инструмент | Статус | Версия / Примечание |
|---|---|---|
| JDK | установлен | OpenJDK 17.0.19 |
| Android SDK | установлен | API 34, build-tools 34.0.0, platform-tools 37.0.0 |
| Python | установлен | (версия не проверена в сессии) |
| Node.js | установлен | 22 |
| ffmpeg | установлен | — |
| yt-dlp | установлен | 2026.7.4 (pip install --user, 2026-07-06) |
| git | установлен | SSH key auth к GitHub |
| gh CLI | установлен | v2.93.0 (pkg), не аутентифицирован — нет GitHub токена |
| adb | НЕ установлен | `adb: command not found` (2026-06-07). `pm install` тоже не работает (exit 255, нет прав). Для установки APK использовать `termux-open <.apk>` |
| OpenClaude | установлен | @gitlawb/openclaude 0.17.1 (npm global, обновлён 2026-06-06), обновлять через `npm install -g @gitlawb/openclaude@latest` |
| proot-distro | установлен | Ubuntu 24.04, JDK 17 внутри. НЕ подходит для сборки Android (aarch64, SDK tools = x86_64) |
| flang | установлен | 21.1.8 (LLVM Fortran), через apt. Нужен для сборки scipy и других Fortran-зависимых пакетов |
| tree-sitter | установлен | 0.26.9 (Termux pkg). Нужен для сборки tree-sitter Python-парсеров (parser.h C-заголовки). Также `tree-sitter` 0.25.2 через pip. |

**ANDROID_HOME**: `$HOME/android-sdk`
**JAVA_HOME**: `/data/data/com.termux/files/usr/lib/jvm/java-17-openjdk`

**Важно:** AAPT2 из Android SDK не работает в Termux (glibc vs Bionic). Сборка Android-проектов невозможна нативно — использовать GitHub Actions, AIDE, или proot Ubuntu.

**How to apply:** JDK + Android SDK установлены, но бесполезны для сборки. proot Ubuntu — запасной вариант. GitHub Actions — основной способ.

