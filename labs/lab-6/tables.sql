-- table courses
CREATE TABLE courses (id SERIAL PRIMARY KEY, credits INT, name VARCHAR(100));

-- table departments
create table departments(
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
create table employees(
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    position VARCHAR(100),
    department_id INT
);