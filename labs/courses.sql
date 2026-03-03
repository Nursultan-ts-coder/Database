CREATE TABLE courses (id SERIAL PRIMARY KEY, credits INT, name VARCHAR(100));

-- Insert some courses
INSERT INTO courses(name, credits) VALUES('Introduction to programming', 6);
INSERT INTO courses(name, credits) VALUES('Introduction to web programming', 6);
INSERT INTO courses(name, credits) VALUES('Object-oriented programming', 6);
INSERT INTO courses(name, credits) VALUES('Structural programming', 6);
INSERT INTO courses(name, credits) VALUES('System programming', 6);
INSERT INTO courses(name, credits) VALUES('Parallel programming', 6);
INSERT INTO courses(name, credits) VALUES('Introduction to Artificial Intelligence', 6);
INSERT INTO courses(name, credits) VALUES('Data Science', 6);

-- Query all courses
SELECT * FROM courses;

-- Add department_id column
ALTER TABLE courses
ADD COLUMN department_id INT;

-- Add foreign key constraint
ALTER TABLE courses
ADD CONSTRAINT fk_course_department
    FOREIGN KEY(department_id)
    REFERENCES departments(id);

-- Add instructor_id column
ALTER TABLE courses
ADD COLUMN instructor_id INT;

ALTER TABLE courses
ADD CONSTRAINT fk_course_instructor
    FOREIGN KEY(instructor_id)
    REFERENCES employees(id);    

-- Set department_id for all courses to 1 (assuming department with id 1 exists)
UPDATE courses SET department_id = 1;  

UPDATE courses SET instructor_id = 1;


