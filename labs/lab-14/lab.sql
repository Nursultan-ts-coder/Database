\c university

SELECT s.name, d.name AS department
FROM students s
INNER JOIN departments d ON d.id = s.department_id;

SELECT s.name, e.semester, c.name AS course
FROM students s
LEFT JOIN enrollments e ON e.student_id = s.id
LEFT JOIN courses c ON c.id = e.course_id
ORDER BY s.name;

SELECT e.id, e.first_name, e.last_name, d.name AS department
FROM departments d
RIGHT JOIN employees e ON e.department_id = d.id;

SELECT s.name AS student, c.name AS course
FROM students s
FULL OUTER JOIN enrollments en ON en.student_id = s.id
FULL OUTER JOIN courses c ON c.id = en.course_id;

SELECT d.name AS department, p.name AS position
FROM departments d
CROSS JOIN positions p
LIMIT 20;

SELECT s.name AS student, c.name AS course, d.name AS department,
       emp.first_name || ' ' || emp.last_name AS instructor
FROM enrollments en
JOIN students s ON s.id = en.student_id
JOIN courses c ON c.id = en.course_id
LEFT JOIN departments d ON d.id = c.department_id
LEFT JOIN employees emp ON emp.id = c.instructor_id
ORDER BY student, course;

SELECT s.name
FROM students s
LEFT JOIN enrollments en ON en.student_id = s.id
WHERE en.id IS NULL
ORDER BY s.name;

SELECT e.first_name || ' ' || e.last_name AS employee,
       m.first_name || ' ' || m.last_name AS manager
FROM employees e
LEFT JOIN employees m ON m.id = e.id - 1
ORDER BY e.id;

-- 1.1 List all students with their department names
    SELECT s.name, d.name AS department
    FROM students s
    JOIN departments d ON s.department_id = d.id;

SELECT * FROM departments;

-- 1.2 List all instructors with their department names
SELECT e.first_name, e.last_name, d.name AS department
 FROM employees e
JOIN departments d ON e.department_id = d.id;


-- 2. List all students with their enrolled courses
SELECT s.name AS student, c.name AS course
FROM students s
JOIN enrollments e ON s.id = e.student_id
JOIN courses c ON e.course_id = c.id

-- 3. List employees with their department names and positions 

SELECT e.first_name, e.last_name, p.name AS position, d.name AS department
FROM employees e
JOIN positions p ON  e.position_id = p.id
JOIN departments d ON e.department_id = d.id;

-- 4. Count how many courses each student is taking
SELECT s.name, COUNT(*) AS course_count 
FROM enrollments e
JOIN students s ON e.student_id = s.id
GROUP BY s.name
ORDER BY course_count DESC;

-- 5. List all departments with number of courses offered
SELECT d.name, COUNT(*) AS course_count
FROM courses c
JOIN departments d ON c.department_id = d.id
GROUP BY d.name
ORDER BY course_count DESC;

-- 6. Full course enrollment report (with department and number of students enrolled, instructor name, and course credits)
SELECT s.name AS student, c.name AS course, d.name AS department, 
    e.first_name || ' ' || e.last_name AS instructor, c.credits,
    COUNT(*) OVER (PARTITION BY c.id) AS total_students_enrolled
FROM enrollments en
JOIN students s ON s.id = en.student_id
JOIN courses c ON c.id = en.course_id
JOIN departments d ON d.id = c.department_id
JOIN employees e ON e.id = c.instructor_id;

