### sudo docker run --detach -p 8880:8880 --name=karaoke-forever-server -v /MNT-TO-DB-FILE/database.sqlite3:/usr/local/lib/node_modules/karaoke-forever/database.sqlite3 -v /MNT-TO-KARAOKE-FILES/FILES:/mnt/KARAOKE_FILES karaoke-forever-server ##
### default db path === /usr/local/lib/node_modules/karaoke-forever/database.sqlite3 ##

FROM node:lts

LABEL MAINTAINER="Ralph Jackson"
LABEL description="Karaoke Forever Node Server"

ARG PORT="8880"
ENV RUN_PORT ${PORT}

ARG CURRENT_VERSION="0.8.0"
ARG VERSION=${CURRENT_VERSION}

### SET TIMEZONE HERE
ENV TZ=America/New_York

### CHANGE TIME ZONE ##
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

### MAKE MOUNT DIR FOR VOLUME MOUNT ##
RUN mkdir /mnt/KARAOKE_FILES && chmod 0777 /mnt/KARAOKE_FILES

### INSTALL KARAOKE FORVER SERVER NPM ##
RUN npm -g config set user root \
    && npm -g install karaoke-forever@${VERSION}

### KARAOKE-FOREVER SERVER AT STARTUP ##
CMD [ "sh", "-c", "karaoke-forever-server --port $RUN_PORT" ]

### MAKE SURE PORT IS OPEN ON CONTAINER ##
EXPOSE $PORT
