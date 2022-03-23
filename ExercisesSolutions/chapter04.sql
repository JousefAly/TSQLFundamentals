USE TSQLV4;

--Select all orders placed in the last day of work
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders AS O1
WHERE orderdate = 
	(SELECT MAX(O2.orderdate)
	 FROM Sales.Orders AS O2);

--Write a query that returns all orders placed by the customer(s) who placed the highest number
--of orders. Note that more than one customer might have the same number of orders:
--we solve this problem by dividing it into steps
--first write a qurey that return customer with heighest number of orders:

SELECT TOP(1) WITH TIES custid , COUNT(*) AS orderscount
FROM Sales.Orders
GROUP BY custid
ORDER BY COUNT(*) DESC;

--second write the subquery into the outer query. should be easy now
SELECT O1.orderid, O1.custid, O1.empid
FROM Sales.Orders AS O1
WHERE custid IN 
	(SELECT TOP(1) WITH TIES O2.custid
	 FROM Sales.Orders AS O2
	 GROUP BY custid
	 ORDER BY COUNT(*) DESC);

--Write a query that returns employees who did not place orders on or after May 1, 2016:
--Tables involved: HR.Employees and Sales.Orders

SELECT E.empid, E.firstname, E.lastname
FROM HR.Employees AS E
WHERE E.empid NOT IN
	(SELECT empid
	 FROM Sales.Orders
	 WHERE orderdate >= '20160501')

--Write a query that returns countries where there are customers but not employees:
--Tables involved: Sales.Customers and HR.Employees

SELECT DISTINCT  C.country
FROM Sales.Customers AS C
WHERE C.country NOT IN
	(SELECT country FROM HR.Employees);

--Write a query that returns for each customer all orders placed on the customer ’s last day of activity:
--Table involved: Sales.Orders

SELECT custid, orderid, orderdate, empid
FROM Sales.Orders AS O1 
WHERE orderdate = 
	(SELECT MAX(orderdate)
	 FROM Sales.Orders AS O2
	 WHERE O2.custid = O1.custid);

--Write a query that returns customers who placed orders in 2015 but not in 2016:
--Tables involved: Sales.Customers and Sales.Orders

SELECT custid, companyname
FROM Sales.Customers
WHERE custid IN
		(SELECT custid
		FROM Sales.Orders
		WHERE YEAR(orderdate) = 2015 )
	 AND custid NOT IN 
		(SELECT custid
		 FROM Sales.Orders
		 WHERE YEAR(orderdate) = 2016 )

--Write a query that returns customers who ordered product 12:
--Tables involved: Sales.Customers, Sales.Orders, and Sales.OrderDetails
--that is complex :)

SELECT custid, companyname
FROM Sales.Customers AS C
WHERE EXISTS
	(SELECT * 
	 FROM Sales.Orders AS O
	 WHERE O.custid = C.custid
		AND EXISTS
			(SELECT * 
			 FROM Sales.OrderDetails AS OD
			 WHERE OD.productid = O.orderid
				AND OD.productid = 12 ));