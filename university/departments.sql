create table departments(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

insert into departments(name) values('Computer Science');
insert into departments(name) values('Mathematics');
insert into departments(name) values('Physics');
insert into departments(name) values('Chemistry');

select * from departments;
delete from departments where name = 'Chemistry';
