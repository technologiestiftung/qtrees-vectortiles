#!/usr/bin/env bash
set -e
IFS=$'\n\t'

echo "system: Running $0"
echo "system: Creating tileset directory...$TILESET_DIR"
mkdir -p "$TILESET_DIR"
mkdir -p "$TMP_DIR"

echo "system: Removing old geojson files..."
rm -f "$TMP_DIR/$GEOJSON_OUTPUT_FILENAME" || true

echo "$TMP_DIR"
echo "$GEOJSON_OUTPUT_FILENAME"
echo "$POSTGREST_API_URL"
echo "$POSTGRES_MATERIALIZE_VIEW_NAME"
echo "ts-node: Creating geojson file from api request..."
npx ts-node --esm "$GITHUB_WORKSPACE"/geojson-generator/index.ts
# ogr2ogr \
#   -f GeoJSON "$TMP_DIR"/out.full.geojson \
#   "PG:host='$POSTGRES_HOST' \
#   dbname='$POSTGRES_DB' \
#   user='$POSTGRES_USER' \
#   password='$POSTGRES_PASSWORD'" \
#   -sql "@$GITHUB_WORKSPACE/ogr2ogr.sql"

echo "tippecanoe: Creating tileset..."
tippecanoe \
  -zg \
  -o "$TMP_DIR/$TILESET_NAME" \
  --force \
  --drop-densest-as-needed \
  --extend-zooms-if-still-dropping \
  "$TMP_DIR"/out.full.geojson

echo "system: Copying tileset to workdir directory..."
cp "$TMP_DIR"/"$TILESET_NAME" "$GITHUB_WORKSPACE"
echo "tileset_path=$GITHUB_WORKSPACE/$TILESET_NAME" >>"$GITHUB_OUTPUT"
echo "system: Upload tileset to s3 bucket"
aws s3api put-object --bucket "$AWS_BUCKET" --key "$TILESET_NAME" --body "$TMP_DIR/$TILESET_NAME"
