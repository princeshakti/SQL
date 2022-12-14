USE [C119_shaktipatel99_gmail]
GO
/****** Object:  StoredProcedure [dbo].[Tags_BatchInsert]    Script Date: 9/26/2022 12:29:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE proc [dbo].[Tags_BatchInsert]
		@batchTags dbo.Tags READONLY
	as 
	
	/* --- TEST CODE ---
	Declare @newTags dbo.Tags

	Insert into dbo.Tags
	Values ('product dev'), ('software dev')

	Execute dbo.Tags_BatchInsert @newTags

	Select *
	From dbo.Tags

	*/

	Begin 

	Insert Into dbo.Tags ([Name])
	Select bt.[Name]
	From @batchTags as bt
	Where NOT EXISTS ( Select 1 
					   From dbo.Tags as t
					   Where t.Name = bt.Name )
	
	End 
GO
