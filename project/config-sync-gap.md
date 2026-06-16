---
name: Config sync BROKEN on Windows
description: sync.sh git_safe_pull fix (7bbed53) не деплоен на Windows + нет git auth → push не работает
type: project
---

**Статус (2026-06-16): СЛОМАНО на Windows.**

**Проблемы:**
1. **sync.sh с `git pull --rebase`** — старый sync.sh в working tree использует rebase, который зависает при конфликтах (stuck interactive rebase). Фикс (git_safe_pull с merge) есть в коммите `7bbed53`, но не деплоен в working tree — восстановлен через `git checkout 7bbed53 -- sync.sh`.
2. **Нет git auth на Windows** — remote HTTPS, но нет credential helper и SSH ключа (SSH ключ только на Termux). Push падает молча.
3. **Ollama-провайдеры не должны синхронизироваться** — .openclaude.json содержит "Ollama Local", который работает только на Windows. При sync.sh pull на Termux этот провайдер ломает `/provider`.

**Что синхронизируется (git-tracked в configs/):**
- `.openclaude.json` — провайдеры, API-ключи, статистика
- `settings.json` — хуки, плагины, модель, env
- `.openclaude-profile.json` — активный профиль
- `memory-sync.sh` — враппер

**Что НЕ синхронизируется:**
- `settings.local.json` — GitHub push protection блокирует (GH013)
- **Ollama провайдеры** — НЕ должны быть в .openclaude.json при пуше с Windows на GitHub, иначе Termux получает нерабочие провайдеры

**sync.sh fix (commit 7bbed53):**
```bash
git_safe_pull() {
    git fetch origin main 2>/dev/null
    if ! git merge --ff-only origin/main 2>/dev/null; then
        git merge --no-edit origin/main 2>/dev/null || true
    fi
}
```

**Что нужно сделать:**
- [ ] Настроить git auth на Windows (SSH ключ или token)
- [ ] Запушить исправленный sync.sh (с git_safe_pull) на GitHub
- [ ] Отфильтровать Ollama-провайдеры из .openclaude.json перед синхронизацией (или использовать device-specific конфиги)

**Why:** Пользователь работает на desktop (Windows) + mobile (Termux). Синхронизация должна быть автоматической и не ломать конфигурацию на другом устройстве.
**How to apply:** После настройки auth: запушить исправленный sync.sh. Рассмотреть фильтрацию Ollama из .openclaude.json перед push.
