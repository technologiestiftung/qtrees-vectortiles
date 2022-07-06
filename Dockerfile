FROM golang:1.18.3-bullseye
# RUN  apt-get update && \
#   apt-get install -y \
#   software-properties-common

RUN apt-get update && apt-get install -y \
  ca-certificates \
  openssl \
  curl \
  make \
  git \
  build-essential \
  libsqlite3-dev \
  zlib1g-dev \
  gdal-bin \
  bash \
  g++
RUN go install github.com/consbio/mbtileserver@v0.8.2
WORKDIR /usr/app
RUN git clone --depth 1 --branch 1.36.0 https://github.com/mapbox/tippecanoe.git && \
  cd tippecanoe && \
  make -j && \
  make install && \
  cd .. && \
  rm -rf tippecanoe
COPY ogr2ogr.sql ogr2ogr.sql
COPY entrypoint.sh entrypoint.sh
ENTRYPOINT [ "/usr/app/entrypoint.sh" ]
