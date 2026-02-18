create table positions(
    id serial primary key,
    name varchar(100) not null unique,
    salary float
);

-- Insert some positions
insert into positions(name, salary) values('Professor', 80000);
insert into positions(name, salary) values('Associate Professor', 60000);
insert into positions(name, salary) values('Assistant Professor', 50000);
insert into positions(name, salary) values('Lecturer', 40000);

-- Query all positions
select * from positions;

