## Scripting

### Remotely check the file version for multiple servers from a file and send to a file.
### Source: https://gallery.technet.microsoft.com/scriptcenter/Get-file-version-on-Remote-8835bfe8

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



### Remotely check the OS version and other details. Run below in PowerShell ISE. It's slow.
### Source: https://gallery.technet.microsoft.com/scriptcenter/PowerShell-System-571521d1

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


### Set registry keys remotely
### Source https://community.spiceworks.com/topic/614948-script-to-modify-registry-value-on-multiple-computers

```
$Computers = Get-Content "C:\computerlist.txt"
$Path = "HKLM:\SOFTWARE\wow6432node\Microsoft\Windows\CurrentVersion\Uninstall\Office14.visio"
$Property = "DisplayName"
$Value = "Microsoft Visio Standard 2010"

$results = foreach ($computer in $Computers)
{
    If (test-connection -ComputerName $computer -Count 1 -Quiet)
    {
        Try {
            Set-ItemProperty -Path $path -Name $Property -Value $Value -ErrorAction 'Stop'
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
