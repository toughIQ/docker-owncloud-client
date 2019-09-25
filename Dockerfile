FROM debian:8
MAINTAINER toughIQ <toughiq@gmail.com>

RUN mkdir -p /opt/scripts

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && rm -rf /usr/share/doc /usr/share/man /usr/share/locale /usr/share/info /usr/share/lintian


RUN echo 'deb http://download.opensuse.org/repositories/isv:/ownCloud:/desktop/Debian_8.0/ /' > /etc/apt/sources.list.d/owncloud-client.list \
    && wget http://download.opensuse.org/repositories/isv:ownCloud:desktop/Debian_8.0/Release.key \
    && apt-key add - < Release.key \
    && apt-get update \
    && apt-get install -yq --no-install-recommends owncloud-client \
    && apt-get upgrade -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && rm -rf /usr/share/doc /usr/share/man /usr/share/locale /usr/share/info /usr/share/lintian

COPY *.sh /opt/scripts/
WORKDIR /ocdata

ENTRYPOINT ["/opt/scripts/docker-entrypoint.sh"]
CMD ["/opt/scripts/run.sh"]

ENV OC_USER=oc_username \
    OC_PASS=oc_passwordORtoken \
    OC_PROTO=https \
    OC_SERVER=yourserver.com \
    OC_URLPATH=/ \
    OC_WEBDAV=remote.php/webdav \
    OC_FILEPATH=/ \
    TRUST_SELFSIGN=0 \
    SYNC_HIDDEN=0 \
    SILENCE_OUTPUT=1 \
    RUN_INTERVAL=30 \
    RUN_UID=1000
