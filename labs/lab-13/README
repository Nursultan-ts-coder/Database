## 📊 Aggregate Functions

Aggregate functions summarize sets of rows into single values. They are commonly used with `GROUP BY` to compute counts, sums, averages, and more.

---

## 🔢 Common Aggregates

### COUNT

```sql
-- Count all rows
SELECT COUNT(*) AS total_employees FROM employees;

-- Count non-NULL in a column
SELECT COUNT(email) AS employees_with_email FROM employees;

-- Count distinct values
SELECT COUNT(DISTINCT department) AS unique_departments FROM employees;
```

### SUM

```sql
-- Total salary expenditure
SELECT SUM(salary) AS total_salaries FROM employees;

-- Total sales by department
SELECT department, SUM(sales_amount) AS total_sales
FROM sales_data
GROUP BY department;
```

### AVG

```sql
-- Average salary
SELECT AVG(salary) AS average_salary FROM employees;

-- Average age by department
SELECT department, AVG(age) AS avg_age
FROM employees
GROUP BY department;
```

### MAX / MIN

```sql
-- Extremes
SELECT MAX(salary) AS highest_salary, MIN(salary) AS lowest_salary
FROM employees;

-- Latest hire per department
SELECT department, MAX(hire_date) AS latest_hire
FROM employees
GROUP BY department;
```

---

## 🧩 Advanced Aggregates

### STRING_AGG

```sql
-- Names per department
SELECT department, STRING_AGG(first_name, ', ') AS employee_names
FROM employees
GROUP BY department;

-- Ordered list of skills
SELECT employee_id, STRING_AGG(skill_name, ', ' ORDER BY skill_name) AS skills
FROM employee_skills
GROUP BY employee_id;
```

### ARRAY_AGG

```sql
-- Salary arrays per department
SELECT department, ARRAY_AGG(salary) AS salary_array
FROM employees
GROUP BY department;

-- Ordered array of names
SELECT department, ARRAY_AGG(first_name ORDER BY last_name) AS employees
FROM employees
GROUP BY department;
```

### Statistical Functions

```sql
-- Standard deviation and variance
SELECT department,
       STDDEV(salary)   AS salary_std_dev,
       VARIANCE(salary) AS salary_variance
FROM employees
GROUP BY department;

-- Correlation
SELECT CORR(experience_years, salary) AS experience_salary_correlation
FROM employees;
```

---

## 🧱 GROUP BY Essentials

```sql
-- Product summary by category
SELECT category,
       COUNT(*) AS number_of_products,
       SUM(price) AS total_value,
       AVG(price) AS average_price
FROM products
GROUP BY category;

-- Year/Quarter analysis
SELECT EXTRACT(YEAR FROM sale_date)    AS year,
       EXTRACT(QUARTER FROM sale_date) AS quarter,
       COUNT(*) AS total_sales,
       SUM(amount) AS total_revenue
FROM sales
GROUP BY EXTRACT(YEAR FROM sale_date), EXTRACT(QUARTER FROM sale_date)
ORDER BY year, quarter;

-- Group by expression
SELECT CASE WHEN age < 30 THEN 'Under 30'
            WHEN age BETWEEN 30 AND 50 THEN '30-50'
            ELSE 'Over 50' END AS age_group,
       COUNT(*) AS employee_count,
       AVG(salary) AS avg_salary
FROM employees
GROUP BY CASE WHEN age < 30 THEN 'Under 30'
              WHEN age BETWEEN 30 AND 50 THEN '30-50'
              ELSE 'Over 50' END;
```

### HAVING (Filter Groups)

```sql
-- Departments with more than 5 employees
SELECT department, COUNT(*) AS employee_count
FROM employees
GROUP BY department
HAVING COUNT(*) > 5;

-- Products with strong reviews
SELECT product_id,
       AVG(rating) AS avg_rating,
       COUNT(*)    AS review_count
FROM product_reviews
GROUP BY product_id
HAVING AVG(rating) > 4.0 AND COUNT(*) >= 10;
```

---

## 🪟 Aggregates vs Window Functions

Aggregates collapse rows; window functions compute values per row.

```sql
-- Aggregate: one row per department
SELECT department, AVG(salary) AS dept_avg_salary
FROM employees
GROUP BY department;

-- Window: per-employee with department average
SELECT employee_id, first_name, department, salary,
       AVG(salary) OVER (PARTITION BY department) AS dept_avg_salary
FROM employees;
```

---

## 🚫 NULL Handling

```sql
-- COUNT(*) includes NULLs; COUNT(column) excludes
SELECT COUNT(*) AS total_rows,
       COUNT(email) AS non_null_emails,
       COUNT(*) - COUNT(email) AS null_emails
FROM employees;

-- SUM/AVG/MAX/MIN ignore NULLs
SELECT SUM(bonus) AS total_bonus,
       AVG(bonus) AS avg_bonus,
       COUNT(bonus) AS employees_with_bonus
FROM employees;
```

---

## ✅ Patterns & Tips

- Combine multiple aggregates per group for compact summaries.
- Use conditional aggregation with `CASE` inside `COUNT/SUM`.
- Compute percentages using a subquery/CTE total.

```sql
-- Department summary with stats
SELECT department,
       COUNT(*)        AS employee_count,
       MIN(salary)     AS min_salary,
       MAX(salary)     AS max_salary,
       AVG(salary)     AS avg_salary,
       STDDEV(salary)  AS salary_std_dev
FROM employees
GROUP BY department
ORDER BY avg_salary DESC;

-- Conditional counts
SELECT department,
       COUNT(*) AS total_employees,
       COUNT(CASE WHEN salary > 50000 THEN 1 END) AS high_earners,
       COUNT(CASE WHEN hire_date > '2023-01-01' THEN 1 END) AS recent_hires
FROM employees
GROUP BY department;

-- Percentage of total
SELECT department,
       COUNT(*) AS dept_count,
       COUNT(*)::FLOAT / (SELECT COUNT(*) FROM employees) * 100 AS percentage
FROM employees
GROUP BY department
ORDER BY percentage DESC;
```
