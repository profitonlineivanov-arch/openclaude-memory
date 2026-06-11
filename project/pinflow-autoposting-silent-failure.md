---
name: PinFlow autoposting — root cause + fix
description: createPin got HTTP 400 "board id is missing" — wrong API format + local files not uploaded. Fixed 2026-06-11.
type: project
---

**Symptom (from log `pinflow_log_20260611_142437.txt`):** Autoposting finds 2 images, both exist, but `createPin` returns HTTP 400: `"board id is missing"`.

**Root cause — TWO bugs:**

1. **Local image files not uploaded.** `createPin` received local paths like `/data/user/0/com.pinflow/files/gallery_images/...` and put them in form body as `source_url=<path>`. Pinterest can't access local Android files. No upload step existed.

2. **Wrong API format.** `createPin` sent flat form fields (`image_url=...&title=...&board_id=...`). Pinterest's `/resource/PinResource/create/` endpoint requires the same format as board loading: `source_url=/<username>/pin-builder/&data={"options":{"board_id":"...","title":"...","image_url":"...","link":"..."},"context":{}}`. The board_id inside `data.options` JSON, not as flat param.

**Fix applied 2026-06-11:**
- Added `uploadImageToPinterest()` — multipart POST to `/upload-image/` with `img` field, returns `image_url`
- Rewrote `createPin()` — uses `source_url=/<user>/pin-builder/&data={JSON}` format matching BoardResource pattern
- Modified `executePostTask` — calls `uploadImageToPinterest()` first, then `createPin(imageUrl=...)`
- APK: `/sdcard/Download/pinflow-upload.apk`
- File changed: `PinterestAutomator.kt` (SCP'd to server, built, APK delivered)
- **Confirmed working by user 2026-06-11:** "отлично, заработал постинг"
- Commit `b282ba8` pushed to GitHub master
- APK: `/sdcard/Download/pinflow-upload.apk`
