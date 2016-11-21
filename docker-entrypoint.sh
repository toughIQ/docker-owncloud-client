#!/bin/bash

useradd --uid $RUN_UID -m --shell /bin/bash occlient

netrc_file="/home/occlient/.netrc"
cat <<EOF > $netrc_file
machine $OC_SERVER
	login $OC_USER
	password $OC_PASS
EOF
chown occlient $netrc_file
chmod 600 $netrc_file

chown -R occlient /ocdata

exec $@
