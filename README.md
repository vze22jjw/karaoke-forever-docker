# karaoke-forever-docker
docker container for karaoke-forever software:

    https://www.karaoke-forever.com/

Prerequsites:
- docker-ce or somethin running a Docker plugin is needed to build and run
- linux or bash interupter to run script

After running bash script or just building container with docker you can run like below, with mount points to a db file that will persist through docker runs and path to your karaoke music files.  The file database.sqlite3, can be a blank one initally but must exist to run below.

sudo docker run --detach -p 8880:8880 --name=karaoke-forever-server -v /MNT-TO-DB-FILE/database.sqlite3:/usr/local/lib/node_modules/karaoke-forever/database.sqlite3 -v /MNT-TO-KARAOKE-FILES/FILES:/mnt/KARAOKE_FILES karaoke-forever-server

THE programs default DB path is:
default db path === /usr/local/lib/node_modules/karaoke-forever/database.sqlite3


Initial Run without persistant DB:

This will not retain any data. You will need to create users, stars and scan music files again.  This is a good starting point to get the db file populated for above persisant future runs.

sudo docker run --detach -p 8880:8880 --name=karaoke-forever-server -v /MNT-TO-KARAOKE-FILES/FILES:/mnt/KARAOKE_FILES karaoke-forever-server
