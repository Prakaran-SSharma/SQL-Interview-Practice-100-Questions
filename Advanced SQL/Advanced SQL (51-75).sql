--------------------------------------------------------------------------------------------------------------------------------------
                                                      Advanced SQL
--------------------------------------------------------------------------------------------------------------------------------------
51. Find the second highest salary using DENSE_RANK().

SELECT EmployeeName, Salary
FROM
(
    SELECT *,
           DENSE_RANK() OVER(ORDER BY Salary DESC) AS SalaryRank
    FROM Employees
) A
WHERE SalaryRank = 2;
--------------------------------------------------------------------------------------------------------------------------------------
52. Find the third highest salary using ROW_NUMBER().

SELECT EmployeeName, Salary
FROM
(
    SELECT *,
           ROW_NUMBER() OVER(ORDER BY Salary DESC) AS RN
    FROM Employees
) A
WHERE RN = 3;

--------------------------------------------------------------------------------------------------------------------------------------
53. Find employees earning more than the department average salary.

SELECT EmployeeName,
       Salary,
       DepartmentID
FROM Employees E
WHERE Salary >
(
    SELECT AVG(Salary)
    FROM Employees
    WHERE DepartmentID = E.DepartmentID
);

--------------------------------------------------------------------------------------------------------------------------------------
54. Find the highest-paid employee in each department.

WITH CTE AS
(
    SELECT *,
           DENSE_RANK() OVER
           (
               PARTITION BY DepartmentID
               ORDER BY Salary DESC
           ) AS RN
    FROM Employees
)

SELECT *
FROM CTE
WHERE RN = 1;


--------------------------------------------------------------------------------------------------------------------------------------
55. Find the lowest-paid employee in each department.

WITH CTE AS
(
    SELECT *,
           DENSE_RANK() OVER
           (
               PARTITION BY DepartmentID
               ORDER BY Salary
           ) AS RN
    FROM Employees
)

SELECT *
FROM CTE
WHERE RN = 1;

--------------------------------------------------------------------------------------------------------------------------------------
56. Find the top 3 highest-paid employees in each department.

WITH CTE AS
(
    SELECT *,
           DENSE_RANK() OVER
           (
               PARTITION BY DepartmentID
               ORDER BY Salary DESC
           ) AS RN
    FROM Employees
)

SELECT *
FROM CTE
WHERE RN <= 3;

--------------------------------------------------------------------------------------------------------------------------------------
57. Calculate the running total of salaries ordered by EmployeeID.

SELECT
EmployeeID,
EmployeeName,
Salary,

SUM(Salary) OVER
(
ORDER BY EmployeeID
) AS RunningTotal

FROM Employees;

--------------------------------------------------------------------------------------------------------------------------------------
58. Calculate the cumulative count of employees hired over time.

SELECT

EmployeeID,
EmployeeName,
HireDate,

COUNT(*) OVER
(
ORDER BY HireDate
) AS EmployeeCount

FROM Employees;
--------------------------------------------------------------------------------------------------------------------------------------
59. Find the percentage contribution of each employees salary to the total salary.

SELECT

EmployeeName,
Salary,

ROUND
(
Salary * 100.0 /
SUM(Salary) OVER(),
2
) AS SalaryPercentage

FROM Employees;

--------------------------------------------------------------------------------------------------------------------------------------
60. Find the difference between an employee's salary and the previous employee's salary using LAG().

SELECT

EmployeeName,
Salary,

LAG(Salary)
OVER
(
ORDER BY Salary
) AS PreviousSalary,

Salary -
LAG(Salary)
OVER
(
ORDER BY Salary
) AS Difference

FROM Employees;

--------------------------------------------------------------------------------------------------------------------------------------
61. Find the difference between an employee's salary and the next employee's salary using LEAD().

SELECT
    EmployeeID,
    EmployeeName,
    Salary,
    LEAD(Salary) OVER(ORDER BY Salary) AS NextSalary,
    LEAD(Salary) OVER(ORDER BY Salary) - Salary AS Difference
FROM Employees;

--------------------------------------------------------------------------------------------------------------------------------------
62. Find employees whose salary is higher than the previous employee.

SELECT *
FROM
(
    SELECT *,
           LAG(Salary) OVER(ORDER BY EmployeeID) AS PreviousSalary
    FROM Employees
) A
WHERE Salary > PreviousSalary;

--------------------------------------------------------------------------------------------------------------------------------------
63. Rank employees by salary within each department.

SELECT
    EmployeeID,
    EmployeeName,
    DepartmentID,
    Salary,

    RANK() OVER
    (
        PARTITION BY DepartmentID
        ORDER BY Salary DESC
    ) AS SalaryRank

FROM Employees;

--------------------------------------------------------------------------------------------------------------------------------------
64. Find duplicate employee names.

SELECT
    EmployeeName,
    COUNT(*) AS TotalCount
FROM Employees
GROUP BY EmployeeName
HAVING COUNT(*) > 1;

--------------------------------------------------------------------------------------------------------------------------------------
65. Delete duplicate employee records while keeping one copy.

WITH CTE AS
(
    SELECT *,
           ROW_NUMBER() OVER
           (
               PARTITION BY EmployeeName
               ORDER BY EmployeeID
           ) AS RN
    FROM Employees
)

DELETE FROM CTE
WHERE RN > 1;
--------------------------------------------------------------------------------------------------------------------------------------
66. Find employees hired in the last 6 months.

SELECT *
FROM Employees
WHERE HireDate >= DATEADD(MONTH,-6,GETDATE());

--------------------------------------------------------------------------------------------------------------------------------------
67. Find employees hired between two dates.

SELECT *
FROM Employees
WHERE HireDate BETWEEN '2024-01-01'
                  AND '2024-12-31';

--------------------------------------------------------------------------------------------------------------------------------------
68. Find employees hired on weekends.

SELECT *
FROM Employees
WHERE DATENAME(WEEKDAY,HireDate)
IN ('Saturday','Sunday');

SELECT *
FROM Employees
WHERE DATEPART(WEEKDAY,HireDate)
IN (1,7);

--------------------------------------------------------------------------------------------------------------------------------------
69. Find employees hired in the current financial year.

SELECT *
FROM Employees
WHERE HireDate >=
CASE
WHEN MONTH(GETDATE())>=4
THEN DATEFROMPARTS(YEAR(GETDATE()),4,1)

ELSE DATEFROMPARTS(YEAR(GETDATE())-1,4,1)
END;

--------------------------------------------------------------------------------------------------------------------------------------
70. Pivot department-wise employee count.

SELECT *
FROM
(
SELECT
DepartmentID,
EmployeeID
FROM Employees
) A

PIVOT
(
COUNT(EmployeeID)
FOR DepartmentID IN
(
[1],[2],[3],[4]
)
) P;

--------------------------------------------------------------------------------------------------------------------------------------
71. Unpivot department-wise data.

SELECT Department, EmployeeCount
FROM
(
    SELECT HR, IT, Finance
    FROM DepartmentSummary
) AS SourceTable

UNPIVOT
(
    EmployeeCount
    FOR Department IN (HR, IT, Finance)
) AS UnpivotTable;

--------------------------------------------------------------------------------------------------------------------------------------
72. Generate row numbers without using ROW_NUMBER().

SELECT
    A.EmployeeID,
    A.EmployeeName,

(
SELECT COUNT(*)
FROM Employees B
WHERE B.EmployeeID <= A.EmployeeID
) AS RowNum

FROM Employees A
ORDER BY EmployeeID;

--------------------------------------------------------------------------------------------------------------------------------------
73. Find missing Employee IDs.

WITH Numbers AS
(
SELECT 1 AS Num

UNION ALL

SELECT Num+1
FROM Numbers
WHERE Num <
(
SELECT MAX(EmployeeID)
FROM Employees
)
)

SELECT Num AS MissingID
FROM Numbers

WHERE Num NOT IN
(
SELECT EmployeeID
FROM Employees
)

OPTION(MAXRECURSION 1000);

--------------------------------------------------------------------------------------------------------------------------------------
74. Generate numbers from 1 to 100 using a Recursive CTE.

WITH Numbers AS
(
SELECT 1 AS Num

UNION ALL

SELECT Num+1

FROM Numbers

WHERE Num<100
)

SELECT *
FROM Numbers

OPTION(MAXRECURSION 100);

--------------------------------------------------------------------------------------------------------------------------------------
75. Find gaps between consecutive Employee IDs.

SELECT

EmployeeID,

LEAD(EmployeeID)
OVER
(
ORDER BY EmployeeID
) AS NextID

FROM Employees;
--------
WITH CTE AS
(
SELECT

EmployeeID,

LEAD(EmployeeID)
OVER
(
ORDER BY EmployeeID
) AS NextID

FROM Employees
)

SELECT *

FROM CTE

WHERE NextID-EmployeeID>1;

--------------------------------------------------------------------------------------------------------------------------------------