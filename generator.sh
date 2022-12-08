#!/usr/bin/env bash
set -e
IFS=$'\n\t'

echo "system: Running $0"
echo "system: Creating tileset directory...$INPUT_TILESET_DIR"
mkdir -p "$INPUT_TILESET_DIR"
mkdir -p "$INPUT_TMP_DIR"

echo "system: Removing old geojson files..."
rm -f "$INPUT_TMP_DIR"/out.full.geojson || true

echo "ogr2ogr: Creating geojson file from sql query"
ogr2ogr \
  -f GeoJSON "$INPUT_TMP_DIR"/out.full.geojson \
  "PG:host='$INPUT_POSTGRES_HOST' \
  dbname='$INPUT_POSTGRES_DB' \
  user='$INPUT_POSTGRES_USER' \
  password='$INPUT_POSTGRES_PASSWORD'" \
  -sql @"$GITHUB_WORKSPACE"/ogr2ogr.sql

echo "tippecanoe: Creating tileset..."
tippecanoe \
  -zg \
  -o "$INPUT_TMP_DIR/$INPUT_TILESET_NAME" \
  --force \
  --drop-densest-as-needed \
  --extend-zooms-if-still-dropping \
  "$INPUT_TMP_DIR"/out.full.geojson

echo "system: Copying tileset to workdir directory..."
cp "$INPUT_TMP_DIR"/"$INPUT_TILESET_NAME" "$GITHUB_WORKSPACE"
echo "tileset_path=$GITHUB_WORKSPACE/$INPUT_TILESET_NAME" >>"$GITHUB_OUTPUT"
