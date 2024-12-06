/* Examples for lecture 2
*/


--Example 1 Inner join
--add the shipping method

SELECT 
a.SalesOrderID,
a.SalesOrderNumber,
a.PurchaseOrderNumber,
a.CustomerID,
a.SalesPersonID,
b.Name as [shipping method]
  FROM SaleS.SalesOrderHeader AS a
  INNER JOIN Purchasing.ShipMethod as b
  on a.ShipMethodID = b.ShipMethodID


  --Example 2 Left join
  -- you want to add the acct details of cutomers that have placed orders

   SELECT 
   a.SalesOrderID,
   a.OrderDate,
   a.PurchaseOrderNumber,
   a.TotalDue,
   b.AccountNumber,
   b.StoreID
  FROM Sales.SalesOrderHeader as a
  LEFT OUTER JOIN Sales.Customer b
    ON a.CustomerID = b.CustomerID
	

-- Example 3 Right Join
  
  SELECT 
  a.SalesOrderID,
  a.OrderDate,
  a.PurchaseOrderNumber,
  a.TotalDue,
  b.AccountNumber,
  b.StoreID
  FROM Sales.SalesOrderHeader AS a
  RIGHT OUTER JOIN Sales.Customer AS b
  ON a.CustomerID = b.CustomerID
WHERE a.CustomerID is null

 
 --MULTILEVEL JOIN
 
 --Example 4
-- add the names of customers

 SELECT 
a.SalesOrderID,
a.SalesOrderNumber,
a.PurchaseOrderNumber,
a.CustomerID,
a.SalesPersonID,
a.TotalDue,
c.FirstName + ' ' + c.LastName as Name
FROM Sales.SalesOrderHeader as a
LEFT JOIN Sales.Customer AS b
ON a.CustomerID = b.CustomerID
LEFT JOIN Person.Person AS c
ON b.PersonID = c.BusinessEntityID
ORDER BY a.SalesOrderID



--Example 5 Explain when to use outer or inner join depending on what you want
--add the category and names to the product we have in the company


  SELECT
a.ProductID,
a.Name AS [Product name],
a.ProductNumber,
a.ReorderPoint,
a.ListPrice,
b.Name AS Subcategory,
c.Name AS Category,
A.ListPrice
FROM
Production.product AS a
LEFT JOIN production.ProductSubcategory as b
on a.ProductSubcategoryID = b.ProductSubcategoryID
JOIN Production.ProductCategory AS c
on b.ProductCategoryID =c.ProductCategoryID
-- WHERE c.Name is null




--Example 6
--Find the total quantity of unique products that have been ordered

  SELECT
  a.ProductID,
  b.Name,
  SUM(a.OrderQty) AS [Total Ordered]
FROM Sales.SalesOrderDetail AS a
LEFT JOIN Production.Product AS b
ON a.ProductID = b.ProductID
GROUP BY a.ProductID,b.Name
ORDER BY  SUM(a.OrderQty) DESC

  

  --Example 7
--Products that have not been ordered
    SELECT
  --a.ProductID as [OrderProductID] ,
  b.ProductID,
  b.Name
FROM Sales.SalesOrderDetail AS a
RIGHT JOIN Production.Product AS b
ON a.ProductID = b.ProductID
WHERE a.ProductID IS NULL




--SUBQUERIES




--Example 8
-- YOU WANT TO KNOW ALL THE ORDERS THAT WERE PLACED ON THE LAST ORDER DATE
  

  SELECT 
  SalesOrderID,
  ShipMethodID,
  TotalDue
  FROM Sales.SalesOrderHeader
  WHERE OrderDate = (
  SELECT MAX(OrderDate)
  FROM [AdventureWorks2019].[Sales].[SalesOrderHeader]
  )




--Example 9

SELECT * 
FROM Sales.SalesOrderHeader
WHERE CustomerID IN
(SELECT DISTINCT CustomerID
FROM Sales.SalesOrderHeader WHERE CustomerID BETWEEN 11000 AND 11006)




--Example 10

/*
1) 

SELECT
    order_id,
    order_date,
    (
        SELECT
            MAX (list_price)
        FROM
            sales.order_items i
        WHERE
            i.order_id = o.order_id
    ) AS max_list_price
FROM
    sales.orders o
order by order_date desc;

2)


SELECT 
   AVG(order_count) average_order_count_by_staff
FROM
(
    SELECT 
	staff_id, 
        COUNT(order_id) order_count
    FROM 
	sales.orders
    GROUP BY 
	staff_id
) t;
*/