#!/bin/bash

while true
do 
	owncloudcmd -n --non-interactive /ocdata $OC_PROTO://$OC_SERVER$OC_WEBDAV$OC_FILEPATH
	sleep $RUN_INTERVAL
done
