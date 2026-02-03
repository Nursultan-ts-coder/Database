# Lab Summary: Introduction to Relational Databases

A comprehensive overview of Database Management Systems (DBMS), the differences between SQL and NoSQL, and the core principles of data integrity.

---

## 🏗️ Core Concepts

### Database vs. DBMS

- **Database**: An organized collection of structured data.
- **DBMS**: Software used to create and manage databases (e.g., PostgreSQL, MySQL, Oracle).
- **CRUD**: The four basic functions of a DBMS: **C**reate, **R**ead, **U**pdate, and **D**elete.

### Relational Database Terminology

- **Table**: Data organized into rows and columns.
- **Row (Record)**: A single item in a table.
- **Column (Field)**: A category of information.
- **Primary Key (PK)**: A unique identifier for every row.
- **Foreign Key (FK)**: A link used to create a relationship between two tables.
- **Schema**: The structural blueprint of the database.

---

## ⚖️ SQL vs. NoSQL

| Feature           | SQL (Relational)                     | NoSQL (Non-Relational)                  |
| :---------------- | :----------------------------------- | :-------------------------------------- |
| **Data Model**    | Rigid, predefined tables             | Flexible (Documents, Graphs, Key-Value) |
| **Scaling**       | Vertical (Increase server power)     | Horizontal (Add more servers)           |
| **Integrity**     | ACID Compliance (Strict)             | BASE Principles (Eventual Consistency)  |
| **Best Use Case** | Financial systems, complex relations | Unstructured data, rapid scaling        |

---

## 🛡️ ACID Properties

To ensure reliability, relational databases follow the **ACID** model:

1.  **Atomicity**: Transactions are "all or nothing."
2.  **Consistency**: Data remains valid according to all defined rules.
3.  **Isolation**: Transactions do not interfere with one another.
4.  **Durability**: Once a transaction is committed, it remains saved even during a system failure.

---

## 🐘 Why PostgreSQL?

PostgreSQL is a powerful, open-source object-relational database system.

- **Reliability**: Full ACID support and high extensibility.
- **Hybrid Power**: Can handle both relational (SQL) and non-relational (JSON) data.
- **Community**: Large, active community with regular updates.
- **Position**: It offers the power of commercial systems (like Oracle) for free (unlike Oracle) and is more robust than lightweight options (like MySQL or SQLite).

---

## 🔗 Relationship Types

- **One-to-One**: One record links to exactly one other record.
- **One-to-Many**: One record links to multiple records in another table.
- **Many-to-Many**: Multiple records link to multiple records (usually requires a join table).
