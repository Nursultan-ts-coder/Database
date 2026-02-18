-- Create students table
create table students (
id serial primary key,
name varchar(100));

-- Insert some students
insert into students(name) values('Alice');
insert into students(name) values('Bob');
insert into students(name) values('Charlie');
insert into students(name) values('Diana');
insert into students(name) values('Eve');
insert into students(name) values('Frank');
insert into students(name) values('Grace');
insert into students(name) values('Nursultan Lukmanov');

-- Query all students
select * from students;

-- Alter table to add age department and email
alter table students
add column email varchar(100),
add column department int;

-- Alter table to add gpa department and email

alter table students
add column gpa decimal(3,2),
add column graduation_year int;

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

-- add foreign key constraint for department_id
alter table students
add constraint fk_student_department
    foreign key(department_id)
    references departments(id);
