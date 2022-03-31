USE TSQLV4;

--Query with a derived table using inline aliasing form
-- We usually use table expressions for logical (not performance related) reasons
-- The TSQL will expand the inner query and access its objects directly in the outer query

SELECT orderyear, COUNT(DISTINCT custid) AS numcusts
FROM(SELECT YEAR(orderdate) AS orderyear, custid
		FROM Sales.Orders) AS D
GROUP BY orderyear;

--the same query using arguments to filter the result to return number of customers placed order in
--a year and  handled by  input employee

DECLARE @empid AS INT = 3;
SELECT orderyear, COUNT(DISTINCT custid) AS numcusts
FROM(SELECT YEAR(orderdate) AS orderyear, custid
		FROM Sales.Orders
		WHERE empid = @empid) AS D
GROUP BY orderyear;

--Nesting
--We can use nesting to nest table experessions but in most cases cesting add complexity and difficulty in
--Readability we can avoid it if the alternative solution -that without table expressions- is more simpler.