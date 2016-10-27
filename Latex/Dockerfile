#
# Docker image for
#
# Latex
#
# WARNING: This is a BIG image after build. Mine is around 4.3 GByte.
#
# Create:
#
# sudo docker build -t akaer/latex .
#
# Run:
#
# sudo docker run --rm=true -it \
#   --name latex \
#   --user="$(id -u):$(id -g)" \
#   --net=none \
#   -v /etc/localtime:/etc/localtime:ro \
#   -v $(pwd):/data \
#   akaer/latex pdflatex <your-tex-file>
#

FROM ubuntu:16.04
MAINTAINER André Raabe <andre.raabe@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C.UTF-8
ENV LATEX_USER latex
ENV LATEX_HOME /home/${LATEX_USER}

RUN set -xe \
    && apt-get update \
    && apt-get install -y \
    aspell \
    aspell-de \
    aspell-de-alt \
    aspell-en \
    software-properties-common \
    texlive-fonts-recommended \
    texlive-full \
    texlive-latex-recommended \
    texlive-xetex \
    && rm -rf /var/lib/apt/lists/*

RUN useradd --create-home --home-dir ${LATEX_HOME} ${LATEX_USER} \
    && chown -R ${LATEX_USER}:${LATEX_USER} ${LATEX_HOME}

USER ${LATEX_USER}

VOLUME [ "/data" ]
WORKDIR /data

CMD [ "pdflatex", "--interaction=nonstopmode" ]

