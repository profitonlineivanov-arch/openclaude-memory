---
name: MiniMax M3 via Gitlawb Opengateway
description: MiniMax M3 is served via Gitlawb Opengateway provider under identifier minimax/minimax-m3 — no separate setup needed (2026-06-07)
type: reference
---

**MiniMax M3** (`minimax/minimax-m3`) — теперь доступен через провайдер Gitlawb Opengateway. Подтверждено 2026-06-07.

**Как использовать:**
1. Переключиться на провайдер: `/provider` → выбрать Gitlawb Opengateway
2. Установить модель: `/model minimax/minimax-m3`
3. Никаких API ключей или device flow не требуется — всё уже настроено в `.openclaude-profile.json`

**История:**
- 2026-06-06: Пытались подключить напрямую через `/provider add minimax` — не работало (device flow в Termux, пользователь не мог найти ключ). Считали что нужен отдельный провайдер MiniMax.
- 2026-06-07: Оказалось, что модель `minimax/minimax-m3` уже доступна через Gitlawb Opengateway. `/provider` + `/model minimax/minimax-m3` достаточно. Endpoint `https://api.minimax.chat/v1` не используется.

**Имя модели в системе:** `mimo-v2.5-pro` (отображаемое в OpenClaude) = `minimax/minimax-m3` (полный идентификатор) = MiniMax M3.