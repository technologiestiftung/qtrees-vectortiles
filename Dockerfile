FROM ubuntu:22.04
RUN  apt-get update && \
  apt-get install -y \
  software-properties-common && \
  add-apt-repository ppa:ubuntugis/ubuntugis-unstable
RUN apt-get update && apt-get install -y \
  ca-certificates \
  openssl \
  curl \
  golang \
  make \
  git \
  build-essential \
  libsqlite3-dev \
  zlib1g-dev \
  gdal-bin \
  bash \
  g++
RUN go install github.com/consbio/mbtileserver@v0.8.2
WORKDIR /usr/tools
RUN git clone --depth 1 --branch 1.36.0 https://github.com/mapbox/tippecanoe.git && \
  cd tippecanoe && \
  make -j && \
  make install
# ENV PATH="/usr/local/bin:${PATH}"
COPY runner.sh runner.sh
# RUN tippecanoe --help
# RUN ogr2ogr --help-general

ENV GOPATH="$HOME/go"
ENV GOROOT="$(go env GOROOT)"
ENV GOROOT="$HOME/go"
ENV PATH="$PATH:$GOROOT/bin:$GOPATH/bin"
# ENTRYPOINT [ /usr/tools/runner.sh ]
CMD [ /usr/tools/runner.sh  ]
# CMD [ "tail", "-f" , "/dev/null" ]