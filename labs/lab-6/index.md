# Lab #6: Tables, Data Types, and Constraints

This lab explores the detailed structure of tables, the various types of data they store, and the constraints (rules) that ensure data integrity.

## 🏗️ Table Creation (`CREATE TABLE`)

A table organizes related data into rows and columns. When creating one, you must define the column names, their data types, and any optional rules (constraints).

### Syntax

```sql
CREATE TABLE table_name (
    column1 datatype constraint,
    column2 datatype constraint,
    ...
);

```

### Pro Example: `students` table

```sql
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,    -- Auto-increments and uniquely identifies rows
    first_name VARCHAR(50) NOT NULL,  -- Cannot be empty
    last_name VARCHAR(50) NOT NULL,   -- Cannot be empty
    email VARCHAR(100) UNIQUE NOT NULL, -- Must be unique and not empty
    faculty VARCHAR(100)
);

```

---

## 📊 Common Data Types & Constraints

### Data Types

- **SERIAL**: An auto-incrementing integer (perfect for IDs).
- **INTEGER / BIGINT**: Whole numbers of varying sizes.
- **VARCHAR(n)**: Text with a character limit of _n_.
- **TEXT**: Unlimited length text.
- **BOOLEAN**: True or False.
- **DATE / TIMESTAMP**: Specific dates or date + time.

### Constraints (The Rules)

- **PRIMARY KEY**: A unique ID for every row. It cannot be NULL.
- **NOT NULL**: Prevents "empty" values in a column.
- **UNIQUE**: Ensures no two rows have the same value in that column.
- **CHECK**: Validates data based on a condition (e.g., `CHECK (age >= 18)`).
- **FOREIGN KEY**: Links a row to a Primary Key in another table.

---

## 🛠️ Modifying Tables (`ALTER TABLE`)

If you need to change your table structure after it's created, use `ALTER TABLE` instead of deleting it.

| Task              | Syntax Example                                                    |
| ----------------- | ----------------------------------------------------------------- |
| **Add Column**    | `ALTER TABLE students ADD COLUMN phone VARCHAR(20);`              |
| **Drop Column**   | `ALTER TABLE students DROP COLUMN phone;`                         |
| **Change Type**   | `ALTER TABLE students ALTER COLUMN first_name TYPE VARCHAR(100);` |
| **Rename Column** | `ALTER TABLE students RENAME COLUMN first_name TO given_name;`    |

---

## 🗑️ Dropping Tables (`DROP TABLE`)

Removes a table and all its data permanently.

- **Basic**: `DROP TABLE students;`
- **Safe**: `DROP TABLE IF EXISTS students;` (Prevents errors if the table is already gone).

---

## 🏷️ Table Naming Conventions

- **Descriptive**: Use `course_enrollments` rather than `table1`.
- **Snake Case**: Use `student_id`, not `studentID`.
- **Singular vs. Plural**: `student` vs `students`. Both work, but stay consistent!
- **Keys**: Use `id` or `table_id` for Primary Keys.

---

## 🧪 Temporary Tables

Useful for intermediate calculations or complex scripts. These tables vanish automatically when your session ends.

```sql
CREATE TEMP TABLE current_session_data (
    temp_id INT,
    action_type TEXT
);

```
