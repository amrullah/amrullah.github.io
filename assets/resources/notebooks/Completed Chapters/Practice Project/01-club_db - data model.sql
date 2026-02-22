-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####Description
-- MAGIC You are working for a club business. The diagram below shows the data model for the club business.\
-- MAGIC The database is desinged using the following tables.
-- MAGIC 1. facilities – stores club facility data including facility name, member and guest cost etc.
-- MAGIC 2. members – stores member information such as name, address, phone etc.
-- MAGIC 3. bookings – stores the booking transactions and relation with facility and members.
-- MAGIC
-- MAGIC ####Requirement
-- MAGIC Data is provide to you as comma delimited files.\
-- MAGIC You are asked to write SQL to implement the data model.

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####Club Data Model
-- MAGIC
-- MAGIC <br>
-- MAGIC <img src ='https://learningjournal.github.io/pub-resources/images/club_data_model.jpg' alt="Left Outer Join" style="width:300px">

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.com/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>