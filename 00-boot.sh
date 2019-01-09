#!/bin/bash

gpio mode 8 output
gpio write 8 1

service ntp restart

while :
do
	sleep 5
	service ntp restart
	/home/pi/pi-clock-timer/00-run.rb
done

