## 🔗 Foreign Keys & Relationships

A Foreign Key (FK) is a column (or set of columns) in one table that points to the Primary Key (PK) in another table. It enforces referential integrity so related data stays consistent across tables.

Think of it as a reliable “reference” from a child table to a parent table — for example, an `enrollments` table referencing `students(student_id)` and `courses(course_id)`.

---

## 🛠️ Creating Foreign Keys

You can define foreign keys inline, at the table level, or add them later.

### Method 1: Column-level (Inline)

```sql
CREATE TABLE enrollments (
	enrollment_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	student_id    INTEGER REFERENCES students(student_id),
	course_id     INTEGER REFERENCES courses(course_id)
);
```

### Method 2: Table-level

```sql
CREATE TABLE enrollments (
	enrollment_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	student_id    INTEGER,
	course_id     INTEGER,
	FOREIGN KEY (student_id) REFERENCES students(student_id),
	FOREIGN KEY (course_id)  REFERENCES courses(course_id)
);
```

### Method 3: Named Constraint (Recommended)

Naming constraints makes maintenance easier (`ALTER TABLE ... DROP CONSTRAINT ...`).

```sql
CREATE TABLE enrollments (
	enrollment_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	student_id    INTEGER,
	course_id     INTEGER,
	CONSTRAINT fk_enrollments_student
		FOREIGN KEY (student_id) REFERENCES students(student_id),
	CONSTRAINT fk_enrollments_course
		FOREIGN KEY (course_id)  REFERENCES courses(course_id)
);
```

### Method 4: Add to an Existing Table

```sql
ALTER TABLE enrollments
	ADD CONSTRAINT fk_enrollments_student
	FOREIGN KEY (student_id)
	REFERENCES students(student_id);

ALTER TABLE enrollments
	ADD CONSTRAINT fk_enrollments_course
	FOREIGN KEY (course_id)
	REFERENCES courses(course_id);
```

---

## 🛡️ Referential Integrity Rules

When a FK exists, PostgreSQL enforces consistency:

- **Insert**: The FK value must exist in the parent table’s PK.
- **Update**: Changing the FK to a value not in the parent is blocked.
- **Delete**: Deleting a parent row that has children is controlled by `ON DELETE` rules.

---

## 🔄 ON DELETE / ON UPDATE Actions

Control how changes in the parent are applied to children:

| Action        | Effect on Child Rows                                                   |
| ------------- | ---------------------------------------------------------------------- |
| `NO ACTION`   | Default. Prevents change if it breaks FK (similar to `RESTRICT`).      |
| `RESTRICT`    | Like `NO ACTION`, checks immediately.                                  |
| `CASCADE`     | Propagates the change (delete children or update FK on parent change). |
| `SET NULL`    | Sets the FK column(s) to `NULL`. Requires FK columns be nullable.      |
| `SET DEFAULT` | Sets FK column(s) to their default value.                              |

Examples:

```sql
-- Delete enrollments when a student is deleted
ALTER TABLE enrollments
	DROP CONSTRAINT fk_enrollments_student,
	ADD  CONSTRAINT fk_enrollments_student
	FOREIGN KEY (student_id)
	REFERENCES students(student_id)
	ON DELETE CASCADE;

-- Set course_id to NULL if the course is removed
ALTER TABLE enrollments
	DROP CONSTRAINT fk_enrollments_course,
	ADD  CONSTRAINT fk_enrollments_course
	FOREIGN KEY (course_id)
	REFERENCES courses(course_id)
	ON DELETE SET NULL;
```

---

## 🧩 Relationship Types

### One-to-One

Each `A` has exactly one `B`. Implement by making a FK unique.

```sql
CREATE TABLE student_profiles (
	student_id INTEGER PRIMARY KEY,
	bio        TEXT,
	-- FK shares the same key, guaranteeing 1:1
	CONSTRAINT fk_profiles_student
		FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- Alternative: FK with UNIQUE
CREATE TABLE student_passports (
	student_id INTEGER UNIQUE,
	passport_no VARCHAR(64) NOT NULL,
	CONSTRAINT fk_passports_student
		FOREIGN KEY (student_id) REFERENCES students(student_id)
);
```

### One-to-Many (Most Common)

One parent row relates to many child rows.

```sql
CREATE TABLE course_offerings (
	offering_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	course_id   INTEGER NOT NULL,
	semester    VARCHAR(20) NOT NULL,
	CONSTRAINT fk_offerings_course
		FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
```

### Many-to-Many

Use a junction table with two FKs and a composite primary key.

```sql
CREATE TABLE course_enrollments (
	student_id INTEGER NOT NULL,
	course_id  INTEGER NOT NULL,
	semester   VARCHAR(20) NOT NULL,
	PRIMARY KEY (student_id, course_id, semester),
	CONSTRAINT fk_ce_student
		FOREIGN KEY (student_id) REFERENCES students(student_id),
	CONSTRAINT fk_ce_course
		FOREIGN KEY (course_id)  REFERENCES courses(course_id)
);
```

---

## 🔧 Managing Existing FKs

- **Add** a FK: `ALTER TABLE ... ADD CONSTRAINT ... FOREIGN KEY ...`
- **Drop** a FK: `ALTER TABLE ... DROP CONSTRAINT constraint_name;`
- **Rename** a constraint: `ALTER TABLE ... RENAME CONSTRAINT old TO new;`

```sql
-- Drop then add with different ON DELETE behavior
ALTER TABLE enrollments DROP CONSTRAINT fk_enrollments_student;
ALTER TABLE enrollments
  ADD CONSTRAINT fk_enrollments_student
  FOREIGN KEY (student_id)
  REFERENCES students(student_id)
  ON DELETE RESTRICT;
```

---

## ⚡ Performance Tips

- PostgreSQL does **not** auto-create indexes for FK columns. Add indexes on FK columns used in joins or filters.

```sql
CREATE INDEX idx_enrollments_student_id ON enrollments(student_id);
CREATE INDEX idx_enrollments_course_id  ON enrollments(course_id);
```

- For heavy batch operations, consider `DEFERRABLE` constraints to check at transaction commit:

```sql
ALTER TABLE enrollments
  ADD CONSTRAINT fk_enrollments_student
  FOREIGN KEY (student_id)
  REFERENCES students(student_id)
  DEFERRABLE INITIALLY DEFERRED;
```

---

## ✅ Quick Checklist

- Use named constraints for clarity and maintenance.
- Choose `ON DELETE/UPDATE` actions that match business rules.
- Index FK columns for better join performance.
- Prefer composite PKs in junction tables; avoid surrogate IDs unless needed.

---

## 📚 Example Workflow (University)

```sql
-- Base tables (simplified)
CREATE TABLE students (
  student_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name       VARCHAR(100) NOT NULL
);

CREATE TABLE courses (
  course_id  INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  title      VARCHAR(200) NOT NULL
);

-- Enrollments with FKs and indexes
CREATE TABLE enrollments (
  enrollment_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  student_id    INTEGER NOT NULL,
  course_id     INTEGER NOT NULL,
  semester      VARCHAR(20) NOT NULL,
  CONSTRAINT fk_enrollments_student
	FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
  CONSTRAINT fk_enrollments_course
	FOREIGN KEY (course_id)  REFERENCES courses(course_id)  ON DELETE RESTRICT
);

CREATE INDEX idx_enrollments_student_id ON enrollments(student_id);
CREATE INDEX idx_enrollments_course_id  ON enrollments(course_id);
```

This structure keeps relationships consistent and fast for typical queries.
