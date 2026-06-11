---
name: PinFlow Parallel Automation
description: Implementation of parallel task loops in PinterestAutomator to prevent task starvation
type: project
---

Automation tasks (posting, likes, follows, unfollows) now run in parallel using independent coroutine loops instead of a sequential queue.

**Commit:** 915c28a (2026-06-11), pushed to GitHub master. Server build + SCP confirmed working — APK `pinflow-parallel.apk` delivered.

**Why:** The sequential `performTasks()` loop caused "task starvation" where a long-running `executePostTask` (due to image uploads and post delays) would block other enabled automation tasks from executing.

**How to apply:** Use `runTaskLoop` for each task type within `runAutomation`. Each task loop should handle its own execution and error catching to ensure one failing task doesn't crash the entire automation process.
