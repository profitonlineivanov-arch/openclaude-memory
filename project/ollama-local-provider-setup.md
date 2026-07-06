---
name: Ollama Local Provider Setup
description: Смартфон 8GB RAM (3.3GB avail), CPU only, no GPU. gemma2:2b + qwen3:4b установлены. gemma4:e4b удалена, e2b отменена. Ollama в providerProfiles.
type: project
---

**Текущее состояние (2026-07-03, обновлено):**
- gemma2:2b (1.6 GB) — локальная, работает на CPU
- **qwen3:4b** (2.5 GB) — УСТАНОВЛЕНА 2026-07-02. Tool use поддержка. CPU inference очень медленная на смартфоне (~2-5 мин на ответ).
- gemma4:e2b — была установлена, попытка использовать через `/provider` 2026-07-02: сессия упала, переключились обратно на Gitlawb mimo-v2.5-pro. Без tool use, зацикливается.
- gemma4:31b-cloud (0 MB) — облачная модель, зарегистрирована в Ollama

**Ollama как провайдер (2026-07-03):**
- Ollama — ЕСТЬ в `providerProfiles` в `.openclaude.json` (id: `provider_9107ba485a1a`)
- Endpoint: `http://localhost:11434/v1`
- Дефолтная модель: `gemma2:2b` (исправлено 2026-07-03 — было `gemma4:e2b\n\n7,2 ГБ...`)
- **UI-баг**: при переключении на Ollama через `/provider` модель сохраняется с UI-метаданными (размер, контекстное окно), приклеенными к имени модели через `\n`. Пример: `gemma4:e2b\n\n7,2 ГБ · 128 КБ...`. Требуется ручная чистка .openclaude.json.
- Тот же мусор попадает в `openaiAdditionalModelOptionsCache` — нужно чистить и там.
- API подтверждён рабочий: gemma2:2b отвечает корректно через /api/chat
- qwen3:4b переключён через `/model` 2026-07-03 — tool use статус не подтверждён, пользователь быстро переключился на другие провайдеры

**Ресурсы устройства (2026-07-02):**
- Смартфон (Android, Termux)
- RAM: 7.6 GB total, **3.3 GB доступно**
- GPU: **нет** — inference только на CPU
- CPU: 8 ядер
- Диск: 122 GB свободно

**Доступные gemma4 теги (ollama.com/library/gemma4):** e2b, e4b, 12b, 26b, 31b, 31b-cloud, latest (+ mlx варианты). Нет квантованных тегов — только полные веса.

**Альтернативы для малого RAM (проверено 2026-07-02):**
- qwen3:4b (~2.5 GB Q4) — лучший quality/RAM ratio с tool use
- qwen3:1.7b — меньше, ниже качество
- qwen2.5:3b — были проблемы с memory в прошлом
- phi4-mini:3.8b — нет уверенности в tool use

**Why:** e2b=7.2 GB и e4b=9.6 GB обе не влезают в 3.3 GB. Ollama gemma4 не имеет квантованных тегов. qwen3:4b (~2.5 GB) — самый качественный вариант с tool use. UI баг с метаданными проявляется при переключении провайдера.
**How to apply:** Локально — gemma2:2b (1.6 GB) работает быстро, qwen3:4b (2.5 GB) работает но медленно на CPU. Cloud — gemma4:31b-cloud. Переключение через `/provider`. После переключения на Ollama проверять `.openclaude.json` на чистоту model поля.

> ⚠️ 2026-07-06: Device-specific — НЕ синхронизировать через GitHub. Ноутбук имеет другой набор моделей (qwen2.5:7b, gemma4:e4b, RTX 3050).
