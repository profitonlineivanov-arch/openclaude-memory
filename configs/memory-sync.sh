#!/bin/bash
# Universal OpenClaude memory sync script
# Auto-discovers memory/ directory inside ~/.openclaude/projects/
# Usage: bash ~/.openclaude/memory-sync.sh [pull|push|sync]

OC_DIR="${HOME}/.openclaude"
MEMORY_DIR=""

# Find memory/ directory containing sync.sh
for d in "$OC_DIR"/projects/*/memory; do
    if [ -f "$d/sync.sh" ]; then
        MEMORY_DIR="$d"
        break
    fi
done

# Fallback: check project root for sync.sh
if [ -z "$MEMORY_DIR" ]; then
    for d in "$OC_DIR"/projects/*/; do
        if [ -f "${d}sync.sh" ]; then
            MEMORY_DIR="$d"
            break
        fi
    done
fi

if [ -z "$MEMORY_DIR" ]; then
    echo "memory-sync: no memory/ with sync.sh found in $OC_DIR/projects/" >&2
    exit 1
fi

cd "$MEMORY_DIR" && bash sync.sh "$@"
