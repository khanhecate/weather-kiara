#!/bin/bash
LINK="https://www.msn.com/en-za/weather/today/Jepara,Jawa-Tengah,Indonesia/we-city?iso=ID&el=Q%2BcfsTcfNgHWbx86rveAzQ%3D%3D" # link weather must from www.msn.com

CURL=$(command -v curl)
if [[ -z $CURL ]]; then
	echo -e "${RED}ERROR !${CLEAR} please install curl to run this tool !"
fi


echo -e "${GREEN}Connecting to www.msn.com ...${CLEAR}"

if ! ls /tmp | grep -q "weather-kiara"; then
	mkdir /tmp/weather-kiara
fi

TMP_FILE="/tmp/weather-kiara/weather-kiara.tmp"
#weather
wget "$LINK" -O ${TMP_FILE} 2>/dev/null
WEATHER=$(cat ${TMP_FILE} |grep '<span class="current" aria-label="The current condition is Fair and the temperature is' | sed 's/<span class="current" aria-label="The current condition is Fair and the temperature is//g' | awk '{print $1}' )
LOCATION=$(cat ${TMP_FILE} |grep '<title>'| sed 's/<title>//g' | sed "s~</title>~~g" |sed "s/ - MSN Weather//g"|sed 's/^ *//' | sed 's/ *$//') 


echo ${LOCATION}  ${WEATHER}°C

rm $TMP_FILE