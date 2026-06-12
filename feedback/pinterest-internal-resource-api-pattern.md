---
name: Pinterest internal resource API — POST + source_url + data pattern
description: All Pinterest /resource/... endpoints require POST with form-encoded source_url+data JSON, not GET with query params
type: feedback
---

**Rule:** Pinterest internal resource endpoints (`/resource/FollowingResource/`, `/resource/PinResource/create/`, `/resource/UserFollowResource/delete/`, etc.) use the same POST+form pattern. GET with `?param=value` returns 403 "Invalid Resource Request" (24-byte body) — that's a format error, not auth.

**Why:** Confirmed by working `createPin` (commit b282ba8, user-verified 2026-06-11) and broken `getFollowingUsers` (GET → 403). Multiple header additions (X-Requested-With, Referer, X-CSRFToken, X-APP-VERSION) did NOT fix GET requests because the issue was the HTTP method and body format, not headers.

**How to apply:** When calling any `/resource/<Name>/` endpoint:

```
POST https://www.pinterest.com/resource/<Name>/
Content-Type: application/x-www-form-urlencoded
Body: source_url=/<page-path>/&data=<URL_ENCODED_JSON>

Headers (all required):
- Cookie
- X-CSRFToken (from csrftoken cookie)
- X-Requested-With: XMLHttpRequest
- X-APP-VERSION: a8065c6
- Accept: application/json
```

`source_url` = the page path that originated the request (e.g., `/<username>/following/`, `/<username>/pin-builder/`), NOT the image URL. The actual params go in `data` as URL-encoded JSON.

**Error diagnosis shortcut:**
- 401 → auth/CSRF issue
- 403 "Invalid Resource Request" (24 bytes) → wrong method/format, use POST+source_url+data
- 403 other → headers or app-version
