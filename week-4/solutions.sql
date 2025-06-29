-- Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.
SELECT CITY
FROM 
STATION 
WHERE LEFT(CITY, 1) IN ('A', 'E', 'I', 'O', 'U', 'a', 'e', 'i', 'o', 'u')
AND RIGHT(CITY, 1) IN ('A', 'E', 'I', 'O', 'U', 'a', 'e', 'i', 'o', 'u');

-- Query the difference between the maximum and minimum populations in CITY.
SELECT MAX(POPULATION) - MIN(POPULATION)
FROM
CITY;

-- Query the Euclidean Distance between points P1 and P2 and format your answer to display  decimal digits.
SELECT FORMAT(SQRT(POWER(MIN(LONG_W) - MAX(LONG_W), 2) + POWER(MIN(LAT_N) - MAX(LAT_N), 2)), 4)
FROM STATION;

-- Given the CITY and COUNTRY tables, query the names of all cities where the CONTINENT is 'Africa'.
SELECT c.NAME
FROM
CITY c
INNER JOIN
COUNTRY ct ON c.COUNTRYCODE = ct.CODE
WHERE ct.CONTINENT = "Africa";

-- Generate Report
SELECT IF(Grades.Grade >= 8, Students.Name, NULL), Grades.Grade, Students.Marks
FROM GRADES, STUDENTS
WHERE Students.Marks BETWEEN Grades.Min_Mark AND Grades.Max_Mark
ORDER BY Grades.Grade DESC, Students.Name;

-- Top Competitors
SELECT h.hacker_id, h.name 
FROM Submissions s 
INNER JOIN Challenges c ON s.challenge_id = c.challenge_id 
INNER JOIN Difficulty d ON c.difficulty_level = d.difficulty_level 
INNER JOIN Hackers h ON s.hacker_id = h.hacker_id AND s.score = d.score 
GROUP  BY h.hacker_id, h.name 
HAVING COUNT(s.hacker_id) > 1 
ORDER  BY COUNT(s.hacker_id) DESC, h.hacker_id ASC;

-- Weather Observation Station 20
SELECT ROUND(AVG(lat_n), 4) AS median
FROM
(
    SELECT lat_n, ROW_NUMBER() OVER (ORDER BY lat_n) AS rn
    FROM station
) AS subq
WHERE
    rn = (SELECT CEIL((COUNT(rn) + 1) / 2) FROM station)
    OR
    rn = (SELECT FLOOR((COUNT(rn) + 1) / 2) FROM station)

-- Ollivander's Inventory
SELECT w1.id, wp1.age, w1.coins_needed, w1.power
FROM 
Wands w1
INNER JOIN
Wands_Property wp1 ON w1.code = wp1.code
WHERE 
wp1.is_evil = 0 
AND
w1.coins_needed = (
    SELECT MIN(w2.coins_needed) 
    FROM wands w2 
    INNER JOIN wands_property wp2 ON w2.code = wp2.code 
    WHERE  wp1.age = wp2.age AND w1.power = w2.power
)
ORDER BY w1.power DESC, wp1.age DESC;

-- Contest Leaderboard
SELECT h.hacker_id, h.name, SUM(sq.score) AS total_score
FROM (
    SELECT hacker_id, challenge_id, MAX(score) AS score
    FROM
    Submissions
    GROUP BY hacker_id, challenge_id
) sq
INNER JOIN Hackers h ON sq.hacker_id = h.hacker_id
GROUP BY h.hacker_id, h.name
HAVING total_score > 0
ORDER BY total_score DESC, h.hacker_id;