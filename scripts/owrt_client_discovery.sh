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
for line in $(sudo /usr/sbin/nlbw -c csv -n -g mac,ip,fam -q |grep -v 00:00:00|tail -n+2)
# the grep -v 00:00:00 is here to prevent empty macs
do
  # trying to get the hostname
  # getting the mac & ip
  mac=$(echo $line |awk '{print $2}')
  ip=$(echo $line |awk '{print $3}')
  if [ $? -eq 0 ]
  then
    nsreturn=$(nslookup $ip |grep "name =")
        if [ $? -eq 0 ]
        then
                hostname=$(echo $nsreturn |awk '{print $4}')
        else
                hostname=$ip
        fi
    # fallback if hostname is not found
    if [ -z "$hostname" ]
    then
      hostname=$ip
    fi
  else
    hostname=$ip
  fi
  detail="${detail}{\"{#NETWORK_CLIENT}\":\"$hostname\",\"{#MACADDR}\": \"$mac\",\"{#IPADDR}\": \"$ip\"},"
done
total=$(echo $detail|sed 's/.$//') # we delete the last "," from our $detail
echo $total
echo ]}
