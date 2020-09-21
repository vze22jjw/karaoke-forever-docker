#!/bin/bash
### CRON TO LOGIN AND RUN A SCAN
### DATA FORMATS
#DATA="{"username":"kadmin","password":"kadmin-1603","roomId":"11"}"
#DATA='"{\"username\":\"kadmin\",\"password\":\"kadmin-1603\",\"roomId\":\"11\"}"'

LOGIN_URL="http://ackshunjackson.duckdns.org:8880/api/login"
SCAN_URL="http://ackshunjackson.duckdns.org:8880/api/prefs/scan"
USERNAME="kadmin"
PASSWORD="kadmin-1603"
ROOMID="1"
TOKEN_NAME="kfToken"
TMP_COOKIES="/tmp/karaoke-cookies.txt"

generate_post_data()
{
  cat <<EOF
{ 
    "username":"$USERNAME",
    "password":"$PASSWORD",
    "roomId":"$ROOMID"
}
EOF
}

rm -rf $TMP_COOKIES && touch $TMP_COOKIES
ECHO "GETTING LOGIN COOKIES..."
curl -i --cookie-jar $TMP_COOKIES -d "$(generate_post_data)" \
    -H "Content-Type: application/json" -X POST $LOGIN_URL

if grep -q "$TOKEN_NAME" $TMP_COOKIES
    then
    echo $?
    echo -e "\n RUNNING SCAN NOW..."
    curl --cookie $TMP_COOKIES -H "Content-Type: application/json" $SCAN_URL
    else
    echo -e "\n TOKEN STRING $TOKEN_NAME NOT FOUND, EXITING..."
    exit 1
fi 
