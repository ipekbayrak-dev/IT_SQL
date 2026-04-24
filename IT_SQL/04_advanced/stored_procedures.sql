-- =============================================================
-- STORED PROCEDURES (Saklı Yordamlar)
-- Database: Northwind
-- =============================================================

-- A STORED PROCEDURE is a named, pre-compiled block of SQL stored
-- in the database. It can accept parameters and encapsulates
-- reusable business logic.
--
-- Benefits:
--   Performance  : Compiled once; execution plan is cached for reuse.
--   Security     : Grant EXEC permission without exposing raw tables.
--                  Natural defense against SQL Injection.
--   Maintainability : Change business logic in one place, all callers benefit.

USE Northwind;
GO


-- READ: Get a product with its category
CREATE PROCEDURE dbo.sp_GetProductWithCategory
    @Id INT
AS
BEGIN
    SELECT p.ProductID, p.ProductName, c.CategoryName
    FROM Products   AS p
    INNER JOIN Categories AS c ON p.CategoryID = c.CategoryID
    WHERE p.ProductID = @Id;
END;
GO

EXEC dbo.sp_GetProductWithCategory @Id = 5;


-- READ: Get a customer by ID
CREATE PROCEDURE dbo.sp_GetCustomerById
    @Id NCHAR(5)
AS
BEGIN
    SELECT * FROM Customers WHERE CustomerID = @Id;
END;
GO

EXEC dbo.sp_GetCustomerById @Id = 'ANTON';


-- CREATE: Insert a shipper and return the new ID
CREATE PROCEDURE dbo.sp_InsertShippers
    @CompanyName NVARCHAR(40),
    @Phone       NVARCHAR(24)
AS
BEGIN
    INSERT INTO Shippers (CompanyName, Phone)
    VALUES (@CompanyName, @Phone);

    SELECT SCOPE_IDENTITY() AS NewID;
END;
GO


-- UPDATE: Update a shipper's details and return the updated row
CREATE PROCEDURE dbo.sp_UpdateShippers
    @Id          INT,
    @CompanyName NVARCHAR(40),
    @Phone       NVARCHAR(24)
AS
BEGIN
    UPDATE Shippers
    SET CompanyName = @CompanyName,
        Phone       = @Phone
    WHERE ShipperID = @Id;

    SELECT * FROM Shippers WHERE ShipperID = @Id;
END;
GO


-- DELETE: Remove a shipper and return the remaining list
CREATE PROCEDURE dbo.sp_DeleteShippers
    @Id INT
AS
BEGIN
    DELETE FROM Shippers WHERE ShipperID = @Id;
    SELECT * FROM Shippers;
END;
GO
