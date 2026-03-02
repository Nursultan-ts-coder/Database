## 📦 Lab 17: Data Import/Export and Backup (University DB)

This lab demonstrates all import/export and backup topics from the DOCX using the existing `university` database objects:

- `departments`
- `positions`
- `employees`
- `students`
- `courses`
- `enrollments`

> Use PostgreSQL terminal (`psql`) and run examples in a safe local environment.

---

## 1) COPY Command (Bulk Transfer)

### 1.1 Basic COPY TO / COPY FROM

```sql
-- Export full table to CSV (server-side path)
COPY students TO '/tmp/students.csv' WITH CSV HEADER;

-- Import CSV back into the table
COPY students FROM '/tmp/students.csv' WITH CSV HEADER;
```

### 1.2 Export with custom delimiter and NULL text

```sql
COPY employees TO '/tmp/employees_pipe.txt'
WITH (FORMAT csv, HEADER true, DELIMITER '|', NULL 'N/A');
```

### 1.3 Import only selected columns

```sql
COPY employees(first_name, last_name)
FROM '/tmp/new_employees.csv'
WITH (FORMAT csv, HEADER true);
```

### 1.4 Export query results

```sql
COPY (
	SELECT s.id, s.name, d.name AS department_name
	FROM students s
	LEFT JOIN departments d ON d.id = s.department_id
	ORDER BY s.id
) TO '/tmp/students_with_departments.csv'
WITH (FORMAT csv, HEADER true);
```

### 1.5 CSV special cases

```sql
-- Semicolon delimiter + quote character
COPY courses TO '/tmp/courses_semicolon.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ';', QUOTE '"');

-- Force quote for a specific column in export
COPY enrollments TO '/tmp/enrollments_quoted.csv'
WITH (FORMAT csv, HEADER true, FORCE_QUOTE (semester));

-- Import with UTF-8 encoding
COPY students FROM '/tmp/students_utf8.csv'
WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');

-- Embedded commas/quotes handling
COPY departments TO '/tmp/departments_feedback_style.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"', ESCAPE '"');

-- Custom NULL marker while importing
COPY positions FROM '/tmp/positions_nullable.csv'
WITH (FORMAT csv, HEADER true, NULL 'NULL');
```

### 1.6 Client-side alternative (`\copy`)

If server cannot access your file path, use `\copy` in `psql`:

```bash
\copy students TO 'data/students_export.csv' WITH CSV HEADER
\copy students FROM 'data/students_export.csv' WITH CSV HEADER
```

---

## 2) `pg_dump` and `pg_restore`

### 2.1 Create backups

```bash
# Plain SQL backup
pg_dump -h localhost -U postgres -d university > university_backup.sql

# Custom compressed backup (recommended)
pg_dump -h localhost -U postgres -d university -Fc > university_backup.dump

# Backup selected tables only
pg_dump -h localhost -U postgres -d university \
  -t students -t courses -t enrollments > university_academic_tables.sql

# Verbose custom backup
pg_dump -h localhost -U postgres -d university -Fc -v > university_verbose.dump
```

### 2.2 Restore backups

```bash
# Restore custom backup to an existing database
pg_restore -h localhost -U postgres -d university university_backup.dump

# Restore into a fresh database
createdb -h localhost -U postgres university_restore_test
pg_restore -h localhost -U postgres -d university_restore_test university_backup.dump

# Restore only one table
pg_restore -h localhost -U postgres -d university -t students university_backup.dump

# Parallel restore for faster load
pg_restore -h localhost -U postgres -d university_restore_test -j 4 university_backup.dump
```

### 2.3 Advanced `pg_dump` options

```bash
# Schema only
pg_dump -h localhost -U postgres -d university -s > university_schema_only.sql

# Data only
pg_dump -h localhost -U postgres -d university -a > university_data_only.sql

# Exclude table(s)
pg_dump -h localhost -U postgres -d university -T enrollments > university_without_enrollments.sql

# Full cluster backup (all databases)
pg_dumpall -h localhost -U postgres > full_cluster_backup.sql
```

---

## 3) Full Backups + Automation + Validation

### 3.1 Full backup commands

```bash
# Full backup for university with verbose output
pg_dump -h localhost -U postgres -d university -Fc --verbose > full_university.dump

# Preserve ownership info in dump metadata
pg_dump -h localhost -U postgres -d university -Fc -O > university_with_ownership.dump
```

### 3.2 Daily backup script example

```bash
#!/bin/bash
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="$HOME/backups/postgresql"
DB_NAME="university"

mkdir -p "$BACKUP_DIR"
pg_dump -h localhost -U postgres -d "$DB_NAME" -Fc > "$BACKUP_DIR/${DB_NAME}_${DATE}.dump"

# Keep only last 7 days
find "$BACKUP_DIR" -name "${DB_NAME}_*.dump" -mtime +7 -delete
```

### 3.3 Validate backup integrity

```bash
# Inspect dump catalog
pg_restore --list university_backup.dump

# Test restore flow
createdb -h localhost -U postgres university_restore_verify
pg_restore -h localhost -U postgres -d university_restore_verify university_backup.dump
```

---

## 4) Incremental Backup Concepts (WAL + Base Backup)

PostgreSQL incremental recovery is based on WAL archiving plus periodic base backups.

### 4.1 `postgresql.conf` settings

```conf
wal_level = replica
archive_mode = on
archive_command = 'cp %p /backup/wal/%f'
```

### 4.2 Base backups

```bash
# Tar + compression
pg_basebackup -h localhost -U replication_user -D /backup/base -Ft -z -P

# Include WAL in base backup
pg_basebackup -h localhost -U replication_user -D /backup/base -x -P
```

### 4.3 WAL maintenance

```sql
SELECT pg_switch_wal();
```

```bash
pg_archivecleanup /backup/wal 000000010000000000000010
```

---

## 5) Point-in-Time Recovery (PITR)

### 5.1 Recovery flow

```bash
# 1) Stop PostgreSQL
sudo systemctl stop postgresql

# 2) Replace data directory from base backup
rm -rf /var/lib/postgresql/data/*
tar -xf /backup/base/base.tar -C /var/lib/postgresql/data/

# 3) Configure recovery target
cat > /var/lib/postgresql/data/recovery.signal << EOF
restore_command = 'cp /backup/wal/%f %p'
recovery_target_time = '2026-03-01 12:30:00'
EOF

# 4) Start PostgreSQL (recovery starts automatically)
sudo systemctl start postgresql
```

### 5.2 Other recovery targets

```conf
recovery_target_xid = '12345'
recovery_target_name = 'before_enrollment_bulk_update'
```

```sql
SELECT pg_create_restore_point('before_enrollment_bulk_update');
```

---

## 6) Data Migration Strategies

### Strategy 1: Dump and Restore

```bash
pg_dump -h source_host -U postgres -d university -Fc > university_migration.dump
pg_restore -h target_host -U postgres -d university university_migration.dump
```

### Strategy 2: Logical Replication (low downtime)

```sql
-- Run on source
CREATE PUBLICATION university_pub FOR TABLE students, courses, enrollments;

-- Run on target
CREATE SUBSCRIPTION university_sub
CONNECTION 'host=source_host dbname=university user=replication_user'
PUBLICATION university_pub;
```

### Strategy 3: Physical Replication (minimal downtime)

```conf
wal_level = replica
max_wal_senders = 3
```

```bash
pg_basebackup -h primary_host -D /var/lib/postgresql/standby -U replication_user -R -P
```

### Strategy 4: ETL Pipeline

```sql
-- 1) Create staging table with same structure as students
CREATE TABLE staging_students AS SELECT * FROM students WHERE 1 = 0;

-- 2) Extract batch to CSV
COPY (
	SELECT * FROM students ORDER BY id LIMIT 1000 OFFSET 0
) TO '/tmp/students_batch_1.csv' WITH CSV HEADER;

-- 3) Load batch into staging
COPY staging_students
FROM '/tmp/students_batch_1.csv'
WITH CSV HEADER;

-- 4) Merge into target with upsert
INSERT INTO students (id, name, email, department_id, gpa, graduation_year)
SELECT id, name, email, department_id, gpa, graduation_year
FROM staging_students
ON CONFLICT (id) DO UPDATE
SET
	name = EXCLUDED.name,
	email = EXCLUDED.email,
	department_id = EXCLUDED.department_id,
	gpa = EXCLUDED.gpa,
	graduation_year = EXCLUDED.graduation_year;
```

---

## 7) Migration Best Practices

```sql
-- Pre-migration row count checks
SELECT COUNT(*) AS students_count FROM students;
SELECT COUNT(*) AS enrollments_count FROM enrollments;

-- Monitor active sessions during migration
SELECT pid, usename, application_name, client_addr, state
FROM pg_stat_activity
WHERE application_name IN ('pg_dump', 'pg_restore');
```

```bash
# Trial migration on one table
pg_dump -h source_host -U postgres -d university -t students | \
psql -h target_host -U postgres -d university_test
```

---

## 8) Handling Large Table Migrations

```sql
-- Example partition structure for enrollments by date (if enrollment_date is populated)
CREATE TABLE enrollments_partitioned (
	LIKE enrollments INCLUDING ALL
) PARTITION BY RANGE (enrollment_date);

CREATE TABLE enrollments_2026 PARTITION OF enrollments_partitioned
FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');
```

```bash
# Migrate only a specific partition/table slice
pg_dump -h source_host -U postgres -d university -t enrollments_2026 | \
psql -h target_host -U postgres -d university
```

---

## ✅ Lab 17 Checklist

- Performed `COPY TO` and `COPY FROM` with `students`/`employees`/`courses`
- Used CSV options: `HEADER`, `DELIMITER`, `QUOTE`, `ESCAPE`, `NULL`, `ENCODING`
- Created full and partial backups with `pg_dump`
- Restored backups with `pg_restore` (single table + full DB + parallel)
- Covered WAL/base backup and PITR workflow
- Covered all 4 migration strategies (dump/restore, logical, physical, ETL)
