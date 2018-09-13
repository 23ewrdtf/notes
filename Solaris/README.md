## Oracle

If you login to Solaris and have a $ sign, you may need to run 

```/bin/bash```

Basic Oracle commands
```https://docs.oracle.com/cd/E23824_01/html/821-1451/gkkwk.html```

Tracert
```/usr/sbin/traceroute```

Ping
```/usr/sbin/ping```

Ifconfig
```/usr/sbin/ifconfig```

Install Oracle Explorer
Go to https://updates.oracle.com/ARULink/PatchDetails/process_form?aru=21785423&patch_password=&no_header=0 and download Services Tools Bundle (STB)
Extract and send install_stb.sh to the oracle server
Make sure the install script is executable:
```
chmod +x install_stb.sh
Run
./install_stb.sh
```
Use Explorer (It's annoying little application which should be installed by default)

```./usr/sbin/explorer```

###### To change shm parameter in Solaris 
###### Under oracle user check the project ID 
```
$ id –p
uid=100(oracle) gid=100(dba) projid=100(user.oracle)
```

###### Project ID = 100

###### Check what’s currently configured
```
$ prctl -n project.max-shm-memory -i project 100
project: 100: user.oracle
NAME PRIVILEGE VALUE FLAG ACTION RECIPIENT
project.max-shm-memory
privileged 10.0GB - deny -
system 16.0EB max deny -
```

```
bash-3.2# cat /etc/project | grep oracle
user.oracle:100::oracle::project.max-sem-ids=(privileged,100,deny);project.max-sem_nsems=(privileged,256,deny);project.max-shm-ids=(privileged,100,deny);project.max-shm-memory=(privileged,10737418240,deny)
```

###### 10737418240 in bytes, ~10GB

###### Under root
###### Set the shm to desired value (16G in below example) for project ID=100. This will be reverted back after reboot, use command below to set it permanently.
```bash-3.2# prctl -n project.max-shm-memory -r -v 16G -i project 100```

###### Set the shm to desired value (16G in below example) for project ID=100 permanently 
```bash-3.2# projmod -sK "project.max-shm-memory=(privileged,16G,deny)" user.oracle```

###### Check if the file /etc/project has been modified. 
```bash-3.2# cat /etc/project | grep
oracle user.oracle:100::oracle::project.max-sem-ids=(privileged,100,deny);project.max-sem_nsems=(privileged,256,deny);project.max-shm-ids=(privileged,100,deny);project.max-shm-memory=(privileged,17179869184,deny) 17179869184 in bytes, ~16GB
```

###### System Stats, every 1 second 11 times
```vmstat 1 11```

###### Zones stats, every 1 second 11 times
```zonestat 1 11```

###### extended device statistics, every 1 second, three times
###### %b Column means: Percentage of time that the disk is busy, a good way to troubleshoot high load.
```iostat -xntcz 1 3```

###### How to install Nagios Solaris Agent: 
```https://assets.nagios.com/downloads/nagiosxi/docs/Installing_The_XI_Solaris_Agent.pdf```

###### to check the Solaris version
```uname -a```

###### nrpe config file
```/etc/nagios/nrpe.cfg```

###### to have a 'normal' terminal
```/bin/bash```

###### list all services
```svcs```

###### Restart NRPE
```svcadm restart application/nagios/nrpe```

###### to download solaris nrpe agent
```/usr/sfw/bin/wget http://assets.nagios.com/downloads/nagiosxi/agents/solaris-nrpe-agent.tar.gz```

###### extract nrpe solaris agent
```gunzip -c solaris-nrpe-agent.tar.gz | tar xf -```

###### to transfer files from Windows to oracle via putty scp
```pscp.exe solaris-nrpe-agent.tar.gz user@IP:/home/user_folder```

###### nrpe check plugins
```/opt/nagios/libexec/```

###### list all zones
```/usr/sbin/zoneadm list -vi```

###### display more info about the zone
```zonecfg -z <zonename> info```

###### to list zone configuration files
```/etc/zones ls```

###### Syslog
```/var/log/syslog```

###### Status of ZSF Pools
```zpool status -v```

###### Errors on hard drives
```iostat -E```

###### Show all disks
```format```

###### Show all disks
```cfgadm -al```

###### Replacing degraded disk in ZFS (if it's raid, hot swap should work.).

###### Take one of the disks from z pool offline
```zpool offline <datapool name> <disk name>```

###### Unconfigure one of the disks before removal
```cfgadm -c unconfigure <disk name>```

###### Replace old disk in a pool with a new one
```zpool replace datapool <Old disk name> <New disk name>```

###### Replacing degraded disk in ZFS (if it's raid, hot swap should work.).

List all drives

```cfgadm –al```

Unconfigure the degraded drive: <Drive_ID>

```zpool status -v <pool>``` command shows the drive ID as the logical device name whilst the ```cfgadm –al``` command shows the physical device name (the one which Solaris is seeing) 
There can also be a little confusion since the machine is using multipathing.
Device Path: /devices/pci/pci/scsi/iport/disk
Multipathing: /pci/pci/scsi/iport/disk 

```
cfgadm -c unconfigure <Physical_disk_id>
```

Verify that the drives blue Ready-to-Remove LED is lit 
Replace the drive 
As this is a replacement in a running server then no further action is necessary. The Solaris OS will auto-configure your hard drive.

Configure the replaced drive
``````cfgadm -c configure <Physical_disk_id>```

Verify that the blue Ready-to-Remove LED is no longer lit on the drive that you installed.

Confirm the drive is now configured
```cfgadm –al```

Confirm the drive is now in zfs pool
```zpool status -v <pool>```

###### Replace old disk in a pool with a new one
```zpool replace datapool <Old disk name> <New disk name>```

###### NTP. Global zone is controlling time on all non global zone so set NTP only on the global zone.
###### Edit sudo vi /etc/inet/ntp.conf and replace public servers with the one you need
```
server IP_of_NTP_Server prefer
server IP_of_NTP_Server iburst
```
###### Save

###### Restart NTP service: 
```svcadm restart svc:/network/ntp```

###### Check if the service is up: 
```svcs | grep ntp```

###### Check syslog:  
```cat /var/adm/messages | grep ntp```

###### See whats NTP is doing: 
```ntpq -p```

###### See current Time zone
```nlsadm get-timezone```

###### List known time zones
```nlsadm list-timezone```

###### Configure Time Zone
```nlsadm set-timezone Europe/London```

###### SFTP
Open SSH on Solaris 10 doesnt support Match and ForceCommand command in /etc/ssh/sshd_config 

###### Check whats my ip
```/usr/sfw/bin/wget -O - -q icanhazip.com```

###### DNS Client, weirdly Solaris works without DNS Client Service but only with configured /etc/resolve.conf

Add ```nameserver <IP of a dns server>``` to ```/etc/resolv.conf```

create\edit ```/etc/nsswitch.conf``` - copy from ```/etc/nsswitch.dns```

Needs to contain a line like ```hosts: files dns```

Enable DNS client service

```svcadm enable network/dns/client```
