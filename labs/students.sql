-- Create students table
CREATE TABLE students (
id SERIAL PRIMARY KEY,
name VARCHAR(100));

-- Insert some students
INSERT INTO students(name) VALUES('Alice');
INSERT INTO students(name) VALUES('Bob');
INSERT INTO students(name) VALUES('Charlie');
INSERT INTO students(name) VALUES('Diana');
INSERT INTO students(name) VALUES('Eve');
INSERT INTO students(name) VALUES('Frank');
INSERT INTO students(name) VALUES('Grace');
INSERT INTO students(name) VALUES('Nursultan Lukmanov');

-- Query all students
SELECT * FROM students;

-- Alter table to add age department and email
ALTER TABLE students
ADD COLUMN email VARCHAR(100),
ADD COLUMN department INT;

-- Alter table to add gpa department and email

ALTER TABLE students
ADD COLUMN gpa DECIMAL(3,2),
ADD COLUMN graduation_year INT;

-- check table students if new columns are added
SELECT * FROM students;

UPDATE students SET department = 1 WHERE name = 'Alice';
UPDATE students SET department = 2 WHERE name = 'Bob';
UPDATE students SET department = 2 WHERE name = 'Charlie';
UPDATE students SET department = 3 WHERE name = 'Diana';
UPDATE students SET department = 1 WHERE name = 'Eve';
UPDATE students SET department = 3 WHERE name = 'Frank';
UPDATE students SET department = 3 WHERE name = 'Grace';

-- add constraints to email column
ALTER TABLE students
ADD CONSTRAINT email_unique UNIQUE(email);

-- rename department column to department_id and add foreign key constraint
ALTER TABLE students
RENAME COLUMN department TO department_id;

-- add foreign key constraint for department_id
ALTER TABLE students
ADD CONSTRAINT fk_student_department
    FOREIGN KEY(department_id)
    REFERENCES departments(id);
