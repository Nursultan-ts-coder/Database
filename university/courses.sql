create table courses (id serial primary key, credits int, name varchar(100));

-- Insert some courses
insert into courses(name, credits) values('Introduction to programming', 6);
insert into courses(name, credits) values('Introduction to web programming', 6);
insert into courses(name, credits) values('Object-oriented programming', 6);
insert into courses(name, credits) values('Structural programming', 6);
insert into courses(name, credits) values('System programming', 6);
insert into courses(name, credits) values('Parallel programming', 6);
insert into courses(name, credits) values('Introduction to Artificial Intelligence', 6);
insert into courses(name, credits) values('Data Science', 6);

-- Query all courses
select * from courses;

-- Add department_id column
alter table courses
add column department_id int;

-- Add foreign key constraint
alter table courses
add constraint fk_course_department
    foreign key(department_id)
    references departments(id);

-- Add instructor_id column
alter table courses
add column instructor_id int;

alter table courses
add constraint fk_course_instructor
    foreign key(instructor_id)
    references employees(id);    

-- Set department_id for all courses to 1 (assuming department with id 1 exists)
update courses set department_id = 1;  

update courses set instructor_id = 1;


