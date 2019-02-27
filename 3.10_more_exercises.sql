-- Use the world database for the questions below.
USE world;

-- What languages are spoken in Santa Monica?
SELECT city.name, countrylanguage.Language, countrylanguage.Percentage
FROM countrylanguage
JOIN city ON countrylanguage.CountryCode = city.CountryCode
WHERE city.name = 'Santa Monica'
ORDER BY countrylanguage.Percentage;

-- How many different countries are in each region?
SELECT Region, COUNT(Region) AS number_of_countries
FROM country
GROUP BY Region
ORDER BY number_of_countries;

-- What is the population for each region?
SELECT Region, SUM(Population)
FROM country
GROUP BY Region 
ORDER BY SUM(Population) DESC;

-- What is the population for each continent?
SELECT Continent, SUM(Population)
FROM country
GROUP BY Continent 
ORDER BY SUM(Population) DESC;

-- What is the average life expectancy globally?
SELECT AVG(LifeExpectancy)
FROM country;

-- What is the average life expectancy for each region, each continent?
-- Sort the results from shortest to longest.
-- Region
SELECT Region, AVG(LifeExpectancy)
FROM country
GROUP BY Region
ORDER BY AVG(LifeExpectancy);

-- Continent
SELECT Continent, AVG(LifeExpectancy)
FROM country
GROUP BY Continent
ORDER BY AVG(LifeExpectancy);

-- Find all the countries whose local name is different from the official name
SELECT Name, LocalName
FROM country
WHERE Name != LocalName;

-- How many countries have a life expectancy less than x?
SELECT COUNT(NAME)
FROM (
	SELECT Name, AVG(LifeExpectancy) AS average
	FROM country 
    GROUP BY Name
	) AS Life
WHERE average < 20;

-- What state is city x located in?
SELECT Name AS City, District AS State
FROM city
WHERE Name = 'Corpus Christi';

-- What region of the world is city x located in?
SELECT co.region, ci.Name AS City
FROM city ci
JOIN country co
	ON ci.CountryCode = co.Code
WHERE ci.Name = 'Corpus Christi';

-- What country (use the human readable name) city x located in?
SELECT city.Name AS City, country.Name AS Country
FROM city
JOIN country
	ON city.CountryCode = country.Code
WHERE city.Name = 'Corpus Christi';

-- What is the life expectancy in city x?
SELECT country.LifeExpectancy AS Life_Expectancy, city.Name AS City
FROM city
JOIN country
	ON city.CountryCode = country.Code
WHERE city.Name = 'Corpus Christi';

-- Sakila Database
USE sakila;

-- Display the first and last names in all lowercase of all the actors.
SELECT LOWER(CONCAT(first_name, ' ', last_name)) FROM actor;

-- You need to find the ID number, first name, and last name of an actor,
-- of whom you know only the first name, "Joe."
-- What is one query you could use to obtain this information?
SELECT actor_id, CONCAT(first_name, ' ', last_name)
FROM actor
WHERE first_name = 'Ed';

-- Find all actors whose last name contain the letters "gen".
SELECT CONCAT(first_name, ' ', last_name)
FROM actor
WHERE last_name LIKE '%gen%';

-- Find all actors whose last names contain the letters "li".
-- This time, order the rows by last name and first name, in that order.
SELECT last_name, first_name
FROM actor
WHERE last_name LIKE '%li%'
ORDER BY last_name, first_name;

-- Using IN, display the country_id and country columns for the following countries:
-- Afghanistan, Bangladesh, and China.
SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- List the last names of all the actors, as well as how many actors have that last name.
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY last_name;

-- List last names of actors and the number of actors who have that last name,
-- but only for names that are shared by at least two actors.
SELECT last_name, COUNT(last_name)
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) > 1;

-- You cannot locate the schema of the address table. Which query would you use to re-create it?
SHOW CREATE TABLE address;

-- Use JOIN to display the first and last names, as well as the address, of each staff member.
SELECT CONCAT(staff.first_name, ' ', staff.last_name) AS Name, address.address
FROM staff
JOIN address
	ON staff.address_id = address.address_id;

-- Use JOIN to display the total amount rung up by each staff member in August of 2005.
SELECT CONCAT(staff.first_name, ' ', staff.last_name), SUM(payment.amount)
FROM staff
JOIN payment
	ON staff.staff_id = payment.staff_id
WHERE payment.payment_date LIKE '2005-08-%'
GROUP BY CONCAT(staff.first_name, ' ', staff.last_name);

-- List each film and the number of actors who are listed for that film.
SELECT film.title, COUNT(film_actor.actor_id) AS Number_of_actors_in_film
FROM film
JOIN film_actor
	ON film.film_id = film_actor.film_id
GROUP BY film.title;

-- How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT COUNT(film_id)
FROM inventory
WHERE film_id = (
		SELECT film_id
		FROM film
		WHERE title = 'Hunchback Impossible'
		);

-- The music of Queen and Kris Kristofferson have seen an unlikely resurgence.
-- As an unintended consequence, films starting with the letters K and Q have also soared in popularity.
-- Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
SELECT title
FROM film
WHERE (title LIKE 'K%' OR title LIKE 'q%')
	AND language_id = (
					SELECT language_id
                    FROM language
                    WHERE name = 'English'
                    );

-- Use subqueries to display all actors who appear in the film Alone Trip.
SELECT CONCAT(first_name, ' ', last_name)
FROM actor
WHERE actor_id IN (
				SELECT actor_id
                FROM film_actor
                WHERE film_id = (
								SELECT film_id
                                FROM film
                                WHERE title = 'Alone Trip'
                                )
				);

-- You want to run an email marketing campaign in Canada,
-- for which you will need the names and email addresses of all Canadian customers.
SELECT CONCAT(first_name, ' ', last_name), email FROM customer WHERE address_id IN (SELECT address_id FROM address WHERE ;


SELECT * FROM country;
-- Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as famiy films.
-- Write a query to display how much business, in dollars, each store brought in.
-- Write a query to display for each store its store ID, city, and country.
-- List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
