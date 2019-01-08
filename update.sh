#!/bin/bash
REPO="https://github.com/btendrich/pi-clock-timer.git"
echo "Starting auto-update..."

RESPONSE=`curl -s http://www.apple.com/library/test/success.html | grep -i success`
COUNT=0
while [ "$RESPONSE" == "" ]
do
	if [ "$COUNT" -gt 5 ]
	then
		echo "Timed out waiting on the internet..."
		exit
	fi
	sleep 5
	RESPONSE=`curl -s http://www.apple.com/library/test/success.html | grep -i success`
	COUNT=$[$COUNT+1]
done

echo "Got ahold of github..."

if [ -d /home/pi/pi-clock-timer ]
then
	su -c "cd /home/pi/pi-clock-timer ; git pull origin master" pi
else
	su -c "cd /home/pi ; git clone ${REPO}" pi
fi

