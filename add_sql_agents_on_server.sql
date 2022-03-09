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