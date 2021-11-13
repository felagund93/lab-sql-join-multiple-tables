# Lab | SQL Joins on multiple tables

#In this lab, you will be using the [Sakila](https://dev.mysql.com/doc/sakila/en/) database of movie rentals.
USE sakila;
### Instructions

#1. Write a query to display for each store its store ID, city, and country.
SELECT a.store_id, c.city, d.country FROM sakila.store a
JOIN sakila.address b ON a.address_id = b.address_id
JOIN sakila.city c ON b.city_id = c.city_id
JOIN sakila.country d ON c.country_id = d.country_id;

#2. Write a query to display how much business, in dollars, each store brought in.
SELECT a.store_id, SUM(c.amount) AS business FROM sakila.store a
JOIN sakila.customer b ON a.store_id = b.store_id
JOIN sakila.payment c ON b.customer_id = c.customer_id
GROUP BY a.store_id;

#3. What is the average running time of films by category?
SELECT a.name AS category, ROUND(AVG(c.length),1) AS avg_duration FROM sakila.category a
JOIN sakila.film_category b ON a.category_id = b.category_id
JOIN sakila.film c ON b.film_id = c.film_id
GROUP BY a.name;

#4. Which film categories are longest?
SELECT a.name AS category, ROUND(AVG(c.length),1) AS avg_duration FROM sakila.category a
JOIN sakila.film_category b ON a.category_id = b.category_id
JOIN sakila.film c ON b.film_id = c.film_id
GROUP BY a.name
ORDER BY avg_duration DESC;

#5. Display the most frequently rented movies in descending order.
SELECT a.title, COUNT(c.rental_id) AS times_rented FROM sakila.film a
JOIN sakila.inventory b ON a.film_id = b.film_id
JOIN sakila.rental c ON b.inventory_id = c.inventory_id
GROUP BY a.title
ORDER BY times_rented DESC;

#6. List the top five genres in gross revenue in descending order.
SELECT a.name AS genre, SUM(e.amount) AS revenue FROM sakila.category AS a
JOIN sakila.film_category AS b ON a.category_id = b.category_id
JOIN sakila.inventory AS c ON b.film_id = c.film_id
JOIN sakila.rental AS d ON c.inventory_id = d.inventory_id
JOIN sakila.payment AS e ON d.rental_id = e.rental_id
GROUP BY a.name
ORDER BY revenue DESC
LIMIT 5;

#7. Is "Academy Dinosaur" available for rent from Store 1?
SELECT c.rental_date, c.return_date FROM sakila.film a
JOIN sakila.inventory b ON a.film_id = b.film_id
JOIN sakila.rental c ON b.inventory_id = c.inventory_id
JOIN sakila.store d ON b.store_id = d.store_id
WHERE a.title = "Academy Dinosaur" AND d.store_id=1
ORDER BY c.rental_date DESC;