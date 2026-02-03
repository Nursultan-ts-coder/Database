-- Basic data operations;

COPY students(first_name, last_name, birth_date)
FROM '/path/to/students.csv'
DELIMITER ','
CSV HEADER;