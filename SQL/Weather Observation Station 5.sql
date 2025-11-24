(SELECT city, length(city) as len
FROM station 
ORDER BY len ASC,city ASC
LIMIT 1
)UNION(
SELECT city, length(city) as len
FROM station 
ORDER BY len DESC,city DESC
LIMIT 1);
