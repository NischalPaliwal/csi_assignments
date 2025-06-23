-- Query all columns (attributes) for every row in the CITY table.
SELECT * FROM CITY;

-- Query all columns for a city in CITY with the ID 1661.
SELECT * FROM CITY WHERE ID = 1661;

-- Write a query that prints a list of employee names (i.e.: the name attribute) from the Employee table in alphabetical order.
SELECT name FROM Employee ORDER BY name;

-- Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.
SELECT * FROM CITY WHERE COUNTRYCODE = 'JPN';

-- Query a list of CITY and STATE from the STATION table.
SELECT CITY, STATE FROM STATION;

-- Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.
-- 1. With modulus
SELECT DISTINCT CITY FROM STATION WHERE ID % 2 = 0;
-- 2. Without modulus
SELECT DISTINCT CITY FROM STATION WHERE ID / 2 * 2 = ID;

-- Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.
SELECT COUNT(CITY) - COUNT(DISTINCT CITY) FROM STATION;

-- Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name). If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.
-- Method 1
SELECT CITY, LENGTH(CITY)
FROM (
SELECT CITY, RANK() OVER (ORDER BY LENGTH(CITY) ASC, CITY ASC) AS rn
FROM STATION
) AS subquery
WHERE rn = 1;

SELECT CITY, LENGTH(CITY)
FROM (
SELECT CITY, RANK() OVER (ORDER BY LENGTH(CITY) DESC, CITY ASC) AS rn
FROM STATION
) AS subquery
WHERE rn = 1;

-- Method 2
SELECT CITY, LENGTH(CITY) 
FROM STATION
ORDER BY LENGTH(CITY) ASC, CITY ASC
LIMIT 1;

SELECT CITY, LENGTH(CITY) 
FROM STATION
ORDER BY LENGTH(CITY) DESC, CITY ASC
LIMIT 1;

-- Query the average population for all cities in CITY, rounded down to the nearest integer.
SELECT ROUND(AVG(POPULATION)) FROM CITY;

-- Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) and their respective average city populations (CITY.Population) rounded down to the nearest integer.
SELECT c2.CONTINENT, FLOOR(AVG(c1.POPULATION)) FROM 
CITY c1 INNER JOIN COUNTRY c2
ON c1.COUNTRYCODE = c2.CODE
GROUP BY c2.CONTINENT;