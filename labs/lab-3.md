# Lab #3: Basic psql Commands & Operations

This lab covers how to use the **psql** interactive terminal to connect to PostgreSQL, manage the environment with meta-commands, and execute basic SQL operations.

---

## 🔌 Connecting to PostgreSQL via psql

`psql` is the terminal interface for working with PostgreSQL. It allows you to connect to a database and execute queries directly.

### Connection Structure

```bash
psql -h <host> -p <port> -U <username> -d <database>
```

- **-h**: Server address (default: `localhost`)
- **-p**: Port (default: `5432`)
- **-U**: PostgreSQL username
- **-d**: Database name

> **Note:** If the database and user match your OS username, you can simply type `psql`.

### Connection Examples

```bash
# Example 1: Full connection
psql -U postgres -d mydb -h localhost -p 5432

# Example 2: Shorthand (assuming default host/port)
psql -U postgres -d mydb

# Example 3: Different flag order
psql -h localhost -U postgres -d mydb

```

---

## 🛠️ Meta-commands in psql

Meta-commands begin with a backslash (`\`). These allow you to manage the database without writing full SQL queries.

| Command       | Description                                     |
| ------------- | ----------------------------------------------- |
| `\l`          | List all databases                              |
| `\c <dbname>` | Connect to a specific database                  |
| `\dt`         | List all tables in the current database         |
| `\d <table>`  | Describe table structure (columns, types, keys) |
| `\q`          | Exit psql                                       |
| `\h`          | Help on SQL commands (e.g., `\h SELECT`)        |
| `\?`          | List all available meta-commands                |

---

## 📝 Basic Command-Line Operations

You can run SQL queries directly inside the `psql` terminal. Here are the fundamental operations covered in this lab:

### 1. Create Data (Table)

```sql
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INT
);

```

### 2. Insert Data

```sql
INSERT INTO students (name, age)
VALUES ('Alice', 21), ('Bob', 23);

```

### 3. Select Data

```sql
SELECT * FROM students;

```

### 4. Delete Table

```sql
DROP TABLE students;

```

---

## 🚪 Exit from psql

To close the connection and return to your standard command prompt, type:

```bash
\q

```
