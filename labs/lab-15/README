## 🧠 Advanced Querying

Level up with subqueries, CTEs (including recursive), set operations, window functions, pivot/unpivot strategies, and optimization techniques.

---

## 🧪 Subqueries

Types:

- Scalar: one value
- Row: one row, multiple columns
- Table: full result set

```sql
-- Above-average earners (scalar subquery)
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);
```

---

## 🧱 Common Table Expressions (CTEs)

Readable, modular queries with `WITH`.

```sql
WITH regional_sales AS (
  SELECT region_id, SUM(amount) AS total_sales
  FROM orders
  GROUP BY region_id
)
SELECT region_id, total_sales
FROM regional_sales
WHERE total_sales > 1000000;
```

### Recursive CTEs

```sql
WITH RECURSIVE org_chart AS (
  -- Anchor: top-level manager
  SELECT employee_id, first_name, last_name, manager_id
  FROM employees
  WHERE manager_id IS NULL
  UNION ALL
  -- Recursive: direct reports
  SELECT e.employee_id, e.first_name, e.last_name, e.manager_id
  FROM employees e
  INNER JOIN org_chart oc ON e.manager_id = oc.employee_id
)
SELECT * FROM org_chart;
```

---

## 🔀 Set Operations

```sql
-- Unique union
SELECT product_name FROM warehouse_1
UNION
SELECT product_name FROM warehouse_2;

-- Intersection
SELECT product_id FROM warehouse_1 WHERE quantity = 0
INTERSECT
SELECT product_id FROM warehouse_2 WHERE quantity = 0;
```

---

## 🪟 Window Functions

Row-wise calculations per partition and order.

```sql
SELECT first_name, last_name, department, salary,
       RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dept_salary_rank
FROM employees;
```

---

## 📈 Pivot / Unpivot

### Pivot via Conditional Aggregation

```sql
SELECT product_name,
       SUM(CASE WHEN year = 2022 THEN sales_amount ELSE 0 END) AS year_2022,
       SUM(CASE WHEN year = 2023 THEN sales_amount ELSE 0 END) AS year_2023,
       SUM(CASE WHEN year = 2024 THEN sales_amount ELSE 0 END) AS year_2024
FROM sales
GROUP BY product_name;
```

### Unpivot via UNION ALL

```sql
SELECT product_name, '2022' AS year, year_2022 AS sales_amount FROM pivoted_sales
UNION ALL
SELECT product_name, '2023' AS year, year_2023 AS sales_amount FROM pivoted_sales
UNION ALL
SELECT product_name, '2024' AS year, year_2024 AS sales_amount FROM pivoted_sales
ORDER BY product_name, year;
```

---

## 🔎 Complex Filtering & Sorting

```sql
-- FILTER with window
SELECT employee_id,
       SUM(salary) OVER (PARTITION BY department)            AS total_dept_salary,
       AVG(salary) FILTER (WHERE tenure > 5) OVER ()         AS avg_salary_senior
FROM employees;

-- Custom order via CASE
SELECT product_name, status
FROM orders
ORDER BY CASE status
           WHEN 'High Priority'   THEN 1
           WHEN 'Medium Priority' THEN 2
           WHEN 'Low Priority'    THEN 3
           ELSE 4
         END;
```

---

## 🚀 Optimization Tips

- Use `EXPLAIN` / `EXPLAIN ANALYZE` to understand plans.
- Index columns used in `WHERE`, joins, and `ORDER BY`.
- Avoid `SELECT *`; fetch only needed columns.
- Prefer `UNION ALL` when duplicates are acceptable.
- Use `LIMIT` during development to iterate faster.
