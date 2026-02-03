## 🔍 Querying Data

Build powerful queries with `SELECT`, `WHERE`, pattern matching, subqueries, `CASE`, and CTEs.

---

## 📄 SELECT Basics

**Syntax**

```sql
SELECT column1, column2, ...
FROM table_name;
```

**Examples**

```sql
SELECT * FROM employees;
SELECT name, department FROM employees;

-- Compute on the fly
SELECT name, salary, salary * 0.10 AS potential_bonus
FROM employees;
```

Note: `AS` renames output columns.

---

## 🎯 WHERE Filtering

Filter rows after `FROM`.

Common operators:

- Comparison: `=`, `<>`/`!=`, `>`, `<`, `>=`, `<=`
- Logical: `AND`, `OR`, `NOT`
- Range: `BETWEEN` (inclusive)
- Null checks: `IS NULL`, `IS NOT NULL`

**Examples**

```sql
SELECT name, salary
FROM employees
WHERE department = 'Sales';

SELECT name
FROM employees
WHERE salary > 75000 AND department = 'Engineering';

SELECT product_name, price
FROM products
WHERE price BETWEEN 20 AND 50;
```

---

## 🔡 Pattern Matching

Use `LIKE` (case-sensitive) and `ILIKE` (case-insensitive). `%` = wildcard characters, `_` = single character.

```sql
SELECT customer_name
FROM customers
WHERE customer_name LIKE 'Bra%';

SELECT product_name
FROM products
WHERE product_name LIKE '%berry';

SELECT email
FROM users
WHERE email ILIKE '%@gmail.com';
```

### Regular Expressions

PostgreSQL regex operators:

- `~` (match, case-sensitive)
- `~*` (match, case-insensitive)
- `!~` / `!~*` (does not match)

```sql
SELECT name
FROM employees
WHERE name ~ '^[AB]';

SELECT email
FROM users
WHERE email ~* '^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$';
```

---

## 🧮 IN vs EXISTS

Check presence in a set or any row in a subquery.

```sql
-- IN with static list
SELECT name, department
FROM employees
WHERE department_id IN (3, 5, 7);

-- IN with subquery
SELECT name
FROM employees
WHERE id IN (SELECT employee_id FROM sales WHERE amount > 1000);

-- EXISTS (stops at first match)
SELECT name
FROM employees e
WHERE EXISTS (
  SELECT 1
  FROM sales s
  WHERE s.employee_id = e.id AND s.amount > 1000
);
```

---

## 🔀 CASE Expressions

Conditional logic inside queries.

```sql
SELECT column1,
  CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ELSE result_default
  END AS new_column_name
FROM table_name;

SELECT name, salary,
  CASE
    WHEN salary > 100000 THEN 'Senior'
    WHEN salary BETWEEN 60000 AND 100000 THEN 'Mid-Level'
    ELSE 'Junior'
  END AS employee_level
FROM employees;
```

---

## 🧱 CTEs (WITH)

Break complex queries into readable parts.

```sql
WITH cte_name AS (
  SELECT ...
  FROM ...
  WHERE ...
)
SELECT *
FROM cte_name
WHERE ...;

-- Example: compare salary to department averages
WITH department_averages AS (
  SELECT department, AVG(salary) AS avg_salary
  FROM employees
  GROUP BY department
)
SELECT e.name, e.salary, e.department, da.avg_salary
FROM employees e
JOIN department_averages da ON e.department = da.department
WHERE e.salary > da.avg_salary;
```

---

## ✅ Tips

- Test predicates with `SELECT` before destructive ops.
- Prefer `EXISTS` for large subqueries; it short-circuits.
- Use indexes on columns in `WHERE` and joins.
