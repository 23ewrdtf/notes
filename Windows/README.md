## Windows

#### Transfer files from Windows to Linux using pscp
```pscp.exe <FileToTransfer> <User>@<IPOfRemoteLinux>:/Folder/To/TransferTo```

#### Transfer files from Linux to Windows using pscp
```pscp.exe <User>@<IPOfRemoteLinux>:/Folder/From/Transfer/FileName FileNameToSaveTo```

#### Netstat filtering query
```netstat -ano | findstr :25 | str ESTABLISHED```

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
