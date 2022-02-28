We can also configure Replication by T-SQL Scripts like below. (Below script is for push type transactional Replication) 

       1.Installing the server as a Distributor. 

                     exec sp_adddistributor @distributor = N'<SourceSQLInstance>', @password = N'' 

        2.  Adding the agent profiles 

     declare @config_id int 

exec sp_add_agent_profile @profile_id = @config_id OUTPUT, @profile_name = N'New_Agent', @agent_type = 3, @profile_type  = 1, @description = N'' 

exec sp_change_agent_parameter @profile_id = @config_id, @parameter_name = N'-BcpBatchSize', @parameter_value = N'2147473647' 

exec sp_change_agent_parameter @profile_id = @config_id, @parameter_name = N'-CommitBatchSize', @parameter_value = N'100' 

exec sp_change_agent_parameter @profile_id = @config_id, @parameter_name = N'-CommitBatchThreshold', @parameter_value = N'1000' 

exec sp_change_agent_parameter @profile_id = @config_id, @parameter_name = N'-HistoryVerboseLevel', @parameter_value = N'1' 

exec sp_change_agent_parameter @profile_id = @config_id, @parameter_name = N'-KeepAliveMessageInterval', @parameter_value = N'300' 

exec sp_change_agent_parameter @profile_id = @config_id, @parameter_name = N'-LoginTimeout', @parameter_value = N'15' 

exec sp_change_agent_parameter @profile_id = @config_id, @parameter_name = N'-MaxBcpThreads', @parameter_value = N'1' 

exec sp_change_agent_parameter @profile_id = @config_id, @parameter_name = N'-MaxDeliveredTransactions', @parameter_value = N'0' 

exec sp_change_agent_parameter @profile_id = @config_id, @parameter_name = N'-PollingInterval', @parameter_value = N'5' 

exec sp_change_agent_parameter @profile_id = @config_id, @parameter_name = N'-QueryTimeout', @parameter_value = N'1800' 

exec sp_change_agent_parameter @profile_id = @config_id, @parameter_name = N'-SkipErrors', @parameter_value = N'2601:2627:20598' 

exec sp_change_agent_parameter @profile_id = @config_id, @parameter_name = N'-TransactionsPerHistory', @parameter_value = N'100' 

GO 

-- Updating the agent profile defaults 

exec sp_MSupdate_agenttype_default @profile_id = 1 

GO 

exec sp_MSupdate_agenttype_default @profile_id = 2 

GO 

exec sp_MSupdate_agenttype_default @profile_id = 6 

GO 

exec sp_MSupdate_agenttype_default @profile_id = 11 

GO 

exec sp_MSupdate_agenttype_default @profile_id = 17 

GO 

    3. Adding the distribution databases 

exec sp_adddistributiondb @database = N'distribution', @data_folder = N'<MDF File path>', @data_file = N'distribution.MDF', @data_file_size = 11178, @log_folder = N'<LDF File path>', @log_file = N'distribution.LDF', @log_file_size = 289, @min_distretention = 0, @max_distretention = 72, @history_retention = 48, @deletebatchsize_xact = 5000, @deletebatchsize_cmd = 2000, @security_mode = 1 

   4. Adding the distribution publishers  

exec sp_adddistpublisher @publisher = N'<SQlServerInstance_Publisher>', @distribution_db = N'distribution', @security_mode = 0, @login = N'<db_owner_UserName>', @password = N'<userPassword>', @working_directory = N'<Directory_For_Replication_Files>', @trusted = N'false', @thirdparty_flag = 0, @publisher_type = N'MSSQLSERVER' 

GO 

  

exec sp_addsubscriber @subscriber = N'<SqlServerInstance_Subscriber>', @type = 0, @description = N'' 

GO 

    5. Enabling the replication database  

use master 

exec sp_replicationdboption @dbname = N'<SourceDatabseName>', @optname = N'publish', @value = N'true' 

GO 

exec [SourceDatabaseName].sys.sp_addlogreader_agent @job_login = N'<db_Owner_USerName>', @job_password = '<UserPassword>', @publisher_security_mode = 1 

GO 

exec [SourceDatabaseName].sys.sp_addqreader_agent @job_login = N'<db_Owner_USerName>', @job_password = '<UserPassword>',@frompublisher = 1 

GO 

   6. Adding the transactional publication 

use [<SourceDatabaseName>] 

exec sp_addpublication @publication = N'<SourceDatabaseName>_PUB', @description = N'Transactional publication of database ''<SourceDatabaseName>'' from Publisher ''<SqlServerInstance_Publisher>''.', @sync_method = N'concurrent', @retention = 0, @allow_push = N'true', @allow_pull = N'true', @allow_anonymous = N'true', @enabled_for_internet = N'false', @snapshot_in_defaultfolder = N'true', @compress_snapshot = N'false', @ftp_port = 21, @ftp_login = N'anonymous', @allow_subscription_copy = N'false', @add_to_active_directory = N'false', @repl_freq = N'continuous', @status = N'active', @independent_agent = N'true', @immediate_sync = N'true', @allow_sync_tran = N'false', @autogen_sync_procs = N'false', @allow_queued_tran = N'false', @allow_dts = N'false', @replicate_ddl = 1, @allow_initialize_from_backup = N'false', @enabled_for_p2p = N'false', @enabled_for_het_sub = N'false' 

GO 

  

  

exec sp_addpublication_snapshot @publication = N'<SourceDatabaseName>_PUB', @frequency_type = 1, @frequency_interval = 0, @frequency_relative_interval = 0, @frequency_recurrence_factor = 0, @frequency_subday = 0, @frequency_subday_interval = 0, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @job_login = N'<db_Owner_USerName>', @job_password = '<UserPassword>', @publisher_security_mode = 1 

exec sp_grant_publication_access @publication = N' <SourceDatabaseName> _PUB', @login = N'<SqlServerUser>' 

    7. Adding the transactional articles 

use [<SourceDatabaseName>] 

exec sp_addarticle @publication = N' <SourceDatabaseName> _PUB', @article = N'<Table/View/SP_Name>', @source_owner = N'dbo', @source_object = N' <Table/View/SP_Name> ', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'none', @destination_table = N'BANKACCOUNTTABLE', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dbo <Table/View/SP_Name>]', @del_cmd = N'CALL [sp_MSdel_dbo <Table/View/SP_Name>]', @upd_cmd = N'SCALL [sp_MSupd_dbo <Table/View/SP_Name>]' 

GO 

    8. Adding the transactional subscriptions 

use [<SourceDatabaseName>] 

exec sp_addsubscription @publication = N' <SourceDatabaseName> _PUB', @subscriber = N'<SqlServerInstance_Subscriber>', @destination_db = N'<DestinationDatabaseName>', @subscription_type = N'Push', @sync_type = N'automatic', @article = N'all', @update_mode = N'read only', @subscriber_type = 0 

exec sp_addpushsubscription_agent @publication = N' <SourceDatabaseName> _PUB', @subscriber = N'<SqlServerInstance_Subscriber>', @subscriber_db = N'<DestinationDatabaseName>', @job_login = N'<db_Owner_USerName>', @job_password = '<UserPassword>', @subscriber_security_mode = 1, @frequency_type = 64, @frequency_interval = 1, @frequency_relative_interval = 1, @frequency_recurrence_factor = 0, @frequency_subday = 4, @frequency_subday_interval = 5, @active_start_time_of_day = 0, @active_end_time_of_day = 235959, @active_start_date = 0, @active_end_date = 0, @dts_package_location = N'Distributor' 

GO 