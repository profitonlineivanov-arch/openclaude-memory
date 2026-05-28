---
name: Local Dev Environment
description: Installed tools on user's Windows machine — ffmpeg, yt-dlp, Python 3.11, Node.js 22, whisper 20250625
type: reference
---

Локальное окружение (Windows 10 Pro, проверено 2026-05-17):

| Инструмент | Статус | Версия |
|---|---|---|
| ffmpeg | установлен | 8.1 |
| yt-dlp | установлен | 2026.03.17 |
| Python | установлен | 3.11.9 |
| pip | установлен | 25.3 |
| Node.js | установлен | v22.20.0 |
| whisper | установлен | 20250625 |

**Примечание по whisper:** CLI entrypoint (`whisper` командой) имеет баг — падает при запуске. Использовать через Python: `import whisper; model = whisper.load_model("base"); result = model.transcribe("audio.mp3")`.

**How to apply:** Полный пайплайн обработки видео доступен: yt-dlp (скачать) → ffmpeg (аудио/кадры) → whisper (speech-to-text).
