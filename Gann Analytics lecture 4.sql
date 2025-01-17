--Example 1

-- Insert

CREATE TABLE #student

(
Student_no INT IDENTITY NOT NULL,
First_name varchar (50) NOT NULL,
Last_name varchar (50) NOT NULL,
Score int 
)


SELECT * FROM #student

INSERT INTO #student

(First_name,Last_name,Score)
VALUES
('Sam','Adam', 30),
('Peter','Adam', 40);

-- IF OBJECT_ID('tempdb..#student') IS NOT NULL DROP Table #student;
--IF OBJECT_ID('tempdb..#student_2') IS NOT NULL DROP Table #student_2

SELECT * FROM #student

--EXAMPLE 2
--INSERT INTO SELECT

INSERT INTO #student
(First_name,Last_name,Score)

SELECT 
  FirstName,
  LastName,
  BusinessEntityID
    FROM [AdventureWorks2019].[Person].[Person]

WHERE BusinessEntityID BETWEEN 30 AND 50


--Example 3
---UPDATE
UPDATE #student
SET Last_name ='Johnson',
	Score = 60
WHERE Student_no = 2

SELECT *
FROM #student
WHERE Student_no =2

--Example 4
--DELETE

DELETE #student
WHERE stUDENT_no = 2


--EXAMPLE 5
--TRUNCATE

TRUNCATE TABLE #student


--EXAMPLE 6
--MERGE

CREATE TABLE #student_2

(
Student_no INT IDENTITY NOT NULL,
First_name varchar (50) NOT NULL,
Last_name varchar (50) NOT NULL,
Score int 
)

INSERT INTO #student_2
(First_name,Last_name,Score)

SELECT 
  FirstName,
  LastName,
  BusinessEntityID + 20
    FROM [AdventureWorks2019].[Person].[Person]

WHERE BusinessEntityID BETWEEN 30 AND 60

SELECT * FROM #student
SELECT * FROM #student_2

TRUNCATE TABLE #student_2


--Exampe6
MERGE #student t 
    USING #student_2 s
ON (s.student_no= t.student_no)
WHEN MATCHED
    THEN UPDATE SET 
        t.Score= s.Score

WHEN NOT MATCHED BY TARGET 
    THEN INSERT (First_name, Last_name, Score)
         VALUES (s.First_name, s.Last_name, s.score)
WHEN NOT MATCHED BY SOURCE 
    THEN DELETE;

	SELECT * FROM #student