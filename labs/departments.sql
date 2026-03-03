-- Create departments table
CREATE TABLE departments(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Populate departments table
INSERT INTO departments(name) VALUES('Computer Science');
INSERT INTO departments(name) VALUES('Mathematics');
INSERT INTO departments(name) VALUES('Physics');
INSERT INTO departments(name) VALUES('Chemistry');

-- Query all departments
SELECT * FROM departments;

-- Delete the Chemistry department
DELETE FROM departments WHERE name = 'Chemistry';
