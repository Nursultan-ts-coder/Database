\c university

SELECT id, name, email, department_id, gpa, graduation_year
FROM students
ORDER BY id;

BEGIN;

INSERT INTO students (name, email, department_id, gpa, graduation_year)
VALUES ('Lab11 Demo Student', 'lab11_demo@auca.kg', 1, 3.20, 2027);

UPDATE students
SET email = regexp_replace(email, '@.*$', '@auca.kg')
WHERE email IS NOT NULL
    AND email LIKE '%@%';

DELETE FROM students
WHERE email IS NOT NULL
    AND email <> ''
    AND email NOT LIKE '%@auca.kg';

SAVEPOINT before_low_gpa_delete;

DELETE FROM students
WHERE gpa IS NOT NULL
    AND gpa < 2.0;

ROLLBACK TO SAVEPOINT before_low_gpa_delete;

COPY (
    SELECT name, email, department_id, gpa, graduation_year
    FROM students
    ORDER BY id
) TO '/tmp/university_students_roundtrip.csv' WITH (FORMAT csv, HEADER true);

\copy students(name, email, department_id, gpa, graduation_year)
FROM '/tmp/university_students_roundtrip.csv' WITH (FORMAT csv, HEADER true);

ROLLBACK;

SELECT id, name, email, department_id, gpa, graduation_year
FROM students
ORDER BY id;


SELECT * FROM students ORDER BY id;

-- Insert a new student with missing email
INSERT INTO students (name, department_id, gpa, graduation_year)
VALUES ('Ian', 2, 3.5, 2024);

-- Update columns in table
UPDATE students
SET email = CASE
WHEN email IS NULL OR email = '' THEN NULL
WHEN email LIKE '%@%' THEN regexp_replace(email, '@.*$', '@auca.kg')
ELSE email || '@auca.kg'
END;

-- Insert a new student with complete data and wrong email 
INSERT INTO students (name, email, department_id, gpa, graduation_year)
VALUES ('Hannah', 'hannah@krsu.edu.kg', 1, 3.8, 2025);

-- Delete row with invalid email
DELETE FROM students
WHERE email IS NOT NULL AND email <> '' AND email NOT LIKE '%@auca.kg';

-- Delete student who has graduation year in the past
DELETE FROM students
WHERE graduation_year < extract(YEAR FROM current_date);    

-- Final check of students table
SELECT * FROM students;

-- Basic data operations;
COPY students(first_name, last_name, birth_date)
FROM 'data/students.csv'
DELIMITER ','
CSV HEADER;

--  create a temporary table to hold raw student data
CREATE TABLE students_raw (
    id INT PRIMARY KEY,
    name TEXT,
    age INT,
    email TEXT,
    department TEXT,
    gpa DECIMAL(3,2),
    graduation_year INT
);

-- import data into students_raw table
COPY students_raw(id, name, age, email, department, gpa, graduation_year)
FROM 'students_raw.csv'
DELIMITER ','
CSV HEADER;

-- check imported data
SELECT * FROM students_raw;

-- bulk insert students table from students_raw
INSERT INTO students (id, name, email, gpa, graduation_year)
SELECT id, name, email, gpa, graduation_year
FROM students_raw;

-- insert distinct departments from students_raw table into departments table
-- on conflict, do nothing (skip if department already exists)
INSERT INTO departments (name)
SELECT DISTINCT department FROM students_raw
WHERE department IS NOT NULL
ON CONFLICT (name) DO NOTHING;

-- check departments table after bulk insert
SELECT * FROM departments;

-- Update department_id in students table based on matching department name in students_raw and departments tables
UPDATE students 
SET department_id = (SELECT id FROM departments WHERE name = students_raw.department)
FROM students_raw
WHERE students.id = students_raw.id

-- Insert new student with less gpa than 2.0
INSERT INTO students (name, email, department_id, gpa, graduation_year)
VALUES ('Jack', 'jack@auca.kg', 1, 1.8, 2025);

-- Delete students who does not have enough gpa (assuming gpa < 2.0 is not enough)
DELETE FROM students
WHERE gpa < 2.0;


