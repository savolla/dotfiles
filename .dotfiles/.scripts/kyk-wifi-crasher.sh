#!/bin/bash
while true
do
	nmcli r wifi off
	nmcli r wifi on
	sleep 12
done
	
