------------------------------------------------------------------------------------------------------------------------------
Intermediate SQL (Questions 26–50)
------------------------------------------------------------------------------------------------------------------------------
🔹 INNER JOIN
26. Display employee names along with their department names.
27. Display recruiter names along with the clients they have worked for.
28. Display candidate names, recruiter names, and application status.
29. Display employees along with their managers using a Self Join.
30. Display all recruiters and the number of candidates they have recruited.
🔹 LEFT JOIN
31. Display all recruiters, including those who have not submitted any candidates.
32. Display all clients and the candidates submitted to them.
33. Display all departments and their employees, including departments with no employees.
🔹 RIGHT JOIN
34. Display all applications and recruiter details, even if recruiter information is missing.
35. Display all clients even if they have no applications.
🔹 FULL OUTER JOIN
36. Display all recruiters and applications, including unmatched records from both tables.
🔹 CROSS JOIN
37. Generate every possible combination of recruiters and clients.
🔹 SELF JOIN
38. Display each employee along with their managers name.
39. Display employees working under the same manager.
🔹 UNION
40. Display all employee names and candidate names in a single list using UNION.
41. Display all cities from Employees and Candidates without duplicates.
🔹 UNION ALL
42. Display all cities from Employees and Candidates including duplicates.
🔹 SUBQUERIES
43. Display employees earning more than the average salary.
44. Display employees who earn the highest salary in their department.
45. Display recruiters who have placed more candidates than the average recruiter.
46. Display clients with the highest number of successful placements.
🔹 EXISTS
47. Display recruiters who have at least one successful placement using EXISTS.
48. Display clients that have received at least one application.
🔹 NOT EXISTS
49. Display recruiters who have never submitted any candidates.
🔹 ANY / ALL
50. Display employees whose salary is greater than ALL employees in the HR department.
------------------------------------------------------------------------------------------------------------------------------
Intermediate SQL (Questions 26–50)
------------------------------------------------------------------------------------------------------------------------------
🔹 INNER JOIN

26. Display employee names along with their department names.
SELECT
    e.EmployeeName,
    d.DepartmentName
FROM Employees e
INNER JOIN Departments d
ON e.DepartmentID = d.DepartmentID;
------------------------------------------------------------------------------------------------------------------------------

27. Display recruiter names along with the clients they have worked for.
SELECT
    r.RecruiterName,
    c.ClientName
FROM Applications a
INNER JOIN Recruiters r
ON a.RecruiterID = r.RecruiterID
INNER JOIN Clients c
ON a.ClientID = c.ClientID;
------------------------------------------------------------------------------------------------------------------------------

28. Display candidate names, recruiter names, and application status.
SELECT
    c.CandidateName,
    r.RecruiterName,
    a.Status
FROM Applications a
INNER JOIN Candidates c
ON a.CandidateID = c.CandidateID
INNER JOIN Recruiters r
ON a.RecruiterID = r.RecruiterID;
------------------------------------------------------------------------------------------------------------------------------

29. Display employees along with their managers using a Self Join.
SELECT
    e.EmployeeName AS Employee,
    m.EmployeeName AS Manager
FROM Employees e
LEFT JOIN Employees m
ON e.ManagerID = m.EmployeeID;
------------------------------------------------------------------------------------------------------------------------------

30. Display all recruiters and the number of candidates they have recruited.
SELECT
    r.RecruiterName,
    COUNT(a.CandidateID) AS TotalCandidates
FROM Recruiters r
LEFT JOIN Applications a
ON r.RecruiterID = a.RecruiterID
GROUP BY r.RecruiterName;
------------------------------------------------------------------------------------------------------------------------------
🔹 LEFT JOIN
------------------------------------------------------------------------------------------------------------------------------

31. Display all recruiters, including those who have not submitted any candidates.
SELECT
    r.RecruiterName,
    a.ApplicationID
FROM Recruiters r
LEFT JOIN Applications a
ON r.RecruiterID = a.RecruiterID;
------------------------------------------------------------------------------------------------------------------------------

32. Display all clients and the candidates submitted to them.
SELECT
    cl.ClientName,
    c.CandidateName
FROM Clients cl
LEFT JOIN Applications a
ON cl.ClientID = a.ClientID
LEFT JOIN Candidates c
ON a.CandidateID = c.CandidateID;
------------------------------------------------------------------------------------------------------------------------------

33. Display all departments and their employees, including departments with no employees.
SELECT
    d.DepartmentName,
    e.EmployeeName
FROM Departments d
LEFT JOIN Employees e
ON d.DepartmentID = e.DepartmentID;
------------------------------------------------------------------------------------------------------------------------------
🔹 RIGHT JOIN
------------------------------------------------------------------------------------------------------------------------------

34. Display all applications and recruiter details, even if recruiter information is missing.
SELECT
    a.ApplicationID,
    r.RecruiterName
FROM Recruiters r
RIGHT JOIN Applications a
ON r.RecruiterID = a.RecruiterID;
------------------------------------------------------------------------------------------------------------------------------

35. Display all clients even if they have no applications.
SELECT
    c.ClientName,
    a.ApplicationID
FROM Applications a
RIGHT JOIN Clients c
ON a.ClientID = c.ClientID;

------------------------------------------------------------------------------------------------------------------------------
🔹 FULL OUTER JOIN
------------------------------------------------------------------------------------------------------------------------------

36. Display all recruiters and applications, including unmatched records from both tables.
SELECT
    r.RecruiterName,
    a.ApplicationID
FROM Recruiters r
FULL OUTER JOIN Applications a
ON r.RecruiterID = a.RecruiterID;

------------------------------------------------------------------------------------------------------------------------------
🔹 CROSS JOIN

37. Generate every possible combination of recruiters and clients.
SELECT
    r.RecruiterName,
    c.ClientName
FROM Recruiters r
CROSS JOIN Clients c;

------------------------------------------------------------------------------------------------------------------------------
🔹 SELF JOIN
------------------------------------------------------------------------------------------------------------------------------

38. Display each employee along with their managers name.
SELECT
    e.EmployeeName,
    m.EmployeeName AS Manager
FROM Employees e
LEFT JOIN Employees m
ON e.ManagerID = m.EmployeeID;
------------------------------------------------------------------------------------------------------------------------------

39. Display employees working under the same manager.
SELECT
    e1.EmployeeName,
    e2.EmployeeName,
    e1.ManagerID
FROM Employees e1
INNER JOIN Employees e2
ON e1.ManagerID = e2.ManagerID
AND e1.EmployeeID <> e2.EmployeeID;

------------------------------------------------------------------------------------------------------------------------------
🔹 UNION
------------------------------------------------------------------------------------------------------------------------------

40. Display all employee names and candidate names in a single list using UNION.
SELECT EmployeeName AS Name
FROM Employees

UNION

SELECT CandidateName
FROM Candidates;
------------------------------------------------------------------------------------------------------------------------------

41. Display all cities from Employees and Candidates without duplicates.
SELECT City
FROM Employees

UNION

SELECT City
FROM Candidates;

------------------------------------------------------------------------------------------------------------------------------
🔹 UNION ALL
------------------------------------------------------------------------------------------------------------------------------

42. Display all cities from Employees and Candidates including duplicates.
SELECT City
FROM Employees

UNION ALL

SELECT City
FROM Candidates;

------------------------------------------------------------------------------------------------------------------------------
🔹 SUBQUERIES
------------------------------------------------------------------------------------------------------------------------------

43. Display employees earning more than the average salary.
SELECT *
FROM Employees
WHERE Salary >
(
SELECT AVG(Salary)
FROM Employees
);
------------------------------------------------------------------------------------------------------------------------------

44. Display employees who earn the highest salary in their department.
SELECT *
FROM Employees e
WHERE Salary =
(
SELECT MAX(Salary)
FROM Employees
WHERE DepartmentID = e.DepartmentID
);
------------------------------------------------------------------------------------------------------------------------------

45. Display recruiters who have placed more candidates than the average recruiter.
SELECT
RecruiterID,
COUNT(*) AS TotalPlacements
FROM Applications
GROUP BY RecruiterID
HAVING COUNT(*) >
(
SELECT AVG(TotalCount)
FROM
(
SELECT COUNT(*) AS TotalCount
FROM Applications
GROUP BY RecruiterID
) t
);
------------------------------------------------------------------------------------------------------------------------------

46. Display clients with the highest number of successful placements.
SELECT TOP 1
c.ClientName,
COUNT(*) AS TotalPlacements
FROM Applications a
JOIN Clients c
ON a.ClientID = c.ClientID
WHERE Status='Joined'
GROUP BY c.ClientName
ORDER BY COUNT(*) DESC;

------------------------------------------------------------------------------------------------------------------------------
🔹 EXISTS
------------------------------------------------------------------------------------------------------------------------------

47. Display recruiters who have at least one successful placement using EXISTS.
SELECT *
FROM Recruiters r
WHERE EXISTS
(
SELECT 1
FROM Applications a
WHERE r.RecruiterID = a.RecruiterID
AND Status='Joined'
);
------------------------------------------------------------------------------------------------------------------------------

48. Display clients that have received at least one application.
SELECT *
FROM Clients c
WHERE EXISTS
(
SELECT 1
FROM Applications a
WHERE c.ClientID = a.ClientID
);

------------------------------------------------------------------------------------------------------------------------------
🔹 NOT EXISTS
------------------------------------------------------------------------------------------------------------------------------

49. Display recruiters who have never submitted any candidates.
SELECT *
FROM Recruiters r
WHERE NOT EXISTS
(
SELECT 1
FROM Applications a
WHERE r.RecruiterID = a.RecruiterID
);

------------------------------------------------------------------------------------------------------------------------------
🔹 ANY / ALL
------------------------------------------------------------------------------------------------------------------------------

50. Display employees whose salary is greater than ALL employees in the HR department.
SELECT *
FROM Employees
WHERE Salary >
ALL
(
SELECT Salary
FROM Employees
WHERE DepartmentID =
(
SELECT DepartmentID
FROM Departments
WHERE DepartmentName='HR'
)
);
------------------------------------------------------------------------------------------------------------------------------
