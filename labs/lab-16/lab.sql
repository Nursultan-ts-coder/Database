\c university

BEGIN;

INSERT INTO enrollments (student_id, course_id, semester, enrollment_date)
SELECT 13, 8, 'Spring 2026', CURRENT_DATE
WHERE NOT EXISTS (
		SELECT 1
		FROM enrollments
		WHERE student_id = 13
			AND course_id = 8
			AND semester = 'Spring 2026'
);

UPDATE students
SET gpa = LEAST(COALESCE(gpa, 2.0) + 0.05, 4.00)
WHERE id = 13;

COMMIT;

BEGIN;

UPDATE students
SET gpa = GREATEST(COALESCE(gpa, 2.0) - 0.10, 0.00)
WHERE id = 13;

ROLLBACK;

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT id, name, gpa FROM students WHERE gpa >= 3.0 ORDER BY gpa DESC;
COMMIT;

BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT id, name, gpa FROM students WHERE gpa >= 3.0 ORDER BY gpa DESC;
SELECT id, name, gpa FROM students WHERE gpa >= 3.0 ORDER BY gpa DESC;
COMMIT;

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
UPDATE students
SET gpa = gpa
WHERE id = 13;
COMMIT;

BEGIN;

SAVEPOINT sp_before_enroll;

INSERT INTO enrollments (student_id, course_id, semester, enrollment_date)
SELECT 5305, 8, 'Spring 2026', CURRENT_DATE
WHERE NOT EXISTS (
		SELECT 1
		FROM enrollments
		WHERE student_id = 5305
			AND course_id = 8
			AND semester = 'Spring 2026'
);

SAVEPOINT sp_after_enroll;

UPDATE students
SET email = 'temporary_change@auca.kg'
WHERE id = 5305;

ROLLBACK TO SAVEPOINT sp_after_enroll;

COMMIT;

SELECT id, student_id, course_id, semester, enrollment_date
FROM enrollments
ORDER BY id DESC
LIMIT 15;


-- First, add a unique constraint to prevent duplicate enrollments:
ALTER TABLE enrollments
ADD CONSTRAINT unique_student_course_semester 
UNIQUE (student_id, course_id, semester);

-- Then use this transaction:
-- Start enrolling student with id 5305
BEGIN;

INSERT INTO enrollments (student_id, course_id, semester, enrollment_date)
VALUES (5305, 8, 'Spring 2026', CURRENT_DATE)
ON CONFLICT (student_id, course_id, semester) 
DO NOTHING;  -- Or DO UPDATE to modify existing enrollment
COMMIT;


-- Start enrolling student with id 13
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;

INSERT INTO enrollments (student_id, course_id, semester, enrollment_date)
VALUES (13, 8, 'Spring 2026', CURRENT_DATE)
ON CONFLICT (student_id, course_id, semester) 
DO NOTHING;  -- Or DO UPDATE to modify existing enrollment

COMMIT;