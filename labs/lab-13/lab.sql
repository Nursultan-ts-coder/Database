\c university

SELECT COUNT(*) AS total_students FROM students;
SELECT COUNT(email) AS students_with_email FROM students;
SELECT COUNT(DISTINCT department_id) AS unique_departments FROM students;

SELECT SUM(p.salary) AS total_salary
FROM employees e
JOIN positions p ON p.id = e.position_id;

SELECT AVG(gpa) AS average_gpa FROM students;
SELECT MAX(gpa) AS max_gpa, MIN(gpa) AS min_gpa FROM students;

SELECT d.name AS department, COUNT(s.id) AS student_count
FROM departments d
LEFT JOIN students s ON s.department_id = d.id
GROUP BY d.name
ORDER BY student_count DESC;

SELECT d.name AS department, COUNT(s.id) AS student_count
FROM departments d
LEFT JOIN students s ON s.department_id = d.id
GROUP BY d.name
HAVING COUNT(s.id) >= 1
ORDER BY student_count DESC;

SELECT d.name AS department, AVG(s.gpa) AS avg_gpa
FROM departments d
LEFT JOIN students s ON s.department_id = d.id
GROUP BY d.name
HAVING AVG(s.gpa) IS NOT NULL
ORDER BY avg_gpa DESC;

SELECT d.name AS department,
	   STDDEV(s.gpa) AS gpa_stddev,
	   VARIANCE(s.gpa) AS gpa_variance
FROM departments d
LEFT JOIN students s ON s.department_id = d.id
GROUP BY d.name
ORDER BY d.name;

SELECT d.name AS department, STRING_AGG(s.name, ', ' ORDER BY s.name) AS students
FROM departments d
LEFT JOIN students s ON s.department_id = d.id
GROUP BY d.name;

SELECT d.name AS department, ARRAY_AGG(s.gpa ORDER BY s.gpa DESC) AS gpas
FROM departments d
LEFT JOIN students s ON s.department_id = d.id
GROUP BY d.name;

SELECT COUNT(*) AS total_rows,
	   COUNT(gpa) AS non_null_gpa,
	   COUNT(*) - COUNT(gpa) AS null_gpa
FROM students;

-- Get count of students in each department
SELECT d.name AS department, COUNT(s.id) AS student_count
FROM students s
JOIN departments d ON s.department_id = d.id
GROUP BY d.name;

-- Get average gpa of students in each department
SELECT d.name AS department, AVG(s.gpa) AS average_gpa
FROM students s
JOIN departments d ON s.department_id = d.id
GROUP BY d.name;

-- Get maximum gpa of students in each department
SELECT d.name AS department, MAX(s.gpa) AS max_gpa
FROM students s
JOIN departments d ON s.department_id = d.id
GROUP BY d.name;

-- Select total salary expenditure
SELECT SUM(salary)
FROM employees e
JOIN positions p ON e.position_id = p.id

-- Get average salary by department
SELECT d.name AS department, AVG(p.salary) AS average_salary
FROM employees e
JOIN positions p ON e.position_id = p.id
JOIN departments d ON e.department_id = d.id
GROUP BY d.name;
