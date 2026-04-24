-- =============================================================
-- IT_ETicaret — Turkish E-Commerce Schema
-- All tables use a soft-delete pattern:
--   SilindiMi BIT (IsDeleted), SilinmeTarihi DATETIME (DeletedAt)
-- Tables: Kategoriler, Urunler, Kullanicilar, Adresler,
--         OdemeTurleri, Odemeler, Kargocular, Siparisler, SiparisDetay
-- =============================================================

CREATE DATABASE IT_ETicaret;
GO
USE IT_ETicaret;
GO

CREATE TABLE Kategoriler (
    Id               INT          PRIMARY KEY IDENTITY(1,1),
    Isim             NVARCHAR(64) NOT NULL,
    Aciklama         NVARCHAR(256),
    EklenmeTarihi    DATETIME     NOT NULL DEFAULT GETDATE(),
    GuncellenmeTarihi DATETIME,
    SilinmeTarihi    DATETIME,
    SilindiMi        BIT          NOT NULL DEFAULT 0
);

CREATE TABLE Urunler (
    Id                INT          PRIMARY KEY IDENTITY(1,1),
    KategoriId        INT          FOREIGN KEY REFERENCES Kategoriler(Id),
    Isim              NVARCHAR(64) NOT NULL,
    Fiyat             SMALLMONEY   NOT NULL,
    Aciklama          NVARCHAR(512),
    EklenmeTarihi     DATETIME     NOT NULL DEFAULT GETDATE(),
    GuncellenmeTarihi DATETIME,
    SilinmeTarihi     DATETIME,
    SilindiMi         BIT          NOT NULL DEFAULT 0
);

CREATE TABLE Kullanicilar (
    Id                INT          PRIMARY KEY IDENTITY(1,1),
    KullaniciAdi      NVARCHAR(64) NOT NULL,
    Email             NVARCHAR(64) NOT NULL,
    Sifre             NVARCHAR(64) NOT NULL,
    EklenmeTarihi     DATETIME     NOT NULL DEFAULT GETDATE(),
    GuncellenmeTarihi DATETIME,
    SilinmeTarihi     DATETIME,
    SilindiMi         BIT          NOT NULL DEFAULT 0
);

CREATE TABLE Adresler (
    Id                INT          PRIMARY KEY IDENTITY(1,1),
    KullaniciId       INT          FOREIGN KEY REFERENCES Kullanicilar(Id),
    Ulke              NVARCHAR(64) NOT NULL,
    Il                NVARCHAR(64) NOT NULL,
    Ilce              NVARCHAR(64) NOT NULL,
    PostaKodu         NVARCHAR(20) NOT NULL,
    Detay             NVARCHAR(256) NOT NULL,
    EklenmeTarihi     DATETIME     NOT NULL DEFAULT GETDATE(),
    GuncellenmeTarihi DATETIME,
    SilinmeTarihi     DATETIME,
    SilindiMi         BIT          NOT NULL DEFAULT 0
);

CREATE TABLE OdemeTurleri (
    Id                INT           PRIMARY KEY IDENTITY(1,1),
    OdemeTipi         NVARCHAR(64)  NOT NULL,
    NakitMi           BIT           NOT NULL DEFAULT 0,
    TaksitSayisi      SMALLINT      NOT NULL DEFAULT 1,
    EklenmeTarihi     DATETIME      NOT NULL DEFAULT GETDATE(),
    GuncellenmeTarihi DATETIME,
    SilinmeTarihi     DATETIME,
    SilindiMi         BIT           NOT NULL DEFAULT 0
);

CREATE TABLE Odemeler (
    Id                INT           PRIMARY KEY IDENTITY(1,1),
    SiparisId         INT           NOT NULL,
    OdemeTurId        INT           FOREIGN KEY REFERENCES OdemeTurleri(Id),
    OdemeTarihi       DATETIME      NOT NULL DEFAULT GETDATE(),
    Tutar             MONEY         NOT NULL,
    OdemeDurumu       BIT           NOT NULL DEFAULT 0,
    IslemNo           NVARCHAR(128),
    EklenmeTarihi     DATETIME      NOT NULL DEFAULT GETDATE(),
    GuncellenmeTarihi DATETIME,
    SilinmeTarihi     DATETIME,
    SilindiMi         BIT           NOT NULL DEFAULT 0
);

CREATE TABLE Kargocular (
    Id                INT          PRIMARY KEY IDENTITY(1,1),
    SirketAdi         NVARCHAR(64) NOT NULL,
    Telefon           NVARCHAR(24),
    EklenmeTarihi     DATETIME     NOT NULL DEFAULT GETDATE(),
    GuncellenmeTarihi DATETIME,
    SilinmeTarihi     DATETIME,
    SilindiMi         BIT          NOT NULL DEFAULT 0
);

CREATE TABLE Siparisler (
    Id                INT        PRIMARY KEY IDENTITY(1,1),
    KullaniciId       INT        FOREIGN KEY REFERENCES Kullanicilar(Id),
    AdresId           INT        FOREIGN KEY REFERENCES Adresler(Id),
    KargoId           INT        FOREIGN KEY REFERENCES Kargocular(Id),
    OdemeTurId        INT        FOREIGN KEY REFERENCES OdemeTurleri(Id),
    SiparisTarihi     DATETIME   NOT NULL DEFAULT GETDATE(),
    ToplamTutar       MONEY      NOT NULL,
    GuncellenmeTarihi DATETIME,
    SilinmeTarihi     DATETIME,
    SilindiMi         BIT        NOT NULL DEFAULT 0
);

CREATE TABLE SiparisDetay (
    Id                INT        PRIMARY KEY IDENTITY(1,1),
    SiparisId         INT        FOREIGN KEY REFERENCES Siparisler(Id),
    UrunId            INT        FOREIGN KEY REFERENCES Urunler(Id),
    Adet              SMALLINT   NOT NULL DEFAULT 1,
    BirimFiyat        SMALLMONEY NOT NULL,
    EklenmeTarihi     DATETIME   NOT NULL DEFAULT GETDATE(),
    GuncellenmeTarihi DATETIME,
    SilinmeTarihi     DATETIME,
    SilindiMi         BIT        NOT NULL DEFAULT 0
);
