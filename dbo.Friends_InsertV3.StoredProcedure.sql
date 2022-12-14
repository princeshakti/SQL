USE [C119_shaktipatel99_gmail]
GO
/****** Object:  StoredProcedure [dbo].[Friends_InsertV3]    Script Date: 9/26/2022 12:29:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	CREATE   proc [dbo].[Friends_InsertV3]
				@Title nvarchar(120)
			   ,@Bio nvarchar(700)
			   ,@Summary nvarchar(255)
			   ,@Headline nvarchar(80)
			   ,@Slug nvarchar(100)
			   ,@StatusId int
			   ,@ImageTypeId int
			   ,@ImageUrl nvarchar(700)
			   ,@batchSkills dbo.SkillsV2 READONLY 
           
			   ,@UserId int
			   ,@Id int OUTPUT

	as 

	/* --- Test Code ---

		DECLARE @batchSkills dbo.SkillsV2

		INSERT INTO @batchSkills (Name)
		VALUES ('Potato'), ('Tomato')

		Declare @Id int =0	 
		Declare	@Title nvarchar(120) = 'Dr.Potato'
				,@Bio nvarchar(700) = 'Matt'
				,@Summary nvarchar(255)= 'Damon'
				,@Headline nvarchar(80)= 'actr '
				,@Slug nvarchar(100)= 'actr'
				,@StatusId int= 1
				,@UserId int = 783
				,@ImageTypeId  int = 1
				,@ImageUrl nvarchar(700)= 'Damon'
			

		Execute[dbo].[Friends_InsertV3]	
			    @Title
			   ,@Bio
			   ,@Summary
			   ,@Headline
			   ,@Slug
			   ,@StatusId
			   ,@ImageTypeId
			   ,@ImageUrl
			   ,@batchSkills

			   ,@UserId 
			   ,@Id OUTPUT
		   
		SELECT * FROM dbo.Skills
		SELECT * FROM dbo.FriendSkills

		Select * 
		from dbo.FriendsV2
	*/

	Begin 

/*	Update dbo.Skills
			set Name = bs.Name
		From @batchSkills as bs inner join dbo.Skills as s
			on s.Name = bs.Name
*/

	Declare @ImageId int;
	Insert Into dbo.Images (TypeId		
							,[Url])
				Values 
					(@ImageTypeId	
					 ,@ImageUrl)

		SET @ImageId = SCOPE_IDENTITY()

	INSERT INTO [dbo].[FriendsV2] 
			   ([Title]
			   ,[Bio]
			   ,[Summary]
			   ,[Headline]
			   ,[Slug]
			   ,[StatusId]
			   ,[PrimaryImageId]
			   ,[UserId])
		 VALUES
			  ( @Title
			   ,@Bio 
			   ,@Summary 
			   ,@Headline 
			   ,@Slug 
			   ,@StatusId 
			   ,@ImageId
			   ,@UserId )
		

		SET @Id = SCOPE_IDENTITY()

		EXEC [dbo].[Skills_InsertBatch] @batchSkills


	Insert into dbo.FriendSkills (FriendId, SkillId)
						(Select @Id, s.Id
							From dbo.Skills as s
							Where Exists (
								Select	1
								From	@batchSkills as bs
								Where	s.Name = bs.Name
										)
						)
	End
GO
