USE [C119_shaktipatel99_gmail]
GO
/****** Object:  StoredProcedure [dbo].[Events_SearchPaginationV2]    Script Date: 9/26/2022 12:29:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Events_SearchPaginationV2]
		@PageIndex int
		,@PageSize int
		,@Latitude float
		,@Longitude float
		,@Radius int

	as

	/* --- Test Code ---
	Declare @PageIndex int = 0
			,@PageSize int = 5
			,@Latitude float = 10.35494521343
			,@Longitude float = -116.3424214324
			,@Radius int = 10

	Execute dbo.Events_SearchPaginationV2
			@PageIndex
			,@PageSize
			,@Latitude
			,@Longitude
			,@Radius

	

	*/

	Begin 

	Declare @Offset int = @PageIndex * @PageSize 
		,@coords geography = geography::Point(@Latitude,@Longitude,4326)

	SELECT e.Id
      ,[metaDataId]				
      ,[name]
      ,[headline]
      ,[description]
      ,[summary]
      ,[slug]
      ,[statusId]
      ,[dateCreated]
      ,[dateModified]
	  ,m.dateStart
	  ,m.dateEnd
	  ,l.latitude 
	  ,l.longitude
	  ,l.zipCode
	  ,l.Address
	  ,[TotalCount] = COUNT(1) Over()
	 FROM [dbo].[Events] as e inner join dbo.metaData as m
					  On e.metaDataId = m.id
					  inner join dbo.location as l
					  on l.Id = m.locationId

	where @coords.STDistance(geography::Point(l.latitude,l.longitude,4326)) < @Radius

	
	Order By e.Id

	OFFSET @Offset ROWS
	Fetch Next @PageSize Rows ONLY 

	
End 
GO
