---
name: Termux glibc binary compatibility
description: Prebuilt Linux binaries requiring glibc/ld-linux fail in Termux (Bionic libc) — patch to use system tools instead
type: feedback
---

Prebuilt Linux binaries (ELF, linked against glibc, requiring `/lib/ld-linux-aarch64.so.1`) don't work in Termux because Termux uses Bionic libc, not glibc.

**Why:** CodeGraph bundled its own Node.js binary compiled for glibc. Running it in Termux produced a "not found" error on the dynamic linker path. npm install also failed (android-arm64 not available, HTTP 404). PinFlow local Gradle build also hit bundled Linux AAPT2 in Termux with `Syntax error: Unterminated quoted string` during `processDebugResources`, blocking Kotlin compilation.

**How to apply:** When installing CLI tools that bundle their own runtime binaries:
1. Try the standalone/linux-arm64 installer first (not npm — npm often lacks arm64 prebuilts).
2. If the tool has a shell shim/wrapper, replace bundled binary calls with Termux system equivalents (e.g., `exec node` instead of `exec "$DIR/node"`).
3. For V8/Node tools that crash with WASM OOM, add `--liftoff-only` flag.
4. Verify with `file <binary>` — if it says "ELF ... dynamically linked, interpreter /lib/ld-linux-aarch64.so.1", it won't run in Termux.
