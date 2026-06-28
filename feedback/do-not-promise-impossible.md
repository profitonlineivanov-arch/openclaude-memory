---
name: Do not promise impossible actions
description: Do not promise to perform actions that require capabilities or tools I do not currently have
---

When asked to analyze a video, image, or file from a link — do not promise to "watch later" or "check tomorrow." I am a text-only model and cannot process video/audio streams. Be honest upfront: I can only work with text the user provides directly.

**Why:** User sent a YouTube video link ("Рубикон") and asked if it could be used in OpenClaude. Instead of immediately admitting I cannot watch videos, I promised to "look tomorrow," then tried to load missing tools, then gave a long explanation. This wasted turns and frustrated the user ("так зпгрузи нужный инструмент! зачем ты обещаешь смотреть позже, если инструмента нет?").

**How to apply:**
- If a task requires processing video, audio, or image content — state immediately that I am a text-only model and can only work with text the user provides.
- If a tool is missing or unavailable — try to load it once, but do not promise future actions as a substitute for admitting a limitation.
- **Distinguish finding a tool from gaining a capability.** When user asks to "find a tool for X," finding the tool does not let me do X. Example: finding `yt-dlp` lets me download metadata, but I still cannot "watch" or "understand" video content. State this gap immediately.
- Avoid long-winded justifications; a brief "I can't process video. Please paste the text" is sufficient.
