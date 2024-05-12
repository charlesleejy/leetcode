-- Table: Products

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | product_id    | int     |
-- | new_price     | int     |
-- | change_date   | date    |
-- +---------------+---------+
-- (product_id, change_date) is the primary key of this table.
-- Each row of this table indicates that the price of some product was changed to a new price at some date.
 

-- Write an SQL query to find the prices of all products on 2019-08-16. AsSUMe the price of all products before any change is 10.

-- Return the result table in any order.

-- The query result format is in the following example.

 

-- Example 1:

-- Input: 
-- Products table:
-- +------------+-----------+-------------+
-- | product_id | new_price | change_date |
-- +------------+-----------+-------------+
-- | 1          | 20        | 2019-08-14  |
-- | 2          | 50        | 2019-08-14  |
-- | 1          | 30        | 2019-08-15  |
-- | 1          | 35        | 2019-08-16  |
-- | 2          | 65        | 2019-08-17  |
-- | 3          | 20        | 2019-08-18  |
-- +------------+-----------+-------------+
-- Output: 
-- +------------+-------+
-- | product_id | price |
-- +------------+-------+
-- | 2          | 50    |
-- | 1          | 35    |
-- | 3          | 10    |
-- +------------+-------+


-- # Write your MySQL query statement below
-- # remember to put inverted commas for date

WITH cte AS (
  SELECT product_id, MAX(change_date) AS latest_change_date
  FROM Products
  WHERE change_date <= '2019-08-16'
  GROUP BY product_id
), cte2 AS (
  SELECT product_id, new_price
  FROM Products
  WHERE (product_id, change_date) IN (SELECT product_id, latest_change_date FROM cte)
)
SELECT p.product_id, IFNULL(c.new_price, 10) AS price
FROM (SELECT DISTINCT product_id FROM Products) p
LEFT JOIN cte2 c 
ON p.product_id = c.product_id


-- a better approach

SELECT DISTINCT  product_id, 10 AS price
FROM Products
GROUP BY product_id
HAVING (min(change_date) > "2019-08-16")

UNION

SELECT p2.product_id, new_price
FROM Products p2
WHERE (p2.product_id, p2.change_date) IN

(
SELECT product_id, max(change_date) AS recent_date
FROM Products
where change_date <= "2019-08-16"
GROUP BY product_id
)