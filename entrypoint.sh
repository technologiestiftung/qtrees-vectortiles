#!/usr/bin/env bash
set -e
IFS=$'\n\t'

echo "Running $0"
rm -f /usr/app/out.full.geojson || true
ogr2ogr -f GeoJSON /usr/app/out.full.geojson "PG:host='$PGHOST' dbname='$PGDATABASE' user='$PGUSER' password='$PGPASSWORD'" -sql "SELECT * from api.trees;"
tippecanoe -zg -o /usr/app/trees.mbtiles --force --drop-densest-as-needed --extend-zooms-if-still-dropping /usr/app/out.full.geojson
cp /usr/app/trees.mbtiles /tilesets

# tippecanoe --help
# ogr2ogr --help-general
mbtileserver --dir /tilesets --enable-fs-watch "$@"
