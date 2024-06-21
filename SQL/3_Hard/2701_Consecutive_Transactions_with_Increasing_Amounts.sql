-- Table: Transactions

-- +------------------+------+
-- | Column Name      | Type |
-- +------------------+------+
-- | transaction_id   | int  |
-- | customer_id      | int  |
-- | transaction_date | date |
-- | amount           | int  |
-- +------------------+------+
-- transaction_id is the primary key of this table. 
-- Each row contains information about transactions that includes unique (customer_id, transaction_date) along with the corresponding customer_id and amount.  
-- Write an SQL query to find the customers who have made consecutive transactions with increasing amount for at least three consecutive days. Include the customer_id, start date of the consecutive transactions period and the end date of the consecutive transactions period. There can be multiple consecutive transactions by a customer.

-- Return the result table ordered by customer_id in ascending order.

-- The query result format is in the following example.

 

-- Example 1:

-- Input: 
-- Transactions table:
-- +----------------+-------------+------------------+--------+
-- | transaction_id | customer_id | transaction_date | amount |
-- +----------------+-------------+------------------+--------+
-- | 1              | 101         | 2023-05-01       | 100    |
-- | 2              | 101         | 2023-05-02       | 150    |
-- | 3              | 101         | 2023-05-03       | 200    |
-- | 4              | 102         | 2023-05-01       | 50     |
-- | 5              | 102         | 2023-05-03       | 100    |
-- | 6              | 102         | 2023-05-04       | 200    |
-- | 7              | 105         | 2023-05-01       | 100    |
-- | 8              | 105         | 2023-05-02       | 150    |
-- | 9              | 105         | 2023-05-03       | 200    |
-- | 10             | 105         | 2023-05-04       | 300    |
-- | 11             | 105         | 2023-05-12       | 250    |
-- | 12             | 105         | 2023-05-13       | 260    |
-- | 13             | 105         | 2023-05-14       | 270    |
-- +----------------+-------------+------------------+--------+
-- Output: 
-- +-------------+-------------------+-----------------+
-- | customer_id | consecutive_start | consecutive_end | 
-- +-------------+-------------------+-----------------+
-- | 101         |  2023-05-01       | 2023-05-03      | 
-- | 105         |  2023-05-01       | 2023-05-04      |
-- | 105         |  2023-05-12       | 2023-05-14      | 
-- +-------------+-------------------+-----------------+
-- Explanation: 
-- - customer_id 101 has made consecutive transactions with increasing amounts from May 1st, 2023, to May 3rd, 2023
-- - customer_id 102 does not have any consecutive transactions for at least 3 days. 
-- - customer_id 105 has two sets of consecutive transactions: from May 1st, 2023, to May 4th, 2023, and from May 12th, 2023, to May 14th, 2023. 
-- customer_id is sorted in ascending order.

-- # Write your MySQL query statement below


WITH date_grps AS (
  SELECT
    T.*,
    TO_DAYS(T.transaction_date)
    - ROW_NUMBER() OVER(PARTITION BY T.customer_id ORDER BY T.transaction_date) AS date_grp
  FROM
    Transactions T
), eligible_grps AS (
  SELECT
    D.customer_id,
    D.date_grp
  FROM
    date_grps D
  GROUP BY
    D.customer_id, D.date_grp
  HAVING
    COUNT(D.date_grp) >= 3
), sub_groups AS (
  SELECT
    D.*,
    (CASE
      WHEN
        D.amount - LAG(D.amount, 1, D.amount) OVER(PARTITION BY D.customer_id, D.date_grp ORDER BY D.transaction_date) <= 0 THEN 1
        ELSE 0
    END) starts_new_grp
  FROM
    eligible_grps E
    INNER JOIN date_grps D ON E.customer_id = D.customer_id AND E.date_grp = D.date_grp
), final_grps AS (
  SELECT
    S.*,
    SUM(S.starts_new_grp) OVER(PARTITION BY S.customer_id ORDER BY S.transaction_date) AS grp
  FROM
    sub_groups S
)
SELECT
  F.customer_id,
  MIN(F.transaction_date) AS consecutive_start,
  MAX(F.transaction_date) AS consecutive_end
FROM
  final_grps F
GROUP BY
  F.customer_id, F.grp
HAVING
  COUNT(F.grp) >= 3
ORDER BY
  F.customer_id;