#!/usr/bin/env bash
set -e
IFS=$'\n\t'

echo "system: Running $0"
echo "system: Creating tileset directory...$TILESET_DIR"
mkdir -p "$TILESET_DIR"
export TILESET_NAME=$TILESET_NAME
export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
export AWS_BUCKET=$AWS_BUCKET
export AWS_DEFAULT_REGION=eu-central-1

echo "system: downloading tileset to tileset directory... $TILESET_DIR"
aws s3api get-object --bucket "$AWS_BUCKET" --key "$TILESET_NAME" "$TILESET_DIR/$TILESET_NAME"

echo "mbtileserver: Starting tile server with args: $*"
mbtileserver "$@"
