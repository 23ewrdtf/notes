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
