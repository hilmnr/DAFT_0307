SELECT customer_id,payment_date, amount, sum(amount) OVER (ORDER BY payment_date) AS running_total
FROM payment
ORDER BY payment_date;

SELECT 
DATE(payment_date) AS payment_date, 
amount,
RANK() OVER (PARTITION BY DATE(payment_date) ORDER BY amount DESC) AS payment_rank,
DENSE_RANK() OVER (PARTITION BY DATE(payment_date) ORDER BY amount DESC) AS payment_dense_rank
FROM payment;

 SELECT
c.name AS category,
f.title AS film_title,
f.rental_rate,
RANK() OVER (PARTITION BY c.category_id ORDER BY f.rental_rate) AS rnk,
DENSE_RANK() OVER (PARTITION BY c.category_id ORDER BY f.rental_rate) AS dens_rank
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id;

WITH ranked_films AS (
SELECT c.name AS category,
f.title AS film_title,
f.rental_rate,
ROW_NUMBER() OVER (PARTITION BY c.category_id ORDER BY f.rental_rate) AS row_num
FROM film AS f
JOIN film_category AS fc ON f.film_id = fc.film_id
JOIN category AS c ON fc.category_id = c.category_id
)
SELECT category,film_title,rental_rate
FROM ranked_films
WHERE row_num <= 5;

SELECT payment_id,
customer_id,
amount,
payment_date,
amount - LAG(amount) OVER (PARTITION BY customer_id ORDER BY payment_date) AS diff_with_previous,
LEAD(amount) OVER (PARTITION BY customer_id ORDER BY payment_date) - amount AS diff_with_next
FROM payment
ORDER BY customer_id, payment_date;





