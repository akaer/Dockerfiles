#
# Docker image for
#
# Selenium with Powershell (https://github.com/PowerShell/PowerShell)
#
#
# Create:
#
# sudo docker build --rm -t akaer/selenium-chrome-powershell . 2>&1 |tee docker_build.log
#
# Run:
#
# Usage:
#
# sudo docker exec -it se-chrome1 /bin/bash


FROM selenium/standalone-chrome-debug:latest
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

ENV POWERSHELL_TELEMETRY_OPTOUT=1
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8
ENV TZ=Europe/Berlin

VOLUME [ "/data" ]
WORKDIR /data

USER root

RUN set -xe \
    && ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && echo ${TZ} > /etc/timezone \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && apt-get update \
    && apt-get full-upgrade -y -q \
    && apt-get install -y --no-install-recommends \
        less \
        python3-pip \
        apt-transport-https \
        software-properties-common \
    && wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && rm -f packages-microsoft-prod.deb \
    && apt-get update \
    && add-apt-repository universe \
    && apt-get install -y --no-install-recommends \
        powershell \
        libgdiplus \
    && rm -rf \
        /usr/share/doc/* \
        /var/cache/* \
        /var/lib/apt/lists/* \
        /var/tmp/*

USER seluser

RUN set -xe \
    && pip3 install --upgrade setuptools \
    && pwsh -NoLogo -NoProfile -Command " \
        \$ErrorActionPreference = 'Stop' ; \
        \$ProgressPreference = 'SilentlyContinue' ; \
        Install-Module Pester,Selenium,PSScriptAnalyzer -Force"
