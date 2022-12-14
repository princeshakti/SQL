USE [C119_shaktipatel99_gmail]
GO
/****** Object:  StoredProcedure [dbo].[Skills_InsertBatch]    Script Date: 9/26/2022 12:29:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE proc [dbo].[Skills_InsertBatch]
		@batchSkills dbo.SkillsV2 READONLY 
		
	as

	/* --- Test Code ---
		Declare @newSkills dbo.Skills
		 

		Insert into dbo.Skills ([Name])
		Values ('HTML'), ('SQL'), ('Phyton')

		Execute dbo.Skills_InsertBatch @newSkills

		Select *
		From dbo.Skills
		
	*/

	Begin 
		
		Insert into [dbo].[Skills] ([Name])
		Select  b.[Name]		  		   
		From @batchSkills as b
		Where NOT EXISTS ( Select 1
						   From dbo.Skills as s
						   Where s.Name = b.Name )						  	

	End 
GO
