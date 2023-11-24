---
title: "Data Modeling: Logical & Physical Modeling"
---

# 01

## Primary Key

Every PK has the following properties:

- **Unique**: No two tables can have the same PK value.
- **Mandatory**: A PK value cannot be null.
- **Monovalued**: Maximum one value of PK.

## Composed Primary Key

Basically it happens when a single PK isn't enough to identify a row.

Ex:

**Dependents Table**:

| Employee ID (FK) | Dependent ID | Dependent Name | Date of Birth |
| ---------------- | ------------ | -------------- | ------------- |
| 2                | 1            | John Doe       | 01/01/2000    |
| 1                | 2            | Jane Doe       | 01/01/2001    |

In this case, the PK is composed by the columns **Employee ID** and **Dependent ID**.

It happens because not the **Employee ID** nor the **Dependent ID** alone is enough to identify a row.

## Some Concepts

- **Minimal Key**: Every column of the PK have to be necessary and sufficient to identify a row.
- **Candidate Key**: A minimal key that can be used as PK. Ex: **Employee ID** and **Employee CPF**. In this case, both are candidate keys.
- **Alternate Key**: A candidate key that is not the PK. Ex: **Employee CPF**.

## Foreign Key

Let's use the **Dependents Table** again, but now with the **Employees Table** as well.

**Employees Table**:

| Employee ID | Employee Name | Employee Birth Date |
| ----------- | ------------- | ------------------- |
| 1           | John Doe      | 01/01/1980          |
| 2           | Jane Doe      | 01/01/1981          |

**Employee ID** is the PK of the **Employees Table** and the **Dependents Table** has a FK to it.

The reason of it is because the tables are related, so we should have a way to access what is the responsible employee from the dependent table, and we do that by referring the employee with a FK.

- *The value of the FK must exist in the PK of the table that it refers to*.

# 02

## Normalization

It's a process that consists in 5 normal forms: 1NF, 2NF, 3NF, 4NF and 5NF. Normally we use until the 3NF. Let's see how it works untill the 3FN:

- Identify the data origin;
- Build a not normalized table from the data;
- Apply the 1NF rules;
- Apply the 2NF rules;
- Apply the 3NF rules.

### 1NF

A table is in agreement with the 1NF when:

- There's no multivalued attributes and no composite attributes;

### 2NF

A table is in agreement with the 2NF when:

- It is in agreement with the 1NF;
- It has no partial functional dependencies.

#### Partial Functional Dependency

It happens when a non-key column depends on a part of the PK. Ex:

**Teacher Table**:

| Project ID | Teacher ID | Teacher Name | Teacher Birth Date | Initial Date | Duration | Category | Salary |
| ---------- | ---------- | ------------ | ------------------ | ------------ | -------- | -------- | ------ |
| 1          | 1          | John Doe     | 01/01/1980         | 01/01/2020   | 6        | BIO      | 2000   |
| 2          | 3          | John Doe     | 01/01/1980         | 01/01/2020   | 12       | MED      | 5100   |
| 3          | 2          | Jane Doe     | 01/01/1981         | 01/01/2020   | 6        | TECH     | 1100   |

Notice that **Teacher Name** depends on **Teacher ID** and not on **Project ID**. So, it's a partial functional dependency.

The resolution is to create a new table for the partial dependency:

**Project Table**:

| Project ID | Initial Date | Duration | Teacher ID |
| ---------- | ------------ | -------- | ---------- |
| 1          | 01/01/2020   | 6        | 1          |
| 2          | 01/01/2020   | 12       | 3          |
| 3          | 01/01/2020   | 6        | 2          |

**Teacher Table**:

| Teacher ID | Teacher Name | Teacher Birth Date | Category | Salary |
| ---------- | ------------ | ------------------ | -------- | ------ |
| 1          | John Doe     | 01/01/1980         | BIO      | 2000   |
| 2          | Jane Doe     | 01/01/1981         | TECH     | 1100   |
| 3          | John Doe     | 01/01/1980         | MED      | 5100   |

### 3NF

A table is in agreement with the 3NF when:

- It is in agreement with the 2NF;
- It has no transitive dependencies.

Notice that **Salary** depends on **Category** and not on **Teacher ID**. So, it's a transitive dependency.

The resolution is to create a new table for the transitive dependency:

**Category Table**:

| Category | Salary |
| -------- | ------ |
| BIO      | 2000   |
| TECH     | 1100   |
| MED      | 5100   |

# 04

## Denormalization

Sometimes we need to denormalize a table to improve the performance of the database.

Besides normalization brings a lot of benefits, it also has some disadvantages, like the need to access multiple tables to retrieve information in some transactions.

Because of that, we can denormalize a table to improve the performance of the database.

## Indexes

Indexes are used to improve the performance of the database. It's a data structure that allows the database to find data fast.

But it brings some disadvantages as well, like if a table is updatted frequently, the indexes will need to be updated as well, which can cause a performance issue.

### What should be indexed?

The columns that are used in the **WHERE** clause of the **SELECT** statement more frequently.