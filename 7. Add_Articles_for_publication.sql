       use [<SourceDatabaseName>] 

       exec sp_addarticle @publication = N' <SourceDatabaseName> _PUB', @article = N'<Table/View/SP_Name>', @source_owner = N'dbo', @source_object = N' <Table/View/SP_Name> ', @type = N'logbased', @description = N'', @creation_script = N'', @pre_creation_cmd = N'drop', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N'none', @destination_table = N'BANKACCOUNTTABLE', @destination_owner = N'dbo', @status = 24, @vertical_partition = N'false', @ins_cmd = N'CALL [sp_MSins_dbo <Table/View/SP_Name>]', @del_cmd = N'CALL [sp_MSdel_dbo <Table/View/SP_Name>]', @upd_cmd = N'SCALL [sp_MSupd_dbo <Table/View/SP_Name>]' 

       GO 