-- =============================================================
-- USER DEFINED FUNCTIONS (UDF)
-- Database: Northwind
-- =============================================================

-- When the built-in RDBMS functions are not sufficient, UDFs allow
-- you to encapsulate custom logic, store it in the database, and
-- reuse it just like a built-in function.

USE Northwind;
GO


-- =============================================================
-- 1. SCALAR FUNCTIONS
-- Accept input parameters, return a single value.
-- =============================================================

-- Simple multiplication
CREATE FUNCTION dbo.Multiply(@Number1 FLOAT, @Number2 FLOAT)
RETURNS FLOAT
AS
BEGIN
    RETURN @Number1 * @Number2;
END;
GO

SELECT dbo.Multiply(5, 78) AS Product;


-- Revenue after discount
CREATE FUNCTION dbo.TotalRevenue(
    @Price    MONEY,
    @Quantity SMALLINT,
    @Discount REAL
)
RETURNS MONEY
AS
BEGIN
    RETURN @Price * @Quantity * (1 - @Discount);
END;
GO

SELECT dbo.TotalRevenue(10, 10, 0.1) AS Revenue;


-- Price after percentage increase
CREATE FUNCTION dbo.PriceAfterRaise(@Price SMALLMONEY, @RaisePercent FLOAT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @NewPrice FLOAT;
    SET @NewPrice = @Price * (1 + (@RaisePercent / 100));
    RETURN @NewPrice;
END;
GO

SELECT p.ProductName, dbo.PriceAfterRaise(p.UnitPrice, 25) AS [Raised Price]
FROM Products AS p;


-- =============================================================
-- 2. TABLE-VALUED FUNCTIONS (Inline)
-- Return a full result set; used like a table in FROM / JOIN.
-- =============================================================

CREATE FUNCTION dbo.GetCustomerProductDetails(@CustomerId NCHAR(5))
RETURNS TABLE
AS
RETURN
(
    SELECT p.ProductName, p.UnitPrice
    FROM Customers  AS c
    JOIN Orders          AS o  ON c.CustomerID  = o.CustomerID
    JOIN [Order Details] AS od ON o.OrderID     = od.OrderID
    JOIN Products        AS p  ON od.ProductID  = p.ProductID
    WHERE c.CustomerID = @CustomerId
);
GO

SELECT * FROM dbo.GetCustomerProductDetails('ANTON')
ORDER BY UnitPrice DESC;


-- =============================================================
-- 3. MULTI-STATEMENT TABLE-VALUED FUNCTIONS
-- Build and manipulate a virtual table inside the function body.
-- Useful when conditional logic must shape the result set.
-- =============================================================

CREATE FUNCTION dbo.GetProduct(@Id INT)
RETURNS @ProductsResult TABLE
(
    Id       INT,
    Name     NVARCHAR(100),
    Category NVARCHAR(50)
)
AS
BEGIN
    IF @Id < 0
    BEGIN
        INSERT INTO @ProductsResult (Id, Name, Category)
        VALUES (0, 'Invalid ID Provided', 'System Error');
    END
    ELSE
    BEGIN
        INSERT INTO @ProductsResult
        SELECT p.ProductID, p.ProductName, c.CategoryName
        FROM Products   AS p
        JOIN Categories AS c ON p.CategoryID = c.CategoryID
        WHERE p.ProductID = @Id;
    END

    RETURN;
END;
GO

SELECT * FROM dbo.GetProduct(5);
SELECT * FROM dbo.GetProduct(-1); -- returns error row
