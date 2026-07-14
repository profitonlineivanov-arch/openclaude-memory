---
name: Pinterest poster — missing images + Gemini plan
description: kwork order 63689016 Pinterest poster не хватает 57 изображений; план добыть через Gemini image-gen модели (img2img по референсам клиента). Резюме для возобновления.
type: project
---

Задача: добить ~57 изображений для Pinterest-постера (kwork order 63689016), стиль = клиентские наклейки. Сессия закрыта, вернёмся позже.

**Why:** Постер `poster.py` крутит 249 пинов, но 57 broken — ссылаются на `D:\Programs\pinterest_poster\generated_images\NAKL_..._sdvar_N.jpg`, которых НЕТ (папка пуста). `sd_variate.py` (img2img SD 1.5) записал в `content_250.json` новые пины, но файлы не сгенерил — скрипт не запущен или упал. Постер эти 57 не сможет запостить.

**How to apply:** При возобновлении — выбрать источник. План ниже.

## Состояние (проверено 2026-07-14)
- Проект: `D:\Programs\pinterest_poster` (poster.py, config.json, content_250.json, watermark.png, generated_images/ — пусто)
- Материалы клиента: `D:\Projects\kworks\Kwork orders\Maintaining a Pinterest\order 63689016`
- `posting_images/`: 192 файла (board1_vintage_stickers=131, board2_card_accessories=25, board3_sill_decor=36)
- `content_250.json`: 249 пинов, 57 broken (source_folder=generated_images, файлов нет)
- `parsed_images/`: 250 файлов (другой набор)
- `Information from the customer/Генерация.zip`: **131 изображение наклеек** (НЕ видео! "frame_NNN" = нумерация экспорта). Формат 1753×2176 RGB (Pinterest 2:3). Коллекции: NAKL_FOUR_WEEK, NAKL_KOTYKI_MOFUSAND_210, NAKL_KOTY_MEM_220, NAKL_LOVE_180_tr. Кириллица в путях внутри zip ломает extract — читать через `zipfile.read()` + PIL `io.BytesIO`.
- `_extracted/Банковские карты/` — ещё одиночные jpg наклеек (NAKL_CARD_*: BITCOIN/HAWAII/JAPANCAT/RUBLE/TIGER)
- SD pipeline есть в `D:\Programs\AI`: gen_clean.py (inpaint), gen_controlnet.py (Canny img2img), sd_variate.py (img2img variator). SD 1.5 слаб для конкретных наклеек.

## Варианты (ранжированы)
1. **Неиспользованные кадры клиента из Генерация.zip** — стиль 1:1, легально, бесплатно. Сначала точно сравнить used vs zip (сравнивать по полному имени `NAKL_<TYPE>_frame_...`, не по basename — posting_images имена склеены). Если ≥57 свободных — просто распределить + дописать в content_250.json.
2. **Gemini image-gen (img2img по референсу клиента)** — ВЫБРАННЫЙ план. Прокси уже настроен, модели подтверждены.
3. SD img2img (gen_controlnet.py Canny) — fallback, медленно + слабое качество.

## Gemini image-gen (подтверждено 2026-07-14)
Профиль `provider_1bb82ec04304` "Google Gemini", ключ валиден, прокси из settings.json работает (список моделей получен).
Доступные image-gen модели (метод generateContent, vision ввод → image вывод):
- `gemini-3-pro-image` — top качество
- `gemini-3.1-flash-image` — **рекомендация**: скорость/цена/качество
- `gemini-2.5-flash-image` — backup
- `imagen-4.0-generate-001` (метод predict, text-only ввод) — fallback без референса

Подход: скармливаешь референс наклейки клиента + prompt "create similar sticker design, same style" → вариация. Watermark потом `apply_watermark.py`. 57 шт потянут по квотам.

Прокси применяется при старте сессии — для standalone Python-скрипта передавать HTTPS_PROXY/NO_PROXY в requests/SDK явно (см. reference/gemini-proxy-setup.md). NO_PROXY = все baseUrl кроме googleapis.
