CREATE TABLE courses (id SERIAL PRIMARY KEY, credits INT, name VARCHAR(100));

INSERT INTO courses(name, credits) VALUES('Introduction to programming', 6);
INSERT INTO courses(name, credits) VALUES('Introduction to web programming', 6);
INSERT INTO courses(name, credits) VALUES('Object-oriented programming', 6);
INSERT INTO courses(name, credits) VALUES('Structural programming', 6);
INSERT INTO courses(name, credits) VALUES('System programming', 6);
INSERT INTO courses(name, credits) VALUES('Parallel programming', 6);
INSERT INTO courses(name, credits) VALUES('Introduction to Artificial Intelligence', 6);
INSERT INTO courses(name, credits) VALUES('Data Science', 6);

SELECT * FROM courses;


alter table courses
add column department_id INT;

alter table courses
add constraint fk_course_department
    foreign key(department_id)
    references departments(id);

update courses set department_id = 1;  