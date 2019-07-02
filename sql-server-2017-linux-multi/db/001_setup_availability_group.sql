CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'P@ssw0rd';
go

CREATE CERTIFICATE AG_@@HOSTNAME@@_Cert
WITH SUBJECT = 'AG_@@HOSTNAME@@ Certificate';
go

BACKUP CERTIFICATE AG_@@HOSTNAME@@_Cert
TO FILE = '/var/opt/mssql/shared/AG_@@HOSTNAME@@_Cert.cer';
go

CREATE ENDPOINT AGEP
STATE = STARTED
AS TCP (
    LISTENER_PORT = 5022,
    LISTENER_IP = ALL)
FOR DATABASE_MIRRORING (
    AUTHENTICATION = CERTIFICATE AG_@@HOSTNAME@@_Cert,
    ROLE = ALL);
go

waitfor delay '00:00:05';
go

if (@@SERVERNAME = 'db1' )
    begin
        CREATE LOGIN AG_db2_Login WITH PASSWORD = 'P@ssw0rd';
        CREATE USER AG_db2_User FOR LOGIN AG_db2_Login;

        CREATE CERTIFICATE AG_db2_Cert
        AUTHORIZATION AG_db2_User
        FROM FILE = '/var/opt/mssql/shared/AG_db2_Cert.cer';

        GRANT CONNECT ON ENDPOINT::AGEP TO AG_db2_Login;

        CREATE LOGIN AG_db3_Login WITH PASSWORD = 'P@ssw0rd';
        CREATE USER AG_db3_User FOR LOGIN AG_db3_Login;

        CREATE CERTIFICATE AG_db3_Cert
        AUTHORIZATION AG_db3_User
        FROM FILE = '/var/opt/mssql/shared/AG_db3_Cert.cer';

        GRANT CONNECT ON ENDPOINT::AGEP TO AG_db3_Login;
    end

if (@@SERVERNAME = 'db2' )
    begin
        CREATE LOGIN AG_db1_Login WITH PASSWORD = 'P@ssw0rd';
        CREATE USER AG_db1_User FOR LOGIN AG_db1_Login;

        CREATE CERTIFICATE AG_db1_Cert
        AUTHORIZATION AG_db1_User
        FROM FILE = '/var/opt/mssql/shared/AG_db1_Cert.cer';

        GRANT CONNECT ON ENDPOINT::AGEP TO AG_db1_Login;

        CREATE LOGIN AG_db3_Login WITH PASSWORD = 'P@ssw0rd';
        CREATE USER AG_db3_User FOR LOGIN AG_db3_Login;

        CREATE CERTIFICATE AG_db3_Cert
        AUTHORIZATION AG_db3_User
        FROM FILE = '/var/opt/mssql/shared/AG_db3_Cert.cer';

        GRANT CONNECT ON ENDPOINT::AGEP TO AG_db3_Login;
    end

if (@@SERVERNAME = 'db3' )
    begin
        CREATE LOGIN AG_db2_Login WITH PASSWORD = 'P@ssw0rd';
        CREATE USER AG_db2_User FOR LOGIN AG_db2_Login;

        CREATE CERTIFICATE AG_db2_Cert
        AUTHORIZATION AG_db2_User
        FROM FILE = '/var/opt/mssql/shared/AG_db2_Cert.cer';

        GRANT CONNECT ON ENDPOINT::AGEP TO AG_db2_Login;

        CREATE LOGIN AG_db1_Login WITH PASSWORD = 'P@ssw0rd';
        CREATE USER AG_db1_User FOR LOGIN AG_db1_Login;

        CREATE CERTIFICATE AG_db1_Cert
        AUTHORIZATION AG_db1_User
        FROM FILE = '/var/opt/mssql/shared/AG_db1_Cert.cer';

        GRANT CONNECT ON ENDPOINT::AGEP TO AG_db1_Login;
    end
go

waitfor delay '00:00:05';
go

if (@@SERVERNAME = 'db1' )
    begin
        CREATE AVAILABILITY GROUP [AGName]
        WITH (CLUSTER_TYPE = NONE)
        for REPLICA ON
            N'db1' WITH (ENDPOINT_URL = N'TCP://db1:5022', FAILOVER_MODE = MANUAL, AVAILABILITY_MODE = SYNCHRONOUS_COMMIT, BACKUP_PRIORITY = 50, SEEDING_MODE = AUTOMATIC, SECONDARY_ROLE(ALLOW_CONNECTIONS = ALL)),
            N'db2' WITH (ENDPOINT_URL = N'TCP://db2:5022', FAILOVER_MODE = MANUAL, AVAILABILITY_MODE = SYNCHRONOUS_COMMIT, BACKUP_PRIORITY = 50, SEEDING_MODE = AUTOMATIC, SECONDARY_ROLE(ALLOW_CONNECTIONS = ALL)),
            N'db3' WITH (ENDPOINT_URL = N'TCP://db3:5022', FAILOVER_MODE = MANUAL, AVAILABILITY_MODE = SYNCHRONOUS_COMMIT, BACKUP_PRIORITY = 50, SEEDING_MODE = AUTOMATIC, SECONDARY_ROLE(ALLOW_CONNECTIONS = ALL));
    end

if (@@SERVERNAME = 'db2' )
    begin
        ALTER AVAILABILITY GROUP [AGName] JOIN WITH (CLUSTER_TYPE = NONE)
        ALTER AVAILABILITY GROUP [AGName] GRANT CREATE ANY DATABASE
    end

if (@@SERVERNAME = 'db3' )
    begin
        ALTER AVAILABILITY GROUP [AGName] JOIN WITH (CLUSTER_TYPE = NONE)
        ALTER AVAILABILITY GROUP [AGName] GRANT CREATE ANY DATABASE
    end

go
