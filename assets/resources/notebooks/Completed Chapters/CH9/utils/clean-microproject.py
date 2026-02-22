# Databricks notebook source
class Setup():
    def __init__(self):
        self.db_name = "ramco_db"
        self.db_name2 = "club_db"
        spark.sql("USE CATALOG dev")
  
    def clean(self):
        if spark.sql(f"SHOW DATABASES IN dev").filter(f"databaseName == '{self.db_name}'").count() == 1:
            print(f"Dropping the database {self.db_name}...", end='')
            spark.sql(f"DROP DATABASE {self.db_name} CASCADE")
            print("Done")

        if spark.sql(f"SHOW DATABASES IN dev").filter(f"databaseName == '{self.db_name2}'").count() == 1:
            print(f"Dropping the database {self.db_name2}...", end='')
            spark.sql(f"DROP DATABASE {self.db_name2} CASCADE")
            print("Done")

    def setup(self, spark):
        spark.sql(f"CREATE DATABASE IF NOT EXISTS {self.db_name}")  

        spark.sql(f"""CREATE OR REPLACE VIEW {self.db_name}.potential_users AS
                        WITH temp_users(id, first_name, last_name, country) AS(
                            SELECT * FROM VALUES(101, "Prashant", "Pandey", "India"),
                                                (102, "Sushant", "Pati", "India"),
                                                (103, "David", "Turner", "US"),
                                                (104, "Katie", "Mcloskey", "UK")
                        )SELECT * FROM temp_users
                  """) 

        spark.sql(f"""CREATE OR REPLACE VIEW {self.db_name}.registered_users AS
                        WITH temp_users(id, first_name, last_name, country) AS(
                            SELECT * FROM VALUES(101, "Vikram", "Singh", "Canada"),
                                                (102, "Abdul", "Bari", "Dubai"),
                                                (103, "Juli", "Ficher", "US"),
                                                (104, "Katie", "Mcloskey", "UK")
                        )SELECT * FROM temp_users
                  """)       
        
        spark.sql(f"""CREATE OR REPLACE VIEW {self.db_name}.sales AS
                        WITH temp_sales(customer_name, product_name, units, amount) AS(
                            SELECT * FROM VALUES("Super Trading Company", "Steel Window 8x4", 16, 158090),
                                                ("Super Trading Company", "Steel TMT 550", 150, 75697),
                                                ("Super Trading Company", "Steel Door 4x7", 23, 232489),
                                                ("One Distributors", "Steel Window 8x4", 15, 157090),
                                                ("One Distributors", "Steel TMT 550", 180, 92614),
                                                ("Great Enterprises", "Steel Window 8x4", 18, 190200),
                                                ("Great Enterprises", "Steel TMT 550", 96, 51264),
                                                ("Great Enterprises", "Steel Door 4x7", 26, 263987),
                                                ("Super Trading Company", "Steel Window 8x4", 17, 180560),
                                                ("Super Trading Company", "Steel TMT 550", 216, 107245),
                                                ("Super Trading Company", "Steel Door 4x7", 15, 153458),
                                                ("One Distributors", "Steel Window 8x4", 12, 126070),
                                                ("One Distributors", "Steel TMT 550", 120, 61398),
                                                ("Great Enterprises", "Steel Window 8x4", 13, 140201),
                                                ("Great Enterprises", "Steel TMT 550", 187, 98945),
                                                ("Great Enterprises", "Steel Door 4x7", 19, 21156)               
                        )SELECT * FROM temp_sales
                  """)
        

        spark.sql(f"""CREATE OR REPLACE VIEW {self.db_name}.sales_pivot AS
                        WITH temp_sales(`Customer Name`, `Steel Door 4x7`,`Steel TMT 550`,`Steel Window 8x4`) AS(
                            SELECT * FROM VALUES("Super Trading Company", 52000, 105000, 88000),
                                                ("One Distributors", null, 64000, 26000),
                                                ("Great Enterprises", 90000, 143000, 35000)                     
                        )SELECT * FROM temp_sales
                  """)  
        
        spark.sql(f"""CREATE OR REPLACE VIEW {self.db_name}.yearly_sales AS
                        WITH temp_sales(year, q1, q2, q3, q4) AS(
                            SELECT * FROM VALUES(2023, 87563, 86124, 97206, 59027),
                                                (2022, 71209, 67230, 71029, 59820),
                                                (2021, 68129, 69018, 56018, 50029)
                        )SELECT * FROM temp_sales
                  """) 
        
        spark.sql(f"CREATE DATABASE IF NOT EXISTS {self.db_name2}") 

        spark.sql(f"""CREATE OR REPLACE TABLE {self.db_name2}.facilities(
                        facility_id INT,
                        facility_name STRING,
                        member_cost DOUBLE,
                        guest_cost DOUBLE,
                        initial_outlay DOUBLE,
                        monthly_maintainance DOUBLE
                    )""")
        
        spark.sql(f"""CREATE OR REPLACE TABLE {self.db_name2}.members(
                        member_id INT,
                        first_name STRING,
                        last_name STRING,
                        address STRING,
                        zip_code STRING,
                        telephone STRING,
                        recommended_by STRING,
                        joining_date DATE
                    )""")
        
        spark.sql(f"""CREATE OR REPLACE TABLE {self.db_name2}.bookings(
                        booking_id INT,
                        facility_id INT,
                        member_id INT,
                        start_time TIMESTAMP,
                        slots INT
                    )""")
        
        spark.sql(f"""insert into {self.db_name2}.facilities
                            select _c0 facility_id, 
                                _c1 facility_name, 
                                _c2 member_cost, 
                                _c3 guest_cost, 
                                _c4 initial_outlay, 
                                _c5 monthly_maintainance
                            from csv.`/Volumes/dev/scholarnest/sql_data/club/facilities.csv` offset 1""")
        
        spark.sql(f"""insert into {self.db_name2}.members
                            select _c0 member_i,
                                _c2 first_name,
                                _c1 last_name,
                                _c3 address,
                                _c4 zip_code,
                                _c5 telephone,
                                _c6 recommended_by,
                                _c7 joining_date
                            from csv.`/Volumes/dev/scholarnest/sql_data/club/members.csv` offset 1""")
        
        spark.sql(f"""insert into {self.db_name2}.bookings
                            select _c0 booking_id,
                                _c1 facility_id,
                                _c2 member_id,
                                _c3 start_time,
                                _c4 slots
                            from csv.`/Volumes/dev/scholarnest/sql_data/club/bookings.csv` offset 1""")

DB = Setup()
DB.clean()