select * from students order by id;

-- Insert a new student with missing email
insert into students (name, department_id, gpa, graduation_year)
values ('Ian', 2, 3.5, 2024);

-- Update columns in table
update students
set email = case
when email is null or email = '' then null
when email like '%@%' then regexp_replace(email, '@.*$', '@auca.kg')
else email || '@auca.kg'
end;

-- Insert a new student with complete data and wrong email 
insert into students (name, email, department_id, gpa, graduation_year)
values ('Hannah', 'hannah@krsu.edu.kg', 1, 3.8, 2025);

-- Delete row with invalid email
delete from students
where email is not null and email <> '' and email not like '%@auca.kg';

-- Delete student who has graduation year in the past
delete from students
where graduation_year < extract(year from current_date);    

-- Final check of students table
select * from students;

-- Basic data operations;
copy students(first_name, last_name, birth_date)
from '/path/to/students.csv'
delimiter ','
csv header;

--  create a temporary table to hold raw student data
create table students_raw (
    id int primary key,
    name text,
    age int,
    email text,
    department text,
    gpa decimal(3,2),
    graduation_year int
);

-- import data into students_raw table
copy students_raw(id, name, age, email, department, gpa, graduation_year)
from 'students_raw.csv'
delimiter ','
csv header;

-- check imported data
select * from students_raw;

-- bulk insert students table from students_raw
insert into students (id, name, email, gpa, graduation_year)
select id, name, email, gpa, graduation_year
from students_raw;

-- insert distinct departments from students_raw table into departments table
-- on conflict, do nothing (skip if department already exists)
insert into departments (name)
select distinct department from students_raw
where department is not null
on conflict (name) do nothing;

-- check departments table after bulk insert
select * from departments;

-- Update department_id in students table based on matching department name in students_raw and departments tables
update students 
set department_id = (select id from departments where name = students_raw.department)
from students_raw
where students.id = students_raw.id

-- Insert new student with less gpa than 2.0
insert into students (name, email, department_id, gpa, graduation_year)
values ('Jack', 'jack@auca.kg', 1, 1.8, 2025);

-- Delete students who does not have enough gpa (assuming gpa < 2.0 is not enough)
delete from students
where gpa < 2.0;