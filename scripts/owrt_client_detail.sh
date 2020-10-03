##########################################
# Detail script for zabbix owrt client
##########################################
# Author : Stephane DEWITTE
# stephane.dewitte@gmail.com
##########################################
IFS=$'\n'
for line in $(sudo /usr/sbin/nlbw -c csv -n -g host -q|tail -n+2)
do
  ip=$(echo $line|awk '{print $2}')
  hostname=$(dig -x $ip +short)
  if [ "$ip" == "$1" ]; then
    if [ "$#" -eq 1 ]
    then
      echo $line
    fi
    if [ "$#" -eq 2 ]
    then
      echo $line |awk -v myindex="$2" '{print $myindex}'
    fi
  fi
done