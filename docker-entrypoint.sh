#!/bin/bash
set -e

# only add user if not already existent, otherwise container wont restart
if [ $(getent passwd occlient|wc -l) -eq 0 ]; then
	echo "[INFO] Adding user 'occlient' with uid $RUN_UID and gid $RUN_GID" | ts '%Y-%m-%d %H:%M:%.S'
	useradd --uid $RUN_UID --gid $RUN_GID -m --shell /bin/bash occlient
fi

netrc_file="/home/occlient/.netrc"
oc_server_without_port=$(echo $OC_SERVER | sed 's/\(.*\):.*/\1/')
cat <<EOF > $netrc_file
machine $oc_server_without_port
	login $OC_USER
	password $OC_PASS
EOF
chown $RUN_UID:$RUN_GID $netrc_file
chmod 600 $netrc_file

echo "[INFO] Chaning ownership of all files and directories in /ocdata to $RUN_UID:$RUN_GID" | ts '%Y-%m-%d %H:%M:%.S'
chown -R $RUN_UID:$RUN_GID /ocdata

exec $@
