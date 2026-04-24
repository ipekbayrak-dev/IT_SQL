-- =============================================================
-- LibraryDB — Library Automation Schema
-- Tables: Users, Profile, Authors, Categories, Books, Renting
-- =============================================================

CREATE DATABASE LibraryDB;
GO
USE LibraryDB;
GO

CREATE TABLE Users (
    Id          INT          PRIMARY KEY IDENTITY(1,1),
    FirstName   NVARCHAR(128) NOT NULL,
    LastName    NVARCHAR(128) NOT NULL,
    CreatedDate DATETIME      NOT NULL DEFAULT GETDATE()
);

-- One-to-one relationship with Users
CREATE TABLE Profile (
    Id     INT PRIMARY KEY IDENTITY(1,1),
    UserId INT UNIQUE FOREIGN KEY REFERENCES Users(Id)
);

CREATE TABLE Categories (
    Id   INT          PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(128) NOT NULL UNIQUE
);

CREATE TABLE Authors (
    Id        INT          PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(128) NOT NULL,
    LastName  NVARCHAR(128) NOT NULL
);

CREATE TABLE Books (
    Id         INT     PRIMARY KEY IDENTITY(1,1),
    AuthorId   INT     FOREIGN KEY REFERENCES Authors(Id),
    CategoryId INT     FOREIGN KEY REFERENCES Categories(Id),
    ISBN       CHAR(13) NOT NULL UNIQUE
);

CREATE TABLE Renting (
    Id          INT      PRIMARY KEY IDENTITY(1,1),
    BookId      INT      FOREIGN KEY REFERENCES Books(Id),
    UserId      INT      FOREIGN KEY REFERENCES Users(Id),
    CreatedDate DATETIME NOT NULL DEFAULT GETDATE()
);
