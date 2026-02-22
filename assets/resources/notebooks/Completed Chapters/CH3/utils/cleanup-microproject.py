# Databricks notebook source
class Cleanup():
    def __init__(self):
        self.db_name = "club_db"
        spark.sql("USE CATALOG dev")
  
    def clean(self):
        if spark.sql(f"SHOW DATABASES IN dev").filter(f"databaseName == '{self.db_name}'").count() == 1:
            print(f"Dropping the database {self.db_name}...", end='')
            spark.sql(f"DROP DATABASE {self.db_name} CASCADE")
            print("Done")
  

CL = Cleanup()
CL.clean()