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

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q1. Load customer table

-- COMMAND ----------

INSERT INTO rental_db.customer
SELECT _c0 customer_id, 
       _c1 store_id, 
       _c2 first_name, 
       _c3 last_name,
       _c4 email, 
       _c5 address_id, 
       if(_c6="t", true, false) activebool, 
       _c7 create_date,
       _c8 last_update, 
       _c9 active 
FROM read_files("/Volumes/dev/scholarnest/sql_data/dvdrental/customer.dat", 
                          format => "csv", header => false, sep => "\t", inferSchema => true)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q2. Load actor table

-- COMMAND ----------

INSERT INTO rental_db.actor
SELECT _c0 actor_id,
       _c1 first_name,
       _c2 last_name,
       _c3 last_update
FROM read_files("/Volumes/dev/scholarnest/sql_data/dvdrental/actor.dat", 
                          format => "csv", header => false, sep => "\t", inferSchema => true)


-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q3. Load category table

-- COMMAND ----------

INSERT INTO rental_db.category
SELECT _c0 category_id,
       _c1 name,
       _c2 last_update
FROM read_files("/Volumes/dev/scholarnest/sql_data/dvdrental/category.dat", 
                          format => "csv", header => false, sep => "\t", inferSchema => true)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q4. Load film table

-- COMMAND ----------

INSERT INTO rental_db.film
SELECT _c0 film_id,
       _c1 title,
       _c2 description,
       _c3 release_year,
       _c4 language_id,
       _c5 rental_duration,
       _c6 rental_rate,
       _c7 length,
       _c8 replacement_cost,
       _c9 rating,
       _c10 last_update
FROM read_files("/Volumes/dev/scholarnest/sql_data/dvdrental/film.dat", 
                          format => "csv", header => false, sep => "\t", inferSchema => true)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q5. Load film_actor table

-- COMMAND ----------

INSERT INTO rental_db.film_actor
SELECT _c0 actor_id,
       _c1 film_id,
       _c2 last_update
FROM read_files("/Volumes/dev/scholarnest/sql_data/dvdrental/film_actor.dat", 
                          format => "csv", header => false, sep => "\t", inferSchema => true)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q6. Load film_category table

-- COMMAND ----------

INSERT INTO rental_db.film_category
SELECT _c0 film_id,
       _c1 category_id,
       _c2 last_update
FROM read_files("/Volumes/dev/scholarnest/sql_data/dvdrental/film_category.dat", 
                          format => "csv", header => false, sep => "\t", inferSchema => true)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q7. Load address table

-- COMMAND ----------

INSERT INTO rental_db.address
SELECT _c0 address_id,
       _c1 address,
       _c2 address2,
       _c3 district,
       _c4 city_id,
       _c5 postal_code,
       _c6 phone,
       _c7 last_update
FROM read_files("/Volumes/dev/scholarnest/sql_data/dvdrental/address.dat", 
                          format => "csv", header => false, sep => "\t", inferSchema => true)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q8. Load city table

-- COMMAND ----------

INSERT INTO rental_db.city
SELECT _c0 city_id,
       _c1 city,
       _c2 country_id,
       _c3 last_update
FROM read_files("/Volumes/dev/scholarnest/sql_data/dvdrental/city.dat", 
                          format => "csv", header => false, sep => "\t", inferSchema => true)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q9. Load country table

-- COMMAND ----------

INSERT INTO rental_db.country
SELECT _c0 country_id,
       _c1 country,
       _c2 last_update
FROM read_files("/Volumes/dev/scholarnest/sql_data/dvdrental/country.dat", 
                          format => "csv", header => false, sep => "\t", inferSchema => true)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q10. Load inventory table

-- COMMAND ----------

INSERT INTO rental_db.inventory
SELECT _c0 inventory_id,
       _c1 film_id,
       _c2 store_id,
       _c3 last_update
FROM read_files("/Volumes/dev/scholarnest/sql_data/dvdrental/inventory.dat", 
                          format => "csv", header => false, sep => "\t", inferSchema => true)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q11. Load language table

-- COMMAND ----------

INSERT INTO rental_db.language
SELECT _c0 language_id,
       _c1 name,
       _c2 last_update
FROM read_files("/Volumes/dev/scholarnest/sql_data/dvdrental/language.dat", 
                          format => "csv", header => false, sep => "\t", inferSchema => true)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q12. Load payment table

-- COMMAND ----------

INSERT INTO rental_db.payment
SELECT _c0 payment_id,
       _c1 customer_id,
       _c2 staff_id,
       _c3 rental_id,
       _c4 amount,
       _c5 payment_date
FROM read_files("/Volumes/dev/scholarnest/sql_data/dvdrental/payment.dat", 
                          format => "csv", header => false, sep => "\t", inferSchema => true)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q13. Load rental table

-- COMMAND ----------

INSERT INTO rental_db.rental
SELECT _c0 rental_id,
       _c1 rental_date,
       _c2 inventory_id,
       _c3 customer_id,
       if(_c4='null', null, _c4) return_date,
       _c5 staff_id,
       _c6 last_update
FROM read_files('/Volumes/dev/scholarnest/sql_data/dvdrental/rental.dat', 
                          format => 'csv', header => false, sep => '\t', inferSchema => true)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q14. Load staff table

-- COMMAND ----------

INSERT INTO rental_db.staff
SELECT _c0 staff_id,
       _c1 first_name,
       _c2 last_name,
       _c3 address_id,
       _c4 email,
       _c5 store_id,
       _c6 active,
       _c7 username,
       _c8 password,
       _c9 last_update
FROM read_files("/Volumes/dev/scholarnest/sql_data/dvdrental/staff.dat", 
                          format => "csv", header => false, sep => "\t", inferSchema => true)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q15. Load store table

-- COMMAND ----------

INSERT INTO rental_db.store 
SELECT _c0 store_id,
       _c1 manager_staff_id,
       _c2 address_id,
       _c3 last_update
FROM read_files("/Volumes/dev/scholarnest/sql_data/dvdrental/store.dat", 
                          format => "csv", header => false, sep => "\t", inferSchema => true)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.com/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>