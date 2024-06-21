-- Table: Student

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | name        | varchar |
-- | continent   | varchar |
-- +-------------+---------+
-- This table may contain duplicate rows.
-- Each row of this table indicates the name of a student and the continent they came from.
 

-- A school has students from Asia, Europe, and America.

-- Write a solution to pivot the continent column in the Student table so that each name is sorted alphabetically and displayed underneath its corresponding continent. The output headers should be America, Asia, and Europe, respectively.

-- The test cases are generated so that the student number from America is not less than either Asia or Europe.

-- The result format is in the following example.

 

-- Example 1:

-- Input: 
-- Student table:
-- +--------+-----------+
-- | name   | continent |
-- +--------+-----------+
-- | Jane   | America   |
-- | Pascal | Europe    |
-- | Xi     | Asia      |
-- | Jack   | America   |
-- +--------+-----------+
-- Output: 
-- +---------+------+--------+
-- | America | Asia | Europe |
-- +---------+------+--------+
-- | Jack    | Xi   | Pascal |
-- | Jane    | null | null   |
-- +---------+------+--------+
 

-- Follow up: If it is unknown which continent has the most students, could you write a solution to generate the student report?

-- # Write your MySQL query statement below

SELECT
    MAX(CASE WHEN continent = 'America' THEN name END ) AS America,
    MAX(CASE WHEN continent = 'Asia' THEN name END ) AS Asia,
    MAX(CASE WHEN continent = 'Europe' THEN name END ) AS Europe  
FROM (SELECT *, 
        ROW_NUMBER() OVER (PARTITION BY continent ORDER BY name) AS row_id 
     FROM student) AS t
GROUP BY row_id