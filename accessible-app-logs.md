---
name: accessible-app-logs
description: Android app logs must be saved to Downloads (or clipboard) — not internal storage only
type: feedback
---

Для Android-приложений всегда сохранять логи/отладочные данные в общедоступное место (Downloads, clipboard), а не только во внутреннюю память приложения.

**Why:** Пользователь работает на Android без root и без ADB. Доступ к `/data/data/` закрыт. Меню «Поделиться» (Intent.ACTION_SEND) непонятное и ненадёжное. Скриншоты захватывают только часть лога. Всё это делает отладку невозможной без внешней помощи.

**How to apply:** При добавлении логирования или экспорта данных в Android-приложение — всегда предусматривать:
1. Сохранение в папку Downloads (MediaStore для API 29+, прямой доступ для старых)
2. Понятный Toast с полным путём к файлу
3. Fallback на копирование в буфер обмена
4. Проверить, что Termux может прочитать файл (`~/storage/downloads/`)
