## Windows

#### Transfer files from Windows to Linux using pscp
```pscp.exe <FileToTransfer> <User>@<IPOfRemoteLinux>:/Folder/To/TransferTo```

#### Transfer files from Linux to Windows using pscp
```pscp.exe <User>@<IPOfRemoteLinux>:/Folder/From/Transfer/FileName FileNameToSaveTo```

#### Netstat filtering query
```netstat -ano | findstr :25 | str ESTABLISHED```

#### Show Windows Firewall Rules

```
Get-NetFirewallRule -Enabled True -Action Allow -Direction Outbound
```

#### NSlookup to find domain controllers
```
nslookup
set type=all
_ldap._tcp.dc._msdcs.Domain_Name
```
#### Uptime check. The line that start with "Statistics since …" provides the time that the server was up from.

```net statistics server```

```net stats srv```

#### WUA Success and Error Codes
```https://msdn.microsoft.com/en-us/library/windows/desktop/hh968413(v=vs.85).aspx```

#### Restart Stopping Service

```sc queryex servicename```

```taskkill /f /pid [PID_From_Above] /T (kills child processes)```

#### Kill Process, different ways

```taskkill /f /pid [PID_From_Above] /T (kills child processes)```

```Get-Process process_name | kill```

```wmic process where name='process_name' delete```

#### Delete certificate (not tested)
```certutil -delstore "Root" <serialnubmer>```

#### Decoding Windows Updates Codes
```
ResultCode X
0=Not Started
1=In Progress
2=Succeeded
3=Succeeded With Errors
4=Failed
5=Aborted
```

```
HResult 
Example: -2145124318
Paste the negative number into Calculator (Windows) in programmer mode "Dec" setting. Convert to "Hex" setting.
-2145124318 in DEC = FFFFFFFF80240022 in HEX = 0x80240022 = WU_E_ALL_UPDATES_FAILED Operation failed for all the updates. (Thanks, Very Useful...)
```

Usefull logs:

```
C:\Windows\Logs\CBS
C:\Windows\WindowsUpdate.log
```

```
List of sites:
https://support.microsoft.com/en-gb/help/938205/windows-update-error-code-list
https://msdn.microsoft.com/en-us/library/cc231198.aspx
https://msdn.microsoft.com/en-us/library/cc704587.aspx
https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc720442(v=ws.10)
https://support.microsoft.com/en-gb/help/902093/how-to-read-the-windowsupdate-log-file
```

#### How to find out who has your FSMO Roles?
```NetDOM /query FSMO```

#### Whats my IP
```nslookup myip.opendns.com. resolver1.opendns.com```

#### Create a file

```fsutil file createnew <filename> <length>```

```
<length>
100 = 1KB
10 000 = ~10KB
10 000 000 = ~10MB
100 000 000 = ~100MB
1 000 000 000 = ~1GB
```

#### Check for installed updates

```wmic qfe list  | findstr KB_Number```

```systeminfo```

#### List used DLLs

```tasklist /m "mscor*"```
