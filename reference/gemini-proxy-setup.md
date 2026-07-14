---
name: Gemini proxy via settings.json
description: Google Gemini API геоблокирован в РФ — работает только через прокси, настроенный в settings.json env (HTTPS_PROXY + NO_PROXY)
type: reference
---

Google Gemini (`gemini-3-flash-preview`, profile `provider_1bb82ec04304`) геоблокирован из РФ — прямой запрос даёт `HTTP 400 "User location is not supported for the API use"`. Ключ валиден, не слит.

**Решение (2026-07-14):** env-переменные в `C:\Users\Admin\.claude\settings.json`:
- `HTTPS_PROXY` = HTTP-прокси с авторизацией (user:pass@host:port) — прокси-креды лежат в settings.json, не дублировать в memory
- `NO_PROXY` = `localhost,127.0.0.1,opengateway.gitlawb.com,api.deepseek.com,api.fireworks.ai,api.mistral.ai,integrate.api.nvidia.com,opencode.ai`

**Почему settings.json:** OpenClaude использует undici `EnvHttpProxyAgent` + `setGlobalDispatcher` — читает `HTTPS_PROXY` глобально, per-profile proxy НЕТ. `NO_PROXY` заставляет остальные провайдеры идти напрямую, через прокси идёт ТОЛЬКО `generativelanguage.googleapis.com`. Безопасно для всех остальных.

**Применяется при старте сессии** — текущая сессия не подхватит, нужен restart OpenClaude.

Бэкап: `C:\Users\Admin\.claude\settings.json.bak.20260714-202238`.

Если прокси умрёт/сменится — обновить `HTTPS_PROXY` в settings.json. Список хостов для NO_PROXY = все `baseUrl` из `providerProfiles` кроме googleapis (перечислить заново если добавится новый провайдер).
