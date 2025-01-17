--window function

--example 1

--1.1
SELECT TOP 10 *
FROM Sales.SalesOrderHeader

--1.2
SELECT SUM(SubTotal) AS Totalorder
FROM Sales.SalesOrderHeader

--1.3
SELECT CustomerID,
SalesPersonID,
SUM(SubTotal) AS Totalorder
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL
GROUP BY CustomerID, SalesPersonID
ORDER BY CustomerID


--1.4
SELECT SalesOrderID,
		OrderDate,
		CustomerID,
		SubTotal,
		SUM(SubTotal) OVER()AS TotalorderforAllCustomer
FROM Sales.SalesOrderHeader

--1.5
SELECT SalesOrderID,
OrderDate,
		CustomerID,
		SubTotal,
		SUM(SubTotal) OVER(PARTITION BY CUSTOMERID)AS TotalorderPerCustomer
FROM Sales.SalesOrderHeader
ORDER BY CustomerID

--1.6
SELECT SalesOrderID,
		OrderDate,
		CustomerID,
		SubTotal,
		SUM(SubTotal) OVER()AS TotalorderforAllCustomer,
		SUM(SubTotal) OVER(PARTITION BY CUSTOMERID) AS TotalorderPerCustomer,
		AVG(SubTotal) OVER()AS AVGorderforAllCustomer, 
		AVG(SubTotal) OVER(PARTITION BY CUSTOMERID) AS AVGorderPerCustomer
	FROM Sales.SalesOrderHeader
ORDER BY CustomerID

--1.7
SELECT SalesOrderID,
		OrderDate,
		CustomerID,
		SubTotal,
		100 * (SubTotal/SUM(SubTotal) OVER(PARTITION BY CUSTOMERID))AS PctPerCus,
		100 * (SubTotal/SUM(SubTotal) OVER())AS PctAllCus
FROM Sales.SalesOrderHeader
ORDER BY CustomerID


-- RANKING WINDOW FUNCTION

--2.1
	 SELECT 
     ROW_NUMBER()OVER(ORDER BY HIREDATE ASC) RankingbyDatejoined
      ,[LoginID]
      ,[OrganizationNode]
      ,[OrganizationLevel]
      ,[JobTitle]
      ,[BirthDate]
      ,[MaritalStatus]
      ,[Gender]
      ,[HireDate]
      ,[SickLeaveHours]
      ,[CurrentFlag]
      
  FROM [AdventureWorks2019].[HumanResources].[Employee]
  order by HireDate

  --2.2
	   SELECT 
       ROW_NUMBER()OVER( partition by JobTitle ORDER BY HIREDATE ASC) RAnkingbyDateJoinedandDept
      ,[LoginID]
      ,[OrganizationNode]
      ,[OrganizationLevel]
      ,[JobTitle]
      ,[BirthDate]
      ,[MaritalStatus]
      ,[Gender]
      ,[HireDate]
      ,[SickLeaveHours]
      ,[CurrentFlag]
      FROM [AdventureWorks2019].[HumanResources].[Employee]
	  ORDER BY JobTitle

	--2.3
	SELECT 
    ROW_NUMBER()OVER(ORDER BY HIREDATE ASC) RankingbyDatejoined
	,RANK()OVER(ORDER BY HIREDATE ASC) Ranking_not_Rownumber
      ,[LoginID]
      ,[OrganizationNode]
      ,[OrganizationLevel]
      ,[JobTitle]
      ,[BirthDate]
      ,[MaritalStatus]
      ,[Gender]
      ,[HireDate]
      ,[SickLeaveHours]
      ,[CurrentFlag]
      FROM [AdventureWorks2019].[HumanResources].[Employee]
	  order by HireDate


	  	  	SELECT 
    ROW_NUMBER()OVER(ORDER BY HIREDATE ASC) RankingbyDatejoined
	,RANK()OVER(ORDER BY HIREDATE ASC) Ranking_not_Rownumber
	,DENSE_RANK()OVER(ORDER BY HIREDATE ASC) DenseRanking_not_Rownumber
      ,[LoginID]
      ,[OrganizationNode]
      ,[OrganizationLevel]
      ,[JobTitle]
      ,[BirthDate]
      ,[MaritalStatus]
      ,[Gender]
      ,[HireDate]
      ,[SickLeaveHours]
      ,[CurrentFlag]
      FROM [AdventureWorks2019].[HumanResources].[Employee]
	  order by HireDate