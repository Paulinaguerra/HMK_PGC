USE sakila;

SELECT first_name, last_name
FROM actor;
#change to UPPERCASE whole columns
SELECT
	UPPER(first_name),
    last_name
FROM actor;
#merge both columns into one and name it 'Actor_name'
SELECT CONCAT(first_name,SPACE(1), last_name) AS Actor_name
FROM actor;
#find 'Joe's ID number, first and last name - query
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name LIKE 'JOE%';
#find all actors whose las name contains the letters 'GEN'
SELECT *
FROM actor
WHERE last_name LIKE '%GEN%';
#find all actors whose last names contain the letters LI. In order rows by last name and first name
SELECT last_name, first_name
FROM actor
WHERE last_name LIKE '%LI%';
#Use IN to display the country_id and country columns of: Afghanistan, Bangladesh and China
SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');
#keep a description of each actor. Create a column in the table actor named description
#use the data type BLOB 
ALTER TABLE actor
ADD COLUMN description BLOB;
#delete description column
ALTER TABLE actor
DROP description;
#List the last names of actors, as well as how many actors have that last name.
SELECT last_name, count(*)
FROM actor
GROUP BY last_name;
# List last names of actors and the number of actors who have that last name
#but only for names that are shared by at least two actors
SELECT last_name, count(*)
FROM actor
GROUP BY last_name HAVING count(*) > 1;
#The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. FIX
UPDATE actor
SET first_name='HARPO'
WHERE first_name='GROUCHO' and last_name='WILLIAMS';
#OUPS In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO.
UPDATE actor
SET first_name='GROUCHO'
WHERE first_name='HARPO' and last_name='WILLIAMS';
#You cannot locate the schema of the address table. Query
SHOW CREATE TABLE address;
#Use JOIN to display the first and last names, as well as the address, of each staff member
#use the tables staff and address:
SELECT first_name, last_name, address
FROM staff
JOIN address ON staff.address_id = address.address_id;
#Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.
SELECT first_name, last_name, SUM(amount) AS total_amount
FROM staff
JOIN payment ON staff.staff_id = payment.staff_id
WHERE payment.payment_date LIKE '%2005-08%';
#List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.
SELECT film.film_id, film.title, film_actor.actor_id, film_actor.film_id
FROM film
INNER JOIN film_actor ON film.film_id = film_actor.film_id;
#How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT title, count(inventory_id) AS total_inventory
FROM inventory
JOIN film ON film.film_id = inventory.film_id
WHERE title = 'Hunchback Impossible';
#Using the tables payment and customer and the JOIN command, list the total paid by each customer
#list the customers alphabetically by last name:
SELECT first_name, last_name, SUM(amount) as total_amount
FROM customer 
JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY first_name, last_name;
#7a. The music of Queen and Kris Kristofferson .films starting with the letters K and Q have also soared in popularity
#use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
SELECT title
FROM film
WHERE title LIKE 'K%' OR  title LIKE'Q%' AND language_id IN (SELECT language_id FROM language WHERE name='English');
#Use subqueries to display all actors who appear in the film Alone Trip.
SELECT film_id, title
FROM film
WHERE title='Alone Trip';

SELECT first_name, last_name 
FROM actor
WHERE actor_id IN (SELECT actor_id FROM film_actor WHERE film_id=17);

#Email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers
#use joins to retrieve this information.
SELECT first_name, last_name, email
FROM customer
JOIN address ON address.address_id = customer.address_id
JOIN city ON city.city_id = address.city_id
JOIN country ON country.country_id = city.country_id
WHERE country ='Canada';
#Sales have been lagging among young families, and you wish to target all family movies for a promotion
#identify all movies categorized as family films.
SELECT title
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id =  category.category_id
WHERE name = 'Family';
#display how much business, in dollars, each store brought in.
SELECT store_id, address, SUM(amount) AS total_dollars
FROM address
JOIN store ON store.address_id = address.address_id
JOIN payment ON store.manager_staff_id = payment.staff_id
GROUP BY store_id;
#display for each store its store ID, city, and country.
SELECT store_id, address, city, country
FROM store
JOIN address ON store.address_id = address.address_id
JOIN city ON city.city_id = address.city_id
JOIN country ON city.country_id = country.country_id;

#List the top five genres in gross revenue in descending order. 
#(Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
SELECT name 

#Easy way of viewing the Top five genres by gross revenue
#Use the solution from the problem above to create a view.
#If you haven't solved 7h, you can substitute another query to create a view.


# How would you display the view that you created in 8a?


#You find that you no longer need the view top_five_genres. Write a query to delete it.
#DELETE 