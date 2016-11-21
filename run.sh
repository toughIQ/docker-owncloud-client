#!/bin/bash

while true
do 
	su - occlient -c "owncloudcmd -n --non-interactive /ocdata $OC_PROTO://$OC_SERVER$OC_URLPATH$OC_WEBDAV$OC_FILEPATH"
	sleep $RUN_INTERVAL
done
