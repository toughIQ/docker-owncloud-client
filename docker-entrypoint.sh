#!/bin/bash
set -e

# only add user if not already existent, otherwise container wont restart
if [ $(getent passwd occlient|wc -l) -eq 0 ]; then
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
chmod $RUN_UID:$RUN_GID $netrc_file

chown -R $RUN_UID:$RUN_GID /ocdata

exec $@
