---
name: Pinterest createPin — two-stage upload+create
description: Pin create requires image upload first (multipart), then create with source_url=/.../&data={JSON} format
type: feedback
---

**Why:** Round 7 autoposting failure (2026-06-11). `createPin` got HTTP 400 "board id is missing" because it used flat form fields and tried to send local file paths as `source_url=<local-path>`.

**Confirmed working by user 2026-06-11** — "отлично, заработал постинг". Commit `b282ba8`.

**How to apply — Pinterest PinResource/create/ requires two-stage flow:**

**Stage 1: Upload image**
- `POST https://www.pinterest.com/upload-image/` (multipart/form-data)
- Field: `img` with file binary, correct MIME type (image/jpeg, image/png, image/gif, image/webp)
- Headers: Cookie, X-CSRFToken, X-Requested-With
- Response contains `image_url` (try `image_url`, `url`, or `resource_response.data.image_url`)

**Stage 2: Create pin**
- `POST https://www.pinterest.com/resource/PinResource/create/`
- Content-Type: application/x-www-form-urlencoded
- Body format: `source_url=/<username>/pin-builder/&data=<URL_ENCODED_JSON>`
- JSON structure:
  ```json
  {
    "options": {
      "board_id": "778278448044030532",
      "title": "My Pin",
      "description": "...",
      "image_url": "https://i.pinimg.com/...",
      "link": "https://..."
    },
    "context": {}
  }
  ```
- Headers: Cookie, X-CSRFToken, X-Requested-With, X-APP-VERSION (a8065c6), Accept (application/json)

**Important:** `source_url` is the Pinterest page path from which the request originates (e.g., `/<username>/pin-builder/`), NOT the image URL. The image URL goes inside `data.options.image_url`.
