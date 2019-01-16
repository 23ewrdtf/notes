## Linux

#### Check Linux version

A list of release files for the most common distros
```http://linuxmafia.com/faq/Admin/release-files.html```

```
cat /etc/*-release
cat /etc/issue
```

#### Check if OS needs a reboot

If this file exist, reboot is needed. Depend on OS

`/var/run/reboot-required`

`/usr/bin/needs-restarting`

Run below, anything listed needs a reboot or you can just restart anything on the list

`needs-restarting`

#### Running multiple commands in one single command

```command_1; command_2; command_3```

#### Running multiple commands in one single command only if the previous command was successful

```command_1 && command_2```

#### Reading a log file in real time

```tail -f path_to_Log```

```tail -f path_to_log | grep search_term```

#### Show file ignoring lines with heh

```cat file.txt | grep -v "heh"```


#### Check what takes all the space
```sudo du -S -h . | sort -n -r | head -n 10```

```ncdu```

#### Remove ALL files, folders and subfolder (be careful with it) (added _ just in case)
```sudo_ rm_ -r *```

#### Run a Linux command at a certain time

```
at 1:00 PM Mon
at> sudo shutdown -r now
at> CTRL+D
```

```sudo shutdown -r 12:00```

#### Automatically remove old images from /boot partition
```sudo apt-get -y autoremove --purge```

#### Disk Operations

Add new disk to Linux. As root.
```grep mpt /sys/class/scsi_host/host?/proc_name```

Which will return something like 
```/sys/class/scsi_host/host0/proc_name:mptspi```

Then you follow it up with 
```echo "- - -" > /sys/class/scsi_host/host0/scan```

List disks
```
administrator@localhost:~$ ls /dev/sd*
/dev/sda /dev/sda1 /dev/sda2 /dev/sda5 /dev/sdb
```
```
sda = physical disk 1
sda1 = physical disk 1 partition 1
sdb = physical disk 2
```

Configure partition on disk sdb
```
fdisk /dev/sdb
p
n
w
q
```

Check new configured disk
```ls /dev/sd*```

Mount new partition as /appdata for example
```
/sbin/mkfs.ext3 -L /appdata /dev/sdb1
cd mnt/
mkdir /appdata
mount /dev/sdb1 /appdata
mount
```

Check if worked
```df -h```

Add new mount to mount during boot
```
vi /etc/fstab
/dev/sdb1 /appdata ext3 defaults 0 0
```

Test by creating a new file
```
cd /appdata/
vi test
ls
```

#### DNS server on Solaris

Check the DNS service status
```svcs -a | grep dns```

Set the DNS server
```
svccfg -s network/dns/client
svc:/network/dns/client> setprop config/nameserver = net_address: (IP_OF_DNS_SERVER)
svc:/network/dns/client> quit
svcadm refresh dns/client
```

#### Find a file

2>/dev/null means to send all the error messages to null so you won't see them
```find . -name "filename" 2>/dev/null```
```https://opensource.com/article/18/4/how-use-find-linux```

Locate is faster but not as powerfull and not always available.
```
locate filename
```

#### Fixing below apt-get install error

```
Errors were encountered while processing:
mfedx
E: Sub-process /usr/bin/dpkg returned an error code (1)
```

1. Backup the file ```sudo cp /var/lib/dpkg/status /var/lib/dpkg/status_backup```
2. Remove package section called mfedx from file, save, try to install again. ```sudo nano /var/lib/dpkg/status```
3. Before install you may need to remove and purge installed package ```sudo apt-get remove/purge package_name```

#### If you use nano or other app and press CTRL Z, below will bring back the app.

Bring back last app ```%```

List all jobs, background apps ```jobs```

Bring back job number 1 ```fg 1```

#### From wikipedia raw article, filter lines containing string photo and remove unwanted characters

```
$ curl -sS "https://en.wikipedia.org/wiki/July_30?action=raw" |  grep photo | cut -c"21-" | awk '{gsub(/\"|\]/,"")}1' | awk '{gsub(/\"|\[/,"")}1' | tr '|' ' '
```

Get a website: curl -sS "https://en.wikipedia.org/wiki/July_30?action=raw" 
-sS allow to strip out the download progress output and just print the downloaded data (or any possible error) in the console.

Find line containing photo: ```grep photo```

Remove characters from 0 to 21: ```cut -c"21-"```

Remove ] character: ```awk '{gsub(/\"|\]/,"")}1'```

Remove [ character ```awk '{gsub(/\"|\[/,"")}1'```

Replace | with space: ```tr '|' ' '```

#### Log files

By default, the journal stores log data in /run/log/journal/. Since /run/ is volatile, log data is lost at reboot.
To make the data persistent, it is sufficient to create /var/log/journal/ where systemd-journald will then store the data.

```journalctl```
