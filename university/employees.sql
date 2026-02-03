create table employees(
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    position VARCHAR(100),
    department_id INT
);

alter table employees
add constraint fk_employee_department
    foreign key(department_id)
    references departments(id);

insert into employees(first_name, last_name, position, department_id)
            values('John', 'Doe', 'Software Engineer', 1);
insert into employees(first_name, last_name, position, department_id)
            values('Sora', 'Nagoyaki', 'Instructor', 2);
insert into employees(first_name, last_name, position, department_id)
            values('Bello', 'Smith', 'Instructor', 3);
insert into employees(first_name, last_name, position, department_id)
            values('Sara', 'Benethon', 'Instructor', 2);

select * from employees;