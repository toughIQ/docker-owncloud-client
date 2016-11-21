#!/bin/bash
set -e

# check if we should trust selfsigned certificates
if [ "$TRUST_SELFSIGN" eq 1 ]; then
  SELFSIGN="--trust"
fi

while true
do 
	su - occlient -c "owncloudcmd $SELFSIGN -n --non-interactive /ocdata $OC_PROTO://$OC_SERVER$OC_URLPATH$OC_WEBDAV$OC_FILEPATH"
	sleep $RUN_INTERVAL
done
