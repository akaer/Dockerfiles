#
# Docker image for
#
# Datasette
#
#
# Create:
#
# sudo docker build --rm -t akaer/datasette . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run -it \
#   --rm -h datasette \
#   --name datasette \
#   -v $(pwd)/datasette:/mnt \
#   -p 8001:8001 akaer/datasette datasette -p 8001 -h 0.0.0.0 /mnt/lotto_data.db --create
#

FROM datasetteproject/datasette:latest
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive

RUN set -ex \
    && apt-get update \
    && apt-get install -q -y \
        coreutils \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/* \
    && pip install \
        datasette-copyable \
        datasette-dateutil \
        datasette-edit-schema \
        datasette-gzip \
        datasette-insert \
        datasette-render-binary \
        datasette-render-markdown \
        datasette-saved-queries \
        datasette-upload-dbs \
        datasette-vega \
        datasette-write \
        sqlite-utils

EXPOSE 8001
CMD ["datasette"]
