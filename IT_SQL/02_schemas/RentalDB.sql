-- =============================================================
-- RentalDB — Car Rental System Schema
-- Tables: Brands, Users, Cars, Rentals, Payments
-- =============================================================

CREATE DATABASE RentalDB;
GO
USE RentalDB;
GO

CREATE TABLE Brands (
    Id   INT          PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(64) NOT NULL UNIQUE
);

CREATE TABLE Users (
    Id             UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    FirstName      NVARCHAR(128)    NOT NULL,
    LastName       NVARCHAR(128)    NOT NULL,
    Email          NVARCHAR(128)    NOT NULL UNIQUE,
    PasswordHash   NVARCHAR(256)    NOT NULL,
    PhoneNumber    NVARCHAR(20),
    IdentityNumber NVARCHAR(11)     UNIQUE,
    CreatedAt      DATETIME         DEFAULT GETDATE()
);

CREATE TABLE Cars (
    Id           INT          PRIMARY KEY IDENTITY(1,1),
    BrandId      INT          FOREIGN KEY REFERENCES Brands(Id),
    Model        NVARCHAR(128) NOT NULL,
    Year         INT           CHECK (Year > 2000),
    Color        NVARCHAR(64),
    Plate        NVARCHAR(20)  NOT NULL UNIQUE,
    Kilometer    INT           DEFAULT 0,
    DailyPrice   SMALLMONEY    NOT NULL CHECK (DailyPrice > 0),
    FuelType     NVARCHAR(20),
    Transmission NVARCHAR(20),
    IsAvailable  BIT           DEFAULT 1,
    CreatedAt    DATETIME      DEFAULT GETDATE()
);

CREATE TABLE Rentals (
    Id                INT              PRIMARY KEY IDENTITY(1,1),
    CarId             INT              FOREIGN KEY REFERENCES Cars(Id),
    UserId            UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Users(Id),
    RentDate          DATETIME         NOT NULL DEFAULT GETDATE(),
    ReturnDate        DATETIME,
    PlannedReturnDate DATETIME         NOT NULL,
    StartKilometer    INT,
    EndKilometer      INT,
    TotalPrice        SMALLMONEY,

    CONSTRAINT CK_RentalDates CHECK (PlannedReturnDate >= RentDate)
);

CREATE TABLE Payments (
    Id          INT        PRIMARY KEY IDENTITY(1,1),
    RentalId    INT        FOREIGN KEY REFERENCES Rentals(Id),
    PaymentDate DATETIME   DEFAULT GETDATE(),
    Amount      SMALLMONEY NOT NULL,
    PaymentType NVARCHAR(50)
);
