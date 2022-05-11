--data of the most polluted cities from https://www.kaggle.com/datasets/ramjasmaurya/most-polluted-cities-and-countries-iqair-index?resource=download

--Add a column to show air quality ratings description for 2021
SELECT city, data2021, CASE WHEN data2021 <=50 THEN 'Good' WHEN data2021 <=100 THEN 'Moderate' 
WHEN data2021 <=150 THEN 'Unhealthy for Sensitive Groups' WHEN data2021 <=200 THEN 'Unhealthy'
WHEN data2021 <=300 THEN 'Very Unhealthy' ELSE 'Hazardous' END AS AirQualityIndex2021
FROM "akilahbrisc/projects"."pollutionbycity"


--CTE and window function to get the average pollution by country/region for 2021
WITH Pcqry(City,Country,data2021)
AS(
SELECT SUBSTRING(city,1,POSITION(',' in city)-1) AS City, SUBSTRING(city,POSITION(',' in city)+2,LENGTH(city)) AS Country, data2021 
from "akilahbrisc/projects"."pollutionbycity" 
WHERE data2021 IS NOT NULL
)
SELECT City, Country, data2021, AVG(data2021) OVER (PARTITION BY Country) AS AvgbyCountry FROM Pcqry
ORDER BY COUNTRY,CITY
