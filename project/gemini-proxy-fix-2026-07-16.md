---
name: Gemini proxy fix 2026-07-16
description: Fix for Gemini 400 geo-block via HTTPS_PROXY in .openclaude.json env
---

## Проблема
Gemini API Error 400: "User location is not supported for the API use." — геоблок РФ.

## Причина
- `.openclaude.json` НЕ содержал top-level `env` блок с прокси.
- Прокси был только в `settings.json` env, который фильтруется `SAFE_ENV_VARS3` whitelist — `HTTPS_PROXY` НЕ входит в whitelist.
- Ранее память ошибочно утверждала что прокси в `.openclaude.json` top-level env.

## Решение
Добавлен top-level `env` блок в `.openclaude.json`:

```json
"env": {
  "HTTPS_PROXY": "http://BbWQkV:qKMUPf@138.59.207.154:9963",
  "NO_PROXY": "localhost,127.0.0.1,opengateway.gitlawb.com,api.deepseek.com,api.fireworks.ai,api.mistral.ai,integrate.api.nvidia.com,opencode.ai"
}
```

## Механика
- `applySafeConfigEnvironmentVariables()` → `getGlobalConfig().env` загружает env из `.openclaude.json` без фильтрации whitelist.
- `generativelanguage.googleapis.com` НЕ входит в `NO_PROXY` → идёт через прокси.
- Прокси протестирован: curl через прокси доходит до Google (404, не 400).

## Инструкция при рецидиве
1. Проверить `.openclaude.json` содержит top-level `env` блок.
2. Перезапустить OpenClaude.
3. Переключиться на Gemini провайдер.
4. Проверить env в сессии: `env | grep HTTPS_PROXY`.

## Бэкап
- `.openclaude.json.bak.20260716-225730`