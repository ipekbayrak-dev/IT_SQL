-- =============================================================
-- NormalizationDB — Student Course Registration
-- Demonstrates a normalized many-to-many relationship.
-- Tables: Ogrenciler, Dersler, OgrenciDersler
-- =============================================================

CREATE TABLE Ogrenciler (
    Id          INT         PRIMARY KEY IDENTITY(1,1),
    Ad          NVARCHAR(128) NOT NULL,
    Soyad       NVARCHAR(128) NOT NULL,
    TCKN        CHAR(11)      NOT NULL UNIQUE,
    KayitTarih  SMALLDATETIME DEFAULT GETDATE()
);

CREATE TABLE Dersler (
    Id  INT          PRIMARY KEY IDENTITY(1,1),
    Ad  NVARCHAR(128) NOT NULL UNIQUE,
    Kod NVARCHAR(128) NOT NULL UNIQUE
);

-- Junction table resolving the many-to-many relationship
CREATE TABLE OgrenciDersler (
    Id         INT           PRIMARY KEY IDENTITY(1,1),
    OgrenciId  INT           FOREIGN KEY REFERENCES Ogrenciler(Id),
    DersId     INT           FOREIGN KEY REFERENCES Dersler(Id),
    KayitTarih SMALLDATETIME DEFAULT GETDATE()
);
