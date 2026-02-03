## 🧱 Database Design Basics

Good database design creates a clear, scalable, and maintainable schema for storing and querying data. Below are the core concepts and a practical path you can follow.

---

## 🧩 Entity–Relationship (ER) Modeling

ER modeling visualizes how data relates before you implement tables.

- **Entity**: Real-world object → becomes a table. Examples: `Student`, `Course`, `Professor`, `Department`.
- **Attribute**: Property of an entity → becomes a column. Examples: `StudentID`, `Name`, `Email`, `DateOfBirth`.
- **Relationship**: How entities connect. Examples: Students enroll in Courses, Professors teach Courses.

### Attribute Types

- **Simple**: Cannot be split further (e.g., `StudentID`, `FirstName`).
- **Composite**: Can be split (e.g., `Address` → `Street`, `City`, `ZipCode`).
- **Derived**: Computed from other attributes (e.g., `Age` from `DateOfBirth`).
- **Key**: Uniquely identifies the entity (e.g., `StudentID`).

### Example (University)

- Relationships:
  - Students **ENROLL** in Courses (Many-to-Many)
  - Professors **TEACH** Courses (One-to-Many)

---

## 🧹 Normalization (1NF → 3NF)

Normalization reduces redundancy and improves integrity by structuring data properly.

**Benefits**

- Eliminates duplication
- Saves space
- Keeps data consistent
- Simplifies updates

### 1NF (First Normal Form)

- Atomic values only (no arrays or repeating groups)
- Each row unique

### 2NF (Second Normal Form)

- Must be in 1NF
- No partial dependency on a composite key (each non-key depends on the full key)

### 3NF (Third Normal Form)

- Must be in 2NF
- No transitive dependency (non-key should not depend on another non-key)

---

## 🛠️ Design Process

### 1) Requirements Analysis

- Understand business goals and data usage
- Identify data to store and user types

### 2) Conceptual Design

- Create high-level ER diagrams
- Identify entities and relationships

### 3) Logical Design

- Convert ER to tables
- Apply normalization
- Define primary/foreign keys
- Choose data types and constraints

### 4) Physical Design

- Select PostgreSQL data types
- Create indexes for performance
- Consider partitioning for large tables
- Plan backups and recovery

---

## 📚 Example: Library Management

### Requirements

- Track books, authors, members, and loans
- Books can have multiple authors
- Members can borrow many books
- Track due dates and late fees

### Conceptual Entities

- `Book`, `Author`, `Member`, `Loan`
- Relationships:
  - Author **WRITES** Book (Many-to-Many)
  - Member **BORROWS** Book via Loan (One-to-Many)

### Logical DDL (PostgreSQL)

```sql
CREATE TABLE authors (
	author_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name      VARCHAR(200) NOT NULL
);

CREATE TABLE books (
	book_id   INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	title     VARCHAR(300) NOT NULL,
	isbn      VARCHAR(20) UNIQUE
);

-- Junction table for many-to-many (Book–Author)
CREATE TABLE book_authors (
	book_id   INTEGER NOT NULL,
	author_id INTEGER NOT NULL,
	PRIMARY KEY (book_id, author_id),
	FOREIGN KEY (book_id)   REFERENCES books(book_id)   ON DELETE CASCADE,
	FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE CASCADE
);

CREATE TABLE members (
	member_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name      VARCHAR(200) NOT NULL,
	email     VARCHAR(200) UNIQUE
);

CREATE TABLE loans (
	loan_id   INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	member_id INTEGER NOT NULL,
	book_id   INTEGER NOT NULL,
	loan_date DATE NOT NULL,
	due_date  DATE NOT NULL,
	returned_date DATE,
	FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
	FOREIGN KEY (book_id)   REFERENCES books(book_id)    ON DELETE RESTRICT
);

-- Helpful indexes
CREATE INDEX idx_loans_member_id ON loans(member_id);
CREATE INDEX idx_loans_book_id   ON loans(book_id);
```

---

## ✅ Quick Checklist

- Define clear PKs and FKs; name constraints.
- Normalize to 3NF for most OLTP use cases.
- Index join/filter columns.
- Use junction tables for many-to-many relations.
