---
name: pinflow-project
description: PinFlow — Android Pinterest automator. Build via GitHub Actions (AAPT2 fails in Termux). GitHub repo + local clone.
type: project
---

PinFlow — Android Pinterest automator (Kotlin, Room DB, WorkManager, OkHttp3, Jsoup).

## Репозиторий
- **GitHub**: https://github.com/profitonlineivanov-arch/pinflow (private, SSH key auth)
- **Local clone**: ~/pinflow/ (на телефоне Termux)
- **Старый путь**: E:/sites/apps/PinFlow/ (Windows, устарел)

## Функциональность
Автопостинг, автолайки, автоподписки, автоотписки, расписание, spintax, WebView-based auth, foreground service, boot receiver.

## Сборка APK
- **AAPT2 не работает в Termux** — бинарник собран для glibc, Termux использует Bionic. Нативная сборка невозможна.
- **JDK 17 + Android SDK (API 34)** установлены в Termux, но не могут использоваться для финальной сборки.
- **GitHub Actions workflow**: `.github/workflows/build.yml` — собирает debug APK при ручном запуске (workflow_dispatch). Запушено в master.
- **Actions page 404**: репозиторий приватный — нужно быть залогиненым в GitHub в браузере, иначе Actions не виден.
- **proot-distro + Ubuntu** установлены в Termux, но Android SDK tools (sdkmanager, AAPT2) — бинарники x86_64, а proot на телефоне работает в aarch64. Сборка через proot тоже невозможна.
- **Удалённый сервер** 45.146.164.144 недоступен (SSH timeout, 2026-06-02) — не вариант для сборки.
- **Нет gh CLI** на телефоне, API-токен не настроен.
- **AIDE (Android IDE)** — вариант для сборки APK прямо на телефоне через GUI (не опробован).

## Статус
2026-06-02: Клонирован из GitHub, создан CI workflow, запушен в master. Сборка в Termux невозможна (AAPT2 + aarch64). proot Ubuntu тоже не подходит (SDK tools = x86_64). Единственный рабочий путь — GitHub Actions (нужен логин в браузере) или AIDE.

**Why:** Пользователь хочет установить приложение на телефон. Не разбирается в Linux/Termux internals, предпочитает простые GUI-решения.
**How to apply:** Предлагать GUI-варианты (AIDE, Actions в браузере) вместо CLI-подходов. Избегать сложных терминов вроде proot, glibc, Bionic.
