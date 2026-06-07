---
name: Hugging Face Provider
description: HF Inference API подключён, 10 моделей: DeepSeek V4 862B, Mistral Medium 3.5 128B, Gemma 4 27B (2026-06-07)
type: reference
---

## Hugging Face Inference API Provider

**Подключён:** 2026-06-07

### Конфигурация
- **Provider:** `openai` (OpenAI-совместимый)
- **Base URL:** `https://api-inference.huggingface.co/v1`
- **API Key:** хранится в `.openclaude.json`

### Доступные модели (10 шт)

| Модель | Параметры | Описание |
|--------|-----------|----------|
| `deepseek-ai/DeepSeek-V4-Pro` | 862B | Самая мощная open-model |
| `deepseek-ai/DeepSeek-R1` | 685B | Reasoning модель |
| `deepseek-ai/DeepSeek-V4-Flash` | 158B | Быстрая версия |
| `mistralai/Mistral-Medium-3.5-128B` | 128B | Флагман Mistral |
| `mistralai/Mistral-Small-4-119B-2603` | 119B | Новая версия Small |
| `mistralai/Mistral-Nemo-Instruct-2407` | 12B | Компактная модель |
| `MiniMaxAI/MiniMax-M2.7` | 139B | Китайская модель |
| `google/gemma-4-26B-A4B-it` | 27B | Флагман Google (MoE) |
| `google/gemma-4-12B-it` | 12B | Компактная Gemma 4 |
| `meta-llama/Meta-Llama-3.1-70B-Instruct` | 70B | Классика Meta |

### Переключение моделей
Модели доступны через UI переключения провайдеров или через `/provider` команду.

### Примечания
- HF Inference API имеет лимиты на бесплатные запросы
- Некоторые модели могут требовать аутентификации с правами на inference
- Для продакшена рекомендуется Hugging Face Pro аккаунт