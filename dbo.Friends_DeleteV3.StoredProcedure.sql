USE [C119_shaktipatel99_gmail]
GO
/****** Object:  StoredProcedure [dbo].[Friends_DeleteV3]    Script Date: 9/26/2022 12:29:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Friends_DeleteV3]
	 @StatusId int
	,@Id int 

as 

/* ----Test Code ----
	Declare @Id int = 6
	Declare @StatusId int = 1

	Select *
	From dbo.FriendsV2
	Where Id = @Id

	Execute dbo.Friends_DeleteV3 
		 @StatusId
		,@Id

	Select *
	From dbo.FriendsV2
	Where Id = @Id

*/

Begin
Declare @DateMod datetime2 = getutcdate()

	UPDATE [dbo].[FriendsV2]
	   SET [StatusId] = @StatusId
		   ,[DateModified] = @DateMod
		  
	 WHERE Id = @Id

End
GO
