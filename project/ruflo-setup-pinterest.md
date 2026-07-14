---
name: Ruflo Setup for Pinterest Autoposter
description: Ruflo (claude-flow) установлен и настроен для автопостинга Pinterest через Gemini. Требует перезапуска OpenClaude.
type: project
---

Ruflo (ruvnet/ruflo) установлен как плагин `claude-flow@github` в OpenClaude.

**Настройка:**
- Плагин включён: `enabledPlugins."claude-flow@github": true`
- Marketplace зарегистрирован: `extraKnownMarketplaces.github` → `ruvnet/ruflo`
- Модель для Ruflo: `agentModels.gemini-free` → Gemini 3 Flash Preview (бесплатный ключ)
- Маршрутизация: `agentRouting.ruflo` → `gemini-free`

**Контекст задачи:**
- Автопостинг изображений заказчика (192 шт.) в Pinterest аккаунт nakley_menja
- Изображения распределены по 3 доскам в `D:/Projects/kworks/Kwork orders/Maintaining a Pinterest/order 63689016/posting_images/`
- CSV со ссылками Wildberries: `Information from the customer/Для Пинтерест - Лист1.csv`
- Selenium скрипт `poster.py` в `D:/Programs/pinterest_poster/` (работает, но требует ручного вмешательства)
- Ruflo должен заменить ручной постинг через агентный подход

**Статус:** Настроен, требует перезапуска OpenClaude для активации MCP серверов.

**Why:** Пользователь хочет автоматизировать постинг через Ruflo вместо ручного Selenium-скрипта.
**How to apply:** После перезапуска проверить доступность инструментов Ruflo (`mcp__ruflo__*`) и запустить агента для постинга.
