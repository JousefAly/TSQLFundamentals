USE TSQLV4;
-- select orders with maximum id for each customer
SELECT custid, orderid, orderdate, empid
FROM Sales.Orders AS O1
WHERE orderid = 
	(SELECT MAX(orderid)
	 FROM Sales.Orders AS O2
	 WHERE O2.custid = O1.custid);

--return customers from spain who placed orders

SELECT custid, companyname
FROM Sales.Customers AS C
WHERE country = N'Spain'
	AND EXISTS 
		(SELECT * FROM Sales.Orders AS O
		 WHERE O.custid = C.custid);