---
name: Can't view Yandex Disk screenshots
description: Yandex Disk image links cannot be viewed by the assistant — ask user to copy-paste text instead
type: feedback
---

Yandex Disk shared image links (e.g. `https://disk.yandex.ru/i/...`) are not viewable — WebFetch only gets the page shell, not the actual image content.

**Why:** User shared a browser console screenshot via Yandex Disk link; couldn't see the errors to debug.

**How to apply:** When user shares a screenshot link, either:
1. Ask them to copy-paste the text content (e.g. console errors) instead of sharing an image
2. Ask them to copy the image file to Termux home dir (`cp ~/storage/downloads/file.png ~/`) — the Read tool can display images directly
