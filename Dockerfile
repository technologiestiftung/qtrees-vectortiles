ARG BASE_IMAGE=technologiestiftung/qtrees-vectortiles-generator-base:2.5
FROM $BASE_IMAGE

ARG TILESET_DIR=/tilesets
ARG TMP_DIR=/tmp
ARG TILESET_NAME=trees.mbtiles
ENV GITHUB_TOKEN "abc"
ENV WORK_DIR /usr/app
ENV TILESET_DIR $TILESET_DIR
ENV TMP_DIR $TMP_DIR
ENV TILESET_NAME $TILESET_NAME

COPY server.sh server.sh

EXPOSE 8000
ENTRYPOINT [ "/usr/app/server.sh" ]