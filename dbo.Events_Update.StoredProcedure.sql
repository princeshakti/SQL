USE [C119_shaktipatel99_gmail]
GO
/****** Object:  StoredProcedure [dbo].[Events_Update]    Script Date: 9/26/2022 12:29:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE proc [dbo].[Events_Update]
		 @name nvarchar(25)
		,@headline nvarchar(120)
		,@description nvarchar(MAX)
		,@summary nvarchar(255)
		,@slug nvarchar(MAX)
		,@statusId int
		,@latitude float
		,@longitude float
		,@zipCode int
		,@address nvarchar(100)
		,@dateStart datetime2
		,@dateEnd datetime2
		,@Id int 
	as

	/* --- Test Code --- 
	Declare @Id int = 1
	Declare  @name nvarchar(25) = 'Lakers'
			,@headline nvarchar(120) = 'Ann'
			,@description nvarchar(MAX) = 'anniversary'
			,@summary nvarchar(255) = 'summary'
			,@slug nvarchar(MAX) = 'ann'
			,@statusId int = 1
			,@latitude float = 15.321092343
			,@longitude float = -432.18494345
			,@zipCode int = 80123
			,@address nvarchar(100) = '500 Main st'
			,@dateStart datetime2 = '07/24/2022'
			,@dateEnd datetime2 = '07/25/2022' 

	Select * From dbo.location Where Id = @Id
	Select * From dbo.metaData Where Id = @Id
	Select * From dbo.Events  Where Id = @Id

	Execute dbo.Events_Update 
		 @name 
		,@headline
		,@description 
		,@summary 
		,@slug
		,@statusId 
		,@latitude 
		,@longitude 
		,@zipCode 
		,@address 
		,@dateStart
		,@dateEnd 
		,@Id

	Select * From dbo.location Where Id = @Id
	Select * From dbo.metaData Where Id = @Id
	Select * From dbo.Events Where Id = @Id

	*/

	Begin 
	Declare @DateMod datetime2 = getutcdate()

	UPDATE [dbo].[location]
	SET [latitude] = @latitude
      ,[longitude] = @longitude
      ,[zipCode] = @zipCode
      ,[Address] = @Address
	WHERE Id = ( Select m.locationId 
				 From dbo.metaData as m inner join dbo.Events as e
				 On m.id = e.metaDataId 
				 Where e.Id = @Id ) 


	UPDATE [dbo].[metaData]
    SET [dateStart] = @dateStart
      ,[dateEnd] = @dateEnd
    WHERE Id = ( Select e.metaDataId
				 From dbo.Events as e 
				 Where e.Id = @Id )


	UPDATE [dbo].[Events]
    SET 
       [name] = @name
      ,[headline] = @headline
      ,[description] = @description
      ,[summary] = @summary
      ,[slug] = @slug
      ,[statusId] = @statusId
      ,[dateModified] = @DateMod
    WHERE Id = @Id

	End 
GO
