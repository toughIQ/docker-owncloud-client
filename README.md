# docker-owncloud-client
Dockerized ownCloud CLI Client to sync from any supported OwnCloud enviroments.
I forked the original project to be able to run TransIP's STACK in a docker.

## Docker Features
* Base: Debian 10
* Latest ownCloud Client from the OpenSUSE repositories
* Size: < 250MB
* Ability to only sync only one folder

## Build
`docker build -t dyonr/docker-owncloud-client .`

## Run
```
docker run -d \
  --name occlient \
  -e OC_USER=owncloud_username \
  -e OC_PASS=owncloud_password \
  -e OC_SERVER=myowncloud.com \
  -v ${PWD}/ocdata:/ocdata \
  toughiq/owncloud-client

```

I also added a `docker-compose.yml` file with all available parameters, so its easier to setup your proper environment. Change values to match your environment and run with `docker-compose up -d`


# Environment Variables & Volumes
## Environment Variables
| Variable | Required | Function | Example | Default |
|----------|----------|----------|----------|----------|
|`OC_USER`| Yes | Username to connect to ownCloud |`OC_USER=dyonr`||
|`OC_PASS`| Yes | Password or App-Token for the ownCloud user |`OC_PASS=ac98df79ed7fb`||
|`OC_SERVER`| Yes | ownCloud Server URL, with, if necessary, with port |`OC_SERVER=example.com:8443`||
|`OC_PROTO`| No | Connect via http or https. |`OC_PROTO=https`|`https`|
|`OC_URLPATH`| No | Server path to the ownCloud instance (like https://example.com:8443**/owncloud/** |`OC_URLPATH=/owncloud/`| `/owncloud/`|
|`OC_WEBDAV`| No | In case the webdav path is not `remote.php/webdav`, you can change it here |`OC_WEBDAV=remote.php/webdav`| `remote.php/webdav` |
|`OC_FILEPATH`| No | Only sync one specific folder |`OC_FILEPATH=/Pictures/Holiday-2020` ||
|`TRUST_SELFSIGN`| No | Ignore self-signed certificate errors. Set to `1` to ignore errors)|`TRUST_SELFSIGN=002`|`0`|
|`SYNC_HIDDEN`| No | Set to `1` to sync all hidden files within the specified ownCloud directory (equivalent to owncloudcmd -h) |`SYNC_HIDDEN=0`|`0`|
|`SILENCE_OUTPUT`| No | Set to `0` to get more verbose output |`SILENCE_OUTPUT=1`|`1`|
|`RUN_INTERVAL`| No | Interval in seconds at which the client will run and check for changes |`RUN_INTERVAL=60` |???|
|`RUN_UID`| No | Only sync one specific folder |`RUN_UID=1000`|`1000`|

## Volumes
| Volume | Required | Function | Example |
|----------|----------|----------|----------|
| `ocdata` | Yes | ownCloud sync location | `/your/ocdata/path/:/ocdata`|

## Debugging
Run a `docker logs -f <YourContainerID>` to see what is happening.

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
  toughiq/owncloud-client
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
