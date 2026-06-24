---
name: Verify before contradicting session history
description: Never state "X doesn't work" when session logs show it was confirmed working — check session transcripts before making claims
type: feedback
---

Не утверждать "X не работает" когда в логах сессий есть обратное. Проверять историю сессий перед категоричными заявлениями.

**Why:** В сессии 75b9d1f2 была таблица с моделями, где qwen2.5:14b и qwen2.5-coder:7b были отмечены как ✅ tools. Memory запись содержала ошибку (утверждала что все модели без tool use не работают). Я продублировал эту ошибку вместо того чтобы проверить логи. Пользователь назвал это "пиздежом" — справедливо.

**How to apply:** Перед категоричными заявлениями о работоспособности — grep по сессиям. Memory может содержать устаревшие/неточные данные. Сессионные логи — авторитетнее memory.
