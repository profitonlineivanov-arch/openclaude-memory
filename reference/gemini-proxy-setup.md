---
name: Gemini proxy via settings.json
description: Google Gemini API геоблокирован в РФ — работает только через прокси, настроенный в settings.json env (HTTPS_PROXY + NO_PROXY)
type: reference
---

Google Gemini (`gemini-3-flash-preview`, profile `provider_1bb82ec04304`) геоблокирован из РФ — прямой запрос даёт `HTTP 400 "User location is not supported for the API use"`. Ключ валиден, не слит.

**Решение (2026-07-14):** env-переменные в `C:\Users\Admin\.claude\settings.json`:
- `HTTPS_PROXY` = HTTP-прокси с авторизацией (user:pass@host:port) — прокси-креды лежат в settings.json, не дублировать в memory
- `NO_PROXY` = `localhost,127.0.0.1,opengateway.gitlawb.com,api.deepseek.com,api.fireworks.ai,api.mistral.ai,integrate.api.nvidia.com,opencode.ai`

**Как работает:** `configureGlobalAgents()` в cli.mjs вызывает `setGlobalDispatcher(getProxyAgent(proxyUrl))` — глобальный undici dispatcher для ВСЕХ запросов (axios + fetch). `generativelanguage.googleapis.com` НЕ в NO_PROXY → идёт через прокси. Прокси протестирован: curl через прокси доходит до Google (404, не geo-block).

**Профили Gemini (2026-07-16):**
- `provider_gemini_free` — `gemini-2.5-flash`, ключ `AQ.Ab8R...`
- `provider_gemini_3_flash` — `gemini-3-flash-preview`, тот же ключ, добавлен 2026-07-16

**Важно:** прокси подхватывается ТОЛЬКО при старте сессии. Если settings.json изменился после старта → рестарт OpenClaude.

Бэкап: `C:\Users\Admin\.claude\settings.json.bak.20260714-202238`.

Если прокси умрёт/сменится — обновить `HTTPS_PROXY` в settings.json. Список хостов для NO_PROXY = все `baseUrl` из `providerProfiles` кроме googleapis (перечислить заново если добавится новый провайдер).
