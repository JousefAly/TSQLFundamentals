USE TSQLV4;
-- select orders with maximum id for each customer
SELECT custid, orderid, orderdate, empid
FROM Sales.Orders AS O1
WHERE orderid = 
	(SELECT MAX(orderid)
	 FROM Sales.Orders AS O2
	 WHERE O2.custid = O1.custid);