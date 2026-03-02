\c university

SELECT * FROM employees;

SELECT e.first_name, e.last_name, p.salary
FROM employees e
JOIN positions p ON p.id = e.position_id;

SELECT e.first_name, e.last_name, p.salary, p.salary * 0.10 AS potential_bonus
FROM employees e
JOIN positions p ON p.id = e.position_id;

SELECT e.first_name, e.last_name, p.salary
FROM employees e
JOIN positions p ON p.id = e.position_id
WHERE p.salary > 50000
ORDER BY p.salary DESC;

SELECT name, email
FROM students
WHERE name ILIKE 'n%';

SELECT name
FROM courses
WHERE name ILIKE '%programming';

SELECT email
FROM students
WHERE email ILIKE '%@auca.kg';

SELECT name
FROM students
WHERE name ~* 'ov$';

SELECT s.id, s.name, s.gpa,
       CASE
           WHEN s.gpa >= 3.5 THEN 'excellent'
           WHEN s.gpa >= 3.0 THEN 'good'
           WHEN s.gpa >= 2.0 THEN 'pass'
           ELSE 'risk'
       END AS gpa_status
FROM students s
ORDER BY s.gpa DESC NULLS LAST, s.name;

SELECT s.id, s.name, s.department_id
FROM students s
WHERE s.department_id IN (
    SELECT d.id
    FROM departments d
    WHERE d.name ILIKE '%computer%' OR d.name ILIKE '%engineering%'
)
ORDER BY s.name;

SELECT s.id, s.name
FROM students s
WHERE EXISTS (
    SELECT 1
    FROM enrollments e
    WHERE e.student_id = s.id
)
ORDER BY s.name;

SELECT id, name, gpa
FROM students
ORDER BY gpa DESC NULLS LAST
LIMIT 5;

WITH student_course_counts AS (
    SELECT s.id, s.name, COUNT(e.id) AS course_count
    FROM students s
    LEFT JOIN enrollments e ON e.student_id = s.id
    GROUP BY s.id, s.name
)
SELECT * FROM student_course_counts
ORDER BY course_count DESC, name;

SELECT * FROM employees;

-- Query to get employee names and their salaries using a subquery
SELECT first_name, last_name, 
    (SELECT salary FROM positions WHERE positions.id = employees.position_id)
 FROM employees;

-- Perform calculations on the fly. This query calculates a 10% bonus for each employee:select first_name, last_name, 
SELECT first_name, last_name, 
    (SELECT salary FROM positions WHERE positions.id = employees.position_id) AS salary,
    (SELECT salary FROM positions WHERE positions.id = employees.position_id) * 1.10 AS salary_with_bonus
 FROM employees;

--  Select employees with paid under 50000
SELECT * FROM employees WHERE (SELECT salary FROM positions WHERE positions.id = employees.position_id) < 50000;

-- Select students with gpa less than 2.7
SELECT * FROM students WHERE gpa < 2.7;

SELECT * FROM enrollments;

-- Select all students total number of courses they are enrolled in
SELECT students.name, COUNT(enrollments.id) AS total_courses
FROM students
LEFT JOIN enrollments ON students.id = enrollments.student_id
GROUP BY students.id, students.name ORDER BY total_courses DESC;

--  Select students whose names end with 'ov'
SELECT * FROM students
WHERE name ~ 'ov$'; -- names ending with 'ov'

