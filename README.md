# docker-owncloud-client
Dockerized OwnCloud CLI Client

__Work in progress!__

## Build
`docker build -t toughiq/owncloud-client:rpi .`

## RUN
```
docker run -d \
  --name occlient \
  -e OC_USER=owncloud_username \
  -e OC_PASS=owncloud_password \
  -e OC_SERVER=myowncloud.com \
  -v ${PWD}/ocdata:/ocdata \
  toughiq/owncloud-client:rpi

```

I also added a `docker-compose.yml` file with all available parameters, so its easier to setup your proper environment.

## Debugging
Run a `docker logs -f <YourContainerID>` to see what is happening.

## Environment Variables
### OC_USER
Username to connect to OwnCloud
### OC_PASS
Password or App-Token for Owncloud User. I recommend using an App-Token. This can be created in your Personal settings in OwnCloud Webinterface. Its called __App passwords__.
### OC_PROTO
Defaults to `https`. If you know what you are doing, you could change it to `http`. __Not recommended!__
### OC_SERVER
OwnCloud Server URL. eg. `myowncloud.com`
Since this is used for `.netrc` creation and CLI URL, just give the servername here. The protocol and path information is added by other variables.
### OC_URLPATH
Use this parameter to add a path to your OwnCloud instance. Like https://myserver.com__/owncloud__. In this case the value would be `/owncloud/`.
### OC_WEBDAV
This variable is fixed with most OwnCloud installations, so it might not be changed in normal usecases. It defaults to `remote.php/webdav`
### OC_FILEPATH
You can append a filepath, so the client will only sync from this path and below. eg. `/Photos` will only sync everything in the __Photos__ directory of your OwnCloud.
### RUN_INTERVAL
This specifies the interval in seconds at which the client will run and check for changes.
### RUN_UID
This is needed to ensure, that the data written to the mounted directory, is written as your user and not as root. There will be a user with this exact UID created within the container and `owncloudcmd` is executed as that user.
Defaults to `UID 1000` which is the common UID for desktop linux users. You can find your current UID by `id -u` on the commandline.
Currently the usage of `UID 0` for __root__ is not supported, since it would collide with the usercreation within the container. Will be changed later on.

## Loadtesting OwnCloud instances
__Do this at your own risk, only when know what you are doing and if the OwnCloud you test against belongs to you!__

Using this container in combination with Docker Swarm Mode can simulate concurrent clients and load/traffic patterns.

### Setup
#### Docker Swarm Mode
- Set up a Swarm by `docker swarm init`
- Optional add additional worker nodes `docker swarm join --token XXX <MasterIP>:<MasterPort>`

#### OwnCloud User
- Create/Prepare one or more Testusers in your OwnCloud.

#### Docker Service
Start one Container client:
```
docker service create \
  --name occlients \
  --env OC_SERVER=owncloud.yourdomain.com \
  --env OC_USER=YourOCuser \
  --env OC_PASS=YourOCpassword \
  toughiq/owncloud-client:rpi
```

See environment variables section, if you need to add some more values. Like __OC_URLPATH__ or __OC_FILEPATH__.
Mounting of a volume is not needed, since we dont want to write the data on the local host. For this tests its just fine, if the data only resides within the containers.

#### Scale Docker Service
Scale the __number__ of running containers up or down.
```
docker service scale occlients=<NUMBER>
```

#### Changing Files/Folders
If you want to change files and folders, which get synced to OwnCloud, you can use the webinterface and connect as the user specified in this test.
Or you could __exec__ into one of the running containers and change data within. `docker exec -it <ContainerID> bash`

#### Removing the Docker Service
To stop/remove the containers, just issue `docker service rm occlients`.
