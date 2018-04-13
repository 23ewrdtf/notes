# Notes for managing different IT systems

## Google Cloud
###### Run below to get all Firewall rules from All projects that allow traffic from ANYWHERE. Results will be send to open_access.csv file. If you don't have access to a particular project you will get an error.
```
for project in $(gcloud projects list --format="value(projectId)")
do
gcloud beta compute firewall-rules list --project=$project --format="csv($project,name,targetTags.list():label=TARGET_TAGS,sourceRanges.list():label=SRC_RANGES,allowed[].map().firewall_rule().list():label=ALLOW,network)" --filter="sourceRanges=('0.0.0.0/0')" >> open_access.csv
done
```

###### Resizing root partition in google cloud linux
https://cloud.google.com/compute/docs/disks/create-root-persistent-disks#resizingrootpd
Once you resize the disk while the vm is running, restart the vm to apply new size automatically (most linux vms should automatically detect the new size).

## Windows

###### Transfer files from Windows to Linux using pscp
```pscp.exe <FileToTransfer> <User>@<IPOfRemoteLinux>:/Folder/To/TransferTo```

###### Transfer files from Linux to Windows using pscp
```pscp.exe <User>@<IPOfRemoteLinux>:/Folder/From/Transfer/FileName FileNameToSaveTo```

###### Netstat filtering query
```netstat -ano | findstr :25 | findstr ESTABLISHED```

###### NSlookup to find domain controllers
```
nslookup
set type=all
_ldap._tcp.dc._msdcs.Domain_Name
```

## Linux

###### Automatically remove old images from /boot partition
```sudo apt-get -y autoremove --purge```

###### Add new disk to Linux. As root.
```grep mpt /sys/class/scsi_host/host?/proc_name```
Which will return something like 
```/sys/class/scsi_host/host0/proc_name:mptspi```
Then you follow it up with 
```echo "- - -" > /sys/class/scsi_host/host0/scan```

###### List disks
```
administrator@localhost:~$ ls /dev/sd*
/dev/sda /dev/sda1 /dev/sda2 /dev/sda5 /dev/sdb
```

sda = physical disk 1
sda1 = physical disk 1 partition 1
sdb = physical disk 2

###### Configure partition on disk sdb
```
fdisk /dev/sdb
p
n
w
q
```

###### Check new configured disk
```ls /dev/sd*```

###### Mount new partition as /appdata for example
```
/sbin/mkfs.ext3 -L /appdata /dev/sdb1
cd mnt/
mkdir /appdata
mount /dev/sdb1 /appdata
mount
```

###### check if worked
```df -h```

###### Add new mount to mount during boot
```
vi /etc/fstab
/dev/sdb1 /appdata ext3 defaults 0 0
```

###### Test by creating a new file
```
cd /appdata/
vi test
ls
```

###### DNS server on Solaris
###### Check the DNS service status
```svcs -a | grep dns```

###### Find a file
###### 2>/dev/null means to send all the error messages to null so you won't see them
```find . -name "filename" 2>/dev/null```


## Red Hat

###### Add system to Red Hat Subscription
```subscription-manager register --username xxxxxxxx --password xxxxxxxxxxxx --auto-attach```

###### Check RedHat Version
```cat /etc/redhat-release```

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

## Oracle

###### If you login to Solaris and have a $ sign, you may need to run /bin/bash

###### Basic Oracle commands
```https://docs.oracle.com/cd/E23824_01/html/821-1451/gkkwk.html```

###### Tracert
```/usr/sbin/traceroute```

###### Ping
```/usr/sbin/ping```

###### Ifconfig
```/usr/sbin/ifconfig```

###### Install Oracle Explorer
###### Go to https://updates.oracle.com/ARULink/PatchDetails/process_form?aru=21785423&patch_password=&no_header=0 and download Services Tools Bundle (STB)
###### Extract and send install_stb.sh to the oracle server
###### Make sure the install script is executable:
```
chmod +x install_stb.sh
Run
./install_stb.sh
```

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

###### Take one of the disks from z pool offline
```zpool offline <datapool name> <disk name>```

###### Unoconfigure one of the disks before removal
```cfgadm -c unconfigure <disk name>```

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

## Ubuntu
###### Clearing up /boot partition

###### First check your kernel version, so you won't delete the in-use kernel image, running:
```uname -r```

###### Now run this command for a list of installed kernels:
```dpkg --list 'linux-image*' | grep ^ii```

###### and delete the kernels you don't want/need anymore by running this. Replace VERSION with the version of the kernel you want to remove.
###### Don't remove the current version.
```sudo apt-get remove linux-image-VERSION```

###### When you're done removing the older kernels, you can run this to remove ever packages you won't need anymore:
```sudo apt-get autoremove```

###### And finally you can run this to update grub kernel list:
```sudo update-grub```

###### For more information use below sites:
```https://askubuntu.com/questions/345588/what-is-the-safest-way-to-clean-up-boot-partition```
```https://help.ubuntu.com/community/RemoveOldKernels```


###### Ubuntu 14 is using Upstart
###### To read more about upstart management read: http://upstart.ubuntu.com/cookbook/#tools

###### Ubuntu 16 is using Systemd

###### NTP Sync
###### Check if NTP is synced
```timedatectl status```

###### Set NTP to True
```sudo timedatectl set-ntp true```

###### Install NTP
```sudo apt-get install ntp```

###### Edit config file and add NTP servers
```sudo nano /etc/ntp.conf
server IP_of_NTP_Server prefer
server IP_of_NTP_Server iburst
```

###### Restart NTP service
```sudo service ntp restart```

###### Check if NTP is syncing
```timedatectl status```

###### Check if NTP is seeing added servers
```ntpq -p```

###### Install NRPE and nagios plugins
```sudo apt-get install nagios-nrpe-server nagios-plugins-basic```

###### NRPE folder
```cd /etc/nagios/```

###### NRPE Config file
```sudo vi /etc/nagios/nrpe.cfg```

###### Restart NRPE
```sudo /etc/init.d/nagios-nrpe-server restart```

###### Nagios Plugins location
```/usr/lib/nagios/plugins/```

###### Sample nrpe.cfg. usually you only need to change
```
allowed_hosts=IP_of_Nagios_server_allowed_to_talk_to_this_client
dont_blame_nrpe=1
```

###### Commands at the end of the file
```
command[check_users]=/usr/lib/nagios/plugins/check_users -w 5 -c 10
command[check_load]=/usr/lib/nagios/plugins/check_load -w 15,10,5 -c 30,25,20
command[check_hda1]=/usr/lib/nagios/plugins/check_disk -w 20% -c 10% -p /dev/hda1
command[check_zombie_procs]=/usr/lib/nagios/plugins/check_procs -w 5 -c 10 -s Z
command[check_total_procs]=/usr/lib/nagios/plugins/check_procs -w 150 -c 200
command[check_nginx]=/usr/lib/nagios/plugins/check_procs -c 1: -w 3: -C nginx
command[check_swap]=/usr/lib/nagios/plugins/check_swap -w 15 -c 10
```

###### The following examples allow user-supplied arguments and can
###### only be used if the NRPE daemon was compiled with support for
###### command arguments *AND* the dont_blame_nrpe directive in this
###### config file is set to '1'. This poses a potential security risk, so
###### make sure you read the SECURITY file before doing this.
```
command[check_users]=/usr/lib/nagios/plugins/check_users -w $ARG1$ -c $ARG2$
command[check_disk]=/usr/lib/nagios/plugins/check_disk $ARG1$ $ARG2$ $ARG3$
command[check_procs]=/usr/lib/nagios/plugins/check_procs -w $ARG1$ -c $ARG2$ -s $ARG3$
```

```NRPE for Nagios on RedHat 7 - https://kb.op5.com/display/HOWTOs/Installation+of+NRPE+agent+on+CentOS+and+RHEL#sthash.OG7MBf75.dpbs```

###### Add the EPEL repository
```yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm```

###### Install NRPE and plugins in your system.
```yum install nrpe nagios-plugins-users nagios-plugins-load nagios-plugins-swap nagios-plugins-disk nagios-plugins-procs```

###### List plugins available to install
```yum --enablerepo=epel -y list nagios-plugins*```

###### Edit the NRPE config
```vi /etc/nagios/nrpe.cfg```

###### configure NRPE to autostart on system boot.
```
sudo systemctl enable nrpe.service
sudo systemctl start nrpe.service
```

###### Restart NRPE
```systemctl restart nrpe```

###### Ubuntu 16 Systemd services management

###### in /etc/systemd/<folder where your .service file is located> 
```
sudo systemctl start .service 
sudo systemctl stop .service
sudo systemctl status .service sudo systemctl --all | grep <service>
```
  
###### If the script is running another script/app systemd needs to know about it. So the file /etc/systemd/system/multi-user.target.wants/<service>.service looks like this now:

```
[Unit] Description=ITS 1966
[Service] 
Type=forking
ExecStart=/pah_to_.sh_file
[Install] WantedBy=multi-user.target
```

## Postgres DB Management
###### Switch to postgres user
```sudo su - postgres```

###### Take backup of a DB
###### localhost
```pg_dump -v -Fc -U postgres -d <DB_NAME> -f <FILENAME.bkp>```

###### Remote host
```pg_dump --host <HOST_OR_IP> --port 5432 -v -Fc -U postgres -d <DB_NAME> -f <FILE_NAME>```


###### Psql is the interactive terminal for working with Postgres. http://postgresguide.com/utilities/psql.html 

###### List all databases with additional information
```postgres-# \l+```

###### Count estimate rows in all tables, total
```
Select Sum(a.n_live_tup ) from (SELECT schemaname,relname,n_live_tup
FROM pg_stat_user_tables
ORDER BY n_live_tup DESC) a ;
```

###### Count estimate rows in all tables, show by table
```Select Sum(a.n_live_tup ) from (SELECT schemaname,relname,n_live_tup
FROM pg_stat_user_tables
ORDER BY n_live_tup DESC) a ;
```

###### Count rows in a specific table. Not Estimate but exact (I think).
```Select count(*) from table_name_from_above;```

###### Create user in postgres
```CREATE USER <username> PASSWORD '<PASSWORD>';```

###### Change user to be Superuser
```
ALTER USER <username> WITH SUPERUSER;
GRANT ALL ON SCHEMA public TO <DB_NAME>;
```

###### Create database
```
CREATE DATABASE "<db_name>"
WITH ENCODING='UTF8'
OWNER=<username>
TEMPLATE=template0
LC_COLLATE='English_United Kingdom.1252'
LC_CTYPE='English_United Kingdom.1252'
CONNECTION LIMIT=-1
TABLESPACE=pg_default;
```

###### Drop (Delete) database
```dropdb.exe -U <username> <DB_NAME>```

###### Restore database from backup, (create database first).
```pg_restore.exe -h <host_IP> -p 5432 -U <username> -d <DB_NAME> -v <Backup_File_Name > log.txt 2>&1```

## SQL
###### How to Programmatically Identify When Your SQL Server Was Last Started (NOT TESTED)
```https://www.databasejournal.com/tips/how-to-programmatically-identify-when-your-sql-server-was-last-started.html```



# Observations

Nsclient, even the latest version needs to be redesigned, I shouldn't be spending so much time trying to make it work.
