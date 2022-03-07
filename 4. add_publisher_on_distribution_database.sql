       exec sp_adddistpublisher @publisher = N'<SQlServerInstance_Publisher>', @distribution_db = N'distribution', @security_mode = 0, @login = N'<db_owner_UserName>', @password = N'<userPassword>', @working_directory = N'<Directory_For_Replication_Files>', @trusted = N'false', @thirdparty_flag = 0, @publisher_type = N'MSSQLSERVER' 

       GO 

       exec sp_addsubscriber @subscriber = N'<SqlServerInstance_Subscriber>', @type = 0, @description = N'' 

       GO 