/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
IF not EXISTS(SELECT * FROM dbo.Person WHERE FirstName = 'demo' AND LastName = 'user' )
BEGIN
    INSERT INTO dbo.Person(FirstName,LastName)
    VALUES('demo','user');
END