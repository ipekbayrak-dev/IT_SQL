-- =============================================================
-- TRIGGERS
-- Database: Northwind / Custom Tables
-- =============================================================

-- A TRIGGER is a special procedure that fires automatically when
-- a specified event (INSERT, UPDATE, DELETE) occurs on a table.
-- You cannot call a trigger manually.
--
-- Use cases:
--   Data integrity  : Keep related tables in sync automatically.
--   Auditing        : Log who changed what and when.
--   Soft deletes    : Replace DELETE with a status flag update.
--
-- Timing options:
--   AFTER           : Fires after the DML statement completes.
--   INSTEAD OF      : Replaces the original DML statement entirely.

USE Northwind;
GO


-- =============================================================
-- AFTER INSERT Trigger
-- Automatically decrements stock (UnitsInStock) whenever a new
-- row is inserted into [Order Details].
-- =============================================================

CREATE TRIGGER dbo.trg_UpdateStockOnOrderInsert
ON [Order Details]
AFTER INSERT
AS
BEGIN
    DECLARE @ProductId INT;
    DECLARE @Quantity  SMALLINT;

    SELECT @ProductId = ProductID, @Quantity = Quantity FROM inserted;

    -- Show stock before update
    SELECT p.ProductID, p.ProductName, p.UnitsInStock
    FROM Products AS p
    WHERE p.ProductID = @ProductId;

    -- Decrement stock
    UPDATE Products
    SET UnitsInStock = UnitsInStock - @Quantity
    WHERE ProductID = @ProductId;

    -- Show stock after update
    SELECT p.ProductID, p.ProductName, p.UnitsInStock
    FROM Products AS p
    WHERE p.ProductID = @ProductId;
END;
GO


-- =============================================================
-- INSTEAD OF DELETE Trigger — Soft Delete
-- Marks a record as deleted (SilindiMi = 1) instead of
-- physically removing it from the Personel table.
-- =============================================================

-- Assumes a table: Personel (Id INT, ..., SilindiMi BIT)

CREATE TRIGGER dbo.trg_SoftDeletePersonel
ON Personel
INSTEAD OF DELETE
AS
BEGIN
    DECLARE @Id INT;
    SELECT @Id = Id FROM deleted;

    UPDATE Personel
    SET SilindiMi = 1
    WHERE Id = @Id;
END;
GO
