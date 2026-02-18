-- Create enrollments table
create table enrollments(
id serial primary key,
student_id int,
course_id int
);

-- Insert some enrollments
insert into enrollments(student_id, course_id) values(3,1);
insert into enrollments(student_id, course_id) values(3,4);
insert into enrollments(student_id, course_id) values(3,5);
insert into enrollments(student_id, course_id) values(2,7);
insert into enrollments(student_id, course_id) values(4,3);
insert into enrollments(student_id, course_id) values(4,6);
insert into enrollments(student_id, course_id) values(4,8);
insert into enrollments(student_id, course_id) values(3336,8);
insert into enrollments(student_id, course_id) values(3336,1);
insert into enrollments(student_id, course_id) values(3336,2);
insert into enrollments(student_id, course_id) values(3336,3);
insert into enrollments(student_id, course_id) values(3336,4);
insert into enrollments(student_id, course_id) values(8774,1);
insert into enrollments(student_id, course_id) values(8774,2);
insert into enrollments(student_id, course_id) values(8774,3);
insert into enrollments(student_id, course_id) values(8774,4);
insert into enrollments(student_id, course_id) values(1396,4);
insert into enrollments(student_id, course_id) values(1396,5);
insert into enrollments(student_id, course_id) values(1396,6);
insert into enrollments(student_id, course_id) values(1396,7);
insert into enrollments(student_id, course_id) values(1396,8);

-- Query all enrollments
select * from enrollments;

-- Add semester, enrollment_date, and grade columns to enrollments table
alter table enrollments
add column semester varchar(20),
add column enrollment_date date default current_date,
add column grade char(2);



--  add foreign key constraints
alter table enrollments
add constraint fk_enrollment_student
    foreign key(student_id)
    references students(id);

-- add foreign key constraint for course_id
alter table enrollments
add constraint fk_enrollment_course
    foreign key(course_id)
    references courses(id);