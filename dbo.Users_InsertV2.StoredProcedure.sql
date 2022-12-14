USE [Carte]
GO
/****** Object:  StoredProcedure [dbo].[Users_InsertV2]    Script Date: 9/26/2022 12:24:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	-- =============================================
-- Author:		Shakti Patel
-- Create date: 08/31/2022
-- Description:	User Insert with roles
-- Code Reviewer: Emily Canas


-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: 
-- Note: 
-- =============================================
	
	CREATE proc [dbo].[Users_InsertV2]
				@Email nvarchar(255)
			   ,@Password varchar(100)
			   ,@batchRoles dbo.UserRolesV2 READONLY
			   ,@Id int OUTPUT
	as

	/* ---- TEST CODE ----
		Declare @Id int = 0
		Declare @Email nvarchar(255) = 'test15@dispostable.com'
			   ,@Password varchar(100) = 'Password1!'

		Declare @batchRoles dbo.UserRolesV2
			Insert into @batchRoles ([RoleId])
			Values  (1), (5)

		Execute dbo.Users_InsertV2
				@Email
			   ,@Password
			   ,@batchRoles
			   ,@Id OUTPUT
		
		SELECT *
		FROM dbo.Users

		SELECT *
		FROM dbo.UserRoles

	*/

	Begin

	INSERT INTO [dbo].[Users]
				(
				 [Email]
				,[Password]
				)
		VALUES
				(	 
				 @Email
				,@Password
				)
	SET @Id = SCOPE_IDENTITY()

	Declare @userId int = @Id

	Insert into [dbo].[UserRoles] ([UserId],[RoleId])
		Select @userId, r.RoleId
		From @batchRoles as r
		Where NOT EXISTS (Select 1
						  From dbo.UserRoles as u
						  Where u.RoleId = r.RoleId AND u.UserId = @userId
						  )

	End 
GO
