      exec sp_adddistributiondb @database = N'distribution', @data_folder = N'<MDF File path>', @data_file = N'distribution.MDF', @data_file_size = 11178, @log_folder = N'<LDF File path>', @log_file = N'distribution.LDF', @log_file_size = 289, @min_distretention = 0, @max_distretention = 72, @history_retention = 48, @deletebatchsize_xact = 5000, @deletebatchsize_cmd = 2000, @security_mode = 1 