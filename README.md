# docker-owncloud-client
Dockerized ownCloud CLI Client (owncloudcmd) to sync from any supported ownCloud enviroment.  
This container should work with ownCloud, NextCloud, TransIP STACK and any other ownCloud/NextCloud based storage endpoints.

I forked the original project to be able to run TransIP's STACK in a docker.

## Docker Features
* Base: Debian 10
* Latest ownCloud Client from the OpenSUSE repositories
* Size: <100MB
* **Ability to only sync only one folder**
* Created with [Unraid](https://unraid.net/) in mind


# Run container from Docker registry
The container is available from the Docker registry and this is the simplest way to get it.

To run the container use this command:
```
$ docker run -d \
             --name='owncloud-client' \
             -v /your/ocdata/path/:/ocdata \
             -e OC_USER=owncloud_username \
             -e OC_PASS=owncloud_password \
             -e OC_SERVER=myowncloud.com \
             --restart unless-stopped \
             'dyonr/owncloud-client'
```

# Environment Variables & Volumes
## Environment Variables
| Variable | Required | Function | Example | Default |
|----------|----------|----------|----------|----------|
|`OC_USER`| Yes | Username to connect to ownCloud |`OC_USER=dyonr`||
|`OC_PASS`| Yes | Password or App-Token for the ownCloud user |`OC_PASS=ac98df79ed7fb`||
|`OC_SERVER`| Yes | ownCloud Server URL, with, if necessary, with port |`OC_SERVER=example.com:8443`||
|`OC_PROTO`| No | Connect via http or https. |`OC_PROTO=https`|`https`|
|`OC_URLPATH`| No | Server path to the ownCloud instance (example: https://example.com:8443/owncloud/ becomes `/owncloud/` |`OC_URLPATH=/owncloud/`| `/owncloud/`|
|`OC_WEBDAV`| No | In case the webdav path is not `remote.php/webdav`, you can change it here |`OC_WEBDAV=remote.php/webdav`| `remote.php/webdav` |
|`OC_FILEPATH`| No | Only sync one specific folder |`OC_FILEPATH=/Pictures/Holiday-2020`|`/`|
|`TRUST_SELFSIGN`| No | Ignore self-signed certificate errors. Set to `1` to ignore SSL errors)|`TRUST_SELFSIGN=0`|`0`|
|`SYNC_HIDDEN`| No | Set to `1` to sync all hidden files within the specified ownCloud directory|`SYNC_HIDDEN=0`|`0`|
|`SILENCE_OUTPUT`| No | Set to `0` to get more verbose output |`SILENCE_OUTPUT=1`|`1`|
|`RUN_INTERVAL`| No | Interval in seconds at which the client will run and check for changes |`RUN_INTERVAL=60`|`30`|
|`RUN_UID`| No |  |`RUN_UID=1000`|`1000`|

## Volumes
| Volume | Required | Function | Example |
|----------|----------|----------|----------|
| `ocdata` | Yes | ownCloud sync location | `/your/ocdata/path/:/ocdata`|

## Ports
This Docker container exposes no ports, has no UI and therfore does not need to have any ports exposed.

# Issues
If you are having issues with this container please submit an issue on GitHub.
Please provide logs, Docker version and other information that can simplify reproducing the issue.
Using the latest stable verison of Docker is always recommended. Any support is on a best-effort basis.
