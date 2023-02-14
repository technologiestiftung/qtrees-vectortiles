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
# echo "$POSTGREST_API_URL"
echo "$POSTGRES_MATERIALIZE_VIEW_NAME"
# echo "ts-node: Creating geojson file from api request..."
# npx ts-node --esm "$WORKDIR"/geojson-generator/index.ts
ogr2ogr \
  -f GeoJSON "$TMP_DIR/$GEOJSON_OUTPUT_FILENAME" \
  "PG:host='$POSTGRES_HOST' \
  dbname='$POSTGRES_DB' \
  user='$POSTGRES_USER' \
  password='$POSTGRES_PASSWORD'" \
  -sql "select * from $POSTGRES_MATERIALIZE_VIEW_NAME"

echo "tippecanoe: Creating tileset..."
tippecanoe \
  -zg \
  -o "$TMP_DIR/$TILESET_NAME" \
  --force \
  --drop-densest-as-needed \
  --extend-zooms-if-still-dropping \
  "$TMP_DIR/$GEOJSON_OUTPUT_FILENAME"

echo "system: Copying tileset to workdir directory..."
cp "$TMP_DIR"/"$TILESET_NAME" "$WORKDIR"
echo "tileset_path=$WORKDIR/$TILESET_NAME" >>"$GITHUB_OUTPUT"
echo "system: Upload tileset to s3 bucket"
aws s3api put-object --bucket "$AWS_BUCKET" --key "$TILESET_NAME" --body "$TMP_DIR/$TILESET_NAME"
