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
