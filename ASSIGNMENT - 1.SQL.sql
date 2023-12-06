-- ASSIGNMENT QUESTION -- (PART - 1)

-- Question -1  Identify the PRIMARY KEYS and FOREIGN KEYS in Mavenmovies db. Discuss the diffrence.
--PRIMARY KEYS - A PRIMARY KEY is a unique column we set in a table to easily identify and located data in queries.
--A table can have only one PRIMARY KEY, which should be unique and NOT NULL.
--FOREIGN KEYS - A FOREIGN KEY is a column used to link two or more tables together.
--A table can have any number of FOREIGN KEYS, can contain duplicate and NULL values.

SHOW TABLES;

desc actor;
 -- actor_id is primary key and last_name is foreign key 
 
 desc actor_award;
 -- actor_award_id is primary key and last_name is foreign key
 
 desc address;
 -- address_id is primary key and city_id is foreign key 
 
 desc advisor;
 -- advisor is primary key
 
 desc category;
 -- category_id is primary
 
 desc city;
 -- city_id is primary key and country_id is foreign key 
 
 desc country;
 -- country_id is primary key
 
 desc customer;
 -- customer_id is primary key and store_id, last_name, address_id are foreign key
 
 desc film;
 -- film_id is primary key and title, language_id, original_language_id are foreign key
 
 desc film_actor;
 -- actor_id and film_id are primary key
 
 desc film_category;
 -- film_id and category_id are primary key
 
 desc film_text;
 -- film_id is primary key and tile is foreign key
 
 desc inventory;
 -- inventory_id is primary key and film_id, store_id are foreign key 
 
 desc investor;
 -- investor is primary key 
 
 desc language;
 -- language_id is primary key 
 
 desc payment;
 -- payment_id is primary key and customer_id, staff_id, rental_id are foreign key 
 
 desc rental;
 -- rental_id is primary key and rental_date, inventory_id, customer_id, staff_id are foreign key
 
 desc staff;
 -- staff_id is priamry key and address_id, store_id are foreign key 
 
 desc store;
 -- store_id is primary key and address_id is foreign key and manager_staff_id is unique 
 
 
 -- QUESTION-2  List all details of actor.
 select * from actor;
 
 -- QUESTION-3  List all customer information from DB.
 select * from customer;
 
 -- QUESTION-4  List different countries.
 select distinct country from country;
 
 -- QUESTION-5  Display all active customers.
  select * from customer where active = 1;
  
  -- QUESTION-6  List of all rental ids from customer with ID 1.
  select customer_id , rental_id from rental where customer_id = 1;
  
  -- QUESTION-7  Display all the films whose rental duration is greater than 5.
  select film_id , title , rental_duration from film where rental_duration >5;
  
  -- QUESTION-8  List the total number of films whose replacement cost is greater than $15 and less than $20.
  select count(*) as total_film from film where replacement_cost >15 and replacement_cost <20;
  
  -- QUESTION-9  Find the number of films whose rental rate is less than 1$.
  select count(*) as no_of_film from film where rental_rate <1;
  
  -- QUESTION-10  Display the count of unique first names of actors.
  select count(distinct first_name) as first_name_count from actor; 
  
  -- QUESTION-11  Disple the first 10 records from the customer table. 
  select * from customer limit 10;
  
  -- QUESTION-12  Display the first 3 records from the coustomer table whose first name starts with 'b'.
  select first_name from customer where first_name like "b%" limit 3;
  
  -- QUESTION-13  Display the names of the first 5 movies which are rated as 'G'. 
  select title , rating from film where rating = 'G' limit 5;
  
  -- QUESTION-14  Find all customers whose first name start with "a". 
  select first_name from customer where first_name like "a%";
  
  -- QUESTION-15  Find all customers whose first name end with "a". 
  select first_name from customer where first_name like "%a";
  
  -- QUESTION-16  Display the list of first 4 cities which start and end with "a". 
  select city from city where city like "a%a";
  
  -- QUESTION-17  Find all customers whose first name have "NI" in any position. 
  select first_name from customer where first_name like "%NI%";
  
  -- QUESTION-18  Find all customers whose first name have "r" in the second position.
  select first_name from customer where first_name like "_r%";
  
  -- QUESTION-19  Find all customers whose first name starts with "a" and are at least 5 characters in length.
  select first_name from customer where first_name like "a%" and length(first_name)>=5;
  
  -- QUESTION-20  Find all customer whose first name starts with "a" and ends with "o". 
  select first_name from customer where first_name like "a%o";
  
  -- QUESTION-21  Get the film with pg and pg-13 rating using in operator.
  select title , rating from film where rating in ("pg","pg13");
  
  -- QUESTION-22  Get the films with length between 50 to 100 using between operator. 
  select title , length from film where length between 50 and 100;
  
  -- QUESTION-23  Get the top 50 actor using limit operator. 
  select * from actor order by actor_id desc limit 50;
  
  -- QUESTION-24  Get the distinct film ids from inventory table. 
  select distinct film_id from film;
  
  
  
  
  
  
  
  
  
  
  
  
  

