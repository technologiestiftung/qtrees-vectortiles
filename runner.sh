#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

echo "Running $0"
tippecanoe --help
ogr2ogr --help-general
/root/go/bin/mbtileserver --help
