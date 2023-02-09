
alias b := build-base

default:
	just --list

build-base:
	docker build --tag qtrees-vectortiles-generator-base:test --file ./Dockerfile.base .