---
name: PinFlow Round 3 — 3 бага найдены при тестировании (2026-06-08)
description: Username="Все", краш extractUsernameViaHttp (WebView thread), двойной запуск автоматора — найдены в логах 14:56 и 16:22
type: project
---

**Статус (2026-06-08 16:30):** Тестирование APK `pinflow-1030.apk` выявило 3 бага, не исправленных в коммитах 47f3324..b1ec51e.

## Баг 1: Username = "Все" (вместо реального)
- `extractUsernameFromPage` возвращает "Все" — это русский текст из UI Pinterest ("All"), не username
- Причина: HTTP-слой упал с крашем (баг 2), cookie-слой не дал username, page-парсер схватил первое попавшееся слово
- Log: `Username from page: Все` → `Extracted username: Все` → `Saved account to database: Все`

## Баг 2: Краш extractUsernameViaHttp — WebView thread mismatch
- `AuthActivity.kt:513` — вызов `WebView.getSettings()` из корутины на `DefaultDispatcher-worker-1`
- WebView требует main thread. Нужно обернуть в `withContext(Dispatchers.Main)`
- Stacktrace: `java.lang.RuntimeException: A WebView method was called on thread 'DefaultDispatcher-worker-1'`

## Баг 3: Двойной запуск автоматора (guard из 47f3324 не работает)
- Во второй сессии (16:21) — два экземпляра Automator запущены с интервалом 30ms
- `Auto-restoring automation after restart` вызывается дважды подряд
- Log: `Запуск автоматизации` ×2, `Автоматизация запущена для Все` ×2, `Выполнение задач` ×2

**Логи:** `pinflow_log_20260608_145633.txt` (177 строк) и `pinflow_log_20260608_162205.txt` (193 строки, включает вторую сессию 16:21).
