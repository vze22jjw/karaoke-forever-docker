# karaoke-forever-docker
docker container for karaoke-forever software:

    https://www.karaoke-forever.com/

docker-ce is needed to build and run
after running bash script can run like below, with mount points to a db file that will persist through docker runs and your karaoke music files

sudo docker run --detach -p 8880:8880 --name=karaoke-forever-server -v /MNT-TO-DB-FILE/database.sqlite3:/usr/local/lib/node_modules/karaoke-forever/database.sqlite3 -v /MNT-TO-KARAOKE-FILES/FILES:/mnt/KARAOKE_FILES karaoke-forever-server

THE programs default DB path is:
default db path === /usr/local/lib/node_modules/karaoke-forever/database.sqlite3

