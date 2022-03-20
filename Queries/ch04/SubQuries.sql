USE TSQLV4;

DECLARE @maxid AS INT = (SELECT MAX(orderid)
						 FROM Sales.Orders);
SELECT orderid, orderdate, empid, custid
FROM Sales.Orders
WHERE orderid = @maxid;
--same as substitude the variable declaration with a sub query

SELECT orderid, orderdate, empid, custid
FROM Sales.Orders
WHERE orderid = (SELECT MAX(orderid)
				FROM Sales.Orders);
-- sub query must be scalar when use equality operator

Select orderid
FROM Sales.Orders
WHERE empid = (SELECT E.empid 
				FROM HR.Employees AS E
				WHERE E.lastname LIKE N'C%');
-- the above query worked because accidently their is only one employee matches the predicate
-- the following query fails because the predicate matches more than one empoloyee
Select orderid
FROM Sales.Orders
WHERE empid = (SELECT E.empid 
				FROM HR.Employees AS E
				WHERE E.lastname LIKE N'D%');
