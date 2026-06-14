#!/bin/bash
# OpenClaude memory + config sync script
# Usage: ./sync.sh [pull|push|sync]

MEMORY_DIR="$(cd "$(dirname "$0")" && pwd)"
OC_DIR="$HOME/.openclaude"
CONFIGS="$MEMORY_DIR/configs"

copy_configs_to_oc() {
    [ -f "$CONFIGS/.openclaude.json" ] && cp "$CONFIGS/.openclaude.json" "$OC_DIR/.openclaude.json"
    [ -f "$CONFIGS/settings.json" ] && cp "$CONFIGS/settings.json" "$OC_DIR/settings.json"
    [ -f "$CONFIGS/settings.local.json" ] && cp "$CONFIGS/settings.local.json" "$OC_DIR/settings.local.json"
    [ -f "$CONFIGS/.openclaude-profile.json" ] && cp "$CONFIGS/.openclaude-profile.json" "$OC_DIR/.openclaude-profile.json"
}

copy_configs_from_oc() {
    mkdir -p "$CONFIGS"
    [ -f "$OC_DIR/.openclaude.json" ] && cp "$OC_DIR/.openclaude.json" "$CONFIGS/.openclaude.json"
    [ -f "$OC_DIR/settings.json" ] && cp "$OC_DIR/settings.json" "$CONFIGS/settings.json"
    [ -f "$OC_DIR/settings.local.json" ] && cp "$OC_DIR/settings.local.json" "$CONFIGS/settings.local.json"
    [ -f "$OC_DIR/.openclaude-profile.json" ] && cp "$OC_DIR/.openclaude-profile.json" "$CONFIGS/.openclaude-profile.json"
}

cd "$MEMORY_DIR"

case "${1:-sync}" in
    pull)
        git pull --rebase origin main 2>/dev/null
        copy_configs_to_oc
        ;;
    push)
        copy_configs_from_oc
        git add -A
        if git diff --cached --quiet; then
            echo "No changes to push"
        else
            git commit -m "Memory update: $(date '+%Y-%m-%d %H:%M')"
            git push origin main 2>/dev/null
        fi
        ;;
    sync)
        git pull --rebase origin main 2>/dev/null
        copy_configs_to_oc
        copy_configs_from_oc
        git add -A
        if ! git diff --cached --quiet; then
            git commit -m "Memory update: $(date '+%Y-%m-%d %H:%M')"
            git push origin main 2>/dev/null
        fi
        ;;
esac
