-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####Description
-- MAGIC You are working for a DVD rental business. The diagram below shows the data model for the DVD rental business.\
-- MAGIC The database is desinged using the following tables.
-- MAGIC 1. actor – stores actor data including first name and last name.
-- MAGIC 2. film – stores film data such as title, release year, length, rating, etc.
-- MAGIC 3. film_actor – stores the relationships between films and actors.
-- MAGIC 4. category – stores film’s categories data.
-- MAGIC 5. film_category- stores the relationships between films and categories.
-- MAGIC 6. store – contains the store data including manager staff and address.
-- MAGIC 7. inventory – stores inventory data.
-- MAGIC 8. rental – stores rental data.
-- MAGIC 9. payment – stores customer’s payments.
-- MAGIC 10. staff – stores staff data.
-- MAGIC 11. customer – stores customer data.
-- MAGIC 12. address – stores address data for staff and customers
-- MAGIC 13. city – stores city names.
-- MAGIC 14. country – stores country names
-- MAGIC 15. languages - stores languages
-- MAGIC
-- MAGIC ####Requirement
-- MAGIC Data is provide to you as tab delimited files.\
-- MAGIC You are asked to write SQL to implement the data model.
-- MAGIC

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####DVD Rental Data Model
-- MAGIC
-- MAGIC <br>
-- MAGIC <img src ='https://learningjournal.github.io/pub-resources/images/dvd_renta_data_model.jpg' alt="Left Outer Join" style="width:300px">

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.com/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>