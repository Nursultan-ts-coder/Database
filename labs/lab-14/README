## 🔗 Joining Tables

Joins combine rows from multiple tables using related columns (often via foreign keys). Use them to reconstruct normalized data into meaningful views.

---

## 🔤 Join Types

### 1) INNER JOIN

Returns rows with matches in both tables.

```sql
SELECT c.name, c.email, o.order_date, o.total_amount
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id;
```

### 2) LEFT JOIN

All rows from the left; matched rows from the right; unmatched right as NULL.

```sql
SELECT c.name, c.email, o.order_date, o.total_amount
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;
```

### 3) RIGHT JOIN

All rows from the right; matched rows from the left; unmatched left as NULL.

```sql
SELECT c.name, c.email, o.order_date, o.total_amount
FROM customers c
RIGHT JOIN orders o ON c.customer_id = o.customer_id;
```

### 4) FULL OUTER JOIN

All rows from either table; unmatched columns filled with NULLs.

```sql
SELECT c.name, c.email, o.order_date, o.total_amount
FROM customers c
FULL OUTER JOIN orders o ON c.customer_id = o.customer_id;
```

### 5) CROSS JOIN

Cartesian product (every row with every row). Use carefully.

```sql
SELECT c.name, p.product_name
FROM customers c
CROSS JOIN products p;
```

---

## 🧰 Multi-Table & Self Joins

### Multi-Table

```sql
SELECT c.name, o.order_date, oi.quantity, p.product_name, p.price
FROM customers c
INNER JOIN orders o      ON c.customer_id = o.customer_id
INNER JOIN order_items oi ON o.order_id   = oi.order_id
INNER JOIN products p     ON oi.product_id = p.product_id;
```

### Self Join

```sql
-- Employees and their managers
SELECT e1.name AS employee, e2.name AS manager
FROM employees e1
LEFT JOIN employees e2 ON e1.manager_id = e2.employee_id;
```

---

## 🎯 Join Conditions & Filters

Add additional predicates to refine results.

```sql
SELECT c.name, o.order_date, o.total_amount
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_date >= '2024-01-01'
    AND o.total_amount > 100;
```

---

## 🧩 Relationship Patterns

### One-to-One

```sql
SELECT u.username, up.first_name, up.last_name, up.phone
FROM users u
LEFT JOIN user_profiles up ON u.user_id = up.user_id;
```

### One-to-Many

```sql
SELECT a.author_name, b.title, b.publication_year
FROM authors a
INNER JOIN books b ON a.author_id = b.author_id
ORDER BY a.author_name, b.publication_year;
```

### Many-to-Many

```sql
SELECT s.student_name, c.course_name, e.enrollment_date, e.grade
FROM students s
INNER JOIN enrollments e ON s.student_id = e.student_id
INNER JOIN courses c     ON e.course_id  = c.course_id
WHERE e.grade IS NOT NULL
ORDER BY s.student_name, c.course_name;
```

---

## ⚡ Performance

- Index join keys and foreign keys.
- Choose the simplest join type that fits.
- Use table aliases for readability.

```sql
CREATE INDEX idx_orders_customer_id      ON orders(customer_id);
CREATE INDEX idx_order_items_order_id    ON order_items(order_id);
CREATE INDEX idx_order_items_product_id  ON order_items(product_id);
```

---

## 🚫 Pitfalls

### Cartesian Products

```sql
-- Wrong: missing join condition
SELECT c.name, o.order_date
FROM customers c, orders o;

-- Correct
SELECT c.name, o.order_date
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id;
```

### Outer Join NULLs

```sql
-- Customers without any orders
SELECT c.name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;
```
