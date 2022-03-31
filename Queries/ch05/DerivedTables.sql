USE TSQLV4;

--Derived tables
SELECT *
FROM (SELECT custid, companyname
		FROM Sales.Customers
		WHERE country = N'USA') AS USACusts;