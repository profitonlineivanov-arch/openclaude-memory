---
name: Freebuff CLI/Desktop Not Launching
description: Симптомы, корень и workaround для freebuff.com CLI Bun-краша и desktop "No internet" — геоблок + упаковка win32x64 битая
type: project
---

# Freebuff CLI & Desktop — не запускаются (2026-08-04)

## Что стоит
- Desktop: `~/AppData/Local/Programs/@codebufffreebuff-desktop/Freebuff.exe` (Electron). Запускается.
- CLI: npm global `freebuff@0.0.137` (latest). Бинарь: `C:\Users\Admin\.config\manicode\freebuff.exe`. Bun-runtime standalone exe, Bun 1.3.14.
- Логи desktop: `~/AppData/Roaming/Freebuff/logs/orchestrator-stderr.log`. Orchestrator = локальный Bun на `http://127.0.0.1:56037`.

## Симптомы
1. **CLI крашит на любой команде** (даже `--version`):
   `panic(main thread): Internal assertion failure — Bun has crashed` (баг в Bun, не в коде freebuff).
   Откат на 0.0.136 — тот же краш. Устойчиво на win32-x64.
   Crash report URL: https://bun.report/1.3.14/w_10d9b296...

2. **Desktop показывает "No internet — turns resume when you reconnect"** несмотря на то что общая сеть есть.

## Корень
- Системный прокси `HTTPS_PROXY=http://BbWQkV:qKMUPf@138.59.207.154:9963` (US exit IP). Через прокси:
  - `freebuff.com` (root, Cloudflare CDN статика) → 200 OK
  - `*.freebuff.com` (api, app, auth, backend, cdn) → **502 Bad Gateway** (Cloudflare не дотягивается до origin, либо прокси-провайдер режет).
- Напрямую без прокси (`--noproxy "*"`) → `code=000` exit 28 таймаут. РФ-провайдер/РКН режет TLS к freebuff.com полностью.

## Итог диагноза
- CLI-баг не связан с сетью — упакованный Bun standalone битый на win32-x64 во всех версиях 0.0.130–0.0.137.
- Desktop "No internet" — реальный симптом геоблокировки: api.freebuff.com недоступен ни напрямую (РФ-блок), ни через прокси (502).

## Workaround (не исправлено)
- Desktop: использовать только если поднимется прокси, у которого origin api.freebuff.com не 502. Текущий US-прокси 138.59.207.154 — НЕ подходит.
- CLI: фикс требует либо пересборки freebuff против свежее Bun (>1.3.14), либо баг-репорт разработчикам.
- NO_PROXY (`localhost,127.0.0.1,opengateway.gitlawb.com,api.deepseek.com,...`) — freebuff НЕ входит.

## Команды диагностики
```
where freebuff; ~/AppData/Roaming/npm/freebuff.cmd --version
curl -sI --max-time 8 https://api.freebuff.com/   # 502 через прокси, timeout напрямую
curl -s --max-time 12 --noproxy "*" -o /dev/null -w "%{http_code}\n" https://freebuff.com/
```
