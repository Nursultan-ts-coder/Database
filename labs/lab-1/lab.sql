\c university

SELECT current_user, current_database();

SELECT * FROM students ORDER BY id LIMIT 10;
SELECT * FROM courses ORDER BY id LIMIT 10;
SELECT * FROM departments ORDER BY id;

SELECT s.name AS student, c.name AS course
FROM enrollments e
JOIN students s ON s.id = e.student_id
JOIN courses c ON c.id = e.course_id
ORDER BY s.name, c.name;

SELECT d.name AS department, COUNT(s.id) AS students_count
FROM departments d
LEFT JOIN students s ON s.department_id = d.id
GROUP BY d.name
ORDER BY students_count DESC, d.name;
