---
name: PinFlow Unfollow Zero
description: FollowingResource returns HTML (not JSON) — findFollowingInJson never runs; need alternative approach (WebView or real API endpoint)
type: project
---

## Status (2026-06-12)

`FollowingResource` returns HTTP 200 with 408KB of **HTML** (React SSR page), not JSON. `JSONObject(htmlBody)` at line 898 throws `JSONException` → caught by outer try/catch at line 922 → returns empty list. `findFollowingInJson` never executes.

Debug file `/sdcard/Download/following_debug.json` confirmed HTML content: starts with `<!DOCTYPE html>`, contains `__PWS_INITIAL_PROPS__` but `initialReduxState` has no following user data. Only embedded resource response is `UserSettingsResource` — no following/follower data.

## Root Cause

Pinterest's `FollowingResource` endpoint is a **React SSR page**, not a data API. Following users are loaded dynamically via client-side JavaScript after page render — they are NOT in the initial HTML server response. This approach CANNOT work.

## Debug Data Analyzed (2026-06-12)

File: `/storage/emulated/0/Download/following_debug.json` (408,208 bytes)

- HTML starts with `<!DOCTYPE html><html class="ru" lang="ru">`
- `__PWS_INITIAL_PROPS__` (script 57, 130KB JSON): bootstrap config + routes + UserSettingsResource only
- `initialReduxState.users` = has only logged-in user (breathefree0177, id=778278516763399193), NO following list
- Script 59 (200KB): route manifest, no API endpoints
- Script 73: secondary redux state, also no user data
- `serverResourceResponse` pushes: 0 (zero)
- `dataHandler()` calls: 0 (zero)  
- `__PWS_RESOURCE_DATA_BEFORE_INIT__.push`: 1 occurrence (function definition only, no data)
- Relay completed requests: 0
- `resource_response` patterns: only `UserSettingsResource` (v3_get_user_settings)
- `followed_by_me`, `"type":"user"` patterns in HTML: 0
- Bootstrap context: `current_url: https://www.pinterest.com/resource/FollowingResource/`, referrer: `https://www.pinterest.com/Soulexpert/following/`
- Route: `www/[username]/_following` exists but has no preloaded resource data
- Username from context: `Soulexpert`

## Code Path (PinterestAutomator.kt)

- Line 846-927: `getFollowingUsers()` — POST to `/resource/FollowingResource/` with `source_url=/$username/following/&data=...`
- Line 897: `val json = JSONObject(body)` — **throws JSONException** on HTML
- Line 922: `catch (e: Exception)` — catches JSONException, returns empty list
- Line 929-957: `findFollowingInJson()` — never reached, expects `type=="user"`, `id.startsWith("/User/")`

## Approaches to Fix (NEXT SESSION)

1. **WebView + JS injection**: Load `/$username/following/` in hidden WebView, wait for page load + render, inject JavaScript to extract following users from hydrated Redux store. Most reliable but slower.
2. **Find real API endpoint**: Pinterest's client JS makes an actual API call (likely GraphQL/relay) to fetch following users. Capture via Chrome DevTools Network tab on the following page. Fastest if found.
3. **DOM scraping via WebView**: Wait for full render, extract user elements from DOM after JS hydration completes.

## Previous Attempts (ALL FAILED)

- v1-v3: GET requests with query params — wrong API pattern
- v4: POST + `source_url` + `data` as form params — returns HTML, not JSON
- `JSONObject(HTML)` → JSONException → empty list
- Debug JSON dump → confirmed HTML, zero user data in SSR

## Next Step

Open `https://www.pinterest.com/Soulexpert/following/` in Chrome with DevTools Network tab to capture the real API call that fetches following users. Replicate that call in Kotlin.

**Why:** Unfollow is core automation. `FollowingResource` fundamentally cannot work — returns HTML without user data. Must find/pick alternative mechanism.

**How to apply:** Do NOT attempt further fixes with `FollowingResource` POST endpoint. Choose WebView or find real API via DevTools.