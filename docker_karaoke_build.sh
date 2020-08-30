#!/bin/bash
### MUST BE RUN IN SAME DIR AS DOCKERFILE

DOCKER_IMAGE_NAME="karaoke-forever-server"
STABLE="0.8.0"
BETA="latest"
ALPHA="next"
VERSION=$STABLE
IMAGE_DATE="336h"
echo "INSTALLED VERSION WILL BE $VERSION. IMAGES NOT USED WILL BE CLEANED STARTING FROM $IMAGE_DATE AGO..."

## IF BETA version don't make two latest tags
if [ "$VESRION" == "latest" ]; then
    docker build -f /volume1/VOLUME1/DATA_BACKUP/DOCKER_BUILDS/docker_karaoke_forever/Dockerfile . \
    --build-arg CURRENT_VERSION=$VERSION -t "$DOCKER_IMAGE_NAME":latest
else
    docker build -f /volume1/VOLUME1/DATA_BACKUP/DOCKER_BUILDS/docker_karaoke_forever/Dockerfile . \
    --build-arg CURRENT_VERSION=$VERSION \
    -t "$DOCKER_IMAGE_NAME":latest -t "$DOCKER_IMAGE_NAME":"$VERSION"
fi

## CLEAN UP DOCKER VOLUMES AND IMAGES older than a week
docker image prune -a --force --filter "until=${IMAGE_DATE}"
docker volume prune --force
