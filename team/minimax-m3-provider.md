---
name: MiniMax M3 provider
description: MiniMax M3 в бесплатном тестировании 3 дня, подключение через /provider add minimax с API ключом
type: reference
---

**MiniMax M3** (`minimaxai/minimax-m2.7`) — доступен для бесплатного тестирования на 3 дня (появилась 2026-06-06).

**Как подключить:**
1. Нужен API ключ MiniMax (получить на minimax.chat)
2. Выполнить `/provider add minimax` — запускает device flow в Termux (нужно передать пользователю код)
3. Endpoint: `https://api.minimax.chat/v1`

**Подтверждено (2026-06-06):** MiniMax API работает — curl на `https://api.minimax.chat/v1/models` возвращает ошибку авторизации (нужен ключ), значит endpoint правильный.

**Проблема (2026-06-06):** Пользователь смотрит YouTube видео где сказано "просто выбрать модель". Встроенные провайдеры OpenClaude: `anthropic, openai, gemini, github, bedrock, vertex, ollama` — MiniMax среди них НЕТ. Нужен API ключ. `/provider add minimax` запускает device flow, но дальше не работает. Пользователь не может найти где взять ключ.