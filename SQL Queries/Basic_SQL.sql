------------------------------------------------------------------------------------------------------------------------------------
📘 Section 1: Basic SQL (1–25)
------------------------------------------------------------------------------------------------------------------------------------
1. Display all records from the Employees table.
2. Display only Employee ID, Employee Name, and Salary.
3. Display all unique cities where employees are located.
4. Display the top 5 highest-paid employees.
5. Display all employees sorted by salary in descending order.
6. Display all employees whose salary is greater than ₹60,000.
7. Display employees who belong to the IT department.
8. Display employees hired after January 1, 2020.
9. Display employees whose salary is between ₹50,000 and ₹80,000.
10. Display employees who work in either Delhi or Noida.
11. Display employees whose names start with the letter 'A'.
12. Display employees whose names end with the letter 'a'.
13. Display employees whose names contain the substring 'an'.
14. Count the total number of employees in the company.
15. Calculate the total salary paid to all employees.
16. Find the average salary of all employees.
17. Find the highest salary in the company.
18. Find the lowest salary in the company.
19. Display the total number of employees in each department.
20. Display the average salary of employees in each department.
21. Display the total salary paid in each department.
22. Display departments where the average salary is greater than ₹70,000.
23. Display departments having more than two employees.
24. Create a salary category using CASE WHEN:
                                                              High Salary (≥ ₹100,000)
                                                              Medium Salary (₹70,000–₹99,999)
                                                              Low Salary (< ₹70,000)
25. Categorize employees based on experience using CASE WHEN:
                                                              Beginner (< 2 years)
                                                              Intermediate (2–5 years)
                                                              Experienced (> 5 years)

------------------------------------------------------------------------------------------------------------------------------------
# Question 01: Select All Employees
------------------------------------------------------------------------------------------------------------------------------------

## Problem Statement
Display all employee records from the Employees table.

## SQL Query
```sql
SELECT *
FROM Employees;
------------------------------------------------------------------------------------------------------------------------------------
## Problem Statement
Q2. Display only Employee Name and Salary.
## SQL Query
```sql
SELECT EmployeeName, Salary
FROM Employees;
------------------------------------------------------------------------------------------------------------------------------------

## Problem Statement
## SQL Query
```sql
Q3. Display unique cities.
SELECT DISTINCT City
FROM Employees;
------------------------------------------------------------------------------------------------------------------------------------

## Problem Statement
Q4. Display top 5 highest-paid employees.
SELECT TOP 5 *
FROM Employees
ORDER BY Salary DESC;
------------------------------------------------------------------------------------------------------------------------------------

## Problem Statement
Q5. Display employees sorted by Hire Date.
SELECT *
FROM Employees
ORDER BY HireDate;
------------------------------------------------------------------------------------------------------------------------------------
Section 2: WHERE Clause
------------------------------------------------------------------------------------------------------------------------------------

## Problem Statement
Q6. Employees earning more than ₹60,000.
SELECT *
FROM Employees
WHERE Salary > 60000;
------------------------------------------------------------------------------------------------------------------------------------

## Problem Statement
Q7. Employees working in Delhi.
SELECT *
FROM Employees
WHERE City = 'Delhi';
------------------------------------------------------------------------------------------------------------------------------------

## Problem Statement
Q8. Employees hired after 2020.
SELECT *
FROM Employees
WHERE HireDate > '2020-12-31';
------------------------------------------------------------------------------------------------------------------------------------

## Problem Statement
Q9. Employees whose salary is between ₹50,000 and ₹80,000.
SELECT *
FROM Employees
WHERE Salary BETWEEN 50000 AND 80000;
------------------------------------------------------------------------------------------------------------------------------------

## Problem Statement
Q10. Employees working in Delhi or Noida.
SELECT *
FROM Employees
WHERE City IN ('Delhi','Noida');
------------------------------------------------------------------------------------------------------------------------------------
Section 3: LIKE Operator
------------------------------------------------------------------------------------------------------------------------------------

## Problem Statement
Q11. Employees whose names start with 'A'.
SELECT *
FROM Employees
WHERE EmployeeName LIKE 'A%';
------------------------------------------------------------------------------------------------------------------------------------

## Problem Statement
Q12. Employees whose names end with 'a'.
SELECT *
FROM Employees
WHERE EmployeeName LIKE '%a';
------------------------------------------------------------------------------------------------------------------------------------

## Problem Statement
Q13. Employees whose names contain 'an'.
SELECT *
FROM Employees
WHERE EmployeeName LIKE '%an%';
------------------------------------------------------------------------------------------------------------------------------------
Section 4: Aggregate Functions
------------------------------------------------------------------------------------------------------------------------------------

## Problem Statement
Q14. Total number of employees.
SELECT COUNT(*) AS TotalEmployees
FROM Employees;
------------------------------------------------------------------------------------------------------------------------------------

## Problem Statement
Q15. Total salary paid.
SELECT SUM(Salary) AS TotalSalary
FROM Employees;
------------------------------------------------------------------------------------------------------------------------------------

## Problem Statement
Q16. Average salary.
SELECT AVG(Salary) AS AverageSalary
FROM Employees;
------------------------------------------------------------------------------------------------------------------------------------

## Problem Statement
Q17. Highest salary.
SELECT MAX(Salary) AS HighestSalary
FROM Employees;
------------------------------------------------------------------------------------------------------------------------------------

## Problem Statement
Q18. Lowest salary.
SELECT MIN(Salary) AS LowestSalary
FROM Employees;

------------------------------------------------------------------------------------------------------------------------------------
Section 5: GROUP BY
------------------------------------------------------------------------------------------------------------------------------------

## Problem Statement
Q19. Employee count by department.
SELECT
DepartmentID,
COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentID;
------------------------------------------------------------------------------------------------------------------------------------

## Problem Statement
Q20. Average salary by department.
SELECT
DepartmentID,
AVG(Salary) AS AverageSalary
FROM Employees
GROUP BY DepartmentID;
------------------------------------------------------------------------------------------------------------------------------------

## Problem Statement
Q21. Total salary by department.
SELECT
DepartmentID,
SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY DepartmentID;
------------------------------------------------------------------------------------------------------------------------------------
Section 6: HAVING
------------------------------------------------------------------------------------------------------------------------------------

## Problem Statement
Q22. Departments where average salary is greater than ₹70,000.
SELECT
DepartmentID,
AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentID
HAVING AVG(Salary) > 70000;
------------------------------------------------------------------------------------------------------------------------------------

## Problem Statement
Q23. Departments having more than 2 employees.
SELECT
DepartmentID,
COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentID
HAVING COUNT(*) > 2;
------------------------------------------------------------------------------------------------------------------------------------
Section 7: CASE WHEN
------------------------------------------------------------------------------------------------------------------------------------

## Problem Statement
Q24. Categorize employees based on salary.
SELECT
EmployeeName,
Salary,
CASE
    WHEN Salary >= 100000 THEN 'High'
    WHEN Salary >= 70000 THEN 'Medium'
    ELSE 'Low'
END AS SalaryCategory
FROM Employees;
------------------------------------------------------------------------------------------------------------------------------------

## Problem Statement
Q25. Categorize employees based on experience.
SELECT
EmployeeName,
HireDate,
CASE
    WHEN DATEDIFF(YEAR, HireDate, GETDATE()) >= 5 THEN 'Experienced'
    WHEN DATEDIFF(YEAR, HireDate, GETDATE()) >= 2 THEN 'Intermediate'
    ELSE 'Beginner'
END AS ExperienceLevel
FROM Employees;
------------------------------------------------------------------------------------------------------------------------------------
