-- =============================================================
-- IT_EV_ChargeStation — EV Charging Station Management System
-- Tables: Users, Stations, Chargers, Bookings, Transactions, UsageLogs
-- All tables use a soft-delete pattern (IsDeleted, DeletedAt).
-- =============================================================

CREATE DATABASE IT_EV_ChargeStation;
GO
USE IT_EV_ChargeStation;
GO

CREATE TABLE Users (
    Id           INT          PRIMARY KEY IDENTITY(1,1),
    UserName     NVARCHAR(64) NOT NULL,
    PasswordHash NVARCHAR(64) NOT NULL,
    Email        NVARCHAR(64) NOT NULL UNIQUE,
    CreatedAt    DATETIME     NOT NULL DEFAULT GETDATE(),
    UpdatedAt    DATETIME,
    DeletedAt    DATETIME,
    IsDeleted    BIT          NOT NULL DEFAULT 0
);

CREATE TABLE Stations (
    Id              INT          PRIMARY KEY IDENTITY(1,1),
    Name            NVARCHAR(64) NOT NULL UNIQUE,
    ChargerCapacity SMALLINT     NOT NULL DEFAULT 1,
    City            NVARCHAR(64) NOT NULL,
    District        NVARCHAR(64) NOT NULL,
    Address         NVARCHAR(64) NOT NULL,
    CreatedAt       DATETIME     NOT NULL DEFAULT GETDATE(),
    UpdatedAt       DATETIME,
    DeletedAt       DATETIME,
    IsDeleted       BIT          NOT NULL DEFAULT 0
);

CREATE TABLE Chargers (
    Id            INT          PRIMARY KEY IDENTITY(1,1),
    StationId     INT          FOREIGN KEY REFERENCES Stations(Id),
    Status        NVARCHAR(24) NOT NULL,
    ConnectorType NVARCHAR(24) NOT NULL,
    PowerOutput   SMALLINT     NOT NULL,
    Charge        SMALLINT     NOT NULL DEFAULT 100,
    CreatedAt     DATETIME     NOT NULL DEFAULT GETDATE(),
    UpdatedAt     DATETIME,
    DeletedAt     DATETIME,
    IsDeleted     BIT          NOT NULL DEFAULT 0
);

CREATE TABLE Bookings (
    Id        INT        PRIMARY KEY IDENTITY(1,1),
    UserId    INT        FOREIGN KEY REFERENCES Users(Id),
    StationId INT        FOREIGN KEY REFERENCES Stations(Id),
    ChargerId INT        FOREIGN KEY REFERENCES Chargers(Id),
    StartTime DATETIME   NOT NULL DEFAULT GETDATE(),
    EndTime   DATETIME   NOT NULL DEFAULT GETDATE(),
    Status    NVARCHAR(24) NOT NULL,
    Pricing   SMALLMONEY   NOT NULL DEFAULT 0 CHECK (Pricing > 0),
    CreatedAt DATETIME     NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME,
    DeletedAt DATETIME,
    IsDeleted BIT          NOT NULL DEFAULT 0
);

CREATE TABLE Transactions (
    Id        INT          PRIMARY KEY IDENTITY(1,1),
    UserId    INT          FOREIGN KEY REFERENCES Users(Id),
    StationId INT          FOREIGN KEY REFERENCES Stations(Id),
    ChargerId INT          FOREIGN KEY REFERENCES Chargers(Id),
    Amount    SMALLMONEY   NOT NULL DEFAULT 0 CHECK (Amount > 0),
    Status    NVARCHAR(24) NOT NULL,
    Method    NVARCHAR(24) NOT NULL,
    CreatedAt DATETIME     NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME,
    DeletedAt DATETIME,
    IsDeleted BIT          NOT NULL DEFAULT 0
);

CREATE TABLE UsageLogs (
    Id             INT      PRIMARY KEY IDENTITY(1,1),
    ChargerId      INT      FOREIGN KEY REFERENCES Chargers(Id),
    UserId         INT      FOREIGN KEY REFERENCES Users(Id),
    EnergyConsumed SMALLINT NOT NULL,
    Duration       INT      NOT NULL DEFAULT 0,
    SessionStart   DATETIME NOT NULL DEFAULT GETDATE(),
    SessionEnd     DATETIME NOT NULL DEFAULT GETDATE(),
    CreatedAt      DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt      DATETIME,
    DeletedAt      DATETIME,
    IsDeleted      BIT      NOT NULL DEFAULT 0
);
