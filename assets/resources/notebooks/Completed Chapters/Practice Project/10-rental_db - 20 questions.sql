-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- DBTITLE 1,Clean Previous Executions
-- MAGIC %run ./utils/clean-practice-project

-- COMMAND ----------

-- DBTITLE 1,Setup Database Tables
-- MAGIC %python
-- MAGIC DB.setupRentalDB(spark)
-- MAGIC DB.loadRentalDB(spark)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q1. List the titles of films along with the substring of the description that contains the first 15 characters present in the description field against each film title.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   title              |substring_description 
-- MAGIC   --------------------------------------------
-- MAGIC   Chamber Italian    |A Fateful Ref
-- MAGIC   Grosse Wonderful   |A Epic Drama
-- MAGIC   Airport Pollock    |A Epic Tale o 
-- MAGIC   ...                |... 
-- MAGIC   Zhivago Core       |A Fateful Yar
-- MAGIC   Zoolander Fiction  |A Fateful Ref
-- MAGIC   Zorro Ark          |A Intrepid Pa
-- MAGIC   --------------------------------------------
-- MAGIC   All or 1000 rows
-- MAGIC ```

-- COMMAND ----------

SELECT title, substring(description FROM 1 FOR 15) AS substring_description
FROM rental_db.film

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q2. List the number of movies that are not present in the inventory.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   count 
-- MAGIC   --------
-- MAGIC   42    
-- MAGIC   --------
-- MAGIC ```

-- COMMAND ----------

-- DBTITLE 1,Using NOT EXISTS
SELECT count(f.film_id) 
FROM rental_db.film f
WHERE NOT EXISTS (SELECT true FROM rental_db.inventory i WHERE i.film_id = f.film_id)

-- COMMAND ----------

-- DBTITLE 1,USING JOIN
SELECT count(f.film_id) 
FROM rental_db.film f LEFT JOIN rental_db.inventory i ON f.film_id = i.film_id
WHERE i.inventory_id IS NULL

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q3. List the customer id and first names of all the customers who have rented more than 40 movies and also list the number of movies they have rented.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   customer_id |first_name |no_of_movies
-- MAGIC   -----------------------------------------
-- MAGIC   526         |Karl       |45
-- MAGIC   75          |Tammy      |41
-- MAGIC   144         |Clara      |42
-- MAGIC   236         |Marcia     |42
-- MAGIC   148         |Eleanor    |46   
-- MAGIC -------------------------------------------
-- MAGIC ```

-- COMMAND ----------

SELECT r.customer_id, first_name, count(r.rental_id) no_of_movies
FROM rental_db.rental r INNER JOIN rental_db.customer c ON r.customer_id = c.customer_id
GROUP BY r.customer_id, first_name 
HAVING count(r.rental_id) > 40

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q4. What are the number of movies that has not been rented so far?
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   count  
-- MAGIC   ------
-- MAGIC   42    
-- MAGIC   ------
-- MAGIC ```

-- COMMAND ----------

SELECT count(title) 
FROM rental_db.film f
WHERE NOT EXISTS ( 
	SELECT true FROM rental_db.rental r
	INNER JOIN rental_db.inventory i ON r.inventory_id = i.inventory_id
	WHERE f.film_id = i.film_id
)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q5. I want to see the number of movies rented for each type of film rating.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   rating  |no_of_files
-- MAGIC   ---------------------
-- MAGIC   PG-13   |3585
-- MAGIC   NC-17   |3293
-- MAGIC   PG      |3212
-- MAGIC   R       |3181
-- MAGIC   G       |2773
-- MAGIC   ----------------
-- MAGIC ```

-- COMMAND ----------

SELECT f.rating, count(i.film_id) no_of_files
FROM rental_db.rental r INNER JOIN rental_db.inventory i ON r.inventory_id = i.inventory_id
RIGHT JOIN rental_db.film f ON i.film_id = f.film_id
GROUP BY f.rating
ORDER BY no_of_files DESC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q6. How many copies of the movie 'Adaptation Holes' are present in our inventory.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   count 
-- MAGIC   --------
-- MAGIC   4     
-- MAGIC   --------
-- MAGIC ```

-- COMMAND ----------

SELECT count(*) AS count
FROM rental_db.film f
INNER JOIN rental_db.inventory i ON i.film_id = f.film_id
WHERE f.title = 'Adaptation Holes'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q7. List the names of any 5 actors who have appeared in most diverse categories of films.\
-- MAGIC Also mention the number of unique categories they have contributed to.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   actor_name      |category_count
-- MAGIC   --------------------------------
-- MAGIC   Gina Degeneres  |16
-- MAGIC   Daryl Wahlberg  |16
-- MAGIC   Harvey Hope     |16
-- MAGIC   Groucho Dunst   |16
-- MAGIC   Reese West      |16
-- MAGIC   ----------------------------------
-- MAGIC   There are many actors appeared in 16 categories.
-- MAGIC   The result may differ.
-- MAGIC ```

-- COMMAND ----------

SELECT concat(a.first_name, ' ', a.last_name) AS actor_name, 
       count(DISTINCT(fc.category_id)) AS category_count
FROM rental_db.actor a
INNER JOIN rental_db.film_actor fa ON a.actor_id = fa.actor_id
INNER JOIN rental_db.film_category fc ON fa.film_id = fc.film_id
GROUP BY actor_name
ORDER BY category_count DESC
LIMIT 5

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q8. Analyze the distribution of rental revenue across different regions. Retrieve the total rental revenue generated by customers from each country, ordered by revenue.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   country         |total_rental_revenue
-- MAGIC   --------------------------------------
-- MAGIC   India           |6034.78  
-- MAGIC   China           |5251.03        
-- MAGIC   United States   |3685.31      
-- MAGIC   --------------------------------------
-- MAGIC   108 rows in the result
-- MAGIC ```

-- COMMAND ----------

SELECT cnt.country, round(sum(p.amount),2) AS total_rental_revenue
FROM rental_db.payment p 
INNER JOIN rental_db.customer cust ON cust.customer_id = p.customer_id
INNER JOIN rental_db.address a ON a.address_id = cust.address_id
INNER JOIN rental_db.city c ON c.city_id = a.city_id 
INNER JOIN rental_db.country cnt ON cnt.country_id = c.country_id
GROUP BY cnt.country
ORDER BY total_rental_revenue DESC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q9. Suppose we want to categorize customers into different tiers based on their total amount spent on rentals. We'll categorize them as "Gold" if they spent more than $200, "Silver" if they spent between $100 and $200, and "Bronze" if they spent less than $100. Display the customer_id, total_spent by the customer and it's category. Sort the list from most to least spend.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   customer_id |total_spent  |customer_category  
-- MAGIC   ----------------------------------------------
-- MAGIC   148         |211.55       |Gold       
-- MAGIC   526         |208.58	      |Gold     
-- MAGIC   178         |194.61       |Silver     
-- MAGIC   ...         |...          |...			  
-- MAGIC   248         |37.87        |Bronze     
-- MAGIC   281         |32.90        |Bronze       
-- MAGIC   318         |27.93        |Bronze       
-- MAGIC   ----------------------------------------------
-- MAGIC   599 rows in result
-- MAGIC ```

-- COMMAND ----------

SELECT customer_id, round(sum(amount),2) AS total_spent,
    CASE WHEN sum(amount) > 200 THEN 'Gold'
         WHEN sum(amount) >= 100 AND sum(amount) <= 200 THEN 'Silver'
         ELSE 'Bronze'
    END AS customer_category
FROM rental_db.payment
GROUP BY customer_id 
ORDER BY total_spent DESC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q10. Count the rentals by their status. If a return date is NULL, categorize it as 'Not Returned'; otherwise, categorize it as 'Returned'.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   return_status |count
-- MAGIC   ----------------------
-- MAGIC   Returned      |15861
-- MAGIC   Not Returned  |183
-- MAGIC   ----------------------
-- MAGIC ```

-- COMMAND ----------

SELECT if(return_date IS NULL, 'Not Returned', 'Returned') return_status,
       count(*) count
FROM rental_db.rental
GROUP BY return_status

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q11. List the staff members who has processed more number of payments than the average number of payments processed by all staff combined.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   Name
-- MAGIC   ---------------
-- MAGIC   Jon Stephens
-- MAGIC   ---------------
-- MAGIC ```

-- COMMAND ----------

WITH count_by_staff AS (SELECT staff_id, count(*) no_of_payments FROM rental_db.payment GROUP BY staff_id)
SELECT s.first_name|| ' ' ||s.last_name AS `Staff Name` 
FROM count_by_staff cs INNER JOIN rental_db.staff s ON s.staff_id = cs.staff_id
WHERE cs.no_of_payments > (SELECT avg(no_of_payments) avg_count FROM count_by_staff)  

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q12. Identify films that are available in one store but not in another.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   film_id |title
-- MAGIC   ----------------------
-- MAGIC   2       |Ace Goldfinger
-- MAGIC   3       |Adaptation Holes
-- MAGIC   5       |African Egg
-- MAGIC   8       |Airport Pollock
-- MAGIC   ----------------------
-- MAGIC   395 rows in the result
-- MAGIC ```

-- COMMAND ----------

WITH temp_inventory AS (SELECT DISTINCT film_id, store_id FROM rental_db.inventory),
     temp_results AS (
          SELECT distinct i.film_id 
          FROM rental_db.inventory i
          WHERE NOT EXISTS (SELECT true FROM temp_inventory t WHERE t.film_id = i.film_id AND t.store_id != i.store_id)
     )
SELECT f.film_id, f.title
FROM rental_db.film f NATURAL JOIN temp_results r
ORDER BY f.film_id     


-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q13. Evaluate the performance of employees based on the number of rentals processed and the number of payments collected. Combine the results to assess overall performance.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   activity_type       |staff_name   |count
-- MAGIC   -------------------------------------------
-- MAGIC   Payments Collected  |Jon Stephens |7304
-- MAGIC   Rentals Processed   |Jon Stephens |8004
-- MAGIC   Rentals Processed   |Mike Hillyer |8040
-- MAGIC   Payments Collected  |Mike Hillyer |7292
-- MAGIC   -------------------------------------------
-- MAGIC ```

-- COMMAND ----------

SELECT 'Rentals Processed' AS activity_type,
        concat(s.first_name, ' ', s.last_name) AS staff_name, 
        count(*) AS count 
FROM rental_db.rental r INNER JOIN rental_db.staff s ON r.staff_id = s.staff_id
GROUP BY staff_name
UNION
SELECT 'Payments Collected' AS activity_type, 
        concat(s.first_name, ' ', s.last_name) AS staff_name,
        count(*) AS count 
FROM rental_db.payment p INNER JOIN rental_db.staff s ON p.staff_id = s.staff_id
GROUP BY staff_name
ORDER BY staff_name

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q14. Create a view named "actor_popularity" that ranks actors based on the number of films they have appeared in and the total revenue generated from those films.

-- COMMAND ----------

CREATE OR REPLACE VIEW rental_db.actor_popularity AS
WITH actor_appearence AS (
            SELECT a.actor_id, a.first_name, a.last_name, count(*) AS films_appeared 
            FROM rental_db.actor a JOIN rental_db.film_actor fa ON a.actor_id = fa.actor_id
            GROUP BY a.actor_id, a.first_name, a.last_name),
    actor_revenue AS (
            SELECT fa.actor_id, round(sum(p.amount), 2) AS revenue_generated
            FROM rental_db.payment p JOIN rental_db.rental r ON p.rental_id = r.rental_id
            JOIN rental_db.inventory i ON i.inventory_id = r.inventory_id
            JOIN rental_db.film f ON f.film_id = i.film_id
            JOIN rental_db.film_actor fa ON fa.film_id = f.film_id
            GROUP BY fa.actor_id)
SELECT * FROM actor_appearence NATURAL JOIN actor_revenue 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q15. Create a view named "film_revenue_performance" that evaluates the revenue performance of each film, considering the total revenue generated from rentals and the average revenue per rental.

-- COMMAND ----------

CREATE OR REPLACE VIEW rental_db.film_revenue_performance AS
SELECT f.film_id, f.title, 
       count(*) no_of_rentals,
       sum(p.amount) total_rental_revenue,
       avg(p.amount) avg_rental_revenue
FROM rental_db.payment p
JOIN rental_db.rental r ON r.rental_id = p.rental_id
JOIN rental_db.inventory i ON i.inventory_id = r.inventory_id
JOIN rental_db.film f ON f.film_id = i.film_id
GROUP BY f.film_id, f.title
ORDER BY f.film_id

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q16. Create a view named "customer_rental_cost_summary" that summarizes the rental cost incurred by each customer, including the total amount spent and the average cost per rental.

-- COMMAND ----------

CREATE OR REPLACE VIEW rental_db.customer_rental_cost_summary AS
SELECT c.customer_id, c.first_name, c.last_name,
       count(*) AS number_of_rentals,
       sum(p.amount) AS total_rentals_revenur,
       avg(p.amount) AS avg_rental_revenue
FROM rental_db.payment p
JOIN rental_db.customer c ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY c.customer_id


-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q17. I want to see the dates in April 2007 when the total payment collected was more than $2500.\
-- MAGIC List all those dates and their corresponding total amount.
-- MAGIC
-- MAGIC Exected Output:
-- MAGIC ```
-- MAGIC   april_date	|total_amount
-- MAGIC   --------------------------
-- MAGIC   2007-04-27	|2673.57
-- MAGIC   2007-04-28	|2622.73
-- MAGIC   2007-04-29	|2717.6
-- MAGIC   2007-04-30	|5723.89
-- MAGIC ```

-- COMMAND ----------

SELECT to_date(payment_date) as april_date, 
       round(sum(amount), 2) as total_amount
FROM rental_db.payment
WHERE to_date(payment_date) BETWEEN '2007-04-01' AND '2007-04-30'
GROUP BY april_date
HAVING total_amount > 2500
order by april_date

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q18. I want to see the movies with costliest rental rate in each rating's category.\
-- MAGIC List the rating, costliest rental rate for that rating and all the movies that corresponding to that rental rate.
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   rating  |rental_rate  |title
-- MAGIC   -------------------------------------
-- MAGIC   G	      |4.99         |Ace Goldfinger
-- MAGIC   G       |4.99         |Autumn Crow
-- MAGIC   ....
-- MAGIC   NC-17   |4.99         |Chamber Italian
-- MAGIC   NC-17   |4.99         |Aladdin Calendar
-- MAGIC   -------------------------------------
-- MAGIC   336 rows in the result
-- MAGIC ```

-- COMMAND ----------

WITH rank_result AS (SELECT rating, rental_rate, title, 
														dense_rank() OVER (PARTITION BY rating ORDER BY rental_rate DESC) rank
											FROM rental_db.film)
SELECT rating, rental_rate, title
FROM rank_result
WHERE rank = 1
ORDER BY rating 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q19. What are the first names of the customers who have spent more than $100 in payment transactions with our Staff ID member 2?
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   first_name
-- MAGIC   -------------
-- MAGIC   Eleanor 
-- MAGIC   Brittany 
-- MAGIC   Stacey   
-- MAGIC   Arnold 
-- MAGIC   Karl 
-- MAGIC ```

-- COMMAND ----------

SELECT first_name FROM rental_db.customer WHERE customer_id IN (
	SELECT customer_id FROM rental_db.payment 
	WHERE staff_id = 2
	GROUP BY customer_id
	HAVING SUM(amount) > 100
);

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q20. What was the name of the op 3 movies that were rented the most?
-- MAGIC
-- MAGIC Expected Output:
-- MAGIC ```
-- MAGIC   title        
-- MAGIC   ---------------------
-- MAGIC   Bucket Brotherhood
-- MAGIC   Rocketeer Mother
-- MAGIC   Ridgemont Submarine	
-- MAGIC ```

-- COMMAND ----------

SELECT f.title
FROM rental_db.rental r JOIN rental_db.inventory i ON r.inventory_id = i.inventory_id 
JOIN rental_db.film f ON f.film_id = i.film_id
GROUP BY f.title
ORDER BY count(*) DESC 
LIMIT 3

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.com/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>