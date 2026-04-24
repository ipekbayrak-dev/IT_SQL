-- =============================================================
-- DDL CONCEPTS
-- Core Data Definition Language theory and syntax reference.
-- =============================================================

-- CREATE TABLE syntax:
-- CREATE TABLE table_name (
--     column1 data_type constraints,
--     column2 data_type constraints
-- );

-- DROP TABLE   : Permanently deletes the selected table.
-- TRUNCATE TABLE : Deletes all rows inside the table, keeps the structure.
-- ALTER TABLE  : Modifies an existing table structure.

-- Example: Add a column
-- ALTER TABLE Vatandas
-- ADD Email NVARCHAR(128);

-- DROP COLUMN  : Removes a specific column from a table.
-- ALTER TABLE Vatandas
-- DROP COLUMN Email;


-- =============================================================
-- SQL CONSTRAINTS
-- Rules enforced on columns to maintain data integrity.
-- =============================================================

-- NOT NULL     : Ensures a column cannot store NULL values.
-- DEFAULT      : Provides a fallback value when no value is supplied.
-- UNIQUE       : Ensures every value in a column is distinct.
-- CHECK        : Validates that values meet a specified condition.

-- PRIMARY KEY (PK) - Birincil Anahtar:
--   Uniquely identifies every row in a table.
--   Implicitly applies both NOT NULL and UNIQUE.
--   A table can have only ONE primary key.
--   Common types: INT (with IDENTITY) or UNIQUEIDENTIFIER (GUID).

-- FOREIGN KEY (FK) - İkincil Anahtar:
--   Creates a relationship between two tables.
--   References the PRIMARY KEY of another table.

-- INDEX:
--   Speeds up data retrieval on frequently queried columns.
--   Similar to a book's index — a sorted structure for fast lookup.
--   Do NOT index every column:
--     - Only index columns used frequently in WHERE / JOIN / ORDER BY.
--     - Too many indexes slow down INSERT / UPDATE / DELETE operations.


-- =============================================================
-- SQL NORMALIZATION
-- =============================================================

-- Normalization organizes tables to:
--   - Minimize data redundancy.
--   - Ensure data consistency.
--   - Prevent anomalies (update / delete / insert errors).

-- 1NF : Each column holds atomic (indivisible) values; no repeating groups.
-- 2NF : Satisfies 1NF + every non-key column is fully dependent on the whole PK.
-- 3NF : Satisfies 2NF + no transitive dependencies between non-key columns.
