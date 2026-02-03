# Lab #4: First SQL Query

This lab introduces the fundamental syntax of SQL (Structured Query Language). You will learn how to retrieve, filter, sort, and limit data within a PostgreSQL database.

---

## 🏗️ SQL Syntax Basics

SQL is the standard language for relational databases. While keywords are case-insensitive, following these conventions makes your code professional:

- **Keywords**: Write in **UPPERCASE** (e.g., `SELECT`, `FROM`).
- **Names**: Use **snake_case** for tables and columns (e.g., `student_id`).
- **Semicolons**: Always end your statements with a `;`.

---

## 🔍 The SELECT Statement

The `SELECT` statement is used to retrieve data.

### Basic Structure

```sql
SELECT column1, column2 FROM table_name;
```

- **SELECT**: Choose the columns you want.
- **FROM**: Choose the table where the data lives.
- **`*` (Asterisk)**: Use this to select **all** columns.

**Example:**

```sql
-- Retrieve specific columns
SELECT name, email FROM students;

-- Retrieve everything
SELECT * FROM students;

```

---

## 🛠️ Filtering, Sorting, and Limiting

### 1. Filtering with `WHERE`

The `WHERE` clause filters rows so you only see data that meets a specific condition.

```sql
SELECT name, email FROM students WHERE name = 'Timur';

```

### 2. Sorting with `ORDER BY`

Sort your results in **ASC** (ascending, default) or **DESC** (descending) order.

```sql
-- Sort by name alphabetically
SELECT name, email FROM students ORDER BY name ASC;

```

### 3. Limiting with `LIMIT`

Control how many rows are returned. This is very useful for large databases.

```sql
-- Get only the first 2 rows
SELECT name, email FROM students LIMIT 2;

```

---

## 💬 Comments in SQL

Comments help explain your code. The database engine ignores them.

- **Single-line**: Use `--`
- **Multi-line**: Use `/* ... */`

```sql
-- This is a single-line comment
SELECT name FROM students;

/* This is a multi-line comment
used for longer explanations.
*/

```

---

## 🚀 How to Run a Query

1. Open your client (**pgAdmin** or **psql**).
2. Connect to your database.
3. Write your code in the Query Editor or terminal.
4. Execute/Run the command.

### Understanding the Results

- **Rows**: Represent individual records.
- **Columns**: Represent specific fields/categories.

| student_id | faculty |
| ---------- | ------- |
| 1          | COMSEH  |
| 2          | MED     |
| 3          | MAT     |
