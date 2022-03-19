--chapeter 2 exercises
USE TSQLV4;

--exercise 1
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE YEAR(orderdate) = 2015 AND MONTH(orderdate) = 6;

--another solution better solution using the range filter to use an index in an efficient manner
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE orderdate >= '20150601' AND orderdate <= '20150630';

--exercise 2
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE orderdate = EOMONTH(orderdate);

--exercise 3
SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname LIKE '%e%e%';

--exercise 4 quite tricky, should be proud as a beginner :)
 SELECT orderid, SUM(unitprice * qty) AS totalvalue
 FROM Sales.OrderDetails
 GROUP BY orderid
 HAVING SUM(unitprice * qty) > 10000
 ORDER BY totalvalue DESC;

 --exersice 5 tricky one cant use [a-z]% because collation use dictionary sort
 --ex: a A b B c C .. z Z though all will qualify a-z exclude Z
 SELECT empid, lastname
 FROM HR.Employees
 WHERE lastname Collate Latin1_General_CS_AS LIKE '[abcdefghijklmnopqrstuvwxyz]%';

 --exercise 6
 /*
	query 1 :
	selects all the orders that took place before may 1 2016 placed with a specified employee and the number of these orders 
	query 2 : 
	selects employees that haven't make any activity since may 2016
 */

 --exersice 7 
 SELECT TOP 3  shipcountry, AVG(freight)  AS avgfreight
 FROM Sales.Orders
 WHERE orderdate >= '20150101' AND orderdate < '20160101'
 GROUP BY shipcountry
 ORDER BY avgfreight DESC;

 --the same with offest fetch
 SELECT shipcountry, AVG(freight)  AS avgfreight
 FROM Sales.Orders
 WHERE orderdate >= '20150101' AND orderdate < '20160101'
 GROUP BY shipcountry
 ORDER BY avgfreight DESC
 OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY;

 --exercise 8 Need to study window partition

 --exercise 9
 SELECT empid, firstname, titleofcourtesy,
	CASE titleofcourtesy
	WHEN N'Mr.' THEN 'male'
	WHEN N'Ms.' THEN 'female'
	WHEN N'Mrs.' THEN 'female'
	ELSE 'unknown'
	END AS gender
 FROM HR.Employees;
 --another solution
 SELECT empid, firstname, titleofcourtesy,
	CASE 
	WHEN titleofcourtesy IN ('Mr.')		   THEN 'Male'
	WHEN titleofcourtesy IN ('Ms.','Mrs.') THEN 'Female'
	ELSE										'unknown'
	END AS gender
 FROM HR.Employees;

 --exercise 10

 SELECT custid, region
 FROM Sales.Customers
 ORDER BY 
	CASE WHEN region IS NULL THEN 1 ELSE 0 END, region;