# docker-owncloud-client
Dockerized OwnCloud CLI Client

__Work in progress!__

## Build
`docker build -t toughiq/owncloud-client .`

## RUN
```
docker run -d \
  --name occlient \
  -e OC_USER=owncloud_username \
  -e OC_PASS=owncloud_password \
  -e OC_SERVER=https://myowncloud.com \
  -v ${PWD}/ocdata:/occlient \
  toughiq/owncloud-client

```
## Environment Variables
### OC_USER
Username to connect to OwnCloud
### OC_PASS
Password or App-Token for Owncloud User. I recommend using an App-Token. This can be created in your Personal settings in OwnCloud Webinterface. Its called __App passwords__.
### OC_SERVER
OwnCloud Server URL. eg. `https://myowncloud.com` or `https://myserver.com/owncloud`
### OC_WEBDAV
This variable is fixed with most OwnCloud installations, so it might not be changed in normal usecases. It defaults to `/remote.php/webdav`
### OC_FILEPATH
You can append a filepath, so the client will only sync from this path and below. eg. `/Photos` will only sync everything in the __Photos__ directory of your OwnCloud.
### RUN_INTERVAL
This specifies the interval in seconds at which the client will run and check for changes.

