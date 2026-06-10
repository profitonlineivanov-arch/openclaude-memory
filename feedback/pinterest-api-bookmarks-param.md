---
name: Pinterest API bookmarks param
description: Pinterest BoardResource API requires 'bookmarks' param — without it returns 400 "Required arguments are missing"
type: feedback
---

Pinterest API `/resource/BoardResource/get/` требует параметр `bookmarks` в options JSON (даже пустую строку `""`).

**Why:** Без `bookmarks` API возвращает 400: `"Required arguments are missing"` с полным listing переданных параметров в message. Раньше работало без него — API изменился на стороне Pinterest.

**How to apply:** При любых запросах к Pinterest web resource API — всегда включать `bookmarks: ""` в options. Проверять FileLogger логи на наличие 400 ошибок с "Required arguments are missing".
