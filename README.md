## Zabbix Opewrt Clients monitor

The purpose of this repository is to allow data collector for openwrt clients, using zabbix-agent. It gets download total bytes, upload total bytes, 
upload total packets, et download total packets for every client.

It doesn't contain any alert, the goal is only to get data, for example to create graphs.

### Prerequisites

You must have zabbix-agent installed and configured to be used with a zabbix server.

You must have luci-app-nlbwmon and sudo installed :
``` 
opkg update
opkg install luci-app-nlbwmon
opkg install sudo
```

User zabbix must be enable to launch */usr/sbin/nlbw* without password. 
In order to do that, please add the following line in your /etc/sudoers file (or in /etc/sudoers.d/zabbix)
```angular2
zabbix ALL=(ALL) NOPASSWD: /usr/sbin/nlbw
```

### Installation 
* copy the owrt_zabbix_userparameter.conf file in /etc/zabbix_agentd.conf.d directory
* create the /etc/zabbix_agentd.conf.d/scripts directory
* copy the owrt_client_discover.sh and the owrt_client_detail.sh in the /etc/zabbix_agentd.conf.d/scripts directory
* restart the zabbix agent (service zabbix_agentd restart)
* import the zbx_export_template.xml into your zabbix server, and link it to your openwrt routeur.

