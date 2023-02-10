export TEST_GEOJSON_FILE_PATH := "/tmp/out.full.geojson"
export TMP_DIR := "/tmp"
export GEOJSON_OUTPUT_FILENAME := "out.full.geojson"
export POSTGREST_API_URL := "http://localhost:3000"
export POSTGRES_MATERIALIZE_VIEW_NAME := "vector_tiles"
alias b := build-base
alias t := test
alias g := generate-geojson
default:
	just --list

generate-geojson:
  npx ts-node --esm geojson-generator/index.ts


build-base:
	docker build --tag qtrees-vectortiles-generator-base:test --file ./Dockerfile.base .

test:
  node --loader ts-node/esm --test __tests__/**.test.ts
