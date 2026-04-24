# SQL Study Notes — Internship Progress

A structured collection of SQL concepts, schema designs, and queries written during my internship.  
All examples target **Microsoft SQL Server (T-SQL)**.

---

## 📁 Structure

| Folder | Contents |
|---|---|
| `01_concepts/` | DDL theory, constraints, indexes, normalization |
| `02_schemas/` | Database schema designs (CREATE TABLE scripts) |
| `03_queries/` | DML and SELECT query practice (Northwind DB) |
| `04_advanced/` | Functions, Views, Stored Procedures, Triggers |

---

## 🗄️ Schemas

| File | Description |
|---|---|
| `BlogDB.sql` | Users, Articles, Categories |
| `RentalDB.sql` | Car rental system (Brands, Cars, Users, Rentals, Payments) |
| `NormalizationDB.sql` | Student-course normalization example |
| `LibraryDB.sql` | Library automation (Users, Books, Authors, Categories) |
| `ECommerceDB.sql` | E-commerce (Products, Orders, Customers, Shipments) |
| `IT_ETicaret.sql` | Turkish e-commerce DB with soft-delete pattern |
| `IT_EV_ChargeStation.sql` | EV charging station management system |

---

## 🔍 Query Topics Covered

- SELECT, WHERE, ORDER BY, TOP
- BETWEEN, IN, LIKE, NULL checks
- Aggregate Functions (MIN, MAX, COUNT, SUM, AVG)
- GROUP BY, HAVING
- Subqueries
- JOINs (INNER, LEFT, RIGHT, FULL, Self-Join)
- UNION, INTERSECT, EXCEPT

## ⚙️ Advanced Topics Covered

- Scalar UDFs, Table-Valued Functions, Multi-Statement TVFs
- Views (with ENCRYPTION option)
- Stored Procedures (CRUD + SCOPE_IDENTITY)
- Triggers (AFTER INSERT, INSTEAD OF DELETE)
