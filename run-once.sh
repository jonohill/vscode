#!/usr/bin/env bash

set -e

code serve-web \
    --without-connection-token \
    --accept-server-license-terms \
    &

sleep 2

for i in {1..120}; do
    curl --silent --fail "http://localhost:8000" >/dev/null

    if [ -f "$HOME/.vscode/cli/serve-web/lru.json" ]; then
        echo "vscode downloaded"
        exit 0
    fi

    echo "Waited ${i}s for vscode download..."

    sleep 1
done

echo "Timed out waiting for vscode download"
exit 1
