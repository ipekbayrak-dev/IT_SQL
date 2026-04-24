-- Yorum Satırı --

--Create Table tablo_adi (
--kolon_adı1 veri_tipi kısıtlamalar,--
--kolon_adı1 veri_tipi kısıtlamalar,--
--kolon_adı1 veri_tipi kısıtlamalar,--
--);

-- Drop Table : Secili tabloyu kalıcı olarak siler.
-- Truncate Table : Secili tablonun icerisindeki verileri siler. 

-- Alter Table Vatandas
--Add Email nvarchar(128);

--Drop Column : Secili tablo icersinde secili kolonun silinmesini saglar.

-- SQL Constraints : SQL kisitlamari, bir tablodaki veriler icin gereli olan kurallardır.
-- NOT NULL : İlgili kolona veri girisi yapılmasını saglar
-- DEFAULT : İlgili kolona veri girisi yapılmazsa yerine otomatik olarak tanımlanan veri girisini saglar.
-- UNIQUE : İlgili kolona girilen her verinin benzersiz olmasını saglar.
-- 

--Primary Key - Birincil anahtar : Tabloya girilen her bir satır verinin benzersiz bir sekilde kimliklendirilmesini saglar. PK, aynı anda hem 'NOT NULL' hemde 'UNIQUE' kısıtlamalarına sahiptir.
-- Bir tabloda yalnız bir PK olabilir. Veri tipi olarak genellikle 'INT' yada 'INUQIEIDENTIFIER(GUID)' tercih edilir.

--Foreign Key - İkincil anahtar : İki tablo arasında bir baglanti kurar. FK, bir tablodaki bir sutunun baska bir tablodaki PK'e referans vermesidir.

--INDEX : Veritabanındaki tablolarda indeks olusturmak veri erisimi hızlandırmak icin kullanılır. Kitapların sonundaki cindekiler alanına benzeyen sıralı bir veri yapısıdır. Her sutuna indeks eklenmemelidir;
-- Sadece sık sorgulanan sutunlar secilmelidir. Fazla indeks, guncelleme islemlerini yavaslatır.

--Create Database BlogDB;
--use BlogDB;
--Create table Users ( 
--Id uniqueidentifier primary key default newid(), 
--FirstName nvarchar(128) default 'Anonymous',
--LastName nvarchar(128) default 'Anonymous',
--Email nvarchar(128) NOT NULL UNIQUE,
--Password nvarchar(128) NOT NULL,
--);

--Create table Articles (
--Id int primary key identity(1,1),
--Name nvarchar(128) not null unique,
--CategoryId int foreign key references Categories(Id),
--Content ntext not null,
--Length int default 0,
--Date datetime default CURRENT_DATE Not Null,
--Reviews int default 0,
--UserId uniqueidentifier foreign key references Users(Id),
--);

--Create table Categories (
--Id int primary key identity(1,1),
--Name nvarchar(128) NOT NULL UNIQUE,
--Description nvarchar(512) default 'No Description',
--);


---- Arac Kiralama
--CREATE DATABASE RentalDB;
--GO
--USE RentalDB;
--GO

--CREATE TABLE Brands (
--    Id INT PRIMARY KEY IDENTITY(1,1),
--    Name NVARCHAR(64) NOT NULL UNIQUE,
--);

--CREATE TABLE Users ( 
--    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(), 
--    FirstName NVARCHAR(128) NOT NULL,
--    LastName NVARCHAR(128) NOT NULL,
--    Email NVARCHAR(128) NOT NULL UNIQUE,
--    PasswordHash NVARCHAR(256) NOT NULL, 
--    PhoneNumber NVARCHAR(20),
--    IdentityNumber NVARCHAR(11) UNIQUE, 
--    CreatedAt DATETIME DEFAULT GETDATE(),
--);

--CREATE TABLE Cars (
--    Id INT PRIMARY KEY IDENTITY(1,1),
--    BrandId INT FOREIGN KEY REFERENCES Brands(Id),
--    Model NVARCHAR(128) NOT NULL,
--    Year INT CHECK (Year > 2000),
--    Color NVARCHAR(64),
--    Plate NVARCHAR(20) NOT NULL UNIQUE,
--    Kilometer INT DEFAULT 0,
--    DailyPrice SMALLMONEY NOT NULL CHECK (DailyPrice > 0),
--    FuelType NVARCHAR(20), 
--    Transmission NVARCHAR(20),
--    IsAvailable BIT DEFAULT 1, 
--    CreatedAt DATETIME DEFAULT GETDATE(),
--);

--CREATE TABLE Rentals (
--    Id INT PRIMARY KEY IDENTITY(1,1),
--    CarId INT FOREIGN KEY REFERENCES Cars(Id),
--    UserId UNIQUEIDENTIFIER FOREIGN KEY REFERENCES Users(Id),
--    RentDate DATETIME NOT NULL DEFAULT GETDATE(),
--    ReturnDate DATETIME, --
--    PlannedReturnDate DATETIME NOT NULL,
--    StartKilometer INT,
--    EndKilometer INT,
--    TotalPrice SMALLMONEY,
    
--    CONSTRAINT CK_RentalDates CHECK (PlannedReturnDate >= RentDate)
--);

--CREATE TABLE Payments (
--    Id INT PRIMARY KEY IDENTITY(1,1),
--    RentalId INT FOREIGN KEY REFERENCES Rentals(Id),
--    PaymentDate DATETIME DEFAULT GETDATE(),
--    Amount SMALLMONEY NOT NULL,
--    PaymentType NVARCHAR(50),
--);

---- SQL Normalizasyon : İliskisel veri tabanlarında veri tekrarını (redundancy) en aza indirmek, veri tutarlılığını sağlamak ve anomalileri (güncelleme / silme hataları) önlemek için tabloların
---- belirli kurallar çerçevesinde yapılandırılması işlemidir. Verileri daha düzenli performansı ve bütünlük içinde depolanmasını sağlar.
---- Stitch

--Create Table Ogrenciler (
--    Id int primary key identity(1,1),
--    Ad nvarchar(128) not null,
--    Soyad nvarchar(128) not null,
--    TCKN char(11) not null unique,
--    KayitTarih smalldatetime default getdate()     
--);

--Create Table Dersler (
--    Id int primary key identity(1,1),
--    Ad nvarchar(128) not null unique,
--    Kod nvarchar(128) not null unique,
--);

--Create Table OgrenciDersler (
--    Id int primary key identity(1,1),
--    OgrenciId int foreign key references Ogrenciler(Id),
--    DersId int foreign key references Dersler(Id),
--    KayıtTarih smalldatetime default getdate()
--);

-- Kutuphane Otomasyon Veritabanı

--Create Database LibraryDB;
--Use LibraryDB;

--Create Table Users (
--Id int primary key identity(1,1),
--FirstName nvarchar(128) not null,
--LastName nvarchar(128) not null,
--CreatedDate datetime not null default getdate()
--);

--Create Table Profile (
--Id int primary key identity(1,1),
--UserId int unique foreign key references Users(Id)
--);

--Create Table Categories (
--Id int primary key identity(1,1),
--Name nvarchar(128) not null unique,
--);

--Create Table Authors (
--Id int primary key identity(1,1),
--FirstName nvarchar(128) not null,
--LastName nvarchar(128) not null,
--);

--Create Table Books (
--Id int primary key identity(1,1),
--AuthorId int foreign key references Authors(Id),
--CategoryId int foreign key references Categories(Id),
--ISBN char(13) not null unique,
--);


--Create Table Renting (
--Id int primary key identity(1,1),
--AuthorId int foreign key references Authors(Id),
--BookId int foreign key references Books(Id),
--UserId int foreign key references Users(Id),
--CreatedDate datetime not null default getdate(),
--);

--Create Database ECommerceDb;
--Use EcommerceDb;

--Create Table Categories (
--    Id int primary key identity(1,1),
--    Name nvarchar(128) not null,
--);

--Create Table Products (
--    Id int primary key identity(1,1),
--    Name nvarchar(128) not null,
--    Price smallmoney not null default 0,
--    Stock int not null default 0,
--    CategoryId int foreign key references Categories(Id),
--);

--Create Table Customers (
--    Id int primary key identity(1,1),
--    email nvarchar(128) not null unique,
--    password nvarchar(128) not null,
--    FirstName nvarchar(128) not null,
--    LastName nvarchar(128) not null,
--);

--Create Table Orders (
--    Id int primary key identity(1,1),
--    CustomerId int foreign key references Customers(Id),
--    OrderDate datetime not null default getdate(),
--);

--Create Table OrderDetails (
--    Id int primary key identity(1,1),
--    OrderId int foreign key references Orders(Id),
--    ProductId int foreign key references Products(Id),
--    Quantity int not null default 1,
--    Total smallmoney not null,
--);

--Create Table Shipments (
--    Id int primary key identity(1,1),
--    Name nvarchar(128) not null,
--    Adress nvarchar(128) not null,
--    OrderId int foreign key references Orders(Id),
--);

--Create Table Payments (
--    Id int primary key identity(1,1),
--    OrderId int foreign key references Orders(Id),
--    Method nvarchar(128) not null,
--    Total smallmoney not null,
--);

-- DML - Data Manipulation Language
-- INSERT INTO
--Insert Into tablo_adi (kolon1, kolon2, koloni, ...)
--Values (deger1, deger2, degeri, ...);
--Insert Into Categories(Name)
--Values ('Clothing');

--Insert Into Categories
--Values ('Electronics');

--Select * From Categories
--Select * From Customers
--Select * From Products

--Insert Into Customers
--Values 
--('ipek@bambicim.com', 'Admin1234!', 'İpek', 'Bayrak'), 
--('mertbayrak023@.com', 'Test1234!', 'İpek', 'Bayrak');



--Insert Into Products
--Values ('Macbook',37500,12,2);

---- UPDATE

--Update Customers 
--Set email = 'ipek@bamcicim.com'
--Where Id = 1;

---- DELETE
--Delete Customers
--Where Id = 2;

--use Northwind;
--select * from Products
--select UnitPrice,ProductName from Products Order By UnitPrice Desc ;
--Select Distinct Country From Customers;
--Select * From Customers Where Country = 'Germany';

--Select * From Products
--Where UnitPrice > 100;

--SELECT * FROM Products
--Where UnitPrice BETWEEN 20 AND 30;

--Select * From Products
--Where ProductName Between 'Chai' AND 'Konbu';

--Select * From Orders
--Where OrderDate Not Between '1996-07-01' AND '1997-07-31';

--Select * From Customers
--Where Country In ('UK','France','Germany');

--Select * From Customers
--Where CompanyName Like 'A%';

--Select * From Customers
--Where CompanyName Like '%a';


--Select * From Customers
--Where CompanyName Like '%a%';

--Select * From Customers
--Where City Like 'Lo____';

--Select * From Customers
--Where CompanyName Like 'b%s';

--Select * From Employees
--Where Notes Like '%toast%'

-- Soru : Brezilya'da olmayan musteriler
--Select * From Customers
--Where Not Country = 'Brazil'

--Select FirstName,LastName,BirthDate 
--From Employees
--Where FirstName Like 'A%';

--Select OrderId,OrderDate
--From Orders
--Where OrderDate Between '1996-01-01' AND '1996-12-31' 
--And ShipCity = 'London';

--Select * From Products
--Order By UnitPrice Desc;

--Select * From Customers
--Order By CompanyName Asc, City Desc;

--Select * From Customers
--Order By ContactName;

--Select Top 5 * From Products;
--Select Top 25 Percent * From Products;

--Select Top 3 * From Products
--Order By UnitPrice Desc;

-- AGGREGATE FUNCTIONS
-- MIN() 
--Select Min(UnitPrice) Min_Price From Products;
-- MAX()
--Select Max(UnitPrice) Max_Price From Products;
-- COUNT()
--Select Count(UnitPrice) Total_Price_Units From Products;
--Select Count(Distinct UnitPrice) Distinct_Prices From Products;
-- SUM()
--Select Sum(UnitPrice) Toplam From Products;
-- AVG()
--Select Avg(UnitPrice) Ortalama From Products;

--Select Count(*) Category_1 From Products
--Where CategoryID = 1;

--Select Count(*) Number_Of_Orders FROM Orders
--Where CustomerID = 'ALFKI';

--Select Sum((UnitPrice * Quantity) * (1 - Discount)) As [Toplam Ciro] 
--From [Order Details]

--Select od.Discount From [Order Details] as od

--SubQuery, InnerQuery

--Select Top 1 ProductName From Products as p
--Order By UnitPrice Desc;

--Select Max(UnitPrice) From Products as p 

--Select * From Products
--Where UnitPrice = (Select Max(UnitPrice) From Products);

--Select * From Products
--Where UnitPrice > (Select Avg(UnitPrice) From Products)
--Order By UnitPrice;


--Select Top 1 od.OrderId, Sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) as [Toplam Ciro]
--From [Order Details] as od
--Group By od.OrderID
--Order By 2 ;

--Select CategoryID,Sum(UnitsInStock) as Number From Products as p 
--Group By p.CategoryID 

--Select ProductID as ProductID,Sum(Quantity) as Quantity From [Order Details] as od
--Group By ProductID
--Having Sum(od.Quantity) > 1000;

--Select CustomerID,CompanyName From Customers as c
--Where CustomerID not in (Select Distinct CustomerId From Orders as ord);

-- Null Values
--Select * From Customers
--Where Fax is null And Region is null;

-- Join
-- Inner Join
-- Left Join (Left Outer Join) 
-- Right Join  (Right Outer Join)
-- Full Join (Full Outer Join)

--Select p.ProductID,p.ProductName,c.CategoryName From Products as p
--Inner Join Categories as c
--on p.CategoryID = c.CategoryID

--Select p.ProductID,p.ProductName,s.CompanyName From Products as p
--Inner Join Suppliers as s
--on p.SupplierID = s.SupplierID

--Select p.ProductName, c.CategoryName, s.CompanyName From Products as p
--Inner Join Categories as c
--on p.CategoryID = c.CategoryID
--Inner Join Suppliers as s
--on p.SupplierID = s.SupplierID

--Select o.OrderID,o.OrderDate,sh.CompanyName From Orders as o
--Inner Join Shippers as sh
--On o.ShipVia = sh.ShipperID

--Select s.CompanyName,Sum(ShipVia) as Siparis_Tasima From Orders as o
--Inner Join Shippers as s
--on o.ShipVia = s.ShipperID
--Group By CompanyName

--Select c.Title, c.FirstName + '' + c.LastName as Patron, m.FirstName + '' + m.LastName as Calisan 
--From Employees as m
--Inner Join Employees as c
--On c.EmployeeID = m.ReportsTo
--Order By 2;

--Select e.FirstName + ' ' + e.LastName as Calisan, Sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) as [Toplam Satıs] From Orders as o
--Inner Join [Order Details] as od
--On o.OrderID = od.OrderID
--Inner Join Employees as e
--On o.EmployeeID = e.EmployeeID
--Group By e.FirstName, e.LastName
--Order By 2 Desc;

--Select Country as Country,Count(Country) as [Number of Suppliers] FROM Suppliers
--Where Country = 'Japan'
--Group By Country

--Select ShipCountry, Sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) as Satis From Orders o
--Inner Join [Order Details] as od
--On o.OrderID = od.OrderID
--Group By ShipCountry
--Order By 2 Desc;

--Select TOP 3 c.CompanyName, Sum(od.UnitPrice * od.Quantity * (1 - od.Discount)) as Satis, Sum(Quantity) as Urunler  From Orders as o
--Inner Join [Order Details] as od
--On o.OrderID = od.OrderID
--Inner Join Customers as c
--On o.CustomerID = c.CustomerID
--Group By c.CompanyName
--Order By 2 Desc;


--Select * From [Order Details] od
--Where od.Quantity > (Select AVG(Quantity) From [Order Details])
--Order By od.Quantity Desc;

--Select * From Employees
--Where Month(BirthDate) = Month(GETDATE())
--AND Day(BirthDate) = Day(GetDate());

--Select OrderID, DATEDIFF(DAY,RequiredDate,ShippedDate) AS Delay From Orders
--Where DATEDIFF(DAY,RequiredDate,ShippedDate) > 0
--Order By 2 Desc;


--Select c.CompanyName, Count(o.OrderID) Count From Customers as c
--Left Join Orders as o
--On c.CustomerID = o .CustomerID
--Group By c.CompanyName
--Order By 2

-- UNION : İki veya daha fazla Select sorgusunun sonuclarını tek bir sonuc kumesinde alt alta birlestiren bir operatordur
-- Bu islem farki tablodaki veya ayni tablodaki farklı kosullardan gelen verileri tek bir liste gibi gormenizi saglar
-- Sutun sayisi : Birlestirilen tum Select ifadeleri aynı sutuna sahip olmalıdır
-- Veri tipleri : Aynı siradaki sutunların veri tipleri birbirine benzer veya uyumlu olmalıdır
-- Benzersizlik : Varsayılan Union operatoru sonuc kumesinceki yinelenen satırları otomatik olarak siler ve sadece benzersiz kayıtları getirir

--Select City, Country From Customers
--Union
--Select City, Country From Suppliers

--Select City From Customers
--Union All
--Select City From Suppliers

--Select 'S' As Type, s.ContactName, s.Phone From Suppliers s
--Union 
--Select 'C' As Type, c.ContactName, c.Phone From Customers c

-- Intersect : İki veya daha fazla Select sorgusunun sonuc kumeleri arasındaki ortak (kesisen) kayıtları donduren bir operatordur
-- Sadece her iki sorgudada mevcut olan benzersiz satırları getirir
-- Ortak Kayıtlar : Sadece her iki sonuc kumesinde de bulunan benzersiz satırları dondurur 
-- Sutun Eslesmesi : Birlestirilern sorguların sutun sayıları ve veri tipleri aynı olmalıdır.
-- Tekrarlanan Veriler : Varsayılan olarak benzersiz sonuclar dondurur
-- Kullanım yeri : Genellikle iki tablo arasında karsılastırma yapmak icin kullanılır

--Select p.ProductID From Products as p
--Intersect
--Select od.ProductID From [Order Details] as od

-- Except : Birinci Select sorgusunun sonuc kumesinde bulunan ancak ikinci Select sorgunsunun sonuc kumesinde yer almayan benzersiz kayıtları donduren bir operatordur.
-- İki tablo arasındaki verisel farkı bulmak sadece bir tabloda mevcut olan satırları lislemek icin kullanılır
-- Temel Amac : İki sorgu arasındaki farkı bulmaktır.
-- İsleyis : A - B islemini yapar.
-- Benzersizlik : Sadece benzersiz kayıtları dondurur
-- Kurallar : İki Select sorgusundaki sutun sayisi, veri tipleri ve sutun siraları aynı olmalıdır

--Select c.CustomerID From Customers as c
--Except
--Select o.CustomerID From Orders as o

-- Matematiksel Fonksiyonlar --
-- Round
--Select Round(235.412, 2) As Yuvarla
-- Ceiling
--Select Ceiling(235.412) As Tavan
-- Floor
--Select Floor(235.412) As Taban
-- Mod
--Select 235 % 2 As Mod

-- Metinsel Fonksiyonlar --
-- Left
--Select Left('Merhaba Dunya', 3) as MetniSoldanKes 
-- Right
--Select Right('Merhaba Dunya', 3) as MetniSagdanKes
-- Len
--Select Len('SQL Ogreniyorum') as MetninUzunlugu
-- Replace
--Select REPLACE('SQL Ogreniyorum', 'O', 'Ö') as HarfSozcukDegistir
--Select REPLACE('SQL Ogreniyorum', 'SQL', 'C#') as HarfSozcukDegistir
-- Substring
--Select SubString('SQL Ogreniyorum', 1, 3) as [Metni Diledigin Yerden İstedigin Kadar Kes]
-- Lower
--Select Lower('BAGIRMASANA LAN') as Kucultme
-- Upper
--Select Upper('bagırsana lan') as Buyutme
-- Reverse
--Select Reverse('SQL Ogreniyorum') as TersdenYazdım
-- LTrim
--Select LTrim('     SQL Ogreniyorum',3) as SoldanBoslukTemizle
-- RTrim
--Select LTrim('SQL Ogreniyorum       ',4) as SagdanBoslukTemizle
-- Trim
--Select  Trim('      SQL Ogreniyorum       ',4) as SagdanSOldanBoslukTemizle

-- UDF (User Defined Function) -- 
-- RDBMS (Relational Database Management System) yerlesik fonksiyonların yetersiz kaldıgı durumlarda
-- kullanıcıların kendi karmasık mantıklarını olusturup, veritabanında saklayabildikleri ve calıstırabildikleri 
-- ozellestirilmis fonksiyonlardır.

-- UDF Turleri : 
-- 1. Scalar Functions : Giris parametrelerine baglı olarak tek bir deger dondurur.
--Create Function Hesapla(@Sayi1 float, @Sayi2 float)
--Returns float
--As
--Begin
--    return @Sayi1 * @Sayi2
--End

--Select dbo.Hesapla(5,78) as Carpim

--Alter Function ToplamCiro(@Price money, @Quantity smallint, @Discount real)
--Returns money
--As
--Begin
--    return @Price * @Quantity * (1 - @Discount)
--End

--Select dbo.ToplamCiro(10,10,0.1)

--Create Function FiyatArtisYuzde(@Fiyat smallmoney, @Zam float)
--Returns float
--As
--Begin
--    Declare @Value float
--    Set @Value = @Fiyat * (1 + (@Zam / 100))
--    return @Value
--End

--Select p.ProductName, dbo.FiyatArtisYuzde(p.UnitPrice, 25) as [Zamli Fiyat] From Products as p

-- 2. Table-Valued Functions : Sonuc olarak bir tablo dondurur.

--Create Function CustomerProductDetails(@Id nchar(5))
--Returns Table
--As
--Return
--(
--    Select p.ProductName, p.UnitPrice From Customers c
--    Join Orders o On c.CustomerId = o.CustomerID
--    Join [Order Details] od On o.OrderID = od.OrderID
--    Join Products p on od.ProductID = p.ProductID
--    Where c.CustomerId = @Id
--);

--Select * From CustomerProductDetails('ANTON')
--Order By 2 Desc;

-- 3. Çok Deyimli Tablo Donduren : Fonksiyon icerisinde sanal bir tablo olusturabilir ve bu tabloya mudahele edilinebilir.

--CREATE FUNCTION GetProduct(@Id int) 
--RETURNS @ProductsOfCustomer TABLE
--(
--    Id int,
--    Name nvarchar(100),
--    Category nvarchar(50)
--)
--AS
--BEGIN
--    IF @Id < 0
--    BEGIN
--        INSERT INTO @ProductsOfCustomer (Id, Name, Category)
--        VALUES (0, 'Invalid ID Provided', 'System Error')
--    END
--    ELSE
--    BEGIN
--        INSERT INTO @ProductsOfCustomer
--        SELECT p.ProductID, p.ProductName, c.CategoryName
--        FROM Products p
--        JOIN Categories c ON p.CategoryID = c.CategoryID
--        WHERE p.ProductID = @Id
--    END

--    RETURN;
--END

-- VIEW (GÖRÜNÜM): 
-- Bir veya daha fazla tablodaki verilerin birleşiminden oluşan, 
-- fiziksel olarak yer kaplamayan "sanal bir tablo"dur. 
-- Karmaşık JOIN sorgularını basitleştirmek ve veri güvenliğini 
-- sağlamak amacıyla kullanılır. 

-- Sanal Yapı: 
-- View'lar disk üzerinde gerçek veriyi değil, sadece SQL sorgusunu saklar. 
-- Bellekte (RAM) geçici olarak oluşurlar, veritabanında ekstra yer kaplamazlar.

-- Güncellik: 
-- View her çağrıldığında (SELECT yapıldığında) bağlı olduğu tablolardan 
-- en güncel veriyi çeker. Yani ana tablodaki bir değişiklik anında View'a yansır.

-- Kullanım Kolaylığı: 
-- Çok uzun ve karmaşık JOIN içeren sorguları bir kez View olarak kaydedip, 
-- sanki tek bir tabloymuş gibi kolayca "SELECT * FROM View_Adi" diyerek 
-- çağırmanıza olanak tanır. Kod karmaşasını (Code Smell) önler.

--Create View UrunDetayView As
--Select p.ProductId, p.ProductName, c.CategoryName, s.CompanyName From Products As p
--Join Categories c On p.CategoryID = c.CategoryID
--Join Suppliers s On p.SupplierID = s.SupplierID

--Select * From UrunDetayView

--Create View SiparisListesiView 
--With Encryption
--As
--Select c.CustomerID, c.CompanyName, o.OrderID, o.OrderDate, o.ShipCountry From Orders o
--Join Customers c On o.CustomerID = c.CustomerID

-- STORED PROCEDURE (SAKLI YORDAM): 
-- Veritabanı üzerinde saklanan, parametre alabilen ve önceden 
-- derlendiği için çok hızlı çalışan "SQL fonksiyonları"dır.
-- Kod tekrarını önler ve iş mantığını (Business Logic) 
-- veritabanı seviyesinde çözmemizi sağlar.

-- Hız ve Performans: 
-- İlk kez çalıştırıldığında derlenir ve "Execution Plan" oluşturulur. 
-- Sonraki çağrılarda tekrar derlenmez, bu yüzden standart SQL 
-- sorgularından çok daha hızlı sonuç verir.

-- Güvenlik (Security): 
-- Kullanıcılara tabloların tamamına erişim vermek yerine, sadece 
-- belirli bir SP'yi çalıştırma yetkisi vererek veriyi koruruz. 
-- Ayrıca "SQL Injection" saldırılarına karşı doğal bir kalkandır.

-- Merkezi Yönetim: 
-- İş mantığında bir değişiklik yapman gerektiğinde (örneğin indirim 
-- hesaplama formülü), C# kodunu değiştirmek yerine sadece SP'yi 
-- güncelleyerek tüm sistemi saniyeler içinde güncelleyebilirsin.


--CREATE PROCEDURE sp_GetProductWithCategory
--    @Id INT
--AS
--BEGIN
--    SELECT p.ProductID, p.ProductName, c.CategoryName 
--    FROM Products p
--    INNER JOIN Categories c ON p.CategoryID = c.CategoryID
--    WHERE p.ProductID = @Id;
--END

--EXEC sp_GetProductWithCategory @Id = 5

--Create Proc sp_GetCustomerById
--    @Id nchar(5)
--AS
--BEGIN
--    Select * From Customers
--    Where CustomerID = @Id;
--END

--EXEC sp_GetCustomerById @Id = 'ANTON'

--Select * From Shippers

--CREATE PROCEDURE sp_InsertShippers
--    @CompanyName nvarchar(40),
--    @Phone nvarchar(24)
--AS
--BEGIN
--    Insert Into Shippers (CompanyName, Phone)
--    Values (@CompanyName, @Phone);

--    Select SCOPE_IDENTITY() AS NewID;
--END

--CREATE PROCEDURE sp_UpdateShippers
--    @Id int, 
--    @CompanyName nvarchar(40),
--    @Phone nvarchar(24)
--AS
--BEGIN
--    Update Shippers
--    Set CompanyName = @CompanyName,
--        Phone = @Phone
--    Where ShipperID = @Id;

--    Select * From Shippers Where ShipperID = @Id;
--END

--Create Procedure sp_DeleteShippers
--    @Id nchar(5)
--AS
--BEGIN
--    Delete From Shippers
--    Where ShipperID = @Id

--    Select * From Shippers;
--END

-- TRIGGER : Bir tabloda Insert, Update veya Delete gibi belirli bir olar gerceklestiginde otomatik olarak calısan bir yapıdır.
-- Veri butunlugunu korumak, islemleri otomatiklestirmek ve yapılan degisikleri loglamak icin kullanılır.

-- Otomatik Calısma : Kullanıcı tarafından manuel olarak calıstırılamaz. Tanımlanan olay gerceklestiginde devreye girer.
-- (After / Before / Instead Of)

-- Veri Butunlugu : Iliskili tablolarda tutarlılıgı saglamak icin kullanılır. Ornegin stok tablosundan urun silinilirse
-- satis tablosundaki ilgili kaydıda silmek guncellemek gibi ..

-- Denetim : Bir tabloda yapılan degisikliklerin kim tarafından ve ne zaman yapıldıgını baska bir tabloda tutmak icin idealdir.

--Create Trigger UpdateStockQuantity On [Order Details]
--After Insert
--As
--Begin
--    Declare @ProductId int
--    Declare @Quantity smallint
--    Select @ProductId = ProductId , @Quantity = Quantity From Inserted

--    Select p.ProductID, p.ProductName, p.UnitsInStock From Products p 
--    Where p.ProductID = @ProductId

--    Update Products
--    Set UnitsInStock -= UnitsInStock - @Quantity
--    Where ProductID = @ProductId

--    Select p.ProductID, p.ProductName, p.UnitsInStock From Products p 
--    Where p.ProductID = @ProductId
--End;

--Create Trigger SoftDelete on Personel
--Instead of Delete
--As
--Begin
--    Declare @Id int
--    Select @Id = From deleted
--    Update Personel
--    Set SilindiMi = 1
--    Where Id = @Id
--End

-- E-Ticaret Veri Tabanı --
-- Kategoriler
-- Urunler
-- Kullanıcılar
-- Adresler
-- Odemeler
-- Odeme Turleri
-- Siparisler
-- Siparis Detayları
-- Kargocular

--Create Database IT_ETicaret;
--Go
--USE IT_ETicaret;
--GO

--CREATE TABLE Kategoriler (
--    Id INT PRIMARY KEY IDENTITY(1,1),
--    Isim NVARCHAR(64) NOT NULL,
--    Acıklama NVARCHAR(256),
--    EklenmeTarihi DATETIME NOT NULL DEFAULT GETDATE(),
--    GuncellenmeTarihi DATETIME,
--    SilinmeTarihi DATETIME,
--    SilindiMi BIT NOT NULL DEFAULT 0
--);

--CREATE TABLE Urunler (
--    Id INT PRIMARY KEY IDENTITY(1,1),
--    KategoriId INT FOREIGN KEY REFERENCES Kategoriler(Id),
--    Isim NVARCHAR(64) NOT NULL,
--    Fiyat SMALLMONEY NOT NULL,
--    Acıklama NVARCHAR(512), 
--    EklenmeTarihi DATETIME NOT NULL DEFAULT GETDATE(),
--    GuncellenmeTarihi DATETIME,
--    SilinmeTarihi DATETIME,
--    SilindiMi BIT NOT NULL DEFAULT 0
--);

--CREATE TABLE Kullanıcılar (
--    Id INT PRIMARY KEY IDENTITY(1,1),
--    KullanıcıAdı NVARCHAR(64) NOT NULL,
--    Email NVARCHAR(64) NOT NULL,
--    Sifre NVARCHAR(64) NOT NULL,
--    EklenmeTarihi DATETIME NOT NULL DEFAULT GETDATE(),
--    GuncellenmeTarihi DATETIME,
--    SilinmeTarihi DATETIME,
--    SilindiMi BIT NOT NULL DEFAULT 0
--);

--CREATE TABLE Adresler (
--    Id INT PRIMARY KEY IDENTITY(1,1),
--    KullaniciId INT FOREIGN KEY REFERENCES Kullanıcılar(Id),
--    Ulke NVARCHAR(64) NOT NULL,
--    Il NVARCHAR(64) NOT NULL,
--    Ilçe NVARCHAR(64) NOT NULL,
--    PostaKodu NVARCHAR(20) NOT NULL,
--    Detay NVARCHAR(256) NOT NULL,
--    EklenmeTarihi DATETIME NOT NULL DEFAULT GETDATE(),
--    GuncellenmeTarihi DATETIME,
--    SilinmeTarihi DATETIME,
--    SilindiMi BIT NOT NULL DEFAULT 0
--);

--CREATE TABLE OdemeTurleri (
--    Id INT PRIMARY KEY IDENTITY(1,1),
--    OdemeTipi NVARCHAR(64) NOT NULL,
--    NakitMi BIT NOT NULL DEFAULT 0,
--    TaksitSayısı SMALLINT NOT NULL DEFAULT 1,
--    EklenmeTarihi DATETIME NOT NULL DEFAULT GETDATE(),
--    GuncellenmeTarihi DATETIME,
--    SilinmeTarihi DATETIME,
--    SilindiMi BIT NOT NULL DEFAULT 0
--);

--CREATE TABLE Odemeler (
--    Id INT PRIMARY KEY IDENTITY(1,1),
--    SiparisId INT NOT NULL,
--    OdemeTurId INT FOREIGN KEY REFERENCES OdemeTurleri(Id),
--    OdemeTarihi DATETIME NOT NULL DEFAULT GETDATE(),
--    Tutar MONEY NOT NULL,
--    OdemeDurumu BIT NOT NULL DEFAULT 0, 
--    IslemNo NVARCHAR(128), 
--    EklenmeTarihi DATETIME NOT NULL DEFAULT GETDATE(),
--    GuncellenmeTarihi DATETIME,
--    SilinmeTarihi DATETIME,
--    SilindiMi BIT NOT NULL DEFAULT 0
--);

--CREATE TABLE Kargocular (
--    Id INT PRIMARY KEY IDENTITY(1,1),
--    SirketAdı NVARCHAR(64) NOT NULL,
--    Telefon NVARCHAR(24),
--    EklenmeTarihi DATETIME NOT NULL DEFAULT GETDATE(),
--    GuncellenmeTarihi DATETIME,
--    SilinmeTarihi DATETIME,
--    SilindiMi BIT NOT NULL DEFAULT 0
--);

--CREATE TABLE Siparisler (
--    Id INT PRIMARY KEY IDENTITY(1,1),
--    KullanıcıId INT FOREIGN KEY REFERENCES Kullanıcılar(Id),
--    AdresId INT FOREIGN KEY REFERENCES Adresler(Id),
--    KargoId INT FOREIGN KEY REFERENCES Kargocular(Id),
--    OdemeTurId INT FOREIGN KEY REFERENCES OdemeTurleri(Id),
--    SiparişTarihi DATETIME NOT NULL DEFAULT GETDATE(),
--    ToplamTutar MONEY NOT NULL,
--    GuncellenmeTarihi DATETIME,
--    SilinmeTarihi DATETIME,
--    SilindiMi BIT NOT NULL DEFAULT 0
--);

--CREATE TABLE SiparisDetay (
--    Id INT PRIMARY KEY IDENTITY(1,1),
--    SiparisId INT FOREIGN KEY REFERENCES Siparisler(Id),
--    ÜrünId INT FOREIGN KEY REFERENCES Urunler(Id),
--    Adet SMALLINT NOT NULL DEFAULT 1,
--    BirimFiyat SMALLMONEY NOT NULL,
--    EklenmeTarihi DATETIME NOT NULL DEFAULT GETDATE(),
--    GuncellenmeTarihi DATETIME,
--    SilinmeTarihi DATETIME,
--    SilindiMi BIT NOT NULL DEFAULT 0
--);

--Create Database IT_EV_ChargeStation;
--GO
--USE IT_EV_ChargeStation;
--GO
--Create Table Users
--(
--    Id int primary key identity(1,1),
--    UserName nvarchar(64) not null,
--    PasswordHash nvarchar(64) not null,
--    Email nvarchar(64) not null unique,
--    CreatedAt datetime not null default getdate(),
--    UpdatedAt datetime,
--    DeletedAt datetime,
--    IsDeleted bit not null default 0
--);
--Create Table Stations
--(    
--    Id int primary key identity(1,1),
--    Name nvarchar(64) not null unique,
--    CreatedAt datetime not null default getdate(),
--    ChargerCapacity smallint not null default 1,
--    City nvarchar(64) not null,
--    District nvarchar(64) not null,
--    Address nvarchar(64) not null,
--    UpdatedAt datetime,
--    DeletedAt datetime,
--    IsDeleted bit not null default 0
--);
--Create Table Chargers
--(    
--    Id int primary key identity(1,1),
--    Status nvarchar(24) not null,
--    ConnectorType nvarchar(24) not null,
--    PowerOutput smallint not null,
--    StationId int foreign key references Stations(Id),
--    Charge smallint not null default 100,
--    CreatedAt datetime not null default getdate(),
--    UpdatedAt datetime,
--    DeletedAt datetime,
--    IsDeleted bit not null default 0
--);
--Create Table Bookings
--(    
--    Id int primary key identity(1,1),
--    UserId int foreign key references Users(Id),
--    StationId int foreign key references Stations(Id),
--    StartTime datetime not null default getdate(),
--    EndTime datetime not null default getdate(),
--    Status nvarchar(24) not null,
--    Pricing smallmoney not null default 0 check (Pricing > 0),
--    ChargerId int foreign key references Chargers(Id),
--    CreatedAt datetime not null default getdate(),
--    UpdatedAt datetime,
--    DeletedAt datetime,
--    IsDeleted bit not null default 0
--);
--Create Table Transactions
--(    
--    Id int primary key identity(1,1),
--    Amount smallmoney not null default 0 check (Amount > 0),
--    Status nvarchar(24) not null,
--    Method nvarchar(24) not null,
--    UserId int foreign key references Users(Id),
--    StationId int foreign key references Stations(Id),
--    ChargerId int foreign key references Chargers(Id),
--    CreatedAt datetime not null default getdate(),
--    UpdatedAt datetime,
--    DeletedAt datetime,
--    IsDeleted bit not null default 0
--);
--Create Table UsageLogs
--(    
--    Id int primary key identity(1,1),
--    ChargerId int foreign key references Chargers(Id),
--    UserId int foreign key references Users(Id),
--    EnergyConsumed smallint not null,
--    Duration int not null default 0,
--    SessionStart datetime not null default getdate(),
--    SessionEnd datetime not null default getdate(),
--    CreatedAt datetime not null default getdate(),
--    UpdatedAt datetime,
--    DeletedAt datetime,
--    IsDeleted bit not null default 0
--);