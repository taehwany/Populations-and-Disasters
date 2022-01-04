-- Data
SELECT * FROM ['country-population$']
SELECT * FROM ['natural-disasters$']

-- Query of Disaster-Related Aspects
SELECT ['country-population$'].country, 
['country-population$'].year, 
['country-population$'].region, 
['country-population$'].population, 
['country-population$'].life_expectancy, 
['country-population$'].age5_surviving,
['country-population$'].babies_per_woman, 
['country-population$'].gdp_per_capita, 
['natural-disasters$'].[Number of deaths from disasters],
['natural-disasters$'].[Death rates from disasters],
['natural-disasters$'].[Total number of people affected by disasters per 100,000],
['natural-disasters$'].[Total economic damages from disasters],
['natural-disasters$'].[Total economic damages from disasters as a share of GDP] FROM ['country-population$']
JOIN ['natural-disasters$']
ON (['country-population$'].country = ['natural-disasters$'].Entity AND ['country-population$'].year = ['natural-disasters$'].year)

-- Query of Top 10 Country Population Data Based on 'X' Year
SELECT TOP 10 ['country-population$'].country, 
['country-population$'].region, 
SUM(['country-population$'].population) AS 'Total Population XXXX-2015', 
AVG(['country-population$'].life_expectancy) AS 'Avg Life Expectancy XXXX-2015', 
AVG(['country-population$'].age5_surviving) AS 'Avg % Babies Surviving Past 5 XXXX-2015',
AVG(['country-population$'].babies_per_woman) AS 'Avg Rate of Babies per Women XXXX-2015', 
AVG(['country-population$'].gdp_per_capita) AS 'Avg GDP per Capita XXXX-2015'
FROM ['country-population$']
WHERE ['country-population$'].year > 1999
GROUP BY ['country-population$'].country, ['country-population$'].region
ORDER BY 'Avg Life Expectancy XXXX-2015' DESC;

-- Query Showing Comparison Between Homelessness and Population
SELECT ['country-population$'].country, 
AVG(['country-population$'].life_expectancy) AS 'Average Life Expectancy', 
AVG(['natural-disasters$'].[Homelessness rate from disasters]) 'Average Homelessness Rate from Disasters',
['natural-disasters$'].Year
FROM ['country-population$']
JOIN ['natural-disasters$']
ON (['country-population$'].country = ['natural-disasters$'].Entity)
WHERE ['natural-disasters$'].Year > 1999
AND ['country-population$'].region = 'America'
GROUP BY ['natural-disasters$'].Year, ['country-population$'].country
ORDER BY 'Average Homelessness Rate from Disasters' DESC,['natural-disasters$'].Year, ['country-population$'].country;

-- Subquery for All Countries with 'W' as Second Letter
SELECT * FROM ['country-population$']
WHERE ['country-population$'].country IN 
(SELECT ['natural-disasters$'].Entity FROM ['natural-disasters$']
WHERE SUBSTRING(['natural-disasters$'].Entity, 2,1) LIKE 'W')
AND ['country-population$'].Year > 2009
-- alternative code --
-- WHERE ['natural-disasters$'].Entity LIKE '_W%'

