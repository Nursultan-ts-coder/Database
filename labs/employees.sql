-- Create employees table
CREATE TABLE employees(
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    position VARCHAR(100),
    department_id INT
);

-- Add foreign key constraint to employees table
ALTER TABLE employees
ADD CONSTRAINT fk_employee_department
    FOREIGN KEY(department_id)
    REFERENCES departments(id);


-- Insert some employees
INSERT INTO employees(first_name, last_name, position, department_id)
            VALUES('John', 'Doe', 'Software Engineer', 1);
INSERT INTO employees(first_name, last_name, position, department_id)
            VALUES('Sora', 'Nagoyaki', 'Instructor', 2);
INSERT INTO employees(first_name, last_name, position, department_id)
            VALUES('Bello', 'Smith', 'Instructor', 3);
INSERT INTO employees(first_name, last_name, position, department_id)
            VALUES('Sara', 'Benethon', 'Instructor', 2);


-- Query all employees
SELECT * FROM employees;

-- Rename column position to position_id
ALTER TABLE employees
RENAME COLUMN position TO position_id;

-- Change position_id column type to integer
ALTER TABLE employees
ALTER COLUMN position_id TYPE INTEGER
USING position_id::INTEGER;

-- Update employees to set position_id values
UPDATE employees SET position_id = 1 WHERE first_name = 'John' AND last_name = 'Doe';
UPDATE employees SET position_id = 2 WHERE first_name = 'Sora' AND last_name = 'Nagoyaki';
UPDATE employees SET position_id = 3 WHERE first_name = 'Bello' AND last_name = 'Smith';
UPDATE employees SET position_id = 4 WHERE first_name = 'Sara' AND last_name = 'Benethon';