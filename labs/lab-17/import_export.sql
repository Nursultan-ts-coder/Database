-- Lab 17: Data Import/Export and Backup (University DB)
--
-- This file contains:
--   1) SQL statements that run inside PostgreSQL/psql
--   2) psql meta-commands (\copy, \! ...)
--   3) terminal/server actions recorded as comments (for pg_dump/pg_restore/PITR)
--
-- Recommended usage:
--   psql -h localhost -U postgres -d university -f labs/lab-17/import_export.sql

\echo '=== LAB 17 START ==='

-- =====================================================================
-- 0) Context
-- =====================================================================

\echo 'Using database: university'
\c university

-- Existing tables used in this lab:
-- departments, positions, employees, students, courses, enrollments


-- =====================================================================
-- 1) COPY Command (Bulk Transfer)
-- =====================================================================

\echo '1.1 Basic COPY TO / COPY FROM'

-- Export full table to CSV (server-side path)
COPY students TO '/tmp/students.csv' WITH CSV HEADER;

-- Import CSV back into table (ensure file exists and format matches table)
COPY students FROM '/tmp/students.csv' WITH CSV HEADER;


\echo '1.2 Export with custom delimiter and NULL text'

COPY employees TO '/tmp/employees_pipe.txt'
WITH (FORMAT csv, HEADER true, DELIMITER '|', NULL 'N/A');


\echo '1.3 Import selected columns only'

COPY employees(first_name, last_name)
FROM '/tmp/new_employees.csv'
WITH (FORMAT csv, HEADER true);


\echo '1.4 Export query results'

COPY (
	SELECT s.id, s.name, d.name AS department_name
	FROM students s
	LEFT JOIN departments d ON d.id = s.department_id
	ORDER BY s.id
) TO '/tmp/students_with_departments.csv'
WITH (FORMAT csv, HEADER true);


\echo '1.5 CSV special cases'

-- Semicolon delimiter + quote character
COPY courses TO '/tmp/courses_semicolon.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ';', QUOTE '"');

-- Force quote for specific column
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


\echo '1.6 Client-side alternative (\\copy)'

-- Use \copy when PostgreSQL server cannot access local file paths.
\copy students TO 'data/students_export.csv' WITH CSV HEADER
\copy students FROM 'data/students_export.csv' WITH CSV HEADER


-- =====================================================================
-- 2) pg_dump / pg_restore actions (Terminal + optional psql \! wrappers)
-- =====================================================================

\echo '2) Backup/restore actions (pg_dump, pg_restore)'

-- NOTE: Run in terminal OR with psql shell escape (\!).
-- Plain SQL backup
-- pg_dump -h localhost -U postgres -d university > university_backup.sql
\! pg_dump -h localhost -U postgres -d university > university_backup.sql

-- Custom compressed backup (recommended)
-- pg_dump -h localhost -U postgres -d university -Fc > university_backup.dump
\! pg_dump -h localhost -U postgres -d university -Fc > university_backup.dump

-- Backup selected tables only
-- pg_dump -h localhost -U postgres -d university -t students -t courses -t enrollments > university_academic_tables.sql
\! pg_dump -h localhost -U postgres -d university -t students -t courses -t enrollments > university_academic_tables.sql

-- Verbose custom backup
-- pg_dump -h localhost -U postgres -d university -Fc -v > university_verbose.dump
\! pg_dump -h localhost -U postgres -d university -Fc -v > university_verbose.dump

-- Restore custom backup to existing DB
-- pg_restore -h localhost -U postgres -d university university_backup.dump
\! pg_restore -h localhost -U postgres -d university university_backup.dump

-- Restore into fresh DB
-- createdb -h localhost -U postgres university_restore_test
-- pg_restore -h localhost -U postgres -d university_restore_test university_backup.dump
\! createdb -h localhost -U postgres university_restore_test
\! pg_restore -h localhost -U postgres -d university_restore_test university_backup.dump

-- Restore single table
-- pg_restore -h localhost -U postgres -d university -t students university_backup.dump
\! pg_restore -h localhost -U postgres -d university -t students university_backup.dump

-- Parallel restore
-- pg_restore -h localhost -U postgres -d university_restore_test -j 4 university_backup.dump
\! pg_restore -h localhost -U postgres -d university_restore_test -j 4 university_backup.dump

-- Advanced pg_dump options
\! pg_dump -h localhost -U postgres -d university -s > university_schema_only.sql
\! pg_dump -h localhost -U postgres -d university -a > university_data_only.sql
\! pg_dump -h localhost -U postgres -d university -T enrollments > university_without_enrollments.sql
\! pg_dumpall -h localhost -U postgres > full_cluster_backup.sql


-- =====================================================================
-- 3) Full backup + automation + validation
-- =====================================================================

\echo '3) Full backups, automation, validation'

-- Full backup with verbose output
\! pg_dump -h localhost -U postgres -d university -Fc --verbose > full_university.dump

-- Preserve ownership metadata in dump
\! pg_dump -h localhost -U postgres -d university -Fc -O > university_with_ownership.dump

-- Daily backup script action (save separately as .sh if needed)
-- ---------------------------------------------------------------------
-- #!/bin/bash
-- DATE=$(date +%Y%m%d_%H%M%S)
-- BACKUP_DIR="$HOME/backups/postgresql"
-- DB_NAME="university"
--
-- mkdir -p "$BACKUP_DIR"
-- pg_dump -h localhost -U postgres -d "$DB_NAME" -Fc > "$BACKUP_DIR/${DB_NAME}_${DATE}.dump"
-- find "$BACKUP_DIR" -name "${DB_NAME}_*.dump" -mtime +7 -delete
-- ---------------------------------------------------------------------

-- Validate backup integrity
\! pg_restore --list university_backup.dump
\! createdb -h localhost -U postgres university_restore_verify
\! pg_restore -h localhost -U postgres -d university_restore_verify university_backup.dump


-- =====================================================================
-- 4) Incremental backup concepts (WAL + base backup)
-- =====================================================================

\echo '4) WAL + base backup concepts'

-- postgresql.conf settings (apply on DB server config, not inside SQL):
-- wal_level = replica
-- archive_mode = on
-- archive_command = 'cp %p /backup/wal/%f'

-- Base backup actions (terminal):
-- pg_basebackup -h localhost -U replication_user -D /backup/base -Ft -z -P
-- pg_basebackup -h localhost -U replication_user -D /backup/base -x -P

-- WAL maintenance SQL
SELECT pg_switch_wal();

-- WAL cleanup action (terminal)
-- pg_archivecleanup /backup/wal 000000010000000000000010
\! pg_archivecleanup /backup/wal 000000010000000000000010


-- =====================================================================
-- 5) Point-in-Time Recovery (PITR)
-- =====================================================================

\echo '5) PITR commands and SQL restore point'

-- Recovery flow (server terminal actions; Linux paths):
-- ---------------------------------------------------------------------
-- sudo systemctl stop postgresql
-- rm -rf /var/lib/postgresql/data/*
-- tar -xf /backup/base/base.tar -C /var/lib/postgresql/data/
-- cat > /var/lib/postgresql/data/recovery.signal << EOF
-- restore_command = 'cp /backup/wal/%f %p'
-- recovery_target_time = '2026-03-01 12:30:00'
-- EOF
-- sudo systemctl start postgresql
-- ---------------------------------------------------------------------

-- Other recovery targets (in postgresql.conf/recovery settings):
-- recovery_target_xid = '12345'
-- recovery_target_name = 'before_enrollment_bulk_update'

-- Create named restore point
SELECT pg_create_restore_point('before_enrollment_bulk_update');


-- =====================================================================
-- 6) Data migration strategies
-- =====================================================================

\echo '6) Data migration strategies'

-- Strategy 1: Dump and restore (terminal)
\! pg_dump -h source_host -U postgres -d university -Fc > university_migration.dump
\! pg_restore -h target_host -U postgres -d university university_migration.dump

-- Strategy 2: Logical replication (run source and target parts separately)
-- Source:
CREATE PUBLICATION university_pub FOR TABLE students, courses, enrollments;

-- Target:
CREATE SUBSCRIPTION university_sub
CONNECTION 'host=source_host dbname=university user=replication_user'
PUBLICATION university_pub;

-- Strategy 3: Physical replication settings/actions
-- In postgresql.conf (primary):
-- wal_level = replica
-- max_wal_senders = 3
--
-- Terminal:
\! pg_basebackup -h primary_host -D /var/lib/postgresql/standby -U replication_user -R -P

-- Strategy 4: ETL pipeline
DROP TABLE IF EXISTS staging_students;
CREATE TABLE staging_students AS SELECT * FROM students WHERE 1 = 0;

COPY (
	SELECT * FROM students ORDER BY id LIMIT 1000 OFFSET 0
) TO '/tmp/students_batch_1.csv' WITH CSV HEADER;

COPY staging_students
FROM '/tmp/students_batch_1.csv'
WITH CSV HEADER;

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


-- =====================================================================
-- 7) Migration best practices checks
-- =====================================================================

\echo '7) Pre/post migration checks'

SELECT COUNT(*) AS students_count FROM students;
SELECT COUNT(*) AS enrollments_count FROM enrollments;

SELECT pid, usename, application_name, client_addr, state
FROM pg_stat_activity
WHERE application_name IN ('pg_dump', 'pg_restore');

-- Trial migration action
-- pg_dump -h source_host -U postgres -d university -t students | psql -h target_host -U postgres -d university_test
\! pg_dump -h source_host -U postgres -d university -t students | psql -h target_host -U postgres -d university_test


-- =====================================================================
-- 8) Handling large table migrations
-- =====================================================================

\echo '8) Large-table migration pattern (partition example)'

DROP TABLE IF EXISTS enrollments_partitioned CASCADE;

CREATE TABLE enrollments_partitioned (
	LIKE enrollments INCLUDING ALL
) PARTITION BY RANGE (enrollment_date);

CREATE TABLE enrollments_2026 PARTITION OF enrollments_partitioned
FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');

-- Migrate a specific partition/table slice
\! pg_dump -h source_host -U postgres -d university -t enrollments_2026 | psql -h target_host -U postgres -d university


-- =====================================================================
-- 9) Checklist summary (comments)
-- =====================================================================
-- [x] COPY TO/FROM: students, employees, courses
-- [x] CSV options: HEADER, DELIMITER, QUOTE, ESCAPE, NULL, ENCODING
-- [x] pg_dump backups (full + partial)
-- [x] pg_restore restores (single table + full DB + parallel)
-- [x] WAL/base backup + PITR coverage
-- [x] Migration strategies: dump/restore, logical, physical, ETL

\echo '=== LAB 17 END ==='
