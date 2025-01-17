
/*Self- contained subquery
Correlated Subqueries
Derived Table
CASE
String Functions
DISTINCT
TOP/ TOP WITH TIES
OFFSET FETCH

*/

--EXAMPLE 1

--self contained subqueries

  SELECT 
  SalesOrderID,
  ShipMethodID,
  TotalDue
  FROM Sales.SalesOrderHeader
  WHERE OrderDate = 
   (
  SELECT MAX(OrderDate)
  FROM [AdventureWorks2019].[Sales].[SalesOrderHeader]
  )




--Example 2

SELECT * 
FROM Sales.SalesOrderHeader
WHERE CustomerID IN 
(SELECT DISTINCT CustomerID
FROM Sales.SalesOrderHeader WHERE CustomerID BETWEEN 11000 AND 11006)



--FIRST ORDER DATE OF EACH CUSTOMER
--find highest list price in each category

--Example 3
SELECT 
* 
FROM
Production.Product AS p1
WHERE 
p1.Listprice  = 
(
SELECT 
MAX(ListPrice)
FROM Production.Product as P2
WHERE p2.ProductSubcategoryID = P1.ProductSubcategoryID
GROUP BY P2.ProductSubcategoryID
)

--EXAMPLE 4

SELECT 
CustomerID
,OrderDate
FROM Sales.SalesOrderHeader AS a
WHERE a.SalesOrderID IN (SELECT MAX(SalesOrderID)
  
  FROM [AdventureWorks2019].[Sales].[SalesOrderHeader] AS b 
  WHERE a.CustomerID = b.CustomerID
  GROUP BY b.CustomerID)
  order by CustomerID


  --Example 5
  --simple case
 SELECT TOP 10*
 FROM [AdventureWorks2019].[Sales].[SalesOrderHeader]

  SELECT SalesOrderID,
		CustomerID,
		CASE ShipMethodID
			WHEN 1 THEN 'DHL'
			when 2 THEN 'ZY - EXPRESS'
			when 3 THEN 'OVERSEAS - DELUXE'
			when 4 then 'OVERNIGHT J-FAST'
			WHEN 5 THEN 'Royal mail'
			ELSE 'Dont know'
			END AS [Shipping Method]
 FROM [AdventureWorks2019].[Sales].[SalesOrderHeader]

 --Using simple CASE expression in aggregate function

 SELECT    
    SUM(CASE
            WHEN ShipMethodID= 1
            THEN 1
            ELSE 0
        END) AS 'XRQ - TRUCK GROUND', 
    SUM(CASE
            WHEN ShipMethodID = 2
            THEN 1
            ELSE 0
        END) AS 'ZY - EXPRESS', 
    SUM(CASE
            WHEN ShipMethodID = 3
            THEN 1
            ELSE 0
        END) AS 'OVERSEAS - DELUXE', 
    SUM(CASE
            WHEN ShipMethodID = 4
            THEN 1
            ELSE 0
        END) AS 'OVERNIGHT J-FAST', 
		SUM(CASE
            WHEN ShipMethodID = 5
            THEN 1
            ELSE 0
        END) AS 'rOYAL MAIL', 
	SUM(CASE
		WHEN ShipMethodID is null
		then 1
		else 0
		end) AS 'NOT KNOWN',
    COUNT(*) AS Total
FROM    
    [AdventureWorks2019].[Sales].[SalesOrderHeader]
WHERE 
    YEAR(OrderDate) = 2012;


	SELECT 
	SalesOrderDetailID,
	OrderQty,
CASE
    WHEN OrderQty > 15 THEN 'The quantity is greater than 15'
    WHEN OrderQty = 15 THEN 'The quantity is 15'
    ELSE 'The quantity is under 15'
END AS QuantityText
FROM Sales.SalesOrderDetail;


-- OFFSET-FETCH
SELECT SalesOrderID,
OrderDate,
SalesOrderNumber,
CustomerID

FROM    
    [AdventureWorks2019].[Sales].[SalesOrderHeader]
order by OrderDate
OFFSET 5 ROWS FETCH NEXT 5 rows only


--TOP WITH TIES

SELECT TOP 10 * FROM 
Production.Product
ORDER BY ListPrice DESC


SELECT TOP 10 WITH TIES *
FROM Production.Product
ORDER BY ListPrice DESC









