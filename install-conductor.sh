#!/usr/bin/env bash

set -euxo pipefail

CONDUCTOR_VERSION=0.4.1
EXTENSIONS_DIR="$HOME/.gemini/extensions"
CONDUCTOR_DIR="/home/node/.local/conductor/$CONDUCTOR_VERSION"

mkdir -p "$EXTENSIONS_DIR"

[ -e "$EXTENSIONS_DIR/conductor" -o -L "$EXTENSIONS_DIR/conductor" ] && {
        echo Conductor already installed in "$EXTENSIONS_DIR/conductor" >&2
        exit 1
}

ln -s "$CONDUCTOR_DIR" "$EXTENSIONS_DIR/conductor"

[ -e "$EXTENSIONS_DIR/extension-enablement.json" -o -L "$EXTENSIONS_DIR/extension-enablement.json" ] && {
        echo "$EXTENSIONS_DIR/extension-enablement.json already exists, not overriding"
        exit 2
}

ln -s "$CONDUCTOR_DIR/extension-enablement.json" "$EXTENSIONS_DIR/extension-enablement.json"
