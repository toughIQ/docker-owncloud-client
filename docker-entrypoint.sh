#!/bin/bash

useradd --u 1000 occlient
chown -R occlient /ocdata

exec $@
