       use master 

       exec sp_replicationdboption @dbname = N'<SourceDatabseName>', @optname = N'publish', @value = N'true' 

       GO 

       exec [<SourceDatabaseName>].sys.sp_addlogreader_agent @job_login = N'<db_Owner_USerName>', @job_password = '<UserPassword>', @publisher_security_mode = 1 

       GO 

       exec [<SourceDatabaseName>].sys.sp_addqreader_agent @job_login = N'<db_Owner_USerName>', @job_password = '<UserPassword>',@frompublisher = 1 

       GO 