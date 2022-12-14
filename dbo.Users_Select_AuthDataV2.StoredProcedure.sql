USE [Carte]
GO
/****** Object:  StoredProcedure [dbo].[Users_Select_AuthDataV2]    Script Date: 9/26/2022 12:24:53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Shakti Patel
-- Create date: 08/29/2022
-- Description:	Users Select Info After Auth Confirm before logging in
-- Code Reviewer: Franklin Ramos


-- MODIFIED BY: author
-- MODIFIED DATE:12/1/2020
-- Code Reviewer: 
-- Note: 
-- =============================================

	CREATE proc [dbo].[Users_Select_AuthDataV2]
			@Email nvarchar(255)
		   
		  
	as

	/* ---- TEST CODE ----
		Declare @Email nvarchar(255) = 'test9@dispostable.com'

		Execute dbo.Users_Select_AuthDataV2 @Email
			
		Select * from dbo.roles
		Select * from dbo.users
	*/

	Begin

			Declare @Status int
				   ,@isConfirmed bit
			Select  @Status = u.UserStatusId
				   ,@isConfirmed = u.isConfirmed
			From dbo.Users as u
			Where   @Email = Email
			 
	IF @isConfirmed = 1
		If @Status < 2
			SELECT	 Id
					,[Email]
					,[Password]
					,[Roles] = (
								Select r.Id, r.Name
								From dbo.Roles as r INNER JOIN dbo.UserRoles as ur ON r.Id = ur.RoleId
								Where ur.UserId = u.Id
								FOR JSON AUTO
							   )
			FROM [dbo].[Users] as u
			WHERE Email = @Email
	ELSE
		THROW 60001, 'Login Failed', 16
	ELSE
		THROW 60002, 'User Email Not Confirmed', 16
		
		
	End

	
GO
