\c university

\d students

-- table courses
CREATE TABLE courses (id SERIAL PRIMARY KEY, credits INT, name VARCHAR(100));

-- table departments
CREATE TABLE departments(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- table students
CREATE TABLE students (
id SERIAL PRIMARY KEY,
name VARCHAR(100));

-- table enrollments
CREATE TABLE enrollments(
id SERIAL PRIMARY KEY,
studentId INT,
courseID INT
);

-- table employees
CREATE TABLE employees(
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    position VARCHAR(100),
    department_id INT
);

ALTER TABLE students ADD COLUMN IF NOT EXISTS phone VARCHAR(20);
ALTER TABLE students ALTER COLUMN name TYPE VARCHAR(120);
ALTER TABLE students RENAME COLUMN phone TO contact_phone;
ALTER TABLE students DROP COLUMN IF EXISTS contact_phone;

ALTER TABLE students DROP CONSTRAINT IF EXISTS chk_students_gpa;
ALTER TABLE students
ADD CONSTRAINT chk_students_gpa
CHECK (gpa IS NULL OR (gpa >= 0 AND gpa <= 4));
