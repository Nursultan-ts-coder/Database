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