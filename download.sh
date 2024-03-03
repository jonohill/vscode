#!/usr/bin/env sh

set -e

check_tool() {
    for tool in "$@"; do
        if ! command -v "$tool" > /dev/null; then
            echo "This script requires $tool"
            exit 1
        fi
    done
}

check_tool curl

if [ "$TARGETPLATFORM" = "linux/amd64" ]; then
  code_arch="x64"
elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then
  code_arch="arm64"
elif [ "$TARGETPLATFORM" = "linux/arm/v7" ]; then
  code_arch="armhf"
else
  echo "This script doesn't know what TARGETPLATFORM \"$TARGETPLATFORM\" is, sorry!"
fi

url="https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-${code_arch}"

curl --fail -L "$url" -o /tmp/vscode.tgz
tar -xvf /tmp/vscode.tgz -C /tmp/
