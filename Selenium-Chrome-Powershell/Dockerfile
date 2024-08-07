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
# sudo docker run -d --rm -p 4444:4444 -p 7900:7900 --shm-size="2g" --name se-chrome-pwsh-1 -v $(pwd)/samples:/data:ro akaer/selenium-chrome-powershell
#
# Usage:
#
# sudo docker exec -it se-chrome-pwsh-1 /bin/bash
#
# or to run the sample directly
#
# sudo docker exec -it se-chrome-pwsh-1 pwsh -Command "Invoke-Pester -Output Detailed"
#
# Open VNC Display
#
# http://localhost:7900/?autoconnect=1&resize=scale&password=secret
#
#
# WARNING: Currently we are stuck with version 115 of Chrome as the PowerShell module for Selenium
# is still not fixed. See https://github.com/adamdriscoll/selenium-powershell/issues/234
# Also, there are some restrictions like taking screenshots within PowerShell:
#   The type initializer for 'Gdip' threw an exception.
#      System.Drawing.Common is not supported on non-Windows platforms. See
#      https://aka.ms/systemdrawingnonwindows for more information.
#

FROM selenium/standalone-chrome:115.0
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
        /var/tmp/* \
    && mkdir -p /home/seluser/.local/lib \
    && chown -R seluser:seluser /home/seluser

USER seluser

RUN set -xe \
    && pip3 install --upgrade setuptools \
    && pwsh -NoLogo -NoProfile -Command " \
        \$ErrorActionPreference = 'Stop' ; \
        \$ProgressPreference = 'SilentlyContinue' ; \
        Install-Module Pester,Selenium -Force"
