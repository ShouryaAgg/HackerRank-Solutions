SELECT city 
FROM station 
WHERE id % 2 =0
GROUP BY city;