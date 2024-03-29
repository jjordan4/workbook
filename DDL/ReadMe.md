# Databases, Servers, and SSMS

- SQL Server
  - Software that runas as a *service* on the computer.
  - Multiple instances of SQL Server can be installed on the same computer.
    - Default Instance - the name of the computer, or `.` to represent the "local machine"
    - Named Instance - the name of the computer followed by the name of the SQL Server instance. e.g.: `.\SQLEXPRESS`
  - Each instance of SQL Server can manage multiple databases.
- SQL Server Management Studio (SSMS)
  - A software tool to connect to and manage SQL Server instances and their databases.

----

## Notes on Operators and Naming Standards

```sql
-- Relational Operators
-- > >= < <=
-- =    <>
-- Logical Operators
-- AND   OR    NOT
-- LIKE is used for pattern-matching
-- [A-Z] single character from A-Z inclusive
CHECK (Province LIKE '[A-Z][A-Z]')
-- [0-9] single character from 0-9 inclusive
-- BETWEEN - upper and lower bounds, inclusive
CHECK (Mark BETWEEN 0 AND 100)

-- Constraint Name Prefixes
-- PK  - Primary Key  - always clustered indexes
-- FK  - Foreign Key
-- DF  - Default
-- CK  - Check
-- UX  - Unique (Alternate Keys - AK) - always non-clustered indexes

-- Indexes
-- IX  - prefix for indexes
-- Indexes are a means of quickly referencing data by having the data sorted by the index.
-- Clustered Index refers to storing the Primary Key index column alongside the rest of the column data for the row.
-- Non-Clustered Index refers to storing an index alongside the corresponding PK index
```

----

## ESP - Spec 1

![Spec 1 ERD](ESP-PhysicalERD-Spec-1.png)

----
## SQL Download 

> Follow the link below and sign in with your Nait ID. Look for SQL Server 2017 developer 64bit download and SQL Server Management Studio [Instructions](https://dmit-1508.github.io/about/slides-installing-sql-server.html#/) on how to install.

[Weblink](https://portal.azure.com/?Microsoft_Azure_Education_correlationId=31368EAF3BFF60520441834B3A4C61B0&Microsoft_Azure_Education_newA4E=true#blade/Microsoft_Azure_Education/EducationMenuBlade/software)

Under the options tab in SQL Server managerment, go to text editor, then activate word wrap and show visual glyphs. Under the tab section within all languages; activate insert spaces.

## DROP TABLES
 Drop your tables in the reverse order you create your tables for your database.

 SQL
 = Is Equal To
 >LIKE "Pattern".
 > use the greater than; less than symbols.

 Logical Operators
 > OR,
 > AND,
 > NOT.
 

 ## Stored Procedures
 Creating stored procedures are a method that are attached to the database.

The 3 place where you would mainly use stored procedures are government,banking systems and military 