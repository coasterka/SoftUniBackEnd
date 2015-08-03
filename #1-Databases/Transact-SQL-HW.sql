-- problem 1
ALTER PROCEDURE usp_SelectFullName
AS
BEGIN
	SELECT FirstName + ' ' + LastName AS [Full Name]
	FROM Persons
END
GO

EXEC usp_SelectFullName
GO

-- problem 2
ALTER PROCEDURE usp_AccountsLargerThan
	@Money MONEY = 0
AS
BEGIN
	SELECT p.PersonId, FirstName, LastName, Balance FROM Persons p
	JOIN Accounts a
	ON p.PersonId = a.PersonId
	WHERE Balance > @Money
END
GO

EXEC usp_AccountsLargerThan @Money = 1000
GO

-- problem 3
ALTER FUNCTION ufn_CalculateInterest(
	@Sum MONEY,
	@Interest FLOAT,
	@Months FLOAT)
	RETURNS MONEY
AS
BEGIN
	RETURN (@Sum * (@Interest / 100)) * (@Months / 12)
END
GO

SELECT dbo.ufn_CalculateInterest(100, 10, 1) AS [Balance Growth]
GO

-- problem 4
ALTER PROCEDURE usp_CalculatePersonInterest
	@AccountId INT = 1,
	@InterestRate FLOAT = 0
AS
BEGIN
	SELECT AccountId, Balance,
		   dbo.ufn_CalculateInterest(Balance, @InterestRate, 1) AS [Interest Per Month]
	FROM Accounts
	WHERE AccountId = @AccountId
END
GO

EXEC dbo.usp_CalculatePersonInterest @AccountId = 1, @InterestRate = 20
GO

-- problem 5
-- Withdraw money
ALTER PROCEDURE usp_WithdrawMoney
	@AccountId INT,
	@Money MONEY
AS
BEGIN TRANSACTION;
	DECLARE @OldAmount MONEY =
		(SELECT Balance FROM Accounts WHERE AccountId = @AccountId)
	IF (@OldAmount < @Money)
		BEGIN
			ROLLBACK TRANSACTION;
			RAISERROR('Not enough money', 16, 1);
		END
	ELSE IF (@Money <= 0)
		BEGIN
			ROLLBACK TRANSACTION;
			RAISERROR('Value must be positive', 16, 1);
		END
	ELSE
		BEGIN
			UPDATE Accounts
			SET Balance = Balance - @Money
			WHERE AccountId = @AccountId;
			COMMIT TRANSACTION;
		END
GO

SELECT * FROM Accounts
EXEC usp_WithdrawMoney @AccountId = 2, @Money = 3.00
GO

-- Deposit money
CREATE PROCEDURE usp_DepositMoney
	@AccountId INT,
	@Money MONEY
AS
	BEGIN TRANSACTION;
	DECLARE @OldAmount MONEY =
		(SELECT Balance FROM Accounts WHERE AccountId = @AccountId)
	IF (@Money <= 0)
		BEGIN
			ROLLBACK TRANSACTION;
			RAISERROR('Value must be positive', 16, 1);
		END
	ELSE
		BEGIN
			UPDATE Accounts
			SET Balance = Balance + @Money
			WHERE AccountId = @AccountId;
			COMMIT TRANSACTION;
		END
GO

SELECT * FROM Accounts
EXEC usp_DepositMoney @AccountId = 2, @Money = -206
GO

-- problem 6
CREATE TRIGGER tr_FillLog
   ON  Accounts
   AFTER UPDATE
AS 
BEGIN
	SET NOCOUNT ON;
	INSERT INTO Logs(AccountId, OldSum, NewSum)
	VALUES
		((SELECT AccountId FROM INSERTED),
		 (SELECT Balance FROM DELETED),
		 (SELECT Balance FROM INSERTED)) 
END
GO