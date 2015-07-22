-- problem 4
SELECT * FROM Departments

-- problem 5
SELECT Name FROM Departments

-- problem 6
SELECT EmployeeID, Salary FROM Employees

-- problem 7
SELECT EmployeeId, FirstName + ' ' + ISNULL(MiddleName, '') + ' ' + LastName AS [Full Name] FROM Employees

-- problem 8
SELECT LOWER(FirstName) + '.' + LOWER(LastName) + '@softuni.bg' AS [Full Email Adresses]
FROM Employees

-- problem 9
SELECT DISTINCT Salary AS [Different Salaries] FROM Employees

-- problem 10
SELECT * FROM Employees WHERE JobTitle = 'Sales Representative'

-- problem 11
SELECT EmployeeID, FirstName FROM Employees WHERE FirstName LIKE 'SA%'


-- problem 12
SELECT EmployeeId, LastName FROM Employees WHERE LastName LIKE '%ei%'

-- problem 13
SELECT  EmployeeId, FirstName, LastName, Salary FROM Employees
	WHERE Salary BETWEEN 20000 AND 30000

-- problem 14
SELECT EmployeeId, FirstName, LastName, Salary FROM Employees WHERE
	Salary = 25000 OR
	Salary = 14000 OR
	Salary = 12500 OR
	Salary = 23600
	
-- problem 15
SELECT EmployeeId, FirstName, LastName, ManagerID FROM Employees
	WHERE ManagerID IS NULL
	
-- problem 16
SELECT EmployeeId, FirstName, LastName, Salary FROM Employees
	WHERE Salary > 50000
ORDER BY Salary DESC

-- problem 17
SELECT TOP 5 EmployeeId, FirstName, LastName, Salary FROM Employees
ORDER BY Salary DESC

-- problem 18
SELECT e.EmployeeId, e.FirstName, e.LastName, a.AddressText FROM Employees e
	INNER JOIN Addresses a ON e.AddressID = a.AddressID
	
-- problem 19
SELECT EmployeeId, FirstName, LastName,
	(SELECT AddressText FROM Addresses a WHERE e.AddressID = a.AddressID)
	AS [Address]
FROM Employees e

-- problem 20
-- employees with manager
SELECT e.EmployeeID, e.FirstName + ' ' + e.LastName AS [Employee],
	e.ManagerID, em.FirstName + ' ' + em.LastName AS [Manager]
FROM Employees e
JOIN Employees em on e.ManagerId = em.EmployeeID
ORDER BY e.EmployeeID


-- problem 21
SELECT e.EmployeeId, e.FirstName + ' ' + e.LastName AS [Employee], e.ManagerId,
	em.FirstName + ' ' + em.LastName AS [Manager],
	a.AddressText AS [Employee Address]
FROM Employees e
	JOIN Employees em ON e.ManagerID = em.EmployeeID
	JOIN Addresses a ON a.AddressID = e.AddressID
	
-- problem 22
SELECT Name FROM Departments
UNION
SELECT Name FROM Towns

-- problem 23
-- employees without manager
SELECT e.EmployeeID, e.FirstName + ' ' + e.LastName AS [Employee],
	e.ManagerID, em.FirstName + ' ' + em.LastName AS [Manager]
FROM Employees e
LEFT OUTER JOIN Employees em on e.ManagerId = em.EmployeeID
ORDER BY e.EmployeeID

-- problem 24
SELECT e.EmployeeId, e.FirstName + ' ' + e.LastName AS [Employee]
	,d.Name AS [Department], YEAR(e.HireDate) AS [Hire Date]
	FROM Employees e
	INNER JOIN Departments d
		ON e.DepartmentID = d.DepartmentID
WHERE YEAR(e.HireDate) BETWEEN 1995 AND 2005
	AND d.Name = 'Sales' OR d.Name = 'Finance'