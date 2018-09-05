## Postgres DB Management

#### Allow connections from other then localhost, add below changing IP and MASK to /etc/postgresql/VERSION/main/pg_hba.conf
host    all             all             IP/MASK       md5

#### Switch to postgres user
```sudo su - postgres```

#### Take backup of a DB

localhost

```pg_dump -v -Fc -U postgres -d <DB_NAME> -f <FILENAME.bkp>```

Remote host

```pg_dump --host <HOST_OR_IP> --port 5432 -v -Fc -U postgres -d <DB_NAME> -f <FILE_NAME>```


#### Psql is the interactive terminal for working with Postgres. http://postgresguide.com/utilities/psql.html 

#### List all databases with additional information

```postgres-# \l+```

#### Count estimate rows in all tables, total

```
Select Sum(a.n_live_tup ) from (SELECT schemaname,relname,n_live_tup
FROM pg_stat_user_tables
ORDER BY n_live_tup DESC) a ;
```

#### Count estimate rows in all tables, show by table

```Select Sum(a.n_live_tup ) from (SELECT schemaname,relname,n_live_tup
FROM pg_stat_user_tables
ORDER BY n_live_tup DESC) a ;
```

#### Count rows in a specific table. Not Estimate but exact (I think).

```Select count(*) from table_name_from_above;```

#### Create user in postgres

```CREATE USER <username> PASSWORD '<PASSWORD>';```

#### Change user to be Superuser

```
ALTER USER <username> WITH SUPERUSER;
GRANT ALL ON SCHEMA public TO <DB_NAME>;
```

#### Create database

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

#### Drop (Delete) database

```dropdb.exe -U <username> <DB_NAME>```

#### Restore database from backup, (create database first).

```pg_restore.exe -h <host_IP> -p 5432 -U <username> -d <DB_NAME> -v <Backup_File_Name > log.txt 2>&1```
