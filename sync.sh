#!/bin/bash
# OpenClaude memory sync script
# Usage: ./sync.sh [pull|push|sync]

MEMORY_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$MEMORY_DIR"

case "${1:-sync}" in
    pull)
        git pull --rebase origin main 2>/dev/null
        ;;
    push)
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
        git add -A
        if ! git diff --cached --quiet; then
            git commit -m "Memory update: $(date '+%Y-%m-%d %H:%M')"
            git push origin main 2>/dev/null
        fi
        ;;
esac
