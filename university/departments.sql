-- Create departments table
create table departments(
    id serial primary key,
    name varchar(100) not null unique
);

-- Populate departments table
insert into departments(name) values('Computer Science');
insert into departments(name) values('Mathematics');
insert into departments(name) values('Physics');
insert into departments(name) values('Chemistry');

-- Query all departments
select * from departments;

-- Delete the Chemistry department
delete from departments where name = 'Chemistry';
