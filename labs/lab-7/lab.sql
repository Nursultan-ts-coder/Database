\c university

\d students
\d courses
\d enrollments

SELECT tc.table_name, kcu.column_name
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu
    ON tc.constraint_name = kcu.constraint_name
WHERE tc.constraint_type = 'PRIMARY KEY'
    AND tc.table_schema = 'public'
ORDER BY tc.table_name, kcu.ordinal_position;

ALTER TABLE enrollments DROP CONSTRAINT IF EXISTS unique_student_course_semester;
ALTER TABLE enrollments
ADD CONSTRAINT unique_student_course_semester
UNIQUE (student_id, course_id, semester);

