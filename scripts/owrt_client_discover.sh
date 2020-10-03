#!/bin/sh
##########################################
# Discovery script for zabbix owrt client
##########################################
# Author : Stephane DEWITTE
# stephane.dewitte@gmail.com
##########################################
IFS=$'\n'
detail=""
echo {\"data\":[
for line in $(sudo /usr/sbin/nlbw -c show -n -g host|grep -v 00:00:00|tail -n+2)
# the grep -v 00:00:00 is here to prevent empty macs
do
  # trying to get the hostname
  ip=$(echo $line|awk '{print $1}')
  hostname=$(dig -x $ip +short)
  # fallback if hostname is not found
  if [ -z "$hostname" ]
  then
    hostname=$ip
  fi
  detail="${detail}{\"{#NETWORK_CLIENT}\": \"$hostname\",\"{#NETWORK_IP}\": \"$ip\"},"
done
total=$(echo $detail|sed 's/.$//') # we delete the last "," from our $detail
echo $total
echo ]}
