-- Create employees table
create table employees(
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    position VARCHAR(100),
    department_id INT
);

-- Add foreign key constraint to employees table
alter table employees
add constraint fk_employee_department
    foreign key(department_id)
    references departments(id);


-- Insert some employees
insert into employees(first_name, last_name, position, department_id)
            values('John', 'Doe', 'Software Engineer', 1);
insert into employees(first_name, last_name, position, department_id)
            values('Sora', 'Nagoyaki', 'Instructor', 2);
insert into employees(first_name, last_name, position, department_id)
            values('Bello', 'Smith', 'Instructor', 3);
insert into employees(first_name, last_name, position, department_id)
            values('Sara', 'Benethon', 'Instructor', 2);


-- Query all employees
select * from employees;

-- Rename column position to position_id
alter table employees
rename column position to position_id;

-- Change position_id column type to integer
alter table employees
alter column position_id type integer
using position_id::integer;

-- Update employees to set position_id values
update employees set position_id = 1 where first_name = 'John' and last_name = 'Doe';
update employees set position_id = 2 where first_name = 'Sora' and last_name = 'Nagoyaki';
update employees set position_id = 3 where first_name = 'Bello' and last_name = 'Smith';
update employees set position_id = 4 where first_name = 'Sara' and last_name = 'Benethon';