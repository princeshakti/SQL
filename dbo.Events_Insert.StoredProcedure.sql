USE [C119_shaktipatel99_gmail]
GO
/****** Object:  StoredProcedure [dbo].[Events_Insert]    Script Date: 9/26/2022 12:29:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE proc [dbo].[Events_Insert]
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
		,@Id int OUTPUT
	as 

	/* --- Test Code ---
	Declare  @Id int = 0
	Declare  @name nvarchar(25) = 'Clippers vs Heat'
			,@headline nvarchar(120) = 'semi-finals'
			,@description nvarchar(MAX) = 'basketball game'
			,@summary nvarchar(255) = 'bb summary'
			,@slug nvarchar(MAX) = 'h vs c'
			,@statusId int = 1
			,@latitude float = 10.35494521343
			,@longitude float = -100.3424214324
			,@zipCode int = 90012
			,@address nvarchar(100) = '100 East st'
			,@dateStart datetime2 = '08/06/2022'
			,@dateEnd datetime2 = '08/07/2022'

	Execute dbo.Events_Insert
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
			,@Id OUTPUT

	Select * From dbo.location
	Select * From dbo.metaData
	Select * From dbo.Events
	*/

	Begin 

	Declare @LocationId int;
	INSERT INTO [dbo].[location]
           ([latitude]
           ,[longitude]
           ,[zipCode]
           ,[Address])
     VALUES
           (@latitude
           ,@longitude
           ,@zipCode
           ,@address)
	SET @LocationId = SCOPE_IDENTITY()

	Declare @MetaDataId int;
	INSERT INTO [dbo].[metaData]
           ([dateStart]
           ,[dateEnd]
           ,[locationId])
     VALUES
           (@dateStart
           ,@dateEnd
           ,@LocationId)
	SET @MetaDataId = SCOPE_IDENTITY()

	INSERT INTO [dbo].[Events]
           ([metaDataId]
           ,[name]
           ,[headline]
           ,[description]
           ,[summary]
           ,[slug]
           ,[statusId]
)
     VALUES
           (@MetaDataId
           ,@name
           ,@headline
           ,@description
           ,@summary
           ,@slug
           ,@statusId)
	SET @Id = SCOPE_IDENTITY()

	End 
GO
