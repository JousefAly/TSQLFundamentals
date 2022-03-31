USE TSQLV4;

--Query with a derived table using inline aliasing form

SELECT orderyear, COUNT(DISTINCT custid) AS numcusts
FROM(SELECT YEAR(orderdate) AS orderyear, custid
		FROM Sales.Orders) AS D
GROUP BY orderyear;