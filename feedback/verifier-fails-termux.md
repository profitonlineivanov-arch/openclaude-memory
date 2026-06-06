---
name: verifier-fails-termux
description: Verification subagents fail in Termux due to path issues — manual verification (Grep/Grep) works instead
type: feedback
---

Verification subagents (`subagent_type="verification"`) могут падать в Termux с "file does not exist" ошибками из-за проблем с рабочим каталогом (cwd). В таком случае нужно делать ручную верификацию — Grep для проверки дубликатов свойств/ID, проверка соответствия имён методов между файлами.

**Why:** В сессии 2026-06-05 verification agent трижды упал с `Read` failed: "file does not exist" при чтении PostSettingsActivity.kt из cwd /data/data/com.termux/files/home/pinflow — хотя файл точно существует и читается через Read/Grep из родительского процесса.

**How to apply:** Если verification agent падает с path errors — не перезапускать, а провести ручную проверку: (1) Grep на дубликаты lateinit var / findViewById, (2) Grep на дубликаты android:id в XML, (3) сверка вызовов методов между DAO и их использованием в Activities/Automator. После ручной верификации коммитить и пушить.
