---
name: AI Free Setup
description: AI Free (Staks-sor/ai-free) установлен как бесплатный OpenAI-compatible провайдер для OpenClaude (2026-07-07)
type: project
---

## AI Free — бесплатный провайдер

**Репо:** https://github.com/Staks-sor/ai-free (v0.3.5)

**Что это:** OpenAI/Anthropic-compatible API на localhost:4318 через браузерные сессии DeepSeek/Qwen/ChatGPT. Бесплатно, без API-ключей.

**Установка:**
1. `git clone https://github.com/Staks-sor/ai-free.git ~/ai-free`
2. `cd ~/ai-free && npm install`
3. `npm run login` (DeepSeek), `npm run login-qwen` (Qwen)
4. `npm run api` → API на http://127.0.0.1:4318/v1

**Провайдеры в OpenClaude (ДОБАВЛЕНЫ 2026-07-09):**
- "AI Free — DeepSeek" (id: provider_ai-free-deepseek) — deepseek-v4-pro
- "AI Free — Qwen" (id: provider_ai-free-qwen) — qwen3.7-max

**Автозапуск (НАСТРОЕН 2026-07-09):** hook в settings.json → SessionStart проверяет localhost:4318, если не отвечает — запускает `npm run api` через PowerShell (Start-Process -WindowHidden). Путь: `C:\Users\Admin\ai-free\`.

**Cookies:** `~/.deepseek-cli/auth.json`, `~/.qwen-cli/auth.json`. Протухают раз в несколько недель — `npm run login` / `npm run login-qwen` обновляет.

**Why:** Пользователь хочет бесплатные модели для тяжёлых задач, где токены жалко.
**How to apply:** При вопросах о стоимости/лимитах — предлагать AI Free как альтернативу. Переключение через /provider.
