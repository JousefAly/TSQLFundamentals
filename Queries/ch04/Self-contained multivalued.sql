USE TSQLV4;

--using IN predicate make the predicate true if any the returned values is true
-- So it will work with IN operator not equality operators like =, >, <.
SELECT orderid
FROM SALES.Orders
WHERE empid IN 
	(SELECT empid
	 FROM HR.Employees
	 WHERE lastname LIKE N'D%');

--another example
SELECT custid, orderid, orderdate, empid
FROM Sales.Orders
WHERE custid IN 
	(SELECT custid
	 FROM Sales.Customers
	 WHERE country = N'USA');

-- return customers who didnt make any order
SELECT custid, companyname
FROM Sales.Customers
WHERE custid NOT IN
	(SELECT O.custid
	 FROM Sales.Orders AS O);

DROP TABLE IF EXISTS dbo.Orders;
CREATE TABLE dbo.Orders(orderid INT NOT NULL CONSTRAINT PK_Orders PRIMARY KEY);

INSERT INTO dbo.Orders(orderid)
	SELECT orderid 
	FROM Sales.Orders
	WHERE orderid % 2 = 0;

SELECT n
FROM dbo.Nums
WHERE n BETWEEN (SELECT MIN(orderid) FROM dbo.Orders)
		AND (SELECT MAX(orderid) FROM dbo.Orders)
	AND n NOT IN (SELECT orderid FROM dbo.Orders);

DROP TABLE IF EXISTS dbo.Orders;