## 🔒 Transactions & ACID

Transactions group multiple operations into an all-or-nothing unit: either `COMMIT` persists all changes, or `ROLLBACK` undoes them—ensuring consistency.

---

## 🧬 ACID Properties

- **Atomicity**: All operations succeed or none do.
- **Consistency**: Database moves from one valid state to another; constraints hold.
- **Isolation**: Concurrent transactions don’t interfere; controlled via isolation levels.
- **Durability**: Committed changes survive crashes.

---

## 🎮 Controls: BEGIN / COMMIT / ROLLBACK

```sql
BEGIN;            -- or START TRANSACTION
UPDATE accounts SET balance = balance - 100 WHERE account_id = 1;
UPDATE accounts SET balance = balance + 100 WHERE account_id = 2;
COMMIT;           -- persist all changes

BEGIN;
UPDATE accounts SET balance = balance - 100 WHERE account_id = 1;
UPDATE accounts SET balance = balance + 100 WHERE account_id = 2;
ROLLBACK;         -- undo all changes
```

---

## 🧪 Isolation Levels

```sql
-- READ UNCOMMITTED (allows dirty reads; rarely used)
BEGIN TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SELECT * FROM accounts;
COMMIT;

-- READ COMMITTED (default; prevents dirty reads)
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT * FROM accounts WHERE balance > 1000;
COMMIT;

-- REPEATABLE READ (stable snapshots; may see phantom reads)
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT * FROM accounts WHERE balance > 1000;
SELECT * FROM accounts WHERE balance > 1000; -- same results
COMMIT;

-- SERIALIZABLE (strongest; transactions appear serial)
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
UPDATE accounts SET balance = balance * 1.05; -- 5% interest
COMMIT;
```

---

## 🧷 Savepoints

Create rollback points inside a transaction.

```sql
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN;

INSERT INTO customers (name, email) VALUES ('Alice', 'alice@email.com');
SAVEPOINT after_customer_insert;

INSERT INTO orders (customer_id, total) VALUES (1, 500.00);
-- Something went wrong
ROLLBACK TO SAVEPOINT after_customer_insert;

-- Retry
INSERT INTO orders (customer_id, total) VALUES (1, 300.00);
COMMIT;

-- Release a savepoint
BEGIN;
SAVEPOINT process_start;
-- work...
RELEASE SAVEPOINT process_start;
COMMIT;
```

Multiple savepoints pattern:

```sql
BEGIN;
INSERT INTO products (name, price) VALUES ('Laptop', 999.99);
SAVEPOINT sp1;

INSERT INTO products (name, price) VALUES ('Mouse', 25.99);
SAVEPOINT sp2;

INSERT INTO products (name, price) VALUES ('Invalid Product', -50.00);
ROLLBACK TO SAVEPOINT sp2; -- remove invalid insert

INSERT INTO products (name, price) VALUES ('Keyboard', 79.99);
COMMIT;
```

---

## ✅ Best Practices

- Keep transactions short; avoid holding locks too long.
- Use higher isolation for critical financial ops.
- Handle errors with savepoints for partial rollback.
- Use explicit transactions for multi-step changes.

```sql
-- Good: short, focused
BEGIN;
UPDATE inventory SET stock = stock - 1 WHERE product_id = 101;
INSERT INTO order_items (order_id, product_id, quantity) VALUES (1, 101, 1);
COMMIT;

-- Monitor blocking
SELECT blocked_locks.pid AS blocked_pid,
       blocked_activity.usename AS blocked_user,
       blocking_locks.pid AS blocking_pid,
       blocking_activity.usename AS blocking_user,
       blocked_activity.query AS blocked_statement
FROM pg_catalog.pg_locks blocked_locks
JOIN pg_catalog.pg_stat_activity blocked_activity
  ON blocked_activity.pid = blocked_locks.pid
JOIN pg_catalog.pg_locks blocking_locks
  ON blocking_locks.locktype = blocked_locks.locktype
WHERE NOT blocked_locks.granted;

-- Explicit control example
BEGIN;
INSERT INTO audit_log (action, timestamp) VALUES ('user_creation', NOW());
INSERT INTO users (name, email) VALUES ('John Doe', 'john@example.com');
INSERT INTO user_preferences (user_id, theme) VALUES (currval('users_id_seq'), 'dark');
COMMIT;
```
