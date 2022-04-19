USE TSQLV4;
--Create View 
--Go Signals the end of a batch of T-SQL statments to the sql server utilities
DROP VIEW IF EXISTS Sales.USACusts;
GO
CREATE VIEW Sales.USACusts
AS
SELECT 
	custid, companyname, contactname, contacttitle, address,
	city, region, postalcode, country, phone, fax
FROM Sales.Customers
WHERE country = N'USA';
GO

--Remember a View should not difine order if you need order for presitaion purposes 
-- define the order by clause in the outer query
--Like this
SELECT custid
FROM Sales.USACusts
ORDER BY custid
GO

ALTER VIEW Sales.USACusts
AS
SELECT
custid, companyname, contactname, contacttitle, address,
city, region, postalcode, country, phone, fax
FROM Sales.Customers
WHERE country = N'USA'
ORDER BY region;
GO

--Alter the view to its original version
ALTER VIEW Sales.USACusts
AS
SELECT
custid, companyname, contactname, contacttitle, address,
city, region, postalcode, country, phone, fax
FROM Sales.Customers
WHERE country = N'USA';
GO

--Get the definition of the view
SELECT OBJECT_DEFINITION(OBJECT_ID('Sales.USACusts'));
GO

--Alter View to have the encryption option
ALTER VIEW Sales.USACusts WITH ENCRYPTION
AS
SELECT
	custid, companyname, contactname, contacttitle, address,
	city, region, postalcode, country, phone, fax
	FROM Sales.Customers
	WHERE country = N'USA';
GO

--Indicates that Object is encrypted
EXEC sp_helptext 'Sales.USACusts';


/*The SCHEMABINDING option is available to views and UDFs; it binds the schema of
referenced objects and columns to the schema of the referencing object. It indicates that
referenced objects cannot be dropped and that referenced columns cannot be dropped or
altered.*/
