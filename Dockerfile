### sudo docker run --detach -p 8880:8880 --name=karaoke-forever-server -v /MNT-TO-DB-FILE/database.sqlite3:/usr/local/lib/node_modules/karaoke-forever/database.sqlite3 -v /MNT-TO-KARAOKE-FILES/FILES:/mnt/KARAOKE_FILES karaoke-forever-server ##
### default db path === /usr/local/lib/node_modules/karaoke-forever/database.sqlite3 ##

FROM node:lts

LABEL MAINTAINER="Ralph Jackson"
LABEL description="Karaoke Forever Node Server"

ARG CURRENT_VERSION="0.8.0"
ARG VERSION=${CURRENT_VERSION}

RUN mkdir /mnt/KARAOKE_FILES && chmod 0777 /mnt/KARAOKE_FILES \
    && npm -g config set user root \
    && npm -g install karaoke-forever@${VERSION}
    #&& npm -g install karaoke-forever@next

CMD [ "karaoke-forever-server", "--port", "8880" ]

EXPOSE 8880
