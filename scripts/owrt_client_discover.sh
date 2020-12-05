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
for line in $(sudo /usr/sbin/nlbw -c csv -n -g mac -q|grep -v 00:00:00|tail -n+2)
# the grep -v 00:00:00 is here to prevent empty macs
do
  # trying to get the hostname
  mac=$(echo $line|awk '{print $1}')
  # getting the ip
  ip=$(arp -n |grep $mac)
  if [ ?$ -eq 0 ]
  then
    hostname=$(dig -x $(arp -n |grep $mac |awk '{print $2}'|awk -F'(' '{print $2}'| awk -F')' '{print $1}') +short)
    # fallback if ho  stname is not found
    if [ -z "$hostname" ]
    then
      hostname=$mac
    fi
  else
    hostname=$mac
  fi
  detail="${detail}{\"{#NETWORK_CLIENT}\": \"$hostname\",\"{#MACADDR}\": \"$mac\"},"
done
total=$(echo $detail|sed 's/.$//') # we delete the last "," from our $detail
echo $total
echo ]}


