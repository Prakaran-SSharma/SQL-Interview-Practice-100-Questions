--------------------------------------------------------------------------------------------------------------------------------------
                                            Real Business Scenarios
--------------------------------------------------------------------------------------------------------------------------------------
76. Create a SQL View for monthly employee reporting.

CREATE VIEW vw_MonthlyEmployeeReport
AS

SELECT

EmployeeID,
EmployeeName,
DepartmentID,
Salary,
HireDate

FROM Employees;
--------------------------------------------------------------------------------------------------------------------------------------

77. Create a Stored Procedure to fetch employees by department.

CREATE PROCEDURE usp_GetEmployeesByDepartment

@DepartmentID INT

AS

BEGIN

SELECT *

FROM Employees

WHERE DepartmentID=@DepartmentID

END;

EXEC usp_GetEmployeesByDepartment 2;
--------------------------------------------------------------------------------------------------------------------------------------

78. Create a Stored Procedure with multiple parameters.

CREATE PROCEDURE usp_GetEmployee

@DepartmentID INT,
@MinSalary DECIMAL(10,2)

AS

BEGIN

SELECT *

FROM Employees

WHERE DepartmentID=@DepartmentID

AND Salary>=@MinSalary

END;

EXEC usp_GetEmployee
@DepartmentID=2,
@MinSalary=50000;
--------------------------------------------------------------------------------------------------------------------------------------

79. Create an Index to optimize salary searches.

CREATE NONCLUSTERED INDEX IX_Salary

ON Employees(Salary);

--------------------------------------------------------------------------------------------------------------------------------------

80. Explain Clustered vs Non-Clustered Index.

--------------------------------------------------------------------------------------------------------------------------------------

81. Find slow-running queries and optimize them.
--------------------------------------------------------------------------------------------------------------------------------------

82. Explain the SQL Query Execution Order.

FROM
JOIN
WHERE
GROUP BY
HAVING
SELECT
DISTINCT
ORDER BY
TOP
--------------------------------------------------------------------------------------------------------------------------------------

83. Difference between WHERE and HAVING with examples.

Theory

Both WHERE and HAVING are used to filter data, but they are applied at different stages of query execution.

WHERE filters individual rows before grouping and aggregation.
HAVING filters grouped data after GROUP BY and aggregation.

Key Differences

WHERE	                                                                 HAVING
Filters rows	                                                       Filters groups
Executed before GROUP BY                      	                       Executed after GROUP BY
Cannot use aggregate functions	                                       Can use aggregate functions
Improves query performance by reducing rows early	                   Used to filter aggregated results

Interview Tip

Use WHERE whenever possible because it filters data earlier and improves performance
--------------------------------------------------------------------------------------------------------------------------------------

84. Difference between UNION and UNION ALL.

Theory

Both combine results from multiple SELECT statements.

UNION removes duplicate rows.
UNION ALL keeps duplicates.

Key Differences
UNION	                                         UNION ALL
Removes duplicates	                             Keeps duplicates
Slower	                                         Faster
Performs sorting to remove duplicates	         No sorting required

Interview Tip

Use UNION ALL whenever duplicate removal is not required because it performs better.
--------------------------------------------------------------------------------------------------------------------------------------

85. Difference between DELETE, TRUNCATE, and DROP.

DELETE
Removes selected rows.
WHERE clause can be used.
Fully logged operation.
Triggers are fired.

DELETE FROM Employees
WHERE DepartmentID = 2;

TRUNCATE
Removes all rows.
Cannot use WHERE.
Faster than DELETE.
Resets identity value.

TRUNCATE TABLE Employees;

DROP
Removes the entire table including structure and data.

DROP TABLE Employees;

Comparison

DELETE	                                          TRUNCATE	                                DROP
Removes rows	                                  Removes all rows	                        Removes entire table
WHERE allowed	                                  WHERE not allowed                         Table removed
Table remains	                                  Table remains	                            Table removed
Slower	                                          Faster	                                Removes object completely
Interview Tip

Use:

DELETE → Remove specific records
TRUNCATE → Empty a table quickly
DROP → Remove the table permanently
--------------------------------------------------------------------------------------------------------------------------------------

86. Difference between CHAR and VARCHAR.

Theory

Both store character data.

CHAR is fixed-length.
VARCHAR is variable-length.

Interview Tip

Use CHAR for values like

Gender
Country Code
Status

Use VARCHAR for

Names
Address
Email
--------------------------------------------------------------------------------------------------------------------------------------

87. Difference between Primary Key and Unique Key.

Primary Key
Uniquely identifies each row.
Cannot contain NULL.
Only one Primary Key per table.

Unique Key
Prevents duplicate values.
Allows one NULL (SQL Server).
Multiple Unique Keys can exist.

--------------------------------------------------------------------------------------------------------------------------------------

88. Difference between Primary Key and Foreign Key.

A Primary Key uniquely identifies a record.

A Foreign Key establishes a relationship between two tables.

--------------------------------------------------------------------------------------------------------------------------------------

89. Difference between CTE and Temporary Table.

Theory

Both store intermediate results.

CTE (Common Table Expression)
Exists only during query execution.
Improves readability.
Cannot be indexed.

Temporary Table
Exists until session ends or dropped.
Can have indexes.
Suitable for large datasets.

--------------------------------------------------------------------------------------------------------------------------------------

90. Difference between View and Stored Procedure.

View

A virtual table based on a SELECT query.

CREATE VIEW vwEmployees
AS
SELECT *
FROM Employees;

Stored Procedure

A precompiled SQL program.

CREATE PROCEDURE usp_GetEmployee

@DepartmentID INT

AS

SELECT *
FROM Employees
WHERE DepartmentID=@DepartmentID;

Execute

EXEC usp_GetEmployee 2;

--------------------------------------------------------------------------------------------------------------------------------------

91. Explain ACID Properties.

Theory

ACID properties ensure database transactions are reliable and consistent.

A — Atomicity

A transaction is treated as a single unit.

Either all operations succeed or none.

Example:

Money transfer

Debit ₹1000

Credit ₹1000

If credit fails, debit is also rolled back.

C — Consistency

A transaction must take the database from one valid state to another.

No invalid data should exist.

I — Isolation

Multiple transactions should not interfere with each other.

Each transaction behaves as if it is running alone.

D — Durability

Once committed, changes remain even if the server crashes.

Data is permanently saved.

Interview Tip

A common interview example is an online banking transaction, which demonstrates all four ACID properties together.

--------------------------------------------------------------------------------------------------------------------------------------

92. Explain SQL Transactions with COMMIT and ROLLBACK.

Theory

A transaction is a group of SQL statements executed as a single unit.

If everything succeeds → COMMIT

If any statement fails → ROLLBACK

Example
BEGIN TRANSACTION;

UPDATE Accounts
SET Balance = Balance - 5000
WHERE AccountID = 101;

UPDATE Accounts
SET Balance = Balance + 5000
WHERE AccountID = 102;

COMMIT;

If an error occurs

BEGIN TRANSACTION;

UPDATE Accounts
SET Balance = Balance - 5000
WHERE AccountID = 101;

ROLLBACK;
Transaction Flow
BEGIN TRANSACTION

↓

Execute SQL Statements

↓

Success?
     │
 ┌──Yes──┐
 │       │
COMMIT  No
         │
     ROLLBACK
Interview Tip

A classic use case is bank fund transfers:

Debit Account A
Credit Account B

If the second step fails, the first must also be undone using ROLLBACK to maintain data consistency.
--------------------------------------------------------------------------------------------------------------------------------------

93. Find employees working under the same manager.

SELECT
    ManagerID,
    COUNT(*) AS TotalEmployees
FROM Employees
GROUP BY ManagerID
HAVING COUNT(*) > 1;
----
SELECT
    ManagerID,
    EmployeeName,
    DepartmentID
FROM Employees
WHERE ManagerID IN
(
    SELECT ManagerID
    FROM Employees
    GROUP BY ManagerID
    HAVING COUNT(*) > 1
)
ORDER BY ManagerID;

--------------------------------------------------------------------------------------------------------------------------------------

94. Find the manager hierarchy using a Recursive CTE.

WITH EmployeeHierarchy AS
(
    -- Top-level manager
    SELECT
        EmployeeID,
        EmployeeName,
        ManagerID,
        1 AS Level
    FROM Employees
    WHERE ManagerID IS NULL

    UNION ALL

    -- Employees reporting to managers
    SELECT
        E.EmployeeID,
        E.EmployeeName,
        E.ManagerID,
        EH.Level + 1
    FROM Employees E
    INNER JOIN EmployeeHierarchy EH
        ON E.ManagerID = EH.EmployeeID
)

SELECT *
FROM EmployeeHierarchy
ORDER BY Level, EmployeeID;

--------------------------------------------------------------------------------------------------------------------------------------

95. Write a query to find inactive employees (no recent activity).

SELECT
    E.EmployeeID,
    E.EmployeeName
FROM Employees E

LEFT JOIN EmployeeActivity A
ON E.EmployeeID=A.EmployeeID

GROUP BY
E.EmployeeID,
E.EmployeeName

HAVING
MAX(ActivityDate) < DATEADD(DAY,-90,GETDATE())

OR

MAX(ActivityDate) IS NULL;


--------------------------------------------------------------------------------------------------------------------------------------

96. Find monthly hiring trends.

SELECT

YEAR(HireDate) AS Year,

MONTH(HireDate) AS Month,

COUNT(*) AS TotalHiring

FROM Employees

GROUP BY

YEAR(HireDate),
MONTH(HireDate)

ORDER BY

Year,
Month;
--------

SELECT

FORMAT(HireDate,'MMM-yyyy') AS HiringMonth,

COUNT(*) AS TotalHiring

FROM Employees

GROUP BY

FORMAT(HireDate,'MMM-yyyy')

ORDER BY

MIN(HireDate);

--------------------------------------------------------------------------------------------------------------------------------------

97. Build a recruiter performance summary using SQL.

SELECT

RecruiterID,

COUNT(CandidateID) AS TotalSubmissions,

SUM(CASE
WHEN Status='Joined'
THEN 1
ELSE 0
END) AS TotalJoinees,

SUM(Billing) AS TotalRevenue

FROM Recruitment

GROUP BY RecruiterID

ORDER BY TotalRevenue DESC;
--------------------------------------------------------------------------------------------------------------------------------------

98. Build a department-wise KPI report using SQL.

SELECT

DepartmentID,

COUNT(EmployeeID) AS TotalEmployees,

AVG(Salary) AS AverageSalary,

SUM(Salary) AS TotalSalary,

MAX(Salary) AS HighestSalary,

MIN(Salary) AS LowestSalary

FROM Employees

GROUP BY DepartmentID;

--------------------------------------------------------------------------------------------------------------------------------------

99. Build a recruitment funnel report (Applied → Interview → Offer → Hire).

SELECT

Stage,

COUNT(*) AS CandidateCount

FROM Recruitment

GROUP BY Stage

ORDER BY

CASE Stage

WHEN 'Applied' THEN 1

WHEN 'Screening' THEN 2

WHEN 'Interview' THEN 3

WHEN 'Offer' THEN 4

WHEN 'Hire' THEN 5

END;

----------------
SELECT

ROUND(

100.0 *

SUM(CASE WHEN Stage='Hire' THEN 1 ELSE 0 END)

/

SUM(CASE WHEN Stage='Applied' THEN 1 ELSE 0 END)

,2)

AS ConversionRate;

--------------------------------------------------------------------------------------------------------------------------------------
100. Design an end-to-end SQL reporting solution for a Power BI dashboard.

Step 1: Understand the Business Requirement

Example:

HR wants a dashboard to track recruiter performance, hiring funnel, billing, revenue, and recruiter incentives.

Step 2: Identify Data Sources
Recruitment Table
Candidate Table
Billing Table
Vendor Table
Employee Table

Step 3: Create SQL Views

Example:

CREATE VIEW vw_RecruitmentSummary
AS

SELECT

R.RecruiterID,

COUNT(R.CandidateID) AS TotalCandidates,

SUM(B.BillingAmount) AS Revenue,

COUNT(CASE
WHEN R.Status='Joined'
THEN 1
END) AS TotalJoining

FROM Recruitment R

LEFT JOIN Billing B

ON R.CandidateID=B.CandidateID

GROUP BY R.RecruiterID;

Step 4: 

Optimize SQL
Create Non-Clustered Indexes
Remove unnecessary columns
Use SQL Views
Optimize JOINs
Use CTEs where appropriate

Step 5: Load into Power BI
Import SQL Views
Create Star Schema
Create Relationships
Build DAX Measures
Build KPIs
Create Visuals

Step 6: Business KPIs
Total Joining
Revenue
Recruiter Ranking
Offer Acceptance %
Time to Hire
Vendor Performance
Client-wise Hiring
Monthly Trend
Incentive Calculation

Step 7: Business Impact
Reduced manual reporting
Faster dashboard refresh
Better data quality
Real-time reporting
Improved decision-making


--------------------------------------------------------------------------------------------------------------------------------------
