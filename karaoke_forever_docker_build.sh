#!/bin/bash
### MUST BE RUN IN SAME DIR AS THE DOCKERFILE

DOCKER_IMAGE_NAME="karaoke-forever-server"

### SERVER PORT FOR KARAOKE SERVER
PORT="8880"

### VERSIONS OF NODE NPM TO PASS TO DOCKER BUILD
STABLE="0.8.0"
BETA="latest"
ALPHA="next"
VERSION=$STABLE

### 14 RETENTION FOR DOCKER IMAGES AND VOLUMES NOT USED IN AN ACTIVE DOCKER RUN
IMAGE_DATE="336h"

echo "INSTALLED VERSION WILL BE $VERSION. IMAGES NOT USED WILL BE CLEANED STARTING FROM $IMAGE_DATE AGO..."

### IF LATEST VERSION DON'T CREATE TWO TAGS
if [ "$VESRION" == "latest" ]; then
    docker build -f /volume1/VOLUME1/DATA_BACKUP/DOCKER_BUILDS/karaoke-forever-docker/Dockerfile . \
    --build-arg CURRENT_VERSION=$VERSION --build-arg PORT=$PORT -t "$DOCKER_IMAGE_NAME":latest
else
    ### MAKE A LATEST TAG AS WELL AS VERSION TAG
    docker build -f /volume1/VOLUME1/DATA_BACKUP/DOCKER_BUILDS/karaoke-forever-docker/Dockerfile . \
    --build-arg CURRENT_VERSION=$VERSION --build-arg PORT=$PORT \
    -t "$DOCKER_IMAGE_NAME":latest -t "$DOCKER_IMAGE_NAME":"$VERSION"
fi

### CLEAN UP DOCKER VOLUMES AND IMAGES older than a week
docker image prune -a --force --filter "until=${IMAGE_DATE}"
docker volume prune --force
