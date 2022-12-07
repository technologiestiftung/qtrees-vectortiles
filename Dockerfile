ARG BASE_IMAGE=technologiestiftung/qtrees-vectortiles-generator-base:2.2.0
FROM $BASE_IMAGE

ENV POSTGRES_HOST postgres
ENV POSTGRES_DB postgres
ENV POSTGRES_USER postgres
ENV POSTGRES_PASSWORD postgres
# ARG TIPPICANOE_TAG=1.36.0
# ARG MBTILESERVER_TAG=0.8.2
# ARG GDAL_VERSION=3.2.2+dfsg-2+deb11u1
# ARG PYTHON3_GDAL_VERSION=3.2.2+dfsg-2+deb11u1
ARG TILESET_DIR=/tileset
ARG TMP_DIR=/tmp

ENV WORK_DIR /usr/app
ENV TILESET_DIR $TILESET_DIR
ENV TMP_DIR $TMP_DIR

WORKDIR ${WORK_DIR}

COPY ogr2ogr.sql ogr2ogr.sql
COPY entrypoint.sh entrypoint.sh
EXPOSE 8000
ENTRYPOINT [ "/usr/app/entrypoint.sh" ]
