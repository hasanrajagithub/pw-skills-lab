use mavenmovies;

-- FIRST NORMAL FORM (1NF)
-- QUES:1 Identify a table in the Sakila database that violates 1NF. Explain how you would normalize it to achieve 1NF
-- ANS - actor_award violates the rule of 1NF 
-- according to 1NF rule 'every coloumn have a atomic value' but in actor_award table there are multiple 
-- values in award column .
-- for normalize in 1NF we have to creat a new table for award.
 


-- SECOND NORMAL FORM (2NF)
-- QUES:2 Choose a table in Sakila and describe how you would determine whether it is in 2NF If it violates 2NF, 
-- explain the steps to normalize it
 select * from film ;
 -- ANS - film table from sakila databse violates 2nf because of the special features column special feature column on the 
 -- table violate 1nf and 2nf has a rule that table is in 1nf 
 -- Identify Partial Dependencies: all the non-prime attributes like title , discription , release_year etc are fully dependent on the primary key
 -- which is film id
 -- we can create a another table and make them columns foreign keys and these foreign keys make reference to that film id table
 -- by using these steps we can avoid 2 nf .



-- THIRD NORMAL FORM (3NF)
-- QUES:3 Identify a table in Sakila that violates 3NF Describe the transitive dependencies present and outline the
-- steps to normalize the table to 3NF
-- ANS- if we saw the customer table in the sakila database we get to know that the column name address_id is linked with store id
-- and both are non key attribute and 3nf stays that table is in 2 nf from and it ensure that all the non key attribute column on the 
-- table are not related with each other (one non key attribute column related to other non key attribute column) so because of that it 
-- violate 2 and 3 nf
-- steps to prevent 3nf
-- 1, analyse the violation 
-- 2, create new table to store data 
-- 3, update customer table (make store id as foreign key ) 
-- 4, update address info. (so it reference to the foreign key ) etc



-- NORMALIZATION PROCESS
-- QUES:4 Take a specific table in Sakila and guide through the process of normalizing it from the initial
-- unnormalized form up to at least 2NF 
-- ANS- In this database "film " table seems like unnormalize form so we discuss the normalizetion process up to 2nf 
-- This table may not be in 1st Normal Form (1NF) because it has repeating groups (like special_features) 
-- and multiple values in a single column. To normalize it, we can follow these steps:
-- Step 1: Identify the Primary Key -- The film_id column seems suitable as the primary key for the film table.

-- Step 2: Eliminate Repeating Groups -- The special_features column contains multiple values, violating 1NF. We can create a new table for special features:

-- Step 3: Eliminate Partial Dependencies -- Now, let's check for partial dependencies. If there are any, we need to create separate tables for those.

-- In this case, it seems like language_id and original_language_id are partially dependent on film_id. We can create a new table for languages:

-- Step 4: Ensure No Transitive Dependencies -- Now, let's check for transitive dependencies. If any are found, create separate tables for those.

-- In this example, there are no apparent transitive dependencies. The table is now in 2nd Normal Form (2NF).



-- CTE BASICS
-- QUES:5  Write a query using a CTE to retrieve the distinct list of actor names and the number of films they have
-- acted in from the actor and film_actor tables.
with actorfilm_count as( select a.actor_id, (concat( first_name,' ', last_name)) as actor_name , 
count(film_id) as number_of_film from actor 
as a join film_actor as fc on a.actor_id = fc.actor_id group by actor_id,actor_name )
 select actor_name, number_of_film from actorfilm_count order by number_of_film desc;


-- RECURSIVE CTE
-- QUES-6 Use a recursive CTE to generate a hierarchical list of categories and their subcategories from the category table in Sakila.
WITH RECURSIVE CategoryHierarchy AS ( SELECT category_id, name AS category_name, NULL AS parent_category_id, 0 
AS depth FROM category WHERE parent_id IS NULL

UNION ALL

SELECT 
    c.category_id,
    c.name AS category_name,
    c.parent_id AS parent_category_id,
    ch.depth + 1 AS depth
FROM category c
JOIN CategoryHierarchy ch ON c.parent_id = ch.category_id
) SELECT * FROM CategoryHierarchy;


-- CTE WITH JOINS
-- QUES-7 Create a CTE that combines information from the film and languge tables to display the film title, language 
-- name, and rental rate.
with filminfo as ( select title, l.name as film_lang, rental_rate from film f join language l on l.language_id = f.language_id)
 select title, film_lang, rental_rate from filminfo;


-- CTE FOR AGGREGATION
-- QUES-8 Write a query using a CTE to find the total revenue generated by each customer (sum of payments) from 
-- the customer and payments tables
WITH totalcustomer_revenue AS ( SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
 SUM(p.amount) AS total_revenue FROM customer c
 LEFT JOIN payment p ON c.customer_id = p.customer_id GROUP BY c.customer_id, customer_name )
 SELECT customer_id, customer_name, total_revenue 
 FROM totalcustomer_revenue ORDER BY total_revenue;


-- CTE WITH WINDOW FUNCTIONS
-- QUES-9 Utilize a CTE with a window function to rank films based on their rental duration from the FILM table.
WITH film_rank as( SELECT film_id, title, rental_duration, RANK() OVER(ORDER BY rental_duration) FROM film)
 select film_id, title, rental_duration FROM film_rank ORDER BY rental_duration desc;


-- CTE AND FILTERING
-- QUES-10 Create a CTE to list customers who have made more than two rentals, and then join this CTE with the customer 
-- table to retrieve additional customer details.
with customerrentals as( SELECT customer_id , count(rental_id) as rental_count from rental
 GROUP BY customer_id HAVING (rental_count)>2 ) 
 select c.*,rental_count FROM customer c 
 join customerrentals on c.customer_id =customerrentals.customer_id
 ORDER BY customerrentals.rental_count desc;



-- CTE FOR DATE CALCULATIONS
-- QUES-11 Write a query using a CTE to find the total number of rentals made each month, considering the from the rental table
with Monthly_rentals as(
SELECT date_format(rental_date,"%y-%m") as rental_month, 
count(rental_id) as total_rental from rental GROUP BY rental_month ) 
SELECT rental_month ,total_rental FROM Monthly_rentals ORDER BY rental_month ;


-- CTE FOR PIVOT OPERATIONS
-- QUES-12 Use a CTE to pivot the data from the payment table to display the total payments made by each customer in 
-- separate columns for different payment methods.
-- In this mavenmovies database there is no any column name as payments mothod so -- we use amount in the place of payments method
with customer_payments as
( select c.customer_id , sum(p.amount) as payment_amount from payment p
 join customer c on c.customer_id = p. customer_id group by customer_id ) 
 select customer_id , payment_amount from customer_payments ORDER BY customer_id;



-- CTE AND SELF-JOIN
-- QUES-13 Create a CTE to generate a report showing pairs of actors who have appeared in the same film together,
-- using film_actor the table
WITH ActorPairs AS
 ( SELECT fa1.actor_id AS actor1_id, fa2.actor_id AS actor2_id,COUNT() AS films_together_count FROM film_actor fa1 
 JOIN film_actor fa2 ON fa1.film_id = fa2.film_id AND
 fa1.actor_id < fa2.actor_id GROUP BY fa1.actor_id, fa2.actor_id HAVING COUNT() > 0 )
