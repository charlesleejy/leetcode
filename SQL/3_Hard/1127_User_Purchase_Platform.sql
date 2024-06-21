-- Table: Spending

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | user_id     | int     |
-- | spend_date  | date    |
-- | platform    | enum    | 
-- | amount      | int     |
-- +-------------+---------+
-- The table logs the history of the spending of users that make purchases from an online shopping website that has a desktop and a mobile application.
-- (user_id, spend_date, platform) is the primary key (combination of columns with unique values) of this table.
-- The platform column is an ENUM (category) type of ('desktop', 'mobile').
 

-- Write a solution to find the total number of users and the total amount spent using the mobile only, the desktop only, and both mobile and desktop together for each date.

-- Return the result table in any order.

-- The result format is in the following example.

 

-- Example 1:

-- Input: 
-- Spending table:
-- +---------+------------+----------+--------+
-- | user_id | spend_date | platform | amount |
-- +---------+------------+----------+--------+
-- | 1       | 2019-07-01 | mobile   | 100    |
-- | 1       | 2019-07-01 | desktop  | 100    |
-- | 2       | 2019-07-01 | mobile   | 100    |
-- | 2       | 2019-07-02 | mobile   | 100    |
-- | 3       | 2019-07-01 | desktop  | 100    |
-- | 3       | 2019-07-02 | desktop  | 100    |
-- +---------+------------+----------+--------+
-- Output: 
-- +------------+----------+--------------+-------------+
-- | spend_date | platform | total_amount | total_users |
-- +------------+----------+--------------+-------------+
-- | 2019-07-01 | desktop  | 100          | 1           |
-- | 2019-07-01 | mobile   | 100          | 1           |
-- | 2019-07-01 | both     | 200          | 1           |
-- | 2019-07-02 | desktop  | 100          | 1           |
-- | 2019-07-02 | mobile   | 100          | 1           |
-- | 2019-07-02 | both     | 0            | 0           |
-- +------------+----------+--------------+-------------+ 
-- Explanation: 
-- On 2019-07-01, user 1 purchased using both desktop and mobile, user 2 purchased using mobile only and user 3 purchased using desktop only.
-- On 2019-07-02, user 2 purchased using mobile only, user 3 purchased using desktop only and no one purchased using both platforms.


-- Write your MySQL query statement below


WITH spend_with_platform AS 
    (SELECT
        user_id,
        spend_date,
        SUM(amount) AS amount,
        CASE WHEN COUNT(DISTINCT platform)=2 THEN 'both' ELSE MAX(platform) END AS seg
    FROM
        Spending AS s
    GROUP BY
        user_id,
        spend_date)
SELECT
    s.spend_date,
    p.platform, 
    COALESCE(SUM(swp.amount),0) AS total_amount,
    COALESCE(COUNT(swp.user_id),0) AS total_users
FROM
    (SELECT 'desktop' AS platform UNION SELECT 'mobile' UNION select 'both') AS p
CROSS JOIN
    (SELECT DISTINCT spend_date FROM Spending) AS s
LEFT JOIN
    spend_with_platform AS swp
ON
    p.platform = swp.seg
    AND s.spend_date = swp.spend_date
GROUP BY
    p.platform, 
    s.spend_date