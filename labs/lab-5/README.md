# Lab #5: Database Management

This lab covers the essential commands for creating, deleting, and navigating between databases in PostgreSQL, along with industry-standard naming conventions.

---

## 🏗️ Creating and Dropping Databases

### 1. Create Database

The `CREATE DATABASE` statement initializes a new storage container for your tables and data.

**Syntax:**

```sql
CREATE DATABASE database_name;
```

**Example:**

```sql
CREATE DATABASE university;

```

### 2. Drop Database

The `DROP DATABASE` statement permanently removes a database.

> [!CAUTION]
> **Warning:** This action is destructive and cannot be undone. Use with extreme caution.

**Syntax:**

```sql
DROP DATABASE database_name;

```

**Important Rules for Dropping:**

- You **cannot** drop a database that is currently in use (active connections).
- You must connect to a different database (e.g., the default `postgres` DB) before dropping your target database.

---

## 🏷️ Database Naming Conventions

Following "Pro" conventions ensures your database is readable and avoids syntax errors.

| Practice       | Recommendation                                         | Example                    |
| -------------- | ------------------------------------------------------ | -------------------------- |
| **Case**       | Use **lowercase** only to avoid case-sensitivity bugs. | `student_db` (Good)        |
| **Separation** | Use **snake_case** (underscores) between words.        | `course_management` (Good) |
| **Keywords**   | Avoid reserved SQL words (SELECT, TABLE, etc.).        | `my_table_data` (Good)     |
| **Clarity**    | Keep it concise but descriptive.                       | `enrollment_2026` (Good)   |

**Avoid:** `StudentDB` (Mixed case), `course management` (Spaces), or `select` (Reserved word).

---

## 🔄 Switching Between Databases

In the **psql** command-line interface, you can move between databases using meta-commands or startup flags.

### Using meta-commands:

```bash
\c database_name

```

_Example:_ `\c university` connects you to the university database.

### Using the startup flag:

You can connect directly to a specific database when launching psql from your terminal:

```bash
psql -d university -U username

```

---
