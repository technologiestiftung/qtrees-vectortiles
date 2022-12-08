#!/usr/bin/env bash
set -e
IFS=$'\n\t'

echo "system: Running $0"
echo "system: Creating tileset directory...$TILESET_DIR"
mkdir -p "$TILESET_DIR"

echo "system: downloading tileset to tileset directory... $TILESET_DIR"

# download artifact from github actions and copy to $TILESET_DIR
curl -L -o "$TILESET_DIR/$TILESET_NAME" "$TILESET_URL"

echo "mbtileserver: Starting tile server with args: $*"
mbtileserver "$@"
