CREATE TABLE enrollments(
id SERIAL PRIMARY KEY,
studentId INT,
courseID INT
);

INSERT INTO enrollments(studentId, courseId) VALUES(3,1);
INSERT INTO enrollments(studentId, courseId) VALUES(3,4);
INSERT INTO enrollments(studentId, courseId) VALUES(3,5);
INSERT INTO enrollments(studentId, courseId) VALUES(2,7);
INSERT INTO enrollments(studentId, courseId) VALUES(4,3);
INSERT INTO enrollments(studentId, courseId) VALUES(4,6);
INSERT INTO enrollments(studentId, courseId) VALUES(4,8);

SELECT * FROM enrollments;

alter table enrollments
add column semester VARCHAR(20),
add column enrollment_date DATE DEFAULT CURRENT_DATE,
add column grade CHAR(2);


-- rename column studentId to student_id and courseID to course_id
alter table enrollments
rename column studentId to student_id;

alter table enrollments
rename column courseID to course_id;

--  add foreign key constraints
alter table enrollments
add constraint fk_enrollment_student
    foreign key(student_id)
    references students(id);


select * from courses;

alter table enrollments
add constraint fk_enrollment_course
    foreign key(course_id)
    references courses(id);