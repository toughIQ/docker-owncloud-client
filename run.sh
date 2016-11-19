#!/bin/bash

while true
do 
	owncloudcmd --user $OC_USER --password $OC_PASS /occlient $OC_SERVER$OC_WEBDAV$OC_FILEPATH
	sleep $RUN_INTERVAL
done
