#### HP Server SNMP check.

```
MIB File       Description
============   =====================================================
CPQSINFO.MIB   ProLiant Specific PC Server information

CPQHOST.MIB    Host Server Operating System information

CPQHLTH.MIB    Server Health information

CPQSM2.MIB     Remote Insight and iLO information
```

##### Overall condition of the Server

```1.3.6.1.4.1.232.3.1.3.0```

##### Condition of RAID

```1.3.6.1.4.1.232.3.2.2.1.1.6.4```

##### ILO Health Status

```1.3.6.1.4.1.232.6.2.11.2.0```

##### Return codes

```
other(1)
ok(2)
degraded(3)
failed(4)
```

##### Nagios checks

```
Server Health Status
check_xi_service_snmp -o 1.3.6.1.4.1.232.6.1.3.0 -C <SNMP_COMMUNITY> -P 2c -w @1 -c 2
```

```
ILO Health Status
check_xi_service_snmp -o 1.3.6.1.4.1.232.6.2.11.2.0 -C <SNMP_COMMUNITY> -P 2c -w @1 -c 2
```
