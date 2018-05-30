## Nagios

###### Remote Ping

Check Command:

```
check_nrpe
$USER1$/check_nrpe -H $HOSTADDRESS$ -t 30 -c $ARG1$ $ARG2$
```

$ARG1$

```
check_nrpe!CheckWMIValue -a MinCrit=0.1 MaxCrit=120 MinWarn=0.2 MaxWarn=80 'Query=select ResponseTime from Win32_PingStatus where Address="IP_ADDRESS_TO_PING"' Check:ResponseTime=ResponseTime!!!!!!!
```
