-- 1.1 List all students with their department names
    select s.name, d.name as department
    from students s
    join departments d on s.department_id = d.id;

select * from departments;

-- 1.2 List all instructors with their department names
select e.first_name, e.last_name, d.name as department
 from employees e
join departments d on e.department_id = d.id;


-- 2. List all students with their enrolled courses
select s.name as student, c.name as course
from students s
join enrollments e on s.id = e.student_id
join courses c on e.course_id = c.id

-- 3. List employees with their department names and positions 

select e.first_name, e.last_name, p.name as position, d.name as department
from employees e
join positions p on  e.position_id = p.id
join departments d on e.department_id = d.id;

-- 4. Count how many courses each student is taking
select s.name, count(*) as course_count 
from enrollments e
join students s on e.student_id = s.id
group by s.name
order by course_count desc;

-- 5. List all departments with number of courses offered
select d.name, count(*) as course_count
from courses c
join departments d on c.department_id = d.id
group by d.name
order by course_count desc;

-- 6. Full course enrollment report (with department and number of students enrolled, instructor name, and course credits)
select s.name as student, c.name as course, d.name as department, 
       e.first_name || ' ' || e.last_name as instructor, c.credits,
       count(*) over (partition by c.id) as total_students_enrolled
from enrollments en
join students s on s.id = en.student_id
join courses c on c.id = en.course_id
join departments d on d.id = c.department_id
join employees e on e.id = c.instructor_id;



