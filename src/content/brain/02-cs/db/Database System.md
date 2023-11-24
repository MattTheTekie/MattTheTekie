---
title: "Database System"
---

# 1

### History

- IBM with the invention of the Hard Disk, and previously, the Von Neumann architecture, initiated the age of the data processing.
- The databases were an natural evolution from file systems.
- The duty to manage the data was given to intermediary software, called Database Management Systems (DBMS), istead of the applications programs.

#### Relational Model

- Invention by Edgar Codd, 1970.
- The data structure is a math function denominated **relation**.
- SQL was the language created by IBM to manipulate the data in the relational model.
- LAMP (Linux, Apache, MySQL, PHP) is a stack of technologies that was very popular in the 2000s.
    - MySQL is a DBMS, by Oracle, that implements the relational model.
- The Ingres project, from the University of California, Berkeley, has originated some cool things:
    - Sybase, which was later associated with Microsoft to create SQL Server.
    - Postgres (from Post Ingres), which extends the model with POO concepts.

# 2

Basically what differentiates a database system from a file based system used as database is the independence of the data from the applications.

Other differences are:

- Self contained nature: In addition to the data, the DBMS also stores the metadata, which is the data about the data (like the restrictions and the structure of the data).
- Data abstraction: Allows conceptual representation of the data by the use of data models that hide storage details and implementations, which supports the data independence and the multiple logic visions of the data.
- Support to data sharing and concurrent transactions: Allows multiple users to access the database simultaneously.

## Data Models

The data models that supports the data abstraction and allows logical and physical data independence are:

- Physical Models: Describe how the data is stored in the computer (archive types, formats, ordering, paths, etc).
- Logical Models: As the relational model being one example, the logical models represents the implementation of the database in an abstract way, hiding how the data is stored and accessed in the disk.
- Conceptual Models: They represent the view of the data from the user perspective. An example is the model of entity-relationship, created by Peter Chen in 1976.

## DBMS

It's DBMS resposability to guarantee transactions properties, known as ACID:

- Atomicity: Every transaction is treated as an composed unity, and it's either executed successfully for all operations or failed for all operations.
- Consistency: A transaction can only bring the database from a valid state to another valid state, according to the rules of integrity of the database.
- Isolation: This guarantees that the concurrent execution of transactions produces the same result as if they were executed sequentially.
- Durability: Once a transaction is completed, the changes made to the database persist, even in the case of system failure.

### Disadvantages

- Performance: Adding the DBMS between the application and the data can cause a performance loss.

# 3

## DBS

Those can include DBMS, the database itself and applications that manipulate the data.

## PostgreSQL

It uses a client/server model of computation.

# Footer

- **Class**: Databases
- **Theme**: Database System