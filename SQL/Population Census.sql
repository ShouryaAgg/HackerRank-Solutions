SELECT  SUM(c.population) 
FROM city c
JOIN country co
ON c.countrycode = co.code
WHERE continent =  'Asia';