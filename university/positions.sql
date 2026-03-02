CREATE TABLE positions(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    salary FLOAT
);

-- Insert some positions
INSERT INTO positions(name, salary) VALUES('Professor', 80000);
INSERT INTO positions(name, salary) VALUES('Associate Professor', 60000);
INSERT INTO positions(name, salary) VALUES('Assistant Professor', 50000);
INSERT INTO positions(name, salary) VALUES('Lecturer', 40000);

-- Query all positions
SELECT * FROM positions;

