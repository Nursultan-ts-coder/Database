CREATE TABLE students (
id SERIAL PRIMARY KEY,
name VARCHAR(100));

INSERT INTO students(name) VALUES('Alice');
INSERT INTO students(name) VALUES('Bob');
INSERT INTO students(name) VALUES('Charlie');
INSERT INTO students(name) VALUES('Diana');
INSERT INTO students(name) VALUES('Eve');
INSERT INTO students(name) VALUES('Frank');
INSERT INTO students(name) VALUES('Grace');

SELECT * FROM students;

select * from students where name = 'Grace';

select * from students order by name;

select * from students order by name limit 3;

-- Alter table to add age department and email

alter table students
add column email VARCHAR(100),
add column department INT;

-- Alter table to add gpa department and email

alter table students
add column gpa DECIMAL(3,2),
add column graduation_year INT;

-- check table students if new columns are added
select * from students;

update students set department = 1 where name = 'Alice';
update students set department = 2 where name = 'Bob';
update students set department = 2 where name = 'Charlie';
update students set department = 3 where name = 'Diana';
update students set department = 1 where name = 'Eve';
update students set department = 3 where name = 'Frank';
update students set department = 3 where name = 'Grace';

-- add constraints to email column
alter table students
add constraint email_unique unique(email);

-- rename department column to department_id and add foreign key constraint
alter table students
rename column department to department_id;

alter table students
add constraint fk_student_department
    foreign key(department_id)
    references departments(id);



CREATE TABLE students_raw (
    id INT PRIMARY KEY,
    name TEXT,
    age INT,
    email TEXT,
    department TEXT,
    gpa DECIMAL(3,2),
    graduation_year INT
);

COPY students_raw(id, name, age, email, department, gpa, graduation_year)
FROM 'students_raw.csv'
DELIMITER ','
CSV HEADER;

select * from students_raw;


INSERT INTO students (id, name, email, gpa, graduation_year)
SELECT id, name, email, gpa, graduation_year
FROM students_raw;