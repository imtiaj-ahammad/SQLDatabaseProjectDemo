CREATE VIEW [dbo].[FullPerson]
	AS SELECT [p].[PersonId] AS PersonId, [p].[FirstName], [p].[LastName], 
				[a].[Id] AS AddressId, [a].[StreetAddress], [a].[City], [a].[State], [a].[ZipCode]
	FROM dbo.Person p
	LEFT JOIN Address a ON p.[PersonId] = a.PersonId