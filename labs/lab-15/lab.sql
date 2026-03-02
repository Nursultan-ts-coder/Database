-- Subqueries
-- Subqueris with select

-- List all the courses with number of enrollments

SELECT name, (SELECT COUNT(e.id) AS number_of_enrollments FROM enrollments e WHERE  e.course_id = c.id  ) FROM courses c ORDER BY number_of_enrollments DESC;

-- Rewrite query above using left joints

SELECT c.name AS course, COUNT(e.id) AS count
FROM courses c
RIGHT JOIN enrollments e ON e.course_id = c.id  
GROUP BY c.name
ORDER BY count DESC;

-- Subqueries with from 
-- List students who has mor than 12 credits

SELECT student, total_credits FROM
 (SELECT s.name AS student, SUM(c.credits) AS total_credits
 FROM enrollments e
 JOIN students s ON e.student_id = s.id
 JOIN courses c ON  e.course_id = c.id  
 GROUP BY s.name
 ORDER BY total_credits DESC NULLS LAST
)
WHERE total_credits >= 12


-- List all students with their total credits
-- 1. Approach
SELECT 
    s.name AS student, 
    COALESCE((
    SELECT SUM(c.credits)
        FROM enrollments e
        JOIN courses c ON e.course_id = c.id
        WHERE e.student_id = s.id
    ), 0) AS total_credits
FROM students s
ORDER BY total_credits DESC NULLS LAST;

-- 2. Approach
SELECT s.name AS student, COALESCE(SUM(c.credits), 0) AS total_credits
        FROM students s
        LEFT JOIN enrollments e ON e.student_id = s.id
        LEFT JOIN courses c ON e.course_id = c.id
        GROUP BY s.id, s.name
        ORDER BY total_credits DESC;


-- Common table expressions
-- Filter only professors

WITH cte_professors AS (
    SELECT first_name, last_name,
    (SELECT name FROM positions p WHERE p.id = e.position_id) AS position,
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









