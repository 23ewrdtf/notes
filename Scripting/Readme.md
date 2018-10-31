## Scripting

#### Remotely check the file version for multiple servers from a file and send to a file.
#### Source: https://gallery.technet.microsoft.com/scriptcenter/Get-file-version-on-Remote-8835bfe8

```
$filename = "\windows\system32\ntoskrnl.exe" 
 
$obj = New-Object System.Collections.ArrayList 
 
$computernames = Get-Content C:\Users\<USER>\list_of_computers.txt
foreach ($server in $computernames) 
{ 
$filepath = Test-Path "\\$server\c$\$filename" 
 
if ($filepath -eq "True") { 
$file = Get-Item "\\$server\c$\$filename" 
 
     
        $obj += New-Object psObject -Property @{'Computer'=$server;'FileVersion'=$file.VersionInfo|Select FileVersion;'LastAccessTime'=$file.LastWriteTime} 
        } 
     } 
     
$obj | select computer, FileVersion, lastaccesstime | Export-Csv -Path 'C:\Users\<USER>\results.txt' -NoTypeInformation 
```



#### Remotely check the OS version and other details. Run below in PowerShell ISE. It's slow.
#### Source: https://gallery.technet.microsoft.com/scriptcenter/PowerShell-System-571521d1

```
function Get-SystemInfo 
{ 
  param($ComputerName = $env:ComputerName) 
  
      $header = 'Hostname','OSName','OSVersion','OSManufacturer','OSConfig','Buildtype', 'RegisteredOwner','RegisteredOrganization','ProductID','InstallDate', 'StartTime','Manufacturer','Model','Type','Processor','BIOSVersion', 'WindowsFolder' ,'SystemFolder','StartDevice','Culture', 'UICulture', 'TimeZone','PhysicalMemory', 'AvailablePhysicalMemory' , 'MaxVirtualMemory', 'AvailableVirtualMemory','UsedVirtualMemory','PagingFile','Domain' ,'LogonServer','Hotfix','NetworkAdapter' 
      systeminfo.exe /FO CSV /S $ComputerName |  
            Select-Object -Skip 1 |  
            ConvertFrom-CSV -Header $header 
} 

Get-SystemInfo -ComputerName <IP or computer name>
```


#### Set registry keys remotely. It might not work due to Trusted Hosts. Try PsExec below
#### Source https://community.spiceworks.com/topic/614948-script-to-modify-registry-value-on-multiple-computers

```
$Computers = Get-Content "C:\computerlist.txt"
$Path = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management"
$Property = "FeatureSettingsOverride"
$Value = "0"

$results = foreach ($computer in $Computers)
{
    If (test-connection -ComputerName $computer -Count 1 -Quiet)
    {
        Try {
            Invoke-Command -ComputerName $Computers -ScriptBlock {Set-ItemProperty -Path $path -Name $Property -Value $Value -ErrorAction 'Stop'}
            $status = "Success"
        } Catch {
            $status = "Failed"
        }
    }
    else
    {   
        $status = "Unreachable"
    }
    
    New-Object -TypeName PSObject -Property @{
        'Computer'=$computer
        'Status'=$status
    }
}

$results |
Export-Csv -NoTypeInformation -Path "./out.csv"
```

#### Same as above but with PsExec

```
PsExec.exe @computers.txt reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v FeatureSettingsOverride /t REG_DWORD /d 0 /f
```

#### IP to Hostname from a txt file

```
Get-Content C:\Users\admin\Downloads\computers.txt | ForEach-Object {([system.net.dns]::GetHostByAddress($_)).hostname >> C:\Users\admin\Downloads\results.txt}
```

Another way from https://blogs.technet.microsoft.com/gary/2009/08/28/resolve-ip-addresses-to-hostname-using-powershell/

```
# The following line read a plain list of IPs from files.  For this demo, I have
# this line commented out and added a line to just define an array of IPs here

#$listofIPs = Get-Content C:\Users\admin\Downloads\computers.txt
$listofIPs = "173.136.234.58","173.136.234.59","173.136.234.60"

#Lets create a blank array for the resolved names
$ResultList = @()

# Lets resolve each of these addresses
foreach ($ip in $listofIPs)
{
     $result = $null
     $currentEAP = $ErrorActionPreference
     $ErrorActionPreference = "silentlycontinue"

     #Use the DNS Static .Net class for the reverse lookup
     # details on this method found here: http://msdn.microsoft.com/en-us/library/ms143997.aspx
     $result = [System.Net.Dns]::gethostentry($ip)

     $ErrorActionPreference = $currentEAP
     If ($Result)
     {
          $Resultlist += [string]$Result.HostName
     }
     Else
     {
          $Resultlist += "$IP - No HostNameFound"
     }
}

# If we wanted to output the results to a text file we could do this, for this
# demo I have this line commented and another line here to echo the results to the screen
#$resultlist | Out-File c:\output.txt
$ResultList
```

#### Create a scheduled task on multiple servers using PsExec. Specify a user to run the task as that user.

```
PsExec.exe @computers.txt schtasks.exe /create /RU <USERNAME> /RP <PASSWORD> /TN Reboot /SD 19/09/2018 /ST 03:00 /SC ONCE /TR "shutdown -r -f -t 5"
```

#### Check if Reboot is required

First way

```
$systemInfo = New-Object -ComObject "Microsoft.Update.SystemInfo"

if ( $systemInfo.RebootRequired ) {
    #Device requires reboot
    return $true
} else {
    #Device does not require reboot
    return $false
}

$systemInfo
```

Another Way

```
(New-Object -ComObject "Microsoft.Update.SystemInfo")
```

Another way

```
Function Test-WUARebootRequired {
    try {
        (New-Object -ComObject "Microsoft.Update.SystemInfo").RebootRequired
    } catch {
        Write-Warning -Message "Failed to query COM object because $($_.Exception.Message)"
    }
}
Test-WUARebootRequired
```
