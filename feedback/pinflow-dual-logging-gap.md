---
name: PinFlow dual logging gap
description: LogManager (in-memory) vs FileLogger (exportable) — exported logs miss critical codepaths
type: feedback
---

PinFlow has two logging systems: `LogManager` (in-memory, shown in app UI) and `FileLogger` (writes to file, exportable to Downloads via `FileLogger.exportToDownloads()`). Exported log files only contain `FileLogger` output.

**Why:** When user exports logs for debugging (e.g. autoposting failure), critical codepaths using only `LogManager` (like `executePostTask`, `getPostImages`, `createPin`) produce ZERO output in the exported file. Makes remote debugging impossible.

**How to apply:** When adding logging to any critical path in PinFlow, add BOTH `logManager.log()` (for in-app display) AND `fileLogger.log()` (for exportable diagnostics). Especially: `executePostTask`, `getPostImages`, `createPin`, `performTasks`, and any future task executors.

Fixed in `PinterestAutomator.kt` on 2026-06-11 — FileLogger calls added alongside existing LogManager calls in posting flow.
