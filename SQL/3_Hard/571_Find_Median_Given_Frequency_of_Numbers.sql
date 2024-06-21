-- Table: Numbers

-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | num         | int  |
-- | frequency   | int  |
-- +-------------+------+
-- num is the primary key (column with unique values) for this table.
-- Each row of this table shows the frequency of a number in the database.
 

-- The median is the value separating the higher half from the lower half of a data sample.

-- Write a solution to report the median of all the numbers in the database after decompressing the Numbers table. Round the median to one decimal point.

-- The result format is in the following example.

 

-- Example 1:

-- Input: 
-- Numbers table:
-- +-----+-----------+
-- | num | frequency |
-- +-----+-----------+
-- | 0   | 7         |
-- | 1   | 1         |
-- | 2   | 3         |
-- | 3   | 1         |
-- +-----+-----------+
-- Output: 
-- +--------+
-- | median |
-- +--------+
-- | 0.0    |
-- +--------+
-- Explanation: 
-- If we decompress the Numbers table, we will get [0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3], so the median is (0 + 0) / 2 = 0.

-- # Write your MySQL query statement below

SELECT 
	ROUND(AVG(num*1.0),2) AS median
FROM (
    SELECT
        *,
        SUM(frequency) OVER (ORDER BY num ASC) AS accumulated_sum,
        SUM(frequency) OVER () / 2 as medium_num
    FROM 
        Numbers
) AS TEMP
WHERE 
	accumulated_sum - frequency <= medium_num AND accumulated_sum >= medium_num

-- # The accumulated frequency of the previous num should be smaller or equal to medium_num