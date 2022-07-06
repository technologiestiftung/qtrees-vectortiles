#!/usr/bin/env bash
set -e
IFS=$'\n\t'

echo "system: Running $0"
echo "system: Creating tileset directory...$TILESET_DIR"
mkdir -p "$TILESET_DIR"

echo "system: Removing old geojson files..."
rm -f "$WORK_DIR"/out.full.geojson || true

echo "ogr2ogr: Creating geojson file from sql query"
ogr2ogr \
  -f GeoJSON "$WORK_DIR"/out.full.geojson \
  "PG:host='$POSTGRES_HOST' \
  dbname='$POSTGRES_DB' \
  user='$POSTGRES_USER' \
  password='$POSTGRES_PASSWORD'" \
  -sql @"$WORK_DIR"/ogr2ogr.sql

echo "tippecanoe: Creating tileset..."
tippecanoe \
  -zg \
  -o "$WORK_DIR"/trees.mbtiles \
  --force \
  --drop-densest-as-needed \
  --extend-zooms-if-still-dropping \
  "$WORK_DIR"/out.full.geojson

echo "system: Copying tileset to tileset directory..."
cp "$WORK_DIR"/trees.mbtiles "$TILESET_DIR"

echo "mbtileserver: Starting tile server with args: $*"
mbtileserver "$@"
