#!/bin/bash

# Check if the PGID exists, if not create the group with the name 'occlient'
grep $"${RUN_GID}:" /etc/group > /dev/null 2>&1
if [ $? -eq 0 ]; then
	echo "[INFO] A group with PGID $RUN_GID already exists in /etc/group, nothing to do." | ts '%Y-%m-%d %H:%M:%.S'
else
	echo "[INFO] A group with PGID $RUN_GID does not exist, adding a group called 'occlient' with PGID $RUN_GID" | ts '%Y-%m-%d %H:%M:%.S'
	groupadd -g $RUN_GID occlient
fi

# Check if the PUID exists, if not create the user with the name 'occlient', with the correct group
grep $"${RUN_UID}:" /etc/passwd > /dev/null 2>&1
if [ $? -eq 0 ]; then
	echo "[INFO] An user with PUID $RUN_UID already exists in /etc/passwd, nothing to do." | ts '%Y-%m-%d %H:%M:%.S'
else
	echo "[INFO] An user with PUID $RUN_UID does not exist, adding an user called 'occlient user' with PUID $RUN_UID" | ts '%Y-%m-%d %H:%M:%.S'
	useradd --comment "occlient user" --gid $RUN_GID --uid $RUN_UID --create-home --shell /bin/bash occlient
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
