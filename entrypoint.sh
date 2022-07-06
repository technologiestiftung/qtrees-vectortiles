#!/usr/bin/env bash
set -e
IFS=$'\n\t'

echo "system: Running $0"
echo "system: Creating tileset directory...$TILESETDIR"
mkdir -p "$TILESETDIR"
echo "system: Removing old geojson files..."
rm -f "$WORKDIR"/out.full.geojson || true
echo "ogr2ogr: Creating geojson file from sql query"
ogr2ogr -f GeoJSON "$WORKDIR"/out.full.geojson "PG:host='$PGHOST' dbname='$PGDATABASE' user='$PGUSER' password='$PGPASSWORD'" -sql @"$WORKDIR"/ogr2ogr.sql
echo "tippecanoe: Creating tileset..."
tippecanoe -zg -o "$WORKDIR"/trees.mbtiles --force --drop-densest-as-needed --extend-zooms-if-still-dropping "$WORKDIR"/out.full.geojson
echo "system: Copying tileset to tileset directory..."
cp "$WORKDIR"/trees.mbtiles "$TILESETDIR"
echo "mbtileserver: Starting tile server with args: $*"
mbtileserver "$@"
