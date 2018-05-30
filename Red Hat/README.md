## Red Hat

###### Add system to Red Hat Subscription
```subscription-manager register --username xxxxxxxx --password xxxxxxxxxxxx --auto-attach```

###### Check RedHat Version
```cat /etc/*-release```

###### The /etc/rc.d/rc.local script is executed by the init command at boot time or when changing runlevels. 
###### Adding commands to the bottom of this script is an easy way to perform necessary tasks like 
###### starting special services or initialize devices without writing complex initialization scripts 
###### in the /etc/rc.d/init.d/ directory and creating symbolic links.

###### Changing time
###### Check the current NTP servers, add if neccesary
```cat /etc/ntp.conf```

###### Check status of the NTP service
```/etc/init.d/ntpd status```

###### Check the current timezone, edit this file if needed, list of timezones is here: cd /usr/share/zoneinfo/
```cat /etc/sysconfig/clock```

###### Restart NTP service
```/etc/init.d/ntpd restart```

###### NTP Status, it take  some time to synchronise
```/usr/bin/ntpstat```

###### Check the current time
```date```
