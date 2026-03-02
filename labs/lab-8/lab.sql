\c university

\d students
\d courses
\d enrollments

SELECT tc.table_name, kcu.column_name, ccu.table_name AS referenced_table, ccu.column_name AS referenced_column
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu
  ON tc.constraint_name = kcu.constraint_name AND tc.table_schema = kcu.table_schema
JOIN information_schema.constraint_column_usage ccu
  ON ccu.constraint_name = tc.constraint_name AND ccu.table_schema = tc.table_schema
WHERE tc.constraint_type = 'FOREIGN KEY' AND tc.table_schema = 'public'
ORDER BY tc.table_name, kcu.column_name;

ALTER TABLE enrollments DROP CONSTRAINT IF EXISTS fk_enrollment_student;
ALTER TABLE enrollments ADD CONSTRAINT fk_enrollment_student
FOREIGN KEY (student_id) REFERENCES students(id)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE enrollments DROP CONSTRAINT IF EXISTS fk_enrollment_course;
ALTER TABLE enrollments ADD CONSTRAINT fk_enrollment_course
FOREIGN KEY (course_id) REFERENCES courses(id)
ON DELETE SET NULL ON UPDATE CASCADE;

