USE [msdb]
GO

/****** Object:  Operator [Email]    Script Date: 9/10/2021 3:13:00 AM ******/
EXEC msdb.dbo.sp_add_operator @name=N'Email', 
		@enabled=1, 
		@weekday_pager_start_time=80000, 
		@weekday_pager_end_time=180000, 
		@saturday_pager_start_time=90000, 
		@saturday_pager_end_time=180000, 
		@sunday_pager_start_time=90000, 
		@sunday_pager_end_time=180000, 
		@pager_days=62, 
		@email_address=N'hank072097@gmail.com', 
		@category_name=N'[Uncategorized]'
GO


