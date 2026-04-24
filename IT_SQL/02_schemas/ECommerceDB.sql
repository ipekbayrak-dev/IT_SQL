-- =============================================================
-- ECommerceDB — E-Commerce Schema
-- Tables: Categories, Products, Customers, Orders,
--         OrderDetails, Shipments, Payments
-- =============================================================

CREATE DATABASE ECommerceDB;
GO
USE ECommerceDB;
GO

CREATE TABLE Categories (
    Id   INT          PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(128) NOT NULL
);

CREATE TABLE Products (
    Id         INT          PRIMARY KEY IDENTITY(1,1),
    Name       NVARCHAR(128) NOT NULL,
    Price      SMALLMONEY    NOT NULL DEFAULT 0,
    Stock      INT           NOT NULL DEFAULT 0,
    CategoryId INT           FOREIGN KEY REFERENCES Categories(Id)
);

CREATE TABLE Customers (
    Id        INT          PRIMARY KEY IDENTITY(1,1),
    Email     NVARCHAR(128) NOT NULL UNIQUE,
    Password  NVARCHAR(128) NOT NULL,
    FirstName NVARCHAR(128) NOT NULL,
    LastName  NVARCHAR(128) NOT NULL
);

CREATE TABLE Orders (
    Id         INT      PRIMARY KEY IDENTITY(1,1),
    CustomerId INT      FOREIGN KEY REFERENCES Customers(Id),
    OrderDate  DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE TABLE OrderDetails (
    Id        INT        PRIMARY KEY IDENTITY(1,1),
    OrderId   INT        FOREIGN KEY REFERENCES Orders(Id),
    ProductId INT        FOREIGN KEY REFERENCES Products(Id),
    Quantity  INT        NOT NULL DEFAULT 1,
    Total     SMALLMONEY NOT NULL
);

CREATE TABLE Shipments (
    Id      INT          PRIMARY KEY IDENTITY(1,1),
    Name    NVARCHAR(128) NOT NULL,
    Address NVARCHAR(128) NOT NULL,
    OrderId INT           FOREIGN KEY REFERENCES Orders(Id)
);

CREATE TABLE Payments (
    Id      INT          PRIMARY KEY IDENTITY(1,1),
    OrderId INT          FOREIGN KEY REFERENCES Orders(Id),
    Method  NVARCHAR(128) NOT NULL,
    Total   SMALLMONEY    NOT NULL
);


-- =============================================================
-- DML — Data Manipulation Language
-- =============================================================

-- INSERT INTO
INSERT INTO Categories (Name) VALUES ('Clothing');
INSERT INTO Categories (Name) VALUES ('Electronics');

INSERT INTO Customers (Email, Password, FirstName, LastName)
VALUES ('ipek@bambicim.com', 'Admin1234!', 'İpek', 'Bayrak');

INSERT INTO Products (Name, Price, Stock, CategoryId)
VALUES ('Macbook', 37500, 12, 2);

-- UPDATE
UPDATE Customers
SET Email = 'ipek@bamcicim.com'
WHERE Id = 1;

-- DELETE
DELETE FROM Customers
WHERE Id = 2;
