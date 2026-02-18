-- Get count of students in each department
select d.name as department, count(s.id) as student_count
from students s
join departments d on s.department_id = d.id
group by d.name;

-- Get average gpa of students in each department
select d.name as department, avg(s.gpa) as average_gpa
from students s
join departments d on s.department_id = d.id
group by d.name;

-- Get maximum gpa of students in each department
select d.name as department, max(s.gpa) as max_gpa
from students s
join departments d on s.department_id = d.id
group by d.name;

-- Select total salary expenditure
select sum(salary)
from employees e
join positions p on e.position_id = p.id

-- Get average salary by department
select d.name as department, avg(p.salary) as average_salary
from employees e
join positions p on e.position_id = p.id
join departments d on e.department_id = d.id
group by d.name;
