---
title: "Create and Manipulate Objects in Postgresql"
---

## Architecture

Postgresql uses client-server model.

***Server Processes:***

- Manage database archives
- Manage connections between applications and SGDB
- Verify and execute commands sent by clients on the database

***Client Processes:***

- Require SGDB access
- Send manipulation commands
- Send query commands

This architecture allows the database and clients to be on different machines/locations.

- Postgresql supports multiple clients at the same time.

## Managing Postgresql Database With psql

```sql
dtsf=$ CREATE TABLE Client (
NAME CHAR(100),
ID INT NOT NULL DEFAULT 0)
;
CREATE TABLE
dtsf=$ \dp
                             Access privileges
 Schema |  Name  | Type  | Access privileges | Column privileges | Policies
--------+--------+-------+-------------------+-------------------+----------
 dtsf   | client | table |                   |                   |
(1 row)

dtsf=$ \d client
                   Table "dtsf.client"
 Column |      Type      | Collation | Nullable | Default
--------+----------------+-----------+----------+---------
 name   | character(100) |           |          |
 id     | integer        |           | not null | 0

dtsf=$ ALTER TABLE client ADD BIRTHDATE DATE;
ALTER TABLE
dtsf=$ \d client
                     Table "dtsf.client"
  Column   |      Type      | Collation | Nullable | Default
-----------+----------------+-----------+----------+---------
 name      | character(100) |           |          |
 id        | integer        |           | not null | 0
 birthdate | date           |           |          |

dtsf=$ ALTER TABLE client DROP COLUMN birthdate;
ALTER TABLE
dtsf=$ \d client
                   Table "dtsf.client"
 Column |      Type      | Collation | Nullable | Default
--------+----------------+-----------+----------+---------
name   | character(100) |           |          |
id     | integer        |           | not null | 0

dtsf=$ INSERT INTO client (name, id) VALUES ('John', 1);
INSERT 0 1
dtsf=$ SELECT * FROM client;
 name | id
------+----
 John |  1
 (1 row)

dtsf=$ UPDATE client SET name = 'John Doe' WHERE id = 1;
UPDATE 1
dtsf=$ SELECT * FROM client;
    name    | id
------------+----
    John Doe   |  1
    (1 row)

dtsf=$ DELETE FROM client WHERE id = 1;
DELETE 1
dtsf=$ SELECT * FROM client;
 name | id
------+----
(0 rows)
```

## Constraints

***What are constraints?***

- Constraints are rules that can be applied to a column or a table.
- They are part of the database schema definition.
- They define certain properties that data in a database must comply with.

***Common kinds of constraints are:***

- **not null** - each value in a column must not be NULL
- **unique** - value(s) in specified column(s) must be unique for each row in a table
- **primary key** - value(s) in specified column(s) must be unique for each row in a table and not be NULL; normally each table in a database should have a primary key - it is used to identify individual records
- **foreign key** - value(s) in specified column(s) must reference an existing record in another table (via it's primary key or some other unique constraint)
- **check** - an expression is specified, which must evaluate to true for constraint to be satisfied

## Transactions

### States of a Transaction

- ***Active***: The transaction is running, executing queries (read and/or write).
- ***Partially Committed***: The transaction has finished executing.
    * ***Committed***: After succeeded validation, the transaction is committed and the changes are made permanent.
    * ***Failed***: If validation fails or the transaction is aborted, the transaction is failed.
- ***Finished***: Transaction get out of the system.

### Postgresql Transactions

Transactions in Postgresql follows the structure:

```sql
BEGIN-- Start a transaction
    -- SQL commands
COMMIT-- Commit the transaction
ROLLBACK-- Rollback the transaction
END-- End the transaction
```

### Multiple Clients and Uncontrolled Transactions

This scenario might bring the following problems:

- ***Problem 1: Lost Update***: When two transactions that access the same data have their operations intercalated in a way that might left the data incorrect.
- ***Problem 2: Temporary Update***: When a transaction updates a database item and then fails for some reason, while in the meantime the item is read by another transaction before being changed back to its original value.
- ***Problem 3: Incorrect Summary***: When a transaction reads a database item that is being updated by another transaction and then performs a calculation based on the old value.
- ***Problem 4: Non-Repeatable Read***: When a transaction reads the same item twice and the value is altered by another transaction between the two reads.

**OBS: These problems occurs only with uncontrolled transactions and multiple clients.**