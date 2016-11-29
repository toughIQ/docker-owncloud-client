FROM resin/rpi-raspbian:latest
MAINTAINER toughIQ <toughiq@gmail.com>

ADD http://pub.sgripon.net/owncloud-client/rpi3/owncloud-client-2.2.4_armhf.deb /

RUN apt-get update \
    && dpkg -i --force-all *.deb \
    && apt-get install -y -f \
    && apt-get install -y libqt4-sql-sqlite \
    && rm -rf *.deb \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && rm -rf /usr/share/doc /usr/share/man /usr/share/locale /usr/share/info /usr/share/lintian

COPY *.sh /
WORKDIR /ocdata

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/run.sh"]

ENV OC_USER=oc_username \
    OC_PASS=oc_passwordORtoken \
    OC_PROTO=https \
    OC_SERVER=yourserver.com \
    OC_URLPATH=/ \
    OC_WEBDAV=remote.php/webdav \
    OC_FILEPATH=/ \
    TRUST_SELFSIGN=0 \
    RUN_INTERVAL=30 \
    RUN_UID=1000
