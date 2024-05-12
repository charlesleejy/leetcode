-- Table: Seat

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | student     | varchar |
-- +-------------+---------+
-- id is the primary key column for this table.
-- Each row of this table indicates the name and the ID of a student.
-- id is a continuous increment.
 

-- Write an SQL query to swap the seat id of every two consecutive students. If the number of students is odd, the id of the last student is not swapped.

-- Return the result table ordered by id in ascending order.

-- The query result format is in the following example.

 

-- Example 1:

-- Input: 
-- Seat table:
-- +----+---------+
-- | id | student |
-- +----+---------+
-- | 1  | Abbot   |
-- | 2  | Doris   |
-- | 3  | Emerson |
-- | 4  | Green   |
-- | 5  | Jeames  |
-- +----+---------+
-- Output: 
-- +----+---------+
-- | id | student |
-- +----+---------+
-- | 1  | Doris   |
-- | 2  | Abbot   |
-- | 3  | Green   |
-- | 4  | Emerson |
-- | 5  | Jeames  |
-- +----+---------+
-- Explanation: 
-- Note that if the number of students is odd, there is no need to change the last one's seat.

-- # Write your MySQL query statement below

-- # note: using s2 student (swapped student) for both the even and odd cte

WITH even AS (
    SELECT s1.id, s2.student
    FROM Seat s1
    LEFT JOIN Seat s2
    ON s1.id - 1 = s2.id
    WHERE s1.id % 2 = 0
), odd AS (
    SELECT s1.id, s2.student
    FROM Seat s1
    INNER JOIN Seat s2
    ON s1.id + 1 = s2.id
    WHERE s1.id % 2 = 1
), last_student AS (
    SELECT id, student FROM Seat
    WHERE id = (SELECT COUNT(id) FROM Seat) AND id % 2 = 1
)
SELECT id, student
FROM even
UNION 
SELECT id, student
FROM odd
UNION
SELECT id, student
FROM last_student
ORDER BY id ASC


-- faster approach

SELECT CASE 
            WHEN ID % 2 = 1 THEN LEAD(ID, 1, ID) OVER (ORDER BY ID ASC)
            WHEN ID % 2 = 0 THEN ID - 1
        END AS ID, STUDENT
FROM SEAT
ORDER BY ID