---
name: verifier-fails-termux
description: Verification subagents fail in Termux due to path issues — manual verification (Grep/Grep) works instead
type: feedback
---

Verification subagents С ТИПОМ `subagent_type="verification"` падают в Termux с "file does not exist" ошибками. Подтип `Explore` при этом работает нормально и завершает задачи успешно.

**Why:** В сессии 2026-06-05 verification agent трижды упал с `Read` failed: "file does not exist" при чтении PostSettingsActivity.kt. 2026-06-06: Explore agent успешно проверил весь проект PinFlow (45 tool calls: Grep, Read, Glob) — нашёл 0 проблем, завершился без ошибок. Значит проблема специфична для подтипа `verification`, не для всех subagent-ов.

**How to apply:** Для верификации в Termux использовать Explore subagent вместо verification. Если Explore тоже падает — ручная проверка: (1) Grep на дубликаты lateinit var / findViewById, (2) Grep на дубликаты android:id в XML, (3) сверка вызовов методов между DAO и их использованием в Activities/Automator.
