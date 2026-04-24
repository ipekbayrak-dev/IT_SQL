-- =============================================================
-- BlogDB — Blog Platform Schema
-- Tables: Users, Categories, Articles
-- =============================================================

CREATE DATABASE BlogDB;
GO
USE BlogDB;
GO

CREATE TABLE Users (
    Id          UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    FirstName   NVARCHAR(128)    NOT NULL DEFAULT 'Anonymous',
    LastName    NVARCHAR(128)    NOT NULL DEFAULT 'Anonymous',
    Email       NVARCHAR(128)    NOT NULL UNIQUE,
    Password    NVARCHAR(128)    NOT NULL
);

CREATE TABLE Categories (
    Id          INT              PRIMARY KEY IDENTITY(1,1),
    Name        NVARCHAR(128)    NOT NULL UNIQUE,
    Description NVARCHAR(512)    DEFAULT 'No Description'
);

-- Note: CategoryId references Categories, so Categories must be created first.
CREATE TABLE Articles (
    Id          INT              PRIMARY KEY IDENTITY(1,1),
    Name        NVARCHAR(128)    NOT NULL UNIQUE,
    CategoryId  INT              FOREIGN KEY REFERENCES Categories(Id),
    Content     NTEXT            NOT NULL,
    Length      INT              DEFAULT 0,
    Date        DATETIME         NOT NULL DEFAULT GETDATE(),
    Reviews     INT              DEFAULT 0,
    UserId      UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Users(Id)
);
