## SQL

#### Check version of installed SQL
```
Press Windows Key + S.
Enter SQL Server Configuration Manager in the Search box and press Enter.
In the top-left frame, click to highlight SQL Server Services.
Right-click SQL Server (NAME) and click Properties.
Click the Advanced tab.
Browse to Stock Keeping Unit Name and Version.
```

###### How to Programmatically Identify When Your SQL Server Was Last Started (NOT TESTED)
```https://www.databasejournal.com/tips/how-to-programmatically-identify-when-your-sql-server-was-last-started.html```

#### SQLEXPR_x64_ENU.exe /?

```
Microsoft (R) SQL Server 2012 11.00.3000.00
Copyright (c) Microsoft Corporation.  All rights reserved.

Usage:
 setup.exe /[option]={value} /[option]={value} ...

 Options:
 ACTION                       Specifies a Setup work flow, like INSTALL,
                              UNINSTALL, or UPGRADE. This is a required
                              parameter.
 ADDCURRENTUSERASSQLADMIN     Provision current user as a Database Engine
                              system administrator for SQL Server 2012 Express.
 AGTDOMAINGROUP               Either domain user name or system account
 AGTSVCACCOUNT                Either domain user name or system account
 AGTSVCPASSWORD               Password for domain user name. Not required for
                              system account
 AGTSVCSTARTUPTYPE            Startup type for the SQL Server Agent service.
                              Supported values are Manual, Automatic or
                              Disabled.
 ALLINSTANCES                 Specifies that all instances are to be included
                              in the Setup operation. This parameter is
                              supported only when applying a patch.
 ALLOWUPGRADEFORSSRSSHAREPOIN
                              RSInputSettings_AllowUpgradeForSSRSSharePointMode_Description
 ASBACKUPDIR                  The location for the Analysis Services backup
                              files.
 ASCOLLATION                  The collation used by Analysis Services.
 ASCONFIGDIR                  The location for the Analysis Services
                              configuration files.
 ASDATADIR                    The location for the Analysis Services data
                              files.
 ASLOGDIR                     The location for the Analysis Services log files.
 ASPROVIDERMSOLAP             Specifies if the MSOLAP provider can run in
                              process.
 ASSERVERMODE                 Specifies the server mode of the Analysis
                              Services instance. Valid values are
                              MULTIDIMENSIONAL and TABULAR. The default value
                              is MULTIDIMENSIONAL.
 ASSVCACCOUNT                 The account used by the Analysis Services
                              service.
 ASSVCPASSWORD                The password for the Analysis Services service
                              account.
 ASSVCSTARTUPTYPE             Controls the service startup type setting for the
                              service.
 ASSYSADMINACCOUNTS           Specifies the list of administrator accounts to
                              provision.
 ASTEMPDIR                    The location for the Analysis Services temporary
                              files.
 BROWSERSVCSTARTUPTYPE        Startup type for Browser Service.
 CLTCTLRNAME                  The computer name that the client communicates
                              with for the Distributed Replay Controller
                              service.
 CLTRESULTDIR                 The result directory for the Distributed Replay
                              Client service.
 CLTSTARTUPTYPE               The startup type for the Distributed Replay
                              Client service.
 CLTSVCACCOUNT                The account used by the Distributed Replay Client
                              service.
 CLTSVCPASSWORD               The password for the Distributed Replay Client
                              service account.
 CLTWORKINGDIR                The working directory for the Distributed Replay
                              Client service.
 CLUSTERPASSIVE               Specifies that SQL Server Setup should not manage
                              the SQL Server services. This option should be
                              used only in a non-Microsoft cluster environment.
 COMMFABRICENCRYPTION         MATRIXCOMMMESSAGEPROTECTION {0,1}
 COMMFABRICNETWORKLEVEL       MATRIXCOMMNETWORKISOLATION {0,1}
 COMMFABRICPORT               MATRIXCOMMPORT <port>
 CONFIGURATIONFILE            Specifies the configuration file to be used for
                              Setup.
 CONFIRMIPDEPENDENCYCHANGE    Indicates that the change in IP address resource
                              dependency type for the SQL Server multi-subnet
                              failover cluster is accepted.
 CTLRSTARTUPTYPE              The startup type for the Distributed Replay
                              Controller service.
 CTLRSVCACCOUNT               The account used by the Distributed Replay
                              Controller service.
 CTLRSVCPASSWORD              The password for the Distributed Replay
                              Controller service account.
 CTLRUSERS                    The Windows account(s) used to grant permission
                              to the Distributed Replay Controller service.
 ENABLERANU                   Set to "1" to enable RANU for SQL Server Express.
 ENU                          Detailed help for command line argument ENU has
                              not been defined yet.
 ERRORREPORTING               Specify if errors can be reported to Microsoft to
                              improve future SQL Server releases. Specify 1 or
                              True to enable and 0 or False to disable this
                              feature.
 FAILOVERCLUSTERDISKS         Specifies a cluster shared disk to associate with
                              the SQL Server failover cluster instance.
 FAILOVERCLUSTERGROUP         Specifies the name of the cluster group for the
                              SQL Server failover cluster instance.
 FAILOVERCLUSTERIPADDRESSES   Specifies an encoded IP address. The encodings
                              are semicolon-delimited (;), and follow the
                              format <IP Type>;<address>;<network name>;<subnet
                              mask>. Supported IP types include DHCP, IPV4, and
                              IPV6.
 FAILOVERCLUSTERNETWORKNAME   Specifies the name of the SQ LServer failover
                              cluster instance.  This name is the network name
                              that is used to connect to SQL Server services.
 FAILOVERCLUSTERROLLOWNERSHIP Specifies whether the upgraded nodes should take
                              ownership of the failover instance group or not.
                              Use 0 to retain ownership in the legacy nodes, 1
                              to make the upgraded nodes take ownership, or 2
                              to let SQL Server Setup decide when to move
                              ownership.
 FEATURES                     Specifies features to install, uninstall, or
                              upgrade. The list of top-level features include
                              SQL, AS, RS, IS, MDS, and Tools. The SQL feature
                              will install the Database Engine, Replication,
                              Full-Text, and Data Quality Services (DQS)
                              server. The Tools feature will install Management
                              Tools, Books online components, SQL Server Data
                              Tools, and other shared components.
 FILESTREAMLEVEL              Level to enable FILESTREAM feature at (0, 1, 2 or
                              3).
 FILESTREAMSHARENAME          Name of Windows share to be created for
                              FILESTREAM File I/O.
 FTSVCACCOUNT                 User account for Full-text Filter Daemon Host.
 FTSVCPASSWORD                User password for Full-text Filter Daemon Host
                              account.
 FTUPGRADEOPTION              Full-text catalog upgrade option.
 HELP                         Displays the command line parameters usage
 IACCEPTSQLSERVERLICENSETERMS By specifying this parameter and accepting the
                              SQL Server license terms, you acknowledge that
                              you have read and understood the terms of use.
 INDICATEPROGRESS             Specifies that the detailed Setup log should be
                              piped to the console.
 INSTALLSHAREDDIR             Specify the root installation directory for
                              shared components.  This directory remains
                              unchanged after shared components are already
                              installed.
 INSTALLSHAREDWOWDIR          Specify the root installation directory for the
                              WOW64 shared components.  This directory remains
                              unchanged after WOW64 shared components are
                              already installed.
 INSTALLSQLDATADIR            The Database Engine root data directory.
 INSTANCEDIR                  Specify the instance root directory.
 INSTANCEID                   Specify the Instance ID for the SQL Server
                              features you have specified. SQL Server directory
                              structure, registry structure, and service names
                              will incorporate the instance ID of the SQL
                              Server instance.
 INSTANCENAME                 Specify a default or named instance. MSSQLSERVER
                              is the default instance for non-Express editions
                              and SQLExpress for Express editions. This
                              parameter is required when installing the SQL
                              Server Database Engine (SQL), Analysis Services
                              (AS), or Reporting Services (RS).
 ISSVCACCOUNT                 Either domain user name or system account.
 ISSVCPASSWORD                Password for domain user.
 ISSVCSTARTUPTYPE             Automatic, Manual or Disabled.
 MATRIXCMBRICKCOMMPORT        MATRIXCMBRICKCOMMPORT portNumber
 MATRIXCMSERVERNAME           MATRIXCMSERVERNAME hostName\instanceName
 MATRIXNAME                   MATRIXNAME=<name>
 NPENABLED                    Specify 0 to disable or 1 to enable the Named
                              Pipes protocol.
 PID                          Specify the SQL Server product key to configure
                              which edition you would like to use.
 QUIET                        Setup will not display any user interface.
 QUIETSIMPLE                  Setup will display progress only, without any
                              user interaction.
 ROLE                         Detailed help for command line argument ROLE has
                              not been defined yet.
 RSCATALOGSERVERINSTANCENAME  The SQL Server server for the report server
                              catalog database.
 RSINSTALLMODE                RSInputSettings_RSInstallMode_Description
 RSSHPINSTALLMODE             RSInputSettings_RSInstallMode_Description
 RSSVCACCOUNT                 Specify the service account of the report server.
                              This value is required. If you omit this value,
                              Setup will use the default built-in account for
                              the current operating system (either
                              NetworkService or LocalSystem). If you specify a
                              domain user account, the domain must be under 254
                              characters and the user name must be under 20
                              characters. The account name cannot contain the
                              following characters:
                              " / \ [ ] : ; | = , + * ? < >
 RSSVCPASSWORD                Specify a strong password for the account. A
                              strong password is at least 8 characters and
                              includes a combination of upper and lower case
                              alphanumeric characters and at least one symbol
                              character. Avoid spelling an actual word or name
                              that might be listed in a dictionary.
 RSSVCSTARTUPTYPE             Specifies the startup mode for the Report Server
                              service. Valid values include Manual, Automatic,
                              and Disabled. The default value for StartupType
                              is Manual, where the server is started when a
                              request is received.
 RSUPGRADEDATABASEACCOUNT     RSInputSettings_RSInstallMode_Description
 RSUPGRADEPASSWORD            RSInputSettings_RSInstallMode_Description
 RULES                        Specifies the list of rule IDs or rule group IDs
                              to run.
 SAPWD                        Password for SQL Server sa account.
 SECURITYMODE                 The default is Windows Authentication. Use "SQL"
                              for Mixed Mode Authentication.
 SQLBACKUPDIR                 Default directory for the Database Engine backup
                              files.
 SQLCOLLATION                 Specifies a Windows collation or an SQL collation
                              to use for the Database Engine.
 SQLSVCACCOUNT                Account for SQL Server service: Domain\User or
                              system account.
 SQLSVCPASSWORD               A SQL Server service password is required only
                              for a domain account.
 SQLSVCSTARTUPTYPE            Startup type for the SQL Server service.
 SQLSYSADMINACCOUNTS          Windows account(s) to provision as SQL Server
                              system administrators.
 SQLTEMPDBDIR                 Directory for Database Engine TempDB files.
 SQLTEMPDBLOGDIR              Directory for the Database Engine TempDB log
                              files.
 SQLUSERDBDIR                 Default directory for the Database Engine user
                              databases.
 SQLUSERDBLOGDIR              Default directory for the Database Engine user
                              database logs.
 SQMREPORTING                 Specify that SQL Server feature usage data can be
                              collected and sent to Microsoft. Specify 1 or
                              True to enable and 0 or False to disable this
                              feature.
 TCPENABLED                   Specify 0 to disable or 1 to enable the TCP/IP
                              protocol.
 UIMODE                       Parameter that controls the user interface
                              behavior. Valid values are Normal for the full
                              UI,AutoAdvance for a simplied UI, and
                              EnableUIOnServerCore for bypassing Server Core
                              setup GUI block.
 UpdateEnabled                Specify whether SQL Server Setup should discover
                              and include product updates. The valid values are
                              True and False or 1 and 0. By default SQL Server
                              Setup will include updates that are found.
 UpdateSource                 Specify the location where SQL Server Setup will
                              obtain product updates. The valid values are "MU"
                              to search Microsoft Update, a valid folder path,
                              a relative path such as .\MyUpdates or a UNC
                              share. By default SQL Server Setup will search
                              Microsoft Update or a Windows Update service
                              through the Window Server Update Services.
 X86                          Specifies that Setup should install into WOW64.
                              This command line argument is not supported on an
                              IA64 or a 32-bit system.

Full unattended installation example, showing all required parameters:


setup.exe /Q /IACCEPTSQLSERVERLICENSETERMS /ACTION=install /PID=<validpid> /FEATURES=SQL,AS,RS,IS,Tools
/INSTANCENAME=MSSQLSERVER /SQLSVCACCOUNT="MyDomain\MyAccount"
/SQLSVCPASSWORD="************" /SQLSYSADMINACCOUNTS="MyDomain\MyAccount "
/AGTSVCACCOUNT="MyDomain\MyAccount" /AGTSVCPASSWORD="************"
/ASSVCACCOUNT="MyDomain\MyAccount" /ASSVCPASSWORD="************"
/RSSVCACCOUNT="MyDomain\MyAccount" /RSSVCPASSWORD="************"
/ISSVCAccount="MyDomain\MyAccount" /ISSVCPASSWORD="************"
/ASSYSADMINACCOUNTS="MyDomain\MyAccount"

Press any key to exit...
```
