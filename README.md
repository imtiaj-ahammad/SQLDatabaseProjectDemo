1. Lets add a project with name **SQLProject** and solution name **SQLDatabaseProjectDemo** against **SQL Server Database Project** framework
2. Let's open **SQL Server Object Explorer** from visual studio View menu
3. In **SQL Server Object Explorer**, explore the Projects folder, you would find you own project folder you just created, explore the folder and go to **Tables** folder and add new Table named **Person**
4. Explore the properties for Id and make it primary and enable Identity from properties
5. Add some more columns FirstName, LastName from designera dn script will auto generated
6. Add a new folder named **Tables** and move the recently created folder into that folder from solutin explorer
7. Add a new table **Address** from **solution explorer** and add the following properties- personId, StreetAddress, City, State, ZipCode 
8. Add the foreign key in Address for PersonId in Address.sql designer. 
9. Go to solution explorer and right click on the **SQLProject** and choose **Publish**
10. Select **Edit** and select local **MSSQLLocalDB** and click okay
11. Add a database name **DemoDB** and select **Save Profile As** and save it into your project directory with Name **LocalDemoDB**
12. Hit publish
13. Add New Folder into the **Solution Explorer** naming **PublishLocations** and move the **LocalDemoDB.publish.xml** into that folder. Now whenerver we need to publish again, we can **double-click** on the xml file and publish again.
14. Now, we are going to add some records into the actual db in the **SQL Server Object Explorer**. Lets add some records into the **Person** and **Address** table.
15. Let's add some views. First we will create a folder for views with the name **Views**. Now right-click on the folder and select **Add** and add a view with name **FullPerson**
    ```
    CREATE VIEW [dbo].[FullPerson]
        AS SELECT [p].[Id] AS PersonId, [p].[FirstName], [p].[LastName], 
                    [a].[Id] AS AddressId, [a].[StreetAddress], [a].[City], [a].[State], [a].[ZipCode]
        FROM dbo.Person p
        LEFT JOIN Address a ON p.Id = a.PersonId
    ```
16. While writing the script for view, you have a option **Expand Wildcards** if you right-click on the table instance under **Refactor** option
17. Let's create another folder for sp with the name **Stored Procedures** and add a sp with name **spPerson_FilterByLastName**
    ```
    CREATE PROCEDURE [dbo].[spPerson_FilterByLastName]
        @LastName nvarchar(50)
    AS
    BEGIN
        SELECT [Id], [FirstName], [LastName]
        FROM dbo.Person
        WHERE LastName = @LastName
    END
    ```
18. Now let's save the files and publish it by double-clicking on the **LocalDemoDB** file. And check the real db if the sp and view is published or not
19. One advantage of this framework is that, if you want to change column name after publishing once, you can use the **right-click->Refactor->Rename**
    - you can directly publish it now to do the changes into the db
    - Or you can use the **Generate Script** and hand it over to your db administrator
20. Let's update the **Id** column into **PersonId** in **Person** table and publish it with xml publish
21. Now, let's update the **FullPerson** view code, go to the view form db from **SQL Server Object Explorer** and click **View Code** and update the view and click **Update** and **Update Database**. 
    ```
    CREATE VIEW [dbo].[FullPerson]
        AS SELECT [p].[FirstName], [p].[LastName], 
                    [a].[Id] AS AddressId, [a].[StreetAddress], [a].[City], [a].[State], [a].[ZipCode]
        FROM dbo.Person p
        LEFT JOIN Address a ON p.[PersonId] = a.PersonId
    ```
    - And now check the **FullPerson** view from **Solution Explorer** in our project. You will see no update is found there.
    - Right-Click on project **SQLProject** from **Solution Explorer** and select **Schema Compare** and **Select Source**->choose db->**Compare**
    - You will get a compare result for view code. 
    - Select **Update** in the compare tab and check if the **View** code updated in the project
    - Save the compare file into a folder **Compares** in the project folder (include the file in solution explorer)
22. There is another feature **Data Comparison** in **SQL Server Object Explorer** when you right click on Db. You can compare 2 databases and fetch data from one db to another.
23. Another feature is **Scheduler** to run scripts on some specific time. 
24. Let's add a folder named **PostPublishScripts**, right-click on the folder and select **Add new Item**, go for **User Scripts** and Add **Post-Deployment Script** with name **Script.PostDeployPerson.sql**
    ```
    IF not EXISTS(SELECT * FROM dbo.Person WHERE FirstName = 'demo' AND LastName = 'user' )
    BEGIN
        INSERT INTO dbo.Person(FirstName,LastName)
        VALUES('demo','user');
    END
    ```
    - Now, publish with the **LocalDemoDB.publish.xml**. You will find the demoUser in **Person** table afterwards
25. Let's have a scenario that you already have a db and you want to carry on with that existing db in the project. 
    - Go to **Solution Explorer** -> Add New Project -> SQL Server -> SQL Server Database Project -> name it **SQLFromExisting**
    - Go to **Solution Explorer** -> Right-Click on the project -> Import -> Database -> Select SQL Server -> Select DB -> Start -> Finish
    - Import will fetch all the tables, views and sps from the db



References:
            - https://www.youtube.com/watch?v=ijDcHGxyqE4
