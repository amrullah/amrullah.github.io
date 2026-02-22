# Databricks notebook source
class Setup():
    def __init__(self):
        self.db_name = "club_db"
        spark.sql("USE CATALOG dev")
  
    def clean(self):
        if spark.sql(f"SHOW DATABASES IN dev").filter(f"databaseName == '{self.db_name}'").count() == 1:
            print(f"Dropping the database {self.db_name}...", end='')
            spark.sql(f"DROP DATABASE {self.db_name} CASCADE")
            print("Done")


    def setup(self, spark):
        spark.sql(f"CREATE DATABASE IF NOT EXISTS {self.db_name}")
        spark.sql(f"""CREATE OR REPLACE TABLE {self.db_name}.facilities(
                        facility_id INT,
                        facility_name STRING,
                        member_cost DOUBLE,
                        guest_cost DOUBLE,
                        initial_outlay DOUBLE,
                        monthly_maintainance DOUBLE
                    )""")
        spark.sql(f"""CREATE OR REPLACE TABLE {self.db_name}.members(
                        member_id INT,
                        first_name STRING,
                        last_name STRING,
                        address STRING,
                        zip_code STRING,
                        telephone STRING,
                        recommended_by STRING,
                        joining_date DATE
                    )""")
        spark.sql(f"""CREATE OR REPLACE TABLE {self.db_name}.bookings(
                        booking_id INT,
                        facility_id INT,
                        member_id INT,
                        start_time TIMESTAMP,
                        slots INT
                    )""")
        
        spark.sql(f"""insert into {self.db_name}.facilities
                            select _c0 facility_id, 
                                _c1 facility_name, 
                                _c2 member_cost, 
                                _c3 guest_cost, 
                                _c4 initial_outlay, 
                                _c5 monthly_maintainance
                            from csv.`/Volumes/dev/scholarnest/sql_data/club/facilities.csv` offset 1""")
        spark.sql(f"""insert into {self.db_name}.members
                            select _c0 member_i,
                                _c2 first_name,
                                _c1 last_name,
                                _c3 address,
                                _c4 zip_code,
                                _c5 telephone,
                                _c6 recommended_by,
                                _c7 joining_date
                            from csv.`/Volumes/dev/scholarnest/sql_data/club/members.csv` offset 1""")
        spark.sql(f"""insert into {self.db_name}.bookings
                            select _c0 booking_id,
                                _c1 facility_id,
                                _c2 member_id,
                                _c3 start_time,
                                _c4 slots
                            from csv.`/Volumes/dev/scholarnest/sql_data/club/bookings.csv` offset 1""")

  

DB = Setup()
DB.clean()