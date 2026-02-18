select * from employees;

-- Query to get employee names and their salaries using a subquery
select first_name, last_name, 
    (select salary FROM positions WHERE positions.id = employees.position_id)
 from employees;

-- Perform calculations on the fly. This query calculates a 10% bonus for each employee:select first_name, last_name, 
select first_name, last_name, 
    (select salary FROM positions WHERE positions.id = employees.position_id) as salary,
    (select salary FROM positions WHERE positions.id = employees.position_id) * 1.10 as salary_with_bonus
 from employees;

--  Select employees with paid under 50000
select * from employees where (select salary FROM positions WHERE positions.id = employees.position_id) < 50000;

-- Select students with gpa less than 2.7
select * from students where gpa < 2.7;

select * from enrollments;

-- Select all students total number of courses they are enrolled in
select students.name, count(enrollments.id) as total_courses
from students
left join enrollments on students.id = enrollments.student_id
group by students.id, students.name order by total_courses desc;

--  Select students whose names end with 'ov'
select * from students
where name ~ 'ov$'; -- names ending with 'ov'
