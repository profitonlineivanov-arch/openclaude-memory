---
name: Retrofit working code with a small domain helper, not rewrite
description: When "раньше все работало" + root cause = один недостающий параметр (CSRF/cookie/header), не переписывать парсер/UI — добавить singleton helper, который мерджит/добирает недостающее и вставить одну строку в существующее место.
type: feedback
---

Когда юзер говорит «раньше всё работало» + из логов видна ОДНА конкретная недостача (CSRF токен, домен куки, заголовок) — правильный фикс это **retrofit** = маленький singleton-helper который делает недостающее + ОДНА строка замены в существующем коде.

## Паттерн (применён 2026-06-28 на PinFlow boards)
1. **Helper** (singleton, package utils) с тремя методами:
   - `collectAll()` — собрать данные из всех возможных источников (домены/поля/конфиги), дедуп по ключу, last-wins
   - `mergeFromStorageOrCollect(stored)` — если в storage есть нужное — берём, иначе добираем из живого источника
   - `extractXxx(merged)` — достать нужное значение простым regex/getter
2. **AuthActivity.saveSessionAndFinish**: 1 строка — заменить `getCookie("www")` → `CookieHelper.collectAll()`
3. **PostSettingsActivity.loadUserBoards**: 2 строки — обернуть `sessionManager.getCookies()` в `CookieHelper.mergeFromWebView(...)`, добавить второй лог Effecti­ve length
4. **Парсер/UI НЕ ТРОГАТЬ** если они не виноваты

## Когда это НЕ работает
- Если сломано несколько слоёв (auth + parser + UI state) — нужен полный коммит, а не retrofit
- Если installer хочет «более чистое API» — это refactor, не fix → согласуй scope отдельно

**Why:** 2026-06-28 PinFlow — юзер сказал «раньше всё работало» в 13:34. Я почти ушёл в переписывание всего `findBoardsFromJson` под новый appVersion Pinterest — overweight решение. Юзер потом сказал «пользователь будет открывать пинтерест так, как он открывается, т.е. в домене ru» — то есть **юзер не хочет менять свой flow**, фикс должен работать с тем как он есть. Retrofit через CookieHelper это и удовлетворил: 92 строки новый файл + 2 минимальные правки, ни парсер, ни UI, ни lifecycle не тронуты.

**How to apply:**
- Прежде чем кодить — спросить себя: «это ОДИН недостающий параметр или системная проблема?»
- Если ОДИН (CSRF, cookie, token, header, threading, missing field) → retrofit pattern
- Построй single-responsibility helper: collect → merge → extract. Три метода, никаких изменений в сигнатурах существующих методов
- ОДНА точка изменения в существующем коде (AuthActivity.saveSessionAndFinish). Если нужно МЕНЯТЬ в 5 местах — это уже не retrofit
- Build APK сразу, чтобы доставить результат (юзер не будет ставить "файл с фиксом", ему нужен работающий APK)
- Не начинай читать 700+ строк кода целиком — спроси юзера или сделай grep поиск конкретного метода, который заменяешь
