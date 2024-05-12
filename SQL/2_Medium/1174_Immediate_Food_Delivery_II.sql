-- Table: Delivery

-- +-----------------------------+---------+
-- | Column Name                 | Type    |
-- +-----------------------------+---------+
-- | delivery_id                 | int     |
-- | customer_id                 | int     |
-- | order_date                  | date    |
-- | customer_pref_delivery_date | date    |
-- +-----------------------------+---------+
-- delivery_id is the primary key of this table.
-- The table holds information about food delivery to customers that make orders at some date and specify a preferred delivery date (on the same order date or after it).
 

-- If the customer's preferred delivery date is the same as the order date, THEN the order is called immediate; otherwise, it is called scheduled.

-- The first order of a customer is the order with the earliest order date that the customer made. It is guaranteed that a customer has precisely one first order.

-- Write an SQL query to find the percentage of immediate orders in the first orders of all customers, rounded to 2 decimal places.

-- The query result format is in the following example.

 

-- Example 1:

-- Input: 
-- Delivery table:
-- +-------------+-------------+------------+-----------------------------+
-- | delivery_id | customer_id | order_date | customer_pref_delivery_date |
-- +-------------+-------------+------------+-----------------------------+
-- | 1           | 1           | 2019-08-01 | 2019-08-02                  |
-- | 2           | 2           | 2019-08-02 | 2019-08-02                  |
-- | 3           | 1           | 2019-08-11 | 2019-08-12                  |
-- | 4           | 3           | 2019-08-24 | 2019-08-24                  |
-- | 5           | 3           | 2019-08-21 | 2019-08-22                  |
-- | 6           | 2           | 2019-08-11 | 2019-08-13                  |
-- | 7           | 4           | 2019-08-09 | 2019-08-09                  |
-- +-------------+-------------+------------+-----------------------------+
-- Output: 
-- +----------------------+
-- | immediate_percentage |
-- +----------------------+
-- | 50.00                |
-- +----------------------+
-- Explanation: 
-- The customer id 1 has a first order with delivery id 1 and it is scheduled.
-- The customer id 2 has a first order with delivery id 2 and it is immediate.
-- The customer id 3 has a first order with delivery id 5 and it is scheduled.
-- The customer id 4 has a first order with delivery id 7 and it is immediate.
-- Hence, half the customers have immediate first orders.


-- # Write your MySQL query statement below
-- take note to ROUND only after multiplying 100

-- this approach beat 98.88%

WITH earliest_order AS (
    SELECT *
    FROM Delivery
    WHERE (customer_id, order_date) IN (
        SELECT customer_id, MIN(order_date)
        FROM Delivery
        GROUP BY customer_id
    )
), cte AS (
    SELECT CASE
        WHEN order_date = customer_pref_delivery_date THEN 1
        ELSE 0
        END immediate
    FROM earliest_order
)
SELECT ROUND(AVG(immediate)*100,2) AS immediate_percentage
FROM cte


-- another approach

-- get first order for customers in cte1
-- since cte1 is referenced inside cte2, we define cte2 with the same with statement
-- cte2 joins Delivery table with first_order_date FROM cte1


WITH cte1 AS (
    SELECT customer_id,
        MIN(order_date) AS first_order_date
    FROM Delivery
    GROUP BY customer_id

), cte2 AS (
    SELECT d.delivery_id,
        d.customer_id,
        d.order_date,
        d.customer_pref_delivery_date,
        IF(d.order_date = d.customer_pref_delivery_date, 'immediate', 'scheduled') AS order_type,
        f.first_order_date
    FROM Delivery AS d
    LEFT JOIN cte1 AS f ON d.customer_id = f.customer_id AND d.order_date = f.first_order_date 
)

-- now just do the calculations calling cte2
SELECT 
    round(
        SUM(CASE WHEN first_order_date IS NOT NULL AND order_type = 'immediate' THEN 1 ELSE 0 END) / 
        SUM(CASE WHEN first_order_date IS NOT NULL THEN 1 ELSE 0 END),
        4
    )*100 AS immediate_percentage
FROM cte2