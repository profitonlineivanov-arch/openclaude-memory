---
name: PinPilot Sales Phase
description: PinPilot (ex-PinFlow) enters sales/monetization phase 2026-07-06, needs test video content
type: project
---

PinPilot (ex-PinFlow) shifts from development to sales phase (2026-07-06).

**User said:** "мне сейчас уже нужно думать о продажах" — needs to start selling.

**Concrete need:** Short vertical videos about Pinterest promotion/marketing tips for testing PinPilot autoposting with actual promotional content. Videos should link back to user's app.

**Result (2026-07-06):** 2 videos delivered to /sdcard/Download/pinpilot/:
1. GCln1eUEnTQ.mp4 (4.7MB) — "Have I missed the boat with Pinterest marketing?"
2. OZhttgIKnbw.mp4 (3.3MB) — "How does Pinterest's algorithm work?"

Original plan was 5 videos, user OK'd 2 ("хватит двух").

**Constraints:**
- YouTube blocked by RKN from Russia, user has HTTP proxy (138.59.207.154:9963)
- yt-dlp + proxy from Termux connects to YouTube but anti-bot requires cookies
- **Workaround:** server 45.146.164.144 (2.3GB free, yt-dlp installed) — YouTube accessible without RKN block or anti-bot issues
- After download on server, SCP files to phone's /sdcard/Download/pinpilot/
- Agent-Reach (Panniantong/Agent-Reach) evaluated — text/info access only, not video download. NOT useful for this task.
- LeronX Engine (AI video generation) — user will try on laptop, not relevant for current video sourcing

**Why:** User wants to test PinPilot with content that has actual business value, not just random memes. Moving to monetization phase.

**How to apply:** When working on PinPilot, prioritize features that support monetization/sales pipeline. For future video needs: use server to download (no RKN block), or ask user for browser cookies for local yt-dlp.