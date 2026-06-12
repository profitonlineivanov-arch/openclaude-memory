---
name: Stale build intermediates after interrupted Gradle run
description: After interrupted/aborted gradle build, processDebugManifest fails with NoSuchFileException for merged_manifest — re-run clean + assembleDebug
type: feedback
---

When `./gradlew assembleDebug` is interrupted or aborted, the next run can fail with:
`Execution failed for task ':app:processDebugManifest'. > kotlin.io.NoSuchFileException: build/intermediates/merged_manifest/debug/AndroidManifest.xml: The source file doesn't exist.`

**Why:** Gradle leaves partial intermediates in `merged_manifest/debug/` (empty `debug/` subdirs) after interruption. The manifest merger task then can't find its expected input even though `app/src/main/AndroidManifest.xml` exists fine. Source manifest is NOT the problem — build pipeline state is.

**How to apply:** Don't waste time investigating source manifest location or build.gradle config. Go straight to: `cd /root/pinflow_scp && ./gradlew clean && ./gradlew :app:assembleDebug`. After clean, build runs normally. Confirmed 2026-06-12 with PinFlow (build OK 1m 20s, APK pinflow-r7.apk delivered).

When checking if the error is stale-state vs real config bug, try `:app:processDebugManifest` alone after clean — if it passes, the rest of assembleDebug will too. Saves a full assembleDebug run for diagnosis.
