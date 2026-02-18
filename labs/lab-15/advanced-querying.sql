-- Subqueries
-- Subqueris with select

-- List all the courses with number of enrollments

select name, (select count(e.id) as number_of_enrollments from enrollments e where  e.course_id = c.id  ) from courses c order by number_of_enrollments DESC;

-- Rewrite query above using left joints

select c.name as course, count(e.id) as count
from courses c
right join enrollments e on e.course_id = c.id  
group by c.name
order by count desc;

-- Subqueries with from 
-- List students who has mor than 12 credits

select student, total_credits from
 (select s.name as student, sum(c.credits) as total_credits
 from enrollments e
 join students s on e.student_id = s.id
 join courses c on  e.course_id = c.id  
 group by s.name
 order by total_credits DESC NULLS LAST
)
where total_credits >= 12


-- List all students with their total credits
-- 1. Approach
SELECT 
    s.name AS student, 
    COALESCE((
    SELECT sum(c.credits)
        FROM enrollments e
        JOIN courses c ON e.course_id = c.id
        WHERE e.student_id = s.id
    ), 0) AS total_credits
FROM students s
ORDER BY total_credits DESC NULLS LAST;

-- 2. Approach
SELECT s.name AS student, COALESCE(sum(c.credits), 0) AS total_credits
        FROM students s
        LEFT JOIN enrollments e ON e.student_id = s.id
        LEFT JOIN courses c ON e.course_id = c.id
        GROUP BY s.id, s.name
        ORDER BY total_credits DESC;


-- Common table expressions
-- Filter only professors

WITH cte_professors AS (
    SELECT first_name, last_name,
    (SELECT name FROM positions p where p.id = e.position_id) AS position,
    (SELECT name FROM departments d WHERE d.id = e.department_id ) AS department
    FROM employees e
    WHERE e.position_id IN (SELECT id FROM positions WHERE name = 'Professor' )
)

SELECT * FROM cte_professors;

-- Window Functions & Partitioning
-- PARTITION BY
-- Find average salary per department while keeping all rows:
SELECT d.name, AVG(salary) OVER (PARTITION BY d.id) AS avg_dept_salary
  FROM employees e
  LEFT JOIN positions p ON e.position_id = p.id 
  LEFT JOIN departments d ON e.department_id = d.id 

-- Get top 3 students for each department

SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY department_id
               ORDER BY gpa DESC NULLS LAST
           ) AS rn
    FROM students
) t
WHERE rn <= 3;









