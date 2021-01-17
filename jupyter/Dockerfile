#
# Docker image for
#
# jupyter (based on https://hub.docker.com/r/continuumio/anaconda/)
#
#
# Create:
#
# sudo docker build --rm -t akaer/jupyter . 2>&1 |tee docker_build.log
#
# Run:
#
#  sudo docker run -d \
#   --name jupyter \
#   -v /etc/localtime:/etc/localtime:ro \
#   -v $(pwd)/notebooks:/notebooks \
#   -p 8888:8888 akaer/jupyter
#

FROM jupyter/scipy-notebook
LABEL maintainer "André Raabe <andre.raabe@gmail.com>"

ENV ORACLE_HOME "/usr/lib/oracle/12.1/client64"
ENV LD_LIBRARY_PATH "/usr/lib/oracle/12.1/client64:$LD_LIBRARY_PATH"

USER root

RUN set -xe \
    && sudo apt-get update \
    && sudo apt-get upgrade -y \
    && sudo apt-get install -y \
        curl \
        freetds-bin \
        freetds-common \
        freetds-dev \
        tdsodbc \
        libaio1 \
        tree \
        unixodbc \
        unixodbc-dev \
        unzip \
    && sudo rm -rf /var/lib/apt/lists/* \
    && echo "[TDS]" >/etc/freetds/tds.driver.template \
    && echo "Description     = FreeTDS Driver for Linux & MSSQL on Win32" >>/etc/freetds/tds.driver.template \
    && echo "Driver          = /usr/lib/x86_64-linux-gnu/odbc/libtdsodbc.so" >>/etc/freetds/tds.driver.template \
    && echo "Setup           = /usr/lib/x86_64-linux-gnu/odbc/libtdsS.so" >>/etc/freetds/tds.driver.template \
    && odbcinst -i -d -f /etc/freetds/tds.driver.template

ADD files/instantclient-basiclite-linux.x64-12.1.0.2.0.zip /tmp/
ADD files/instantclient-sdk-linux.x64-12.1.0.2.0.zip /tmp/
ADD files/instantclient-sqlplus-linux.x64-12.1.0.2.0.zip /tmp/

RUN set -xe \
    && cd /tmp \
    && unzip /tmp/instantclient-basiclite-linux.x64-12.1.0.2.0.zip \
    && unzip /tmp/instantclient-sqlplus-linux.x64-12.1.0.2.0.zip \
    && unzip /tmp/instantclient-sdk-linux.x64-12.1.0.2.0.zip \
    && mkdir -p /usr/lib/oracle/12.1/ \
    && mv /tmp/instantclient_12_1 ${ORACLE_HOME} \
    && ln -s ${ORACLE_HOME}/libclntsh.so.12.1 ${ORACLE_HOME}/libclntsh.so \
    && rm -f /tmp/*.zip \
    && touch /etc/ld.so.conf.d/oracle.conf \
    && ldconfig \
    && tree ${ORACLE_HOME}

USER $NB_USER

RUN set -xe \
    && pip install --upgrade pip \
    && pip install cx_oracle \
    && pip install pyodbc \
    && pip install xlwt \
    && pip install XlsxWriter \
    && pip install wordcloud

CMD [ "start-notebook.sh", "--NotebookApp.token=''" ]
