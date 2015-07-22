-- Advanced SQL Homework
-- part 2
-- problems 29 to 34

-- problem 29
CREATE TABLE WorkHours(
	WorkHourId INT IDENTITY,
	EmployeeId INT FOREIGN KEY REFERENCES Employees(EmployeeID) NOT NULL,
	WorkDate DATETIME,
	Task NVARCHAR(100) NOT NULL,
	WorkHours INT NOT NULL,
	Comments NVARCHAR(MAX) NULL,
	CONSTRAINT PK_WorkHours PRIMARY KEY(WorkHourId)
)
GO

-- problem 30
-- insert
INSERT INTO WorkHours(EmployeeId, WorkDate, Task, WorkHours, Comments)
     VALUES
           (2, GETDATE(), 'task 1', 3, 'task 1 comment'),
           (4, GETDATE(), 'task 2', 3, 'task 2 comment'),
           (2, GETDATE(), 'task 1', 3, NULL);
GO
-- update
UPDATE WorkHours SET Comments = 'No comments'
WHERE Comments IS NULL;
GO
-- delete
DELETE FROM WorkHours WHERE EmployeeID = 4
GO

-- problem 31
CREATE TABLE WorkHoursLogs (
  WorkHoursLogId INT IDENTITY,
  LogCommand NVARCHAR(6) NOT NULL,
  OldWorkHourId INT NULL,
  OldEmployeeId INT FOREIGN KEY REFERENCES Employees(EmployeeID) NULL,
  OldWorkDate DATETIME NULL,  
  OldTask NVARCHAR(100) NULL,
  OldWorkHours INT NULL,
  OldComments NVARCHAR(MAX) NULL,
  NewWorkHourId INT NULL,
  NewEmployeeId INT FOREIGN KEY REFERENCES Employees(EmployeeID) NULL,
  NewWorkDate DATETIME NULL,  
  NewTask NVARCHAR(100) NULL,
  NewWorkHours INT NULL,
  NewComments NVARCHAR(MAX) NULL,
  CONSTRAINT PK_WorkHoursLogs PRIMARY KEY(WorkHoursLogID)
)
GO

-- delete trigger
CREATE TRIGGER tr_WorkHoursDelete
ON WorkHours
FOR DELETE
AS
BEGIN  
    INSERT INTO WorkHoursLogs
    SELECT 'DELETE', * , NULL, NULL, NULL, NULL, NULL, NULL
        FROM DELETED
END
GO

-- update trigger
CREATE TRIGGER tr_WorkHoursUpdate
ON WorkHours
FOR UPDATE
AS
BEGIN  
    SET NOCOUNT ON;
    INSERT INTO WorkHoursLogs
    SELECT 'UPDATE',
           d.WorkHourId,
           d.EmployeeId,
           d.WorkDate,
           d.Task,
           d.WorkHours,
           d.Comments,
           i.WorkHourId,
           i.EmployeeId,
           i.WorkDate,
           i.Task,
           i.WorkHours,
           i.Comments
        FROM INSERTED i, DELETED d
END
GO

-- insert trigger
CREATE TRIGGER tr_WorkHoursInsert
ON WorkHours
FOR INSERT
AS
BEGIN
    INSERT INTO WorkHoursLogs
    SELECT 'INSERT', NULL, NULL, NULL, NULL, NULL, NULL, *
        FROM INSERTED
END
GO

-- problem 32
BEGIN TRANSACTION
	DELETE Employees FROM Employees e
		JOIN Departments d
		ON e.EmployeeID = d.DepartmentID
	WHERE d.Name = 'Sales'
ROLLBACK TRANSACTION
GO

-- problem 33
BEGIN TRANSACTION 
	DROP TABLE EmployeesProjects 
ROLLBACK TRANSACTION
GO

-- problem 34
SELECT * INTO #TempTableProjects
FROM EmployeesProjects
 
DROP TABLE EmployeesProjects

CREATE TABLE EmployeesProjects(
	EmployeeID INT FOREIGN KEY REFERENCES Employees(EmployeeID) NOT NULL,
	ProjectID INT FOREIGN KEY REFERENCES Projects(ProjectID) NOT NULL,
)
 
INSERT INTO EmployeesProjects
SELECT * FROM #TempTableProjects;

DROP TABLE tempdb.#TempTableProjects;