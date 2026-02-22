-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- DBTITLE 1,Clean Previous Executions
-- MAGIC %run ./utils/clean-practice-project

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q1. Create rental_db database

-- COMMAND ----------

CREATE DATABASE IF NOT EXISTS rental_db

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q2. Create customer table

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS rental_db.customer (
    customer_id INT,
    store_id INT,
    first_name STRING,
    last_name STRING,
    email STRING,
    address_id INT,
    activebool BOOLEAN,
    create_date DATE,
    last_update TIMESTAMP,
    active INT
)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q3. Create actor table

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS rental_db.actor (
    actor_id INT,
    first_name STRING,
    last_name STRING,
    last_update TIMESTAMP
)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q4. Create category table

-- COMMAND ----------


CREATE TABLE IF NOT EXISTS rental_db.category (
    category_id INT,
    name STRING,
    last_update TIMESTAMP
)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q5. Create film table

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS rental_db.film (
    film_id INT,
    title STRING,
    description STRING,
    release_year INT,
    language_id INT,
    rental_duration INT,
    rental_rate DOUBLE,
    length INT,
    replacement_cost DOUBLE,
    rating STRING,
    last_update TIMESTAMP
)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q6. Create film_actor table

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS rental_db.film_actor (
    actor_id INT,
    film_id INT,
    last_update TIMESTAMP
)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q7. Create film_category table

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS rental_db.film_category (
    film_id INT,
    category_id INT,
    last_update TIMESTAMP
)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q8. Create address table

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS rental_db.address (
    address_id INT,
    address STRING,
    address2 STRING,
    district STRING,
    city_id INT,
    postal_code STRING,
    phone STRING,
    last_update TIMESTAMP
)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q9. Create city table

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS rental_db.city (
    city_id INT,
    city STRING,
    country_id INT,
    last_update TIMESTAMP
)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q10. Create country table

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS rental_db.country (
    country_id INT,
    country STRING,
    last_update TIMESTAMP
)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q11. Create inventory table

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS rental_db.inventory (
    inventory_id INT,
    film_id INT,
    store_id INT,
    last_update TIMESTAMP
)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q12. Create language table

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS rental_db.language (
    language_id INT,
    name STRING,
    last_update TIMESTAMP
)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q13. Create payment table

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS rental_db.payment (
    payment_id INT,
    customer_id INT,
    staff_id INT,
    rental_id INT,
    amount DOUBLE,
    payment_date TIMESTAMP
)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q14. Create rental table

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS rental_db.rental (
    rental_id INT,
    rental_date TIMESTAMP,
    inventory_id INT,
    customer_id INT,
    return_date TIMESTAMP,
    staff_id INT,
    last_update TIMESTAMP
)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q15. Create staff table

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS rental_db.staff (
    staff_id INT,
    first_name STRING,
    last_name STRING,
    address_id INT,
    email STRING,
    store_id INT,
    active BOOLEAN,
    username STRING,
    password STRING,
    last_update TIMESTAMP
)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q16. Create store table

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS rental_db.store (
    store_id INT,
    manager_staff_id INT,
    address_id INT,
    last_update TIMESTAMP
)


-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.com/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>