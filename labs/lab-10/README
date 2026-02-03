## 🧭 Viewing Database & Table Structure

Understanding the schema—tables, columns, types, constraints, and relationships—is essential for debugging and development.

---

## 🔎 psql Meta-commands

Use the `psql` client’s handy backslash commands.

### List Tables

```sql
\dt
```

Filter by schema or pattern:

```sql
\dt public.*
\dt *students*
```

### Describe a Table

```sql
\d table_name
```

Show more detail (indexes, constraints):

```sql
\d+ table_name
```

### List Schemas / Relations / Indexes

```sql
\dn         -- schemas
\dv         -- views
\di         -- indexes
\df         -- functions
\da         -- aggregates
\ds         -- sequences
```

---

## 🗂️ Inspect with SQL

Explore catalog views for deeper insights.

```sql
-- All tables in a schema
SELECT tablename
FROM pg_catalog.pg_tables
WHERE schemaname = 'public';

-- Columns of a table
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema = 'public' AND table_name = 'students'
ORDER BY ordinal_position;

-- Foreign keys of a table (simplified)
SELECT tc.constraint_name, kcu.column_name, ccu.table_name AS foreign_table, ccu.column_name AS foreign_column
FROM information_schema.table_constraints AS tc
JOIN information_schema.key_column_usage AS kcu
	ON tc.constraint_name = kcu.constraint_name AND tc.table_schema = kcu.table_schema
JOIN information_schema.constraint_column_usage AS ccu
	ON ccu.constraint_name = tc.constraint_name AND ccu.table_schema = tc.table_schema
WHERE tc.table_schema='public' AND tc.table_name='enrollments' AND tc.constraint_type='FOREIGN KEY';
```

---

## 🧰 pgAdmin ERD

pgAdmin can generate simple ER diagrams:

- Open DB → `Schemas` → `Tables`
- Right-click → ERD for database

Recommended: keep PK/FK constraints and indexes well-defined to improve ERD clarity.

---

## ✅ Quick Tips

- Use `\d+` to see storage and indexes.
- Prefer `information_schema` for portable metadata queries.
- Document schema changes in migration files (e.g., `ALTER TABLE`).
