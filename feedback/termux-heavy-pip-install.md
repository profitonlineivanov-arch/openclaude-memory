---
name: Heavy pip install in Termux
description: How to install large Python packages on Termux — use --user + extended timeout + background; for Fortran deps (scipy), install flang from Termux repo first
type: feedback
---

При установке тяжёлых Python-пакетов в Termux (с большими зависимостями вроде tree-sitter парсеров, rapidfuzz, scipy) использовать:
`pip install --timeout 300 --retries 10 --user <package>` + запускать через `run_in_background: true`.

**Why:** Мобильная сеть в Termux нестабильна — pip таймаутится при скачивании с PyPI, а не в самой компиляции. `--user` нужен чтобы пакет не конфликтовал с системным site-packages Termux. Фоновый режим обязателен — обычные pip-установки тяжёлых пакетов занимают 10-30+ мин, что превышает 2-минутный лимит Bash tool.

**ВАЖНОЕ ОГРАНИЧЕНИЕ (обновлено 2026-06-07):** Если пакет зависит от **scipy** (или другого Fortran-зависимого пакета), нужно ПРЕДВАРИТЕЛЬНО установить Fortran-компилятор: `apt install flang` (flang есть в репо Termux). Без flang scipy упадёт с `metadata-generation-failed`. До 2026-06-07 считалось, что Fortran-зависимости — непреодолимый блокер в Termux, но `apt-cache search flang` показал, что flang доступен.

**How to apply:**
- Пакеты **без** Fortran-зависимостей: `--user --timeout 300 --retries 10` + background — работает
- Пакеты **с** scipy/numpy/Fortran-зависимостями: сначала `apt install flang`, затем `pip install --user --timeout 300 --retries 10 <pkg>` в фоне
- Проверить наличие flang: `apt-cache search flang` — если есть в репо, установить; если нет, предложить proot-distro Ubuntu

**Tree-sitter C-заголовки (обновлено 2026-06-07):** Если при установке Python-пакетов tree-sitter-* (cpp, java, etc.) возникает `fatal error: 'tree_sitter/parser.h' file not found`:
1. Установить системный tree-sitter: `apt install tree-sitter` (даёт `tree_sitter/api.h`)
2. Создать compat-заголовок: `cp /data/data/com.termux/files/usr/include/tree_sitter/api.h /data/data/com.termux/files/usr/include/tree_sitter/parser.h`
3. **Ограничение:** Старые tree-sitter парсеры (<0.22 API) используют устаревшие макросы (`TSLexer`, `START_LEXER`, etc.), которых нет в api.h 0.26 — такие парсеры не соберутся даже с compat-заголовком. Нужен реген грамматик мейнтейнерами.
