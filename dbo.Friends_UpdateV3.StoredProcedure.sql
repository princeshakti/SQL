USE [C119_shaktipatel99_gmail]
GO
/****** Object:  StoredProcedure [dbo].[Friends_UpdateV3]    Script Date: 9/26/2022 12:30:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


	CREATE proc [dbo].[Friends_UpdateV3]
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
		,@Id int
		
	as

	/*----TEST CODE -----
	Declare @Id int = 283
	DECLARE @batchSkills dbo.SkillsV2
	INSERT INTO @batchSkills (Name)
		VALUES ('Vs'), ('Git')

	Declare  @Title nvarchar(120)= 'Mr'
			,@Bio nvarchar(700)= 'Test Update'
			,@Summary nvarchar(255)= 'Update summ'
			,@Headline nvarchar(80)= 'Chief of Potatoes'
			,@Slug nvarchar(100)= 'Upd'
			,@StatusId int= 2
			,@ImageTypeId int= 2
			,@ImageUrl nvarchar(700) = 'updated url'
			
			,@UserId int= 123
		
			Select *
			from dbo.FriendsV2 as f inner join dbo.Images as i
				 on f.PrimaryImageId = i.Id
				 inner join dbo.FriendSkills as fs
				 on fs.FriendId = f.Id
				 inner join dbo.Skills as s
				 on s.Id = fs.SkillId
			where f.Id = @Id

		Execute dbo.Friends_UpdateV3

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
			,@Id
			

			Select *
			from dbo.FriendsV2 as f inner join dbo.Images as i
				 on f.PrimaryImageId = i.Id
				 inner join dbo.FriendSkills as fs
				 on fs.FriendId = f.Id
				 inner join dbo.Skills as s
				 on s.Id = fs.SkillId
			where f.Id = @Id
			

	*/
	Begin
	Declare @DateMod datetime2 = getutcdate()
	
	Insert Into dbo.Skills (Name)
		Select bs.Name 
		From @batchSkills as bs
		Where Not Exists (Select 1
						  From dbo.Skills as s
						  Where s.Name = bs.Name) 

	UPDATE [dbo].[Images]
	   SET [TypeId] = @ImageTypeId
		   ,[Url] = @ImageUrl
	   WHERE Id = ( Select f.PrimaryImageId
					From dbo.FriendsV2 as f
					Where f.Id = @Id)


	UPDATE [dbo].[FriendsV2]
	   SET [Title] = @Title
		  ,[Bio] = @Bio
		  ,[Summary] = @Summary
		  ,[Headline] = @Headline
		  ,[Slug] = @Slug
		  ,[StatusId] = @StatusId
		  
		  ,[DateModified] = @DateMod
		  ,[UserId] = @UserId
	 WHERE Id = @Id

	Delete from dbo.FriendSkills 
	Where FriendId = @Id

	Insert into dbo.FriendSkills (FriendId, SkillId)
	Select @Id, s.Id
	From dbo.Skills as s
	Where Exists (Select 1
				  From @batchSkills as bs
				  Where s.Name = bs.Name)


	


	End
GO
