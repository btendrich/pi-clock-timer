#!/bin/bash

gpio mode 8 output
gpio write 8 1

service ntp restart

while :
do
	cp /home/pi/pi-clock-timer/clock_720 /tmp/clock_720
	/tmp/clock_720
	sleep 1
done

