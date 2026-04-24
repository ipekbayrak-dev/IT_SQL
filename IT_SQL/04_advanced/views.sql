-- =============================================================
-- VIEWS (Görünümler)
-- Database: Northwind
-- =============================================================

-- A VIEW is a virtual table built from a saved SELECT query.
-- It does not physically store data — only the SQL definition is saved.
-- Every time it is queried it fetches live data from the base tables.
--
-- Benefits:
--   - Simplifies complex JOINs into a single reusable object.
--   - Improves security: grant access to a view, not the raw tables.
--   - Always returns up-to-date data (reflects base table changes instantly).

USE Northwind;
GO


-- Product detail view: product + category + supplier in one place
CREATE VIEW dbo.ProductDetailView AS
SELECT
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    s.CompanyName AS SupplierName
FROM Products  AS p
JOIN Categories AS c ON p.CategoryID  = c.CategoryID
JOIN Suppliers  AS s ON p.SupplierID  = s.SupplierID;
GO

SELECT * FROM dbo.ProductDetailView;


-- Encrypted order list view (definition hidden from sys.sql_modules)
CREATE VIEW dbo.OrderListView
WITH ENCRYPTION
AS
SELECT
    c.CustomerID,
    c.CompanyName,
    o.OrderID,
    o.OrderDate,
    o.ShipCountry
FROM Orders    AS o
JOIN Customers AS c ON o.CustomerID = c.CustomerID;
GO

SELECT * FROM dbo.OrderListView;
