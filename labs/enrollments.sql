-- Create enrollments table
CREATE TABLE enrollments(
id SERIAL PRIMARY KEY,
student_id INT,
course_id INT
);

-- Insert some enrollments
INSERT INTO enrollments(student_id, course_id) VALUES(3,1);
INSERT INTO enrollments(student_id, course_id) VALUES(3,4);
INSERT INTO enrollments(student_id, course_id) VALUES(3,5);
INSERT INTO enrollments(student_id, course_id) VALUES(2,7);
INSERT INTO enrollments(student_id, course_id) VALUES(4,3);
INSERT INTO enrollments(student_id, course_id) VALUES(4,6);
INSERT INTO enrollments(student_id, course_id) VALUES(4,8);
INSERT INTO enrollments(student_id, course_id) VALUES(3336,8);
INSERT INTO enrollments(student_id, course_id) VALUES(3336,1);
INSERT INTO enrollments(student_id, course_id) VALUES(3336,2);
INSERT INTO enrollments(student_id, course_id) VALUES(3336,3);
INSERT INTO enrollments(student_id, course_id) VALUES(3336,4);
INSERT INTO enrollments(student_id, course_id) VALUES(8774,1);
INSERT INTO enrollments(student_id, course_id) VALUES(8774,2);
INSERT INTO enrollments(student_id, course_id) VALUES(8774,3);
INSERT INTO enrollments(student_id, course_id) VALUES(8774,4);
INSERT INTO enrollments(student_id, course_id) VALUES(1396,4);
INSERT INTO enrollments(student_id, course_id) VALUES(1396,5);
INSERT INTO enrollments(student_id, course_id) VALUES(1396,6);
INSERT INTO enrollments(student_id, course_id) VALUES(1396,7);
INSERT INTO enrollments(student_id, course_id) VALUES(1396,8);

-- Query all enrollments
SELECT * FROM enrollments;

-- Add semester, enrollment_date, and grade columns to enrollments table
ALTER TABLE enrollments
ADD COLUMN semester VARCHAR(20),
ADD COLUMN enrollment_date DATE DEFAULT CURRENT_DATE,
ADD COLUMN grade CHAR(2);



--  add foreign key constraints
ALTER TABLE enrollments
ADD CONSTRAINT fk_enrollment_student
    FOREIGN KEY(student_id)
    REFERENCES students(id);

-- add foreign key constraint for course_id
ALTER TABLE enrollments
ADD CONSTRAINT fk_enrollment_course
    FOREIGN KEY(course_id)
    REFERENCES courses(id);