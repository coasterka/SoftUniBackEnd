-- Advanced SQL Homework

-- problem 16
CREATE VIEW v_UsersActiveToday AS
	SELECT * FROM Users WHERE
		DAY(LastLogin) = DAY(GETDATE())