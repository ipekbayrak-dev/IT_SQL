-- =============================================================
-- Northwind Queries — SELECT & DML Practice
-- Database: Northwind (Microsoft sample database)
-- =============================================================

USE Northwind;
GO


-- =============================================================
-- BASIC SELECT
-- =============================================================

SELECT * FROM Products;
SELECT UnitPrice, ProductName FROM Products ORDER BY UnitPrice DESC;
SELECT DISTINCT Country FROM Customers;
SELECT * FROM Customers WHERE Country = 'Germany';


-- =============================================================
-- WHERE CLAUSES
-- =============================================================

-- Comparison operators
SELECT * FROM Products WHERE UnitPrice > 100;

-- BETWEEN (numeric)
SELECT * FROM Products WHERE UnitPrice BETWEEN 20 AND 30;

-- BETWEEN (text — alphabetical range)
SELECT * FROM Products WHERE ProductName BETWEEN 'Chai' AND 'Konbu';

-- NOT BETWEEN (date)
SELECT * FROM Orders WHERE OrderDate NOT BETWEEN '1996-07-01' AND '1997-07-31';

-- IN
SELECT * FROM Customers WHERE Country IN ('UK', 'France', 'Germany');

-- LIKE patterns
SELECT * FROM Customers WHERE CompanyName LIKE 'A%';    -- starts with A
SELECT * FROM Customers WHERE CompanyName LIKE '%a';    -- ends with a
SELECT * FROM Customers WHERE CompanyName LIKE '%a%';   -- contains a
SELECT * FROM Customers WHERE City LIKE 'Lo____';       -- Lo + exactly 4 chars
SELECT * FROM Customers WHERE CompanyName LIKE 'b%s';   -- starts with b, ends with s
SELECT * FROM Employees WHERE Notes LIKE '%toast%';

-- NOT
SELECT * FROM Customers WHERE NOT Country = 'Brazil';

-- AND / OR
SELECT FirstName, LastName, BirthDate
FROM Employees
WHERE FirstName LIKE 'A%';

SELECT OrderId, OrderDate
FROM Orders
WHERE OrderDate BETWEEN '1996-01-01' AND '1996-12-31'
  AND ShipCity = 'London';

-- NULL checks
SELECT * FROM Customers WHERE Fax IS NULL AND Region IS NULL;


-- =============================================================
-- ORDER BY & TOP
-- =============================================================

SELECT * FROM Products ORDER BY UnitPrice DESC;
SELECT * FROM Customers ORDER BY CompanyName ASC, City DESC;
SELECT * FROM Customers ORDER BY ContactName;

SELECT TOP 5 * FROM Products;
SELECT TOP 25 PERCENT * FROM Products;
SELECT TOP 3 * FROM Products ORDER BY UnitPrice DESC;


-- =============================================================
-- AGGREGATE FUNCTIONS
-- =============================================================

SELECT MIN(UnitPrice)            AS Min_Price        FROM Products;
SELECT MAX(UnitPrice)            AS Max_Price        FROM Products;
SELECT COUNT(UnitPrice)          AS Total_Units      FROM Products;
SELECT COUNT(DISTINCT UnitPrice) AS Distinct_Prices  FROM Products;
SELECT SUM(UnitPrice)            AS Total            FROM Products;
SELECT AVG(UnitPrice)            AS Average          FROM Products;

SELECT COUNT(*) AS Category_1_Products FROM Products WHERE CategoryID = 1;
SELECT COUNT(*) AS Number_Of_Orders    FROM Orders    WHERE CustomerID = 'ALFKI';

-- Total revenue (with discount)
SELECT SUM((UnitPrice * Quantity) * (1 - Discount)) AS [Total Revenue]
FROM [Order Details];


-- =============================================================
-- GROUP BY & HAVING
-- =============================================================

SELECT CategoryID, SUM(UnitsInStock) AS Number
FROM Products
GROUP BY CategoryID;

SELECT ProductID, SUM(Quantity) AS Quantity
FROM [Order Details]
GROUP BY ProductID
HAVING SUM(Quantity) > 1000;

-- Customers with no orders
SELECT CustomerID, CompanyName
FROM Customers
WHERE CustomerID NOT IN (SELECT DISTINCT CustomerID FROM Orders);

-- Top order by total revenue
SELECT TOP 1
    od.OrderId,
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS [Total Revenue]
FROM [Order Details] AS od
GROUP BY od.OrderID
ORDER BY 2 DESC;

-- Revenue by ship country
SELECT ShipCountry, SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS Sales
FROM Orders o
INNER JOIN [Order Details] AS od ON o.OrderID = od.OrderID
GROUP BY ShipCountry
ORDER BY 2 DESC;


-- =============================================================
-- SUBQUERIES
-- =============================================================

-- Most expensive product
SELECT * FROM Products
WHERE UnitPrice = (SELECT MAX(UnitPrice) FROM Products);

-- Products above average price
SELECT * FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products)
ORDER BY UnitPrice;

-- Orders with above-average quantity
SELECT * FROM [Order Details] AS od
WHERE od.Quantity > (SELECT AVG(Quantity) FROM [Order Details])
ORDER BY od.Quantity DESC;


-- =============================================================
-- JOINS
-- =============================================================

-- INNER JOIN: Products with their categories
SELECT p.ProductID, p.ProductName, c.CategoryName
FROM Products AS p
INNER JOIN Categories AS c ON p.CategoryID = c.CategoryID;

-- INNER JOIN: Products with their suppliers
SELECT p.ProductID, p.ProductName, s.CompanyName
FROM Products AS p
INNER JOIN Suppliers AS s ON p.SupplierID = s.SupplierID;

-- Multiple INNER JOINs: Products with category AND supplier
SELECT p.ProductName, c.CategoryName, s.CompanyName
FROM Products AS p
INNER JOIN Categories AS c ON p.CategoryID = c.CategoryID
INNER JOIN Suppliers  AS s ON p.SupplierID = s.SupplierID;

-- Orders with shipping company
SELECT o.OrderID, o.OrderDate, sh.CompanyName
FROM Orders AS o
INNER JOIN Shippers AS sh ON o.ShipVia = sh.ShipperID;

-- Orders per shipper
SELECT s.CompanyName, SUM(ShipVia) AS OrdersHandled
FROM Orders AS o
INNER JOIN Shippers AS s ON o.ShipVia = s.ShipperID
GROUP BY CompanyName;

-- Self-Join: Employee / Manager hierarchy
SELECT
    c.Title,
    c.FirstName + ' ' + c.LastName AS Employee,
    m.FirstName + ' ' + m.LastName AS Manager
FROM Employees AS c
INNER JOIN Employees AS m ON c.ReportsTo = m.EmployeeID
ORDER BY 2;

-- Sales per employee
SELECT
    e.FirstName + ' ' + e.LastName AS Employee,
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS [Total Sales]
FROM Orders AS o
INNER JOIN [Order Details] AS od ON o.OrderID  = od.OrderID
INNER JOIN Employees       AS e  ON o.EmployeeID = e.EmployeeID
GROUP BY e.FirstName, e.LastName
ORDER BY 2 DESC;

-- Supplier count by country
SELECT Country, COUNT(Country) AS [Number of Suppliers]
FROM Suppliers
WHERE Country = 'Japan'
GROUP BY Country;

-- Top 3 customers by revenue
SELECT TOP 3
    c.CompanyName,
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS Sales,
    SUM(Quantity) AS Units
FROM Orders AS o
INNER JOIN [Order Details] AS od ON o.OrderID  = od.OrderID
INNER JOIN Customers       AS c  ON o.CustomerID = c.CustomerID
GROUP BY c.CompanyName
ORDER BY 2 DESC;

-- LEFT JOIN: All customers and their order count (including 0)
SELECT c.CompanyName, COUNT(o.OrderID) AS OrderCount
FROM Customers AS c
LEFT JOIN Orders AS o ON c.CustomerID = o.CustomerID
GROUP BY c.CompanyName
ORDER BY 2;


-- =============================================================
-- DATE FUNCTIONS
-- =============================================================

-- Employees with a birthday today
SELECT * FROM Employees
WHERE MONTH(BirthDate) = MONTH(GETDATE())
  AND DAY(BirthDate)   = DAY(GETDATE());

-- Late shipments (shipped after required date)
SELECT OrderID, DATEDIFF(DAY, RequiredDate, ShippedDate) AS Delay
FROM Orders
WHERE DATEDIFF(DAY, RequiredDate, ShippedDate) > 0
ORDER BY 2 DESC;


-- =============================================================
-- SET OPERATORS
-- =============================================================

-- UNION: Distinct cities from Customers and Suppliers combined
SELECT City, Country FROM Customers
UNION
SELECT City, Country FROM Suppliers;

-- UNION ALL: All cities including duplicates
SELECT City FROM Customers
UNION ALL
SELECT City FROM Suppliers;

-- UNION with a type label column
SELECT 'S' AS Type, s.ContactName, s.Phone FROM Suppliers s
UNION
SELECT 'C' AS Type, c.ContactName, c.Phone FROM Customers c;

-- INTERSECT: Products that have been ordered at least once
SELECT p.ProductID FROM Products AS p
INTERSECT
SELECT od.ProductID FROM [Order Details] AS od;

-- EXCEPT: Customers who have never placed an order
SELECT c.CustomerID FROM Customers AS c
EXCEPT
SELECT o.CustomerID FROM Orders AS o;


-- =============================================================
-- MATHEMATICAL FUNCTIONS
-- =============================================================

SELECT ROUND(235.412, 2)   AS Rounded;
SELECT CEILING(235.412)    AS CeilingVal;
SELECT FLOOR(235.412)      AS FloorVal;
SELECT 235 % 2             AS Modulo;


-- =============================================================
-- STRING FUNCTIONS
-- =============================================================

SELECT LEFT('Hello World', 5)                       AS LeftChars;
SELECT RIGHT('Hello World', 5)                      AS RightChars;
SELECT LEN('SQL Study')                             AS StringLength;
SELECT REPLACE('SQL Study', 'SQL', 'C#')            AS Replaced;
SELECT SUBSTRING('SQL Study', 1, 3)                 AS Sliced;
SELECT LOWER('STOP SHOUTING')                       AS Lowered;
SELECT UPPER('speak up')                            AS Uppered;
SELECT REVERSE('SQL Study')                         AS Reversed;
SELECT LTRIM('     SQL Study')                      AS LeftTrimmed;
SELECT RTRIM('SQL Study     ')                      AS RightTrimmed;
SELECT TRIM('     SQL Study     ')                  AS BothTrimmed;
