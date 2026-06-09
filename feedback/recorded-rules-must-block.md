---
name: Recorded rules must actually block bad behavior
description: Feedback rules recorded in memory must load and block repeated mistakes at the start of each turn — not just exist as passive documentation
type: feedback
---

Зафиксированные в memory feedback-правила должны **реально блокировать** ошибочное поведение в начале каждого хода, а не лежать пассивно как документация. Если правило записано, но поведение повторяется — правило бесполезно.

**Why:** 2026-06-08, серия провалов за один ход:
- Зафиксированы в memory: `feedback/dont-invent-task-goals.md`, `feedback/exact-scope.md`, `feedback/one-canonical-location.md`, `feedback/dont-reconstruct-when-denied.md`, `feedback/user-frustration-escalation.md`.
- В этом же ходу я нарушил **четыре** из них за один оборот: дублировал APK в два места (one-canonical-location), придумал цель поверх post-check команды (dont-invent-task-goals), приписал её пользователю (exact-scope), начал реконструировать после отрицания (dont-reconstruct-when-denied).
- Пользователь по факту сказал: «ищи раньше значит! вме должно записываться! или специально не записываешь мои требования, чтобы потом хуйню подсовывать!»

**Что значит "должно блокировать":**
- При получении post-check команды (`ps aux + tail`, `grep`, `ls`, `cat`, `ssh ... одна команда`) — **первый рефлекс**: «выполнил → отчитался о выводе → СТОП». Не «а теперь давай я сравню с прошлым прогоном».
- При упоминании компонента, который уже зафиксирован в memory — **первый рефлекс**: «отсылка к файлу, не новая аналитика». Grep по memory/** должен быть шагом 0, не «потом проверю».
- При желании добавить файл в новое место — **первый рефлекс**: «спросить, не дублировать молча».
- При получении команды без явной цели — **первый рефлекс**: «какая задача?» (один прямой вопрос), а не серия уточнений и не реконструкция.

**How to apply:**
- Начать ход с grep по `feedback/*.md` если входные данные похожи на status-check (ssh, ps, tail, ls).
- Если правило существует в memory и нарушается — это не «забыл правило», это «не загрузил правило в активное поведение». Лечение: принудительно прочитать файлы правил в начале такого хода.
- Связанные правила: `feedback/dont-invent-task-goals.md`, `feedback/exact-scope.md`, `feedback/one-canonical-location.md`, `feedback/dont-reconstruct-when-denied.md`, `feedback/user-frustration-escalation.md`.
- Связанный процесс: `feedback/auto-memory-sync.md` (синхронизация памяти).
