#!/bin/bash
set -e

# check if we should trust selfsigned certificates
if [ "$TRUST_SELFSIGN" -eq 1 ]; then
	echo "[INFO] TRUST_SELFSIGN is set to $TRUST_SELFSIGN, setting run parameter '--trust'" | ts '%Y-%m-%d %H:%M:%.S'
	SELFSIGN="--trust"
fi

# check if we should sync hidden files
if [ "$SYNC_HIDDEN" -eq 1 ]; then
	echo "[INFO] SYNC_HIDDEN is set to $SYNC_HIDDEN, setting run parameter '-h'" | ts '%Y-%m-%d %H:%M:%.S'
	SYNCHIDDEN='-h'
fi

# check if we should silence output
if [ "$SILENCE_OUTPUT" -eq 1 ]; then
	echo "[INFO] SILENCE_OUTPUT is set to $SILENCE_OUTPUT, setting run parameter '--silent'" | ts '%Y-%m-%d %H:%M:%.S'
	SILENCEOUTPUT='--silent'
fi

echo "[INFO] Running owncloudcmd as following:" | ts '%Y-%m-%d %H:%M:%.S'
echo "[INFO] owncloudcmd $SELFSIGN $SYNCHIDDEN $SILENCEOUTPUT -n --non-interactive /ocdata $OC_PROTO://$OC_SERVER$OC_URLPATH$OC_WEBDAV$OC_FILEPATH" | ts '%Y-%m-%d %H:%M:%.S'
while true
do 
	su - occlient -c "owncloudcmd $SELFSIGN $SYNCHIDDEN $SILENCEOUTPUT -n --non-interactive /ocdata $OC_PROTO://$OC_SERVER$OC_URLPATH$OC_WEBDAV$OC_FILEPATH"
	sleep $RUN_INTERVAL
done
