### sudo docker run --detach -p 8880:8880 --name=karaoke-forever-server -v /MNT-TO-DB-FILE/database.sqlite3:/usr/local/lib/node_modules/karaoke-forever/database.sqlite3 -v /MNT-TO-KARAOKE-FILES/FILES:/mnt/KARAOKE_FILES karaoke-forever-server ##
### default db path === /usr/local/lib/node_modules/karaoke-forever/database.sqlite3 ##

FROM node:lts

LABEL MAINTAINER="Ralph Jackson"
LABEL description="Karaoke Forever NODE Server"

### SET TIMEZONE HERE
ENV TZ=America/New_York

ARG PORT="8880"
ENV RUN_PORT ${PORT}

ARG CURRENT_VERSION="0.8.0"
ARG VERSION=${CURRENT_VERSION}

### INSTALL CURL, CRON FOR SCANNING ##
RUN apt-get update && apt-get install -y --no-install-recommends \
    supervisor \
    cron && \
    rm -rf /var/lib/apt/lists/*

### CHANGE TIME ZONE ##
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

### MAKE MOUNT DIR FOR VOLUME MOUNT ##
RUN mkdir -p /mnt/KARAOKE_FILES /etc/supervisor/conf.d \ 
    && chmod 0777 /mnt/KARAOKE_FILES

### MAKE CRON AND SUPERVISOR CONF FILES ##
COPY scan_cron.sh /root/scan_cron.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN touch /etc/cron.d/kf-scanner-cron && \
    chmod 0744 /root/scan_cron.sh && chmod 0744 /etc/cron.d/kf-scanner-cron && \
    echo "42 03,15 * * * /root/scan_cron.sh >> /dev/stdout" > /etc/cron.d/kf-scanner-cron && \
    crontab /etc/cron.d/kf-scanner-cron && sed -i "s/RUUUN_POOORT/${RUN_PORT}/g" /etc/supervisor/conf.d/supervisord.conf

### INSTALL KARAOKE FORVER SERVER NPM ##
RUN npm -g config set user root \
    #&& npm -g install karaoke-forever@${VERSION}
    && npm -g install karaoke-forever@next

### KARAOKE-FOREVER SERVER AT STARTUP ##
CMD /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf

### MAKE SURE PORT IS OPEN ON CONTAINER ##
EXPOSE $PORT
