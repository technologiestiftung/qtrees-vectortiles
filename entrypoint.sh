#!/usr/bin/env bash
set -e
IFS=$'\n\t'

WORKDIR=/usr/app
TILESETDIR=/tilesets

echo "Running $0"
rm -f $WORKDIR/out.full.geojson || true
ogr2ogr -f GeoJSON $WORKDIR/out.full.geojson "PG:host='$PGHOST' dbname='$PGDATABASE' user='$PGUSER' password='$PGPASSWORD'" -sql @$WORKDIR/ogr2ogr.sql
tippecanoe -zg -o $WORKDIR/trees.mbtiles --force --drop-densest-as-needed --extend-zooms-if-still-dropping $WORKDIR/out.full.geojson
cp $WORKDIR/trees.mbtiles $TILESETDIR

mbtileserver --dir $TILESETDIR --enable-fs-watch "$@"
