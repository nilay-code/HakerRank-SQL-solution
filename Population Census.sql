select sum(city.population) from city,country where CITY.CountryCode=Country.code and country.continent ='Asia'
