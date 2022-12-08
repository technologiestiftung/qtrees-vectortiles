#!/usr/bin/env bash
set -e
IFS=$'\n\t'

echo "system: Running $0"
echo "system: Creating tileset directory...$TILESET_DIR"
mkdir -p "$TILESET_DIR"

# download artifact from github actions and copy to $TILESET_DIR
echo "system: filtering build artifacts for tileset..."
# save output of command in variable
TILESET_URL=$(curl -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $GITHUB_TOKEN" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/repos/technologiestiftung/qtrees-vectortiles-generator/actions/artifacts | jq '.artifacts[] | select(.name == "tileset") | .archive_download_url')
echo "system: found the following url... $TILESET_URL"
# download via curl from  $TILESET_URL and unzip to $TILESET_DIR
echo "system: downloading tileset to tileset directory... $TILESET_DIR"
curl -o trees-tileset.zip "$TILESET_URL"
unzip trees-tileset.zip -d "$TILESET_DIR"

echo "mbtileserver: Starting tile server with args: $*"
mbtileserver "$@"
