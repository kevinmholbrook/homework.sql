USE sakila;

-- 1a. Display the first and last names of all actors from the table actor. --
SELECT first_name, last_name FROM actor;

-- 1b. Display the first and last name of each actor in a single column in upper case letters. 
-- Name the column Actor Name. --
SELECT CONCAT (first_name," ",last_name) AS "Actor Name" FROM actor;

-- 2a. You need to find the ID number, first name, and last name of an actor, of whom you know 
-- only the first name, "Joe." What is one query would you use to obtain this information? --
SELECT actor_id, first_name, last_name FROM actor
WHERE first_name = "Joe";

-- 2b. Find all actors whose last name contain the letters GEN: --
SELECT first_name, last_name FROM actor
WHERE last_name LIKE "%GEN%";

-- 2c. Find all actors whose last names contain the letters LI. This time, order the rows by 
-- last name and first name, in that order: --
SELECT last_name, first_name FROM actor
WHERE last_name LIKE "%LI%";

-- 2d. Using IN, display the country_id and country columns of the following countries: 
-- Afghanistan, Bangladesh, and China: --
SELECT country_id, country FROM country
WHERE country IN ("Afghanistan", "Bangladesh", "China");

-- 3a. You want to keep a description of each actor. You don't think you will be performing 
-- queries on a description, so create a column in the table actor named description and use 
-- the data type BLOB (Make sure to research the type BLOB, as the difference between it and 
-- VARCHAR are significant).--
SELECT * FROM actor;
ALTER TABLE actor
ADD Column description BLOB;

-- 3b. Very quickly you realize that entering descriptions for each actor is too much effort. 
-- Delete the description column. --
SELECT * FROM actor;
ALTER TABLE actor
DROP COLUMN description;

-- 4a. List the last names of actors, as well as how many actors have that last name. --
SELECT last_name, COUNT(*) AS "Count" FROM actor
GROUP BY last_name;

-- 4b. List last names of actors and the number of actors who have that last name, but only 
-- for names that are shared by at least two actors--
SELECT last_name, COUNT(*) AS "Count" FROM actor
GROUP BY last_name
HAVING Count > 2;

-- 4c. The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO 
-- WILLIAMS. Write a query to fix the record.--
SELECT * FROM actor;
UPDATE actor
SET first_name = "Harpo" WHERE first_name = "Groucho" AND last_name = "Williams";

-- 4d. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was
-- the correct name after all! In a single query, if the first name of the actor is currently
-- HARPO, change it to GROUCHO. --
SELECT * FROM actor;
UPDATE actor
SET first_name = "Groucho" WHERE first_name = "Harpo" AND last_name = "Williams";

-- 5a. You cannot locate the schema of the address table. Which query would you use to re-create it? --

-- -- -- HAD TROUBLE WITH THIS ONE -- -- --
-- ------------------------------------- --

-- 6a. Use JOIN to display the first and last names, as well as the address, of each staff 
-- member. Use the tables staff and address: --
SELECT staff.first_name, staff.last_name, address.address
FROM staff LEFT JOIN address ON staff.address_id = address.address_id;

-- 6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. 
-- Use tables staff and payment. --
SELECT staff.first_name, staff.last_name, SUM(payment.amount) as "Total"
FROM staff LEFT JOIN payment ON staff.staff_id = payment.staff_id
GROUP BY staff.first_name, staff.last_name;

-- 6c. List each film and the number of actors who are listed for that film. Use tables 
-- film_actor and film. Use inner join. --
SELECT film.title, COUNT(film_actor.actor_id) AS "Total"
FROM film LEFT JOIN film_actor ON film.film_id = film_actor.film_id
GROUP BY film.title;

-- 6d. How many copies of the film Hunchback Impossible exist in the inventory system? --
SELECT title, COUNT(inventory_id) FROM film
INNER JOIN inventory ON film.film_id = inventory.film_id WHERE title = "Hunchback Impossible";

-- 6e. Using the tables payment and customer and the JOIN command, list the total paid by 
-- each customer. List the customers alphabetically by last name: --
SELECT customer.first_name, customer.last_name, SUM(payment.amount) AS "Total"
FROM customer LEFT JOIN payment on customer.customer_id = payment.customer_id
GROUP BY customer.first_name, customer.last_name ORDER BY customer.last_name;

-- 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an 
-- unintended consequence, films starting with the letters K and Q have also soared in 
-- popularity. Use subqueries to display the titles of movies starting with the letters K and
-- Q whose language is English. --
SELECT title from film WHERE language_id IN (SELECT language_id FROM language WHERE name = "English")
AND (title LIKE "K%") OR (title LIKE "Q%");

-- 7b. Use subqueries to display all actors who appear in the film Alone Trip. --
SELECT first_name, last_name FROM actor WHERE actor_id IN 
	(SELECT actor_id FROM film_actor WHERE film_id IN
		(SELECT film_id FROM film WHERE title = "Alone Trip"));
        
-- 7c. You want to run an email marketing campaign in Canada, for which you will need the 
-- names and email addresses of all Canadian customers. Use joins to retrieve this information.
SELECT country, first_name, last_name, email FROM country
LEFT JOIN customer ON customer.country_id = customer.customer_id
WHERE country = "Canada";
-- -- -- Cant figure out my error here -- -- --
-- ----------------------------------------- --

-- 7d. Sales have been lagging among young families, and you wish to target all family 
-- movies for a promotion. Identify all movies categorized as family films. --
SELECT title, category FROM film_list WHERE category = "Family";

-- 7e. Display the most frequently rented movies in descending order.--
-- -- -- PROGRESS STOPS HERE ( NEED MORE TIME ) -- -- --










































