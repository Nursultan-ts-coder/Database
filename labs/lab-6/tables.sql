-- table courses
create table courses (id serial primary key, credits int, name varchar(100));

-- table departments
create table departments(
    id serial primary key,
    name varchar(100) not null unique
);

-- table students
create table students (
id serial primary key,
name varchar(100));

-- table enrollments
create table enrollments(
id serial primary key,
studentId int,
courseID int
);

-- table employees
create table employees(
    id serial primary key,
    first_name varchar(100),
    last_name varchar(100),
    position varchar(100),
    department_id int
);