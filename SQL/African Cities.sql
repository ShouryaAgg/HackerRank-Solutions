SELECT  c.name 
FROM city c
JOIN country co
ON c.countrycode = co.code
WHERE continent =  'Africa';