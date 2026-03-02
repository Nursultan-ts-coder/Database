\c university

SELECT * FROM students;
SELECT id, name FROM students;
SELECT name, email FROM students;
SELECT id, name, department_id FROM students WHERE name = 'Nursultan Lukmanov';
SELECT id, name, gpa FROM students WHERE gpa >= 3.0;
SELECT id, name, gpa FROM students ORDER BY gpa DESC NULLS LAST;
SELECT id, name FROM students ORDER BY name LIMIT 2;
SELECT name, email FROM students WHERE name ILIKE 't%';
