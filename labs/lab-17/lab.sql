\c university

COPY students TO '/tmp/students_export.csv' WITH (FORMAT csv, HEADER true);
COPY employees TO '/tmp/employees_pipe.txt' WITH (FORMAT csv, HEADER true, DELIMITER '|', NULL 'N/A');

COPY (
	SELECT s.id, s.name, s.email, d.name AS department_name
	FROM students s
	LEFT JOIN departments d ON d.id = s.department_id
	ORDER BY s.id
) TO '/tmp/students_with_departments.csv' WITH (FORMAT csv, HEADER true);

\copy students(name, email, department_id, gpa, graduation_year)
FROM 'data/students.csv' WITH (FORMAT csv, HEADER true);

\! pg_dump -h localhost -U nursultanlukmanov -d university > university_backup.sql
\! pg_dump -h localhost -U nursultanlukmanov -d university -Fc > university_backup.dump
\! pg_dump -h localhost -U nursultanlukmanov -d university -t students -t courses -t enrollments > university_academic_tables.sql
\! pg_dump -h localhost -U nursultanlukmanov -d university -s > university_schema_only.sql
\! pg_dump -h localhost -U nursultanlukmanov -d university -a > university_data_only.sql
\! pg_restore --list university_backup.dump

SELECT pg_switch_wal();
SELECT pg_create_restore_point('before_enrollment_bulk_update');

