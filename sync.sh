#!/bin/bash
# OpenClaude memory + config sync script
# Usage: ./sync.sh [pull|push|sync]

MEMORY_DIR="$(cd "$(dirname "$0")" && pwd)"
OC_DIR="$HOME/.openclaude"
CONFIGS="$MEMORY_DIR/configs"
GITHUB_TOKEN="${GITHUB_TOKEN:-}"

# Ensure HTTPS remote for automation (SSH key may not be available in all contexts)
git config remote.origin.url "https://github.com/profitonlineivanov-arch/openclaude-memory.git" 2>/dev/null

git_safe_pull() {
    git fetch origin main 2>/dev/null
    if ! git merge --ff-only origin/main 2>/dev/null; then
        git merge --no-edit origin/main 2>/dev/null || true
    fi
}

git_push() {
    if [ -n "$GITHUB_TOKEN" ]; then
        GIT_ASKPASS=echo GITHUB_TOKEN="$GITHUB_TOKEN" git push origin main
    else
        git push origin main
    fi
}

cd "$MEMORY_DIR"

case "${1:-sync}" in
    pull)
        git_safe_pull
        ;;
    push)
        git add -A
        if git diff --cached --quiet; then
            echo "No changes to push"
        else
            git commit -m "Memory update: $(date '+%Y-%m-%d %H:%M')"
            git_push
        fi
        ;;
    sync)
        git_safe_pull
        git add -A
        if ! git diff --cached --quiet; then
            git commit -m "Memory update: $(date '+%Y-%m-%d %H:%M')"
            git_push
        fi
        ;;
esac
