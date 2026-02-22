-- Databricks notebook source
-- MAGIC %md
-- MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
-- MAGIC   <img src="https://learningjournal.github.io/pub-resources/logos/scholarnest_academy.jpg" alt="ScholarNest Academy" style="width: 1400px">
-- MAGIC </div>

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #####Commonly used String functions
-- MAGIC 1. concat(col1, col2, ..., colN) 
-- MAGIC 2. concat_ws(sep, col1, col2, ..., colN) 
-- MAGIC 3. contains(str, substr), instr(str, substr)
-- MAGIC 4. initcap(str), ucase(str), lcase(str)  
-- MAGIC 5. left(str, len), right(str, len), substr(str, start, lenght)
-- MAGIC 6. length(str)
-- MAGIC 7. trim(str), ltrim(str), rtrim(str) 
-- MAGIC 8. replace(str, substr, replace_str)
-- MAGIC 9. rlike()

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q1. Which function is used to concatinate more than one string columns?

-- COMMAND ----------

WITH user(id, name, dob)(
  SELECT * FROM VALUES(101, "Prashant", "25-10-1978"),
                      (109, "Sushant", "23-12-1982")
)
SELECT *, concat(lcase(name), 
                 year(to_date(dob, "dd-MM-yyyy")), 
                 "@scholarnest.com") as email_id
FROM user


-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q2. Which function is used to concatinate more than one string columns with a saperator?

-- COMMAND ----------

SELECT concat_ws(" ", "Prashant", "Kumar", "Pandey")


-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q3. Which function is used to search a string inside a string column?

-- COMMAND ----------

SELECT contains("Spark, SQL, Python", "Python") AS contains,
       instr("Spark, SQL, Python", "Python") AS instr


-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q4. Which function is used to change the case of a string column?

-- COMMAND ----------

SELECT initcap("prashant kumar pandey") AS init_cap, 
       ucase("prashant kumar pandey") AS u_case, 
       lcase("Prashant KUMAR pandey") AS l_case


-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q5. Which function is used to extract N characters from a string column?

-- COMMAND ----------

SELECT left("Prashant Kumar Pandey", 8) AS left_8, 
       right("Prashant Kumar Pandey", 6) AS right_6,
       substr("Prashant Kumar Pandey", 10, 5) middle_10_5


-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q6. Which function is used to calculate the length of a string column?

-- COMMAND ----------

SELECT length("Prashant Kumar Pandey") AS len


-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q7. Which function is used to remove leading/trailing withspaces from a string column?

-- COMMAND ----------

SELECT "     Prashant     " as org_value, 
       ltrim("     Prashant     ") as ltr, 
       rtrim("     Prashant     ") as rtr,
       trim("     Prashant     ") as trm


-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q8. Which function is used to find a substring and replace it with new string?

-- COMMAND ----------

SELECT replace("Prashant Kumr Pandey", "Kumr", "Kumar") as correct

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Q9. Create the following CTE and standardize the gender string?
-- MAGIC ```
-- MAGIC   -----------------
-- MAGIC   name  | gender
-- MAGIC   -----------------
-- MAGIC   ABC   | M
-- MAGIC   XYZ   | mele
-- MAGIC   JKL   | Women
-- MAGIC   KBC   | Femen
-- MAGIC   GKG   | man
-- MAGIC   OPQ   | Male-ish
-- MAGIC   LKO   | Not sure
-- MAGIC ```

-- COMMAND ----------

WITH users(name, gender) AS(
  SELECT * FROM VALUES("ABC", "M"),
                      ("XYZ", "mele"),
                      ("JKL", "Women"),
                      ("KBC", "Femen"),
                      ("GKG", "man"),
                      ("OPQ", "Male-ish"),
                      ("LKO", "Not sure")
)
SELECT name, CASE WHEN rlike(lower(gender), "^f$|f.m|w.m") THEN "F"
                  WHEN rlike(lower(gender), "^m$|ma|m.l") THEN "M"
                  ELSE "UnKnown"
             END gender 
FROM users

-- COMMAND ----------

-- MAGIC %md
-- MAGIC &copy; 2021-2025 <a href="https://www.scholarnest.com/">ScholarNest</a>. All rights reserved.<br/>
-- MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
-- MAGIC Databricks, Databricks Cloud and the Databricks logo are trademarks of the <a href="https://www.databricks.com/">Databricks Inc</a>.<br/>
-- MAGIC <br/>
-- MAGIC <a href="https://www.scholarnest.in/pages/privacy">Privacy Policy</a> | <a href="https://www.scholarnest.in/pages/terms">Terms of Use</a> | <a href="https://www.scholarnest.in/pages/contact">Contact Us</a>