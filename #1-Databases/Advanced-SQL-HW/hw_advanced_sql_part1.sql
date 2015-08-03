-- Advanced SQL Homework
-- part 1
-- problems 1 to 28

-- problem 1
SELECT FirstName, LastName, Salary
	FROM Employees
	WHERE Salary IN (SELECT MIN(Salary) FROM Employees)

-- problem 2
SELECT FirstName, LastName, Salary
	FROM Employees
	WHERE Salary BETWEEN
		(SELECT TOP 1 MIN(Salary) FROM Employees) AND
		((SELECT TOP 1 MIN(Salary) FROM Employees) * 1.1)
--ORDER BY Salary DESC
		
-- problem 3
SELECT FirstName + ' ' + LastName AS [Full Name], Name, e.Salary
FROM Employees e
	join Departments d on
		e.DepartmentID = d.DepartmentID
WHERE e.Salary IN (SELECT MIN(Salary) FROM Employees WHERE
	DepartmentID = e.DepartmentID)
	
-- problem 4
SELECT TOP 1 Name AS [Department],
	(SELECT AVG(Salary) FROM Employees WHERE DepartmentID = 1)
		AS [Average salary]
FROM Departments

-- problem 5
-- the given answer shows AVG(Salary) for all the departments
SELECT AVG(Salary) AS [Average Salary for Sales Department]
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
WHERE d.Name = 'Sales'

-- problem 6
SELECT COUNT(EmployeeId) AS [Sales Employees Count]
FROM Employees e
JOIN Departments d
ON e.DepartmentID = d.DepartmentID
WHERE d.Name = 'Sales'

-- problem 7
SELECT COUNT(EmployeeId) AS [Employees with manager]
FROM Employees
WHERE ManagerID IS NOT NULL

-- problem 8
SELECT COUNT(EmployeeId) AS [Employees without manager]
FROM Employees
WHERE ManagerID IS NULL

-- problem 9
SELECT d.Name, AVG(e.Salary) FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE Salary IN (SELECT Salary FROM Employees WHERE DepartmentID = e.DepartmentID)
GROUP BY d.Name
ORDER BY d.name

-- problem 10
SELECT t.Name AS [Town], d.Name AS [Department],
	COUNT(e.EmployeeId) AS [Employees count]
FROM Towns t
JOIN Addresses a ON t.TownID = a.TownID
JOIN Employees e ON a.AddressID = e.AddressID
JOIN Departments d ON d.DepartmentID = e.DepartmentID
GROUP BY t.Name, d.Name

-- problem 11
SELECT m.FirstName, m.LastName,
	COUNT(e.EmployeeId) AS [Employees count] FROM Employees e 
JOIN Employees m ON e.ManagerID = m.EmployeeID
GROUP BY m.FirstName, m.LastName
HAVING COUNT(e.EmployeeId) = 5

-- problem 12
SELECT e.FirstName + ' ' + e.LastName AS [Employee],
	ISNULL(m.FirstName + ' ' + m.LastName, 'No manager') AS [Manager]
FROM Employees e
LEFT JOIN Employees m on e.ManagerID = m.EmployeeID

-- problem 13
SELECT FirstName, LastName FROM Employees
WHERE LEN(LastName) = 5

-- problem 14
SELECT CONVERT(VARCHAR(24),GETDATE(),104) + ' ' +
	CONVERT(VARCHAR(24),GETDATE(),114)
AS [DateTime]

-- problem 15
CREATE TABLE Users
(
	UserId INT IDENTITY NOT NULL,
	Username NVARCHAR(20) NOT NULL,
	Password NVARCHAR(32) NULL,
	FullName NVARCHAR(50) NOT NULL,
	LastLogin DATETIME
	CONSTRAINT PK_Users PRIMARY KEY (UserId),
	CONSTRAINT UK_Username UNIQUE (Username),
	CONSTRAINT CH_Password CHECK (LEN(Password) > 5)
)

-- fill Users table with data // from problem 19
INSERT INTO Users (Username, Password, FullName, LastLogin)
	VALUES
	('penka_divata', '123456', 'Penka Penkova', GETDATE()),
	('misho_shamara', '654321', 'Lil Sha', GETDATE()),
	('maika_ti', '888888', 'Guna Marova', GETDATE()),
	('emporip_armani', 'asdasd', 'Emporio Armani', NULL),
	('policaicheto', '112112', 'Genadi Genadiev', GETDATE()),
	('muci_99_simitli', 'xixixi', 'Mara Mariikina', GETDATE())

-- problem 16
-- in order to test the view, you have to insert another row
-- in Users table with LastLogin = GETDATE()
SELECT * FROM v_UsersActiveToday

-- problem 17
CREATE TABLE Groups
(
	GroupId INT IDENTITY NOT NULL,
	Name NVARCHAR(20) NOT NULL,
	CONSTRAINT PK_Groups PRIMARY KEY (GroupId),
	CONSTRAINT UK_Name UNIQUE (Name)
)

-- problem 18
ALTER TABLE Users
ADD
	GroupId INT NULL,
	CONSTRAINT FK_Users_Groups FOREIGN KEY (GroupId) REFERENCES Groups(GroupId)
	
-- problem 19 // Users filled in problem 15
INSERT INTO Groups (Name)
VALUES
	('Admin'), ('BigUser'), ('MediumUser'), ('SmallUser'), ('Loser')
	
-- problem 20
UPDATE Users
SET FullName = 'Big Sha'
WHERE FullName LIKE 'Lil%'

UPDATE Groups
SET Name = 'Noob'
WHERE Name = 'Loser'

-- problem 21
DELETE FROM Users
WHERE UserId = 4

DELETE FROM Groups
WHERE Name LIKE 'Small%'

-- problem 22
INSERT INTO Users
SELECT
LEFT(FirstName, 1) + LOWER(LastName) + ISNULL(LEFT(MiddleName, 1), ''),
LEFT(FirstName, 1) + LOWER(LastName) + '123',
FirstName + ' ' + LastName,
NULL,
4
FROM Employees

-- problem 23
UPDATE Users
SET Password = NULL
WHERE LastLogin < ('10.03.2010')

-- problem 24
DELETE FROM Users
WHERE Password IS NULL

-- problem 25
SELECT d.Name AS [Department], e.JobTitle,
	AVG(e.Salary) AS [Average Salary]
FROM Departments d
JOIN Employees e
ON d.DepartmentID = e.DepartmentID
--WHERE d.Name = 'Finance'
GROUP BY e.JobTitle, d.Name
ORDER BY d.Name

-- problem 26
SELECT d.Name AS [Department], e.JobTitle AS [Job Title], e.FirstName AS [First Name],
	MIN(e.Salary) AS [Min Salary]
FROM Departments d
JOIN Employees e
ON d.DepartmentID = e.DepartmentID
GROUP BY e.JobTitle, d.Name, e.FirstName
ORDER BY d.Name

-- problem 27
SELECT TOP 1 t.Name,
(SELECT COUNT(e.EmployeeId) FROM Employees
	WHERE EmployeeID = e.EmployeeID) AS [Number of employees]
FROM Towns t
JOIN Addresses a ON t.TownID = a.TownID
JOIN Employees e ON a.AddressID = a.AddressID
GROUP BY t.Name, e.EmployeeID
ORDER BY COUNT(e.EmployeeID) DESC

-- problem 28
SELECT t.Name AS Town, COUNT(e.ManagerID) AS [Number of managers]
FROM Towns t
JOIN Addresses a ON t.TownID = a.TownID
JOIN Employees e ON a.AddressID = e.AddressID
JOIN Employees m ON e.ManagerID = m.EmployeeID
GROUP BY t.Name