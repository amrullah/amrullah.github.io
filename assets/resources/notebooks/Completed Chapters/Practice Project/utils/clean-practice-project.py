# Databricks notebook source
class Setup():
    def __init__(self):
        self.db_name1 = "club_db"
        self.db_name2 = "rental_db"
        self.db_name3 = "corp_db"
        spark.sql("USE CATALOG dev")
  
    def clean(self):
        if spark.sql(f"SHOW DATABASES IN dev").filter(f"databaseName == '{self.db_name1}'").count() == 1:
            print(f"Dropping the database {self.db_name1}...", end='')
            spark.sql(f"DROP DATABASE {self.db_name1} CASCADE")
            print("Done")

        if spark.sql(f"SHOW DATABASES IN dev").filter(f"databaseName == '{self.db_name2}'").count() == 1:
            print(f"Dropping the database {self.db_name2}...", end='')
            spark.sql(f"DROP DATABASE {self.db_name2} CASCADE")
            print("Done")

        if spark.sql(f"SHOW DATABASES IN dev").filter(f"databaseName == '{self.db_name3}'").count() == 1:
            print(f"Dropping the database {self.db_name3}...", end='')
            spark.sql(f"DROP DATABASE {self.db_name3} CASCADE")
            print("Done")

    def setupRentalDB(self, spark):
        spark.sql(f"CREATE DATABASE IF NOT EXISTS {self.db_name2}")
        
        spark.sql(f"""CREATE TABLE IF NOT EXISTS {self.db_name2}.customer (
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
                        )""")
        
        spark.sql(f"""CREATE TABLE IF NOT EXISTS {self.db_name2}.actor (
                            actor_id INT,
                            first_name STRING,
                            last_name STRING,
                            last_update TIMESTAMP
                        )""")
        
        spark.sql(f"""CREATE TABLE IF NOT EXISTS {self.db_name2}.category (
                            category_id INT,
                            name STRING,
                            last_update TIMESTAMP
                        )""")
        
        spark.sql(f"""CREATE TABLE IF NOT EXISTS {self.db_name2}.film (
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
                    )""")

        spark.sql(f"""CREATE TABLE IF NOT EXISTS {self.db_name2}.film_actor (
                        actor_id INT,
                        film_id INT,
                        last_update TIMESTAMP
                    )""")

        spark.sql(f"""CREATE TABLE IF NOT EXISTS {self.db_name2}.film_category (
                        film_id INT,
                        category_id INT,
                        last_update TIMESTAMP
                    )""")

        spark.sql(f"""CREATE TABLE IF NOT EXISTS {self.db_name2}.address (
                        address_id INT,
                        address STRING,
                        address2 STRING,
                        district STRING,
                        city_id INT,
                        postal_code STRING,
                        phone STRING,
                        last_update TIMESTAMP
                    )""")

        spark.sql(f"""CREATE TABLE IF NOT EXISTS {self.db_name2}.city (
                        city_id INT,
                        city STRING,
                        country_id INT,
                        last_update TIMESTAMP
                    )""")

        spark.sql(f"""CREATE TABLE IF NOT EXISTS {self.db_name2}.country (
                        country_id INT,
                        country STRING,
                        last_update TIMESTAMP
                    )""")

        spark.sql(f"""CREATE TABLE IF NOT EXISTS {self.db_name2}.inventory (
                        inventory_id INT,
                        film_id INT,
                        store_id INT,
                        last_update TIMESTAMP
                    )""")

        spark.sql(f"""CREATE TABLE IF NOT EXISTS {self.db_name2}.language (
                        language_id INT,
                        name STRING,
                        last_update TIMESTAMP
                    )""")

        spark.sql(f"""CREATE TABLE IF NOT EXISTS {self.db_name2}.payment (
                        payment_id INT,
                        customer_id INT,
                        staff_id INT,
                        rental_id INT,
                        amount DOUBLE,
                        payment_date TIMESTAMP
                    )""")

        spark.sql(f"""CREATE TABLE IF NOT EXISTS {self.db_name2}.rental (
                        rental_id INT,
                        rental_date TIMESTAMP,
                        inventory_id INT,
                        customer_id INT,
                        return_date TIMESTAMP,
                        staff_id INT,
                        last_update TIMESTAMP
                    )""")

        spark.sql(f"""CREATE TABLE IF NOT EXISTS {self.db_name2}.staff (
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
                    )""")

        spark.sql(f"""CREATE TABLE IF NOT EXISTS {self.db_name2}.store (
                        store_id INT,
                        manager_staff_id INT,
                        address_id INT,
                        last_update TIMESTAMP
                    )""")       


    def setupClubDB(self, spark):
        spark.sql(f"CREATE DATABASE IF NOT EXISTS {self.db_name1}")

        spark.sql(f"""CREATE OR REPLACE TABLE {self.db_name1}.facilities(
                        facility_id INT,
                        facility_name STRING,
                        member_cost DOUBLE,
                        guest_cost DOUBLE,
                        initial_outlay DOUBLE,
                        monthly_maintainance DOUBLE
                    )""")
        
        spark.sql(f"""CREATE OR REPLACE TABLE {self.db_name1}.members(
                        member_id INT,
                        first_name STRING,
                        last_name STRING,
                        address STRING,
                        zip_code STRING,
                        telephone STRING,
                        recommended_by STRING,
                        joining_date DATE
                    )""")
        
        spark.sql(f"""CREATE OR REPLACE TABLE {self.db_name1}.bookings(
                        booking_id INT,
                        facility_id INT,
                        member_id INT,
                        start_time TIMESTAMP,
                        slots INT
                    )""")
        

    def setupCorpDB(self, spark):
        spark.sql(f"CREATE DATABASE IF NOT EXISTS {self.db_name3}")

        spark.sql(f"""CREATE OR REPLACE TABLE {self.db_name3}.employees (
                            emp_id STRING,
                            emp_name STRING,    
                            emp_dept STRING,
                            emp_salary DOUBLE,
                            emp_years_in_org INT,
                            emp_age INT
                        )""")
        
        spark.sql(f"""CREATE OR REPLACE TABLE {self.db_name3}.products(
                            product_id INT,
                            product_name STRING,
                            product_cost DOUBLE,
                            qty_available INT,
                            qty_sold INT,
                            product_category STRING
                        )""")
        
        spark.sql(f"""CREATE OR REPLACE TABLE {self.db_name3}.clients(
                            cl_name STRING,
                            cl_age INT,
                            cl_profession STRING,
                            cl_retention INT,
                            product_id INT,
                            total_puchase DOUBLE,
                            cl_phone STRING,
                            emp_id STRING
                        )""")


    def loadRentalDB(self, spark):
        spark.sql(f"""INSERT INTO {self.db_name2}.customer
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
                                         format => "csv", header => false, sep => "\t", inferSchema => true)""")
        
        spark.sql(f"""INSERT INTO {self.db_name2}.actor
                        SELECT _c0 actor_id,
                            _c1 first_name,
                            _c2 last_name,
                            _c3 last_update
                        FROM read_files("/Volumes/dev/scholarnest/sql_data/dvdrental/actor.dat", 
                                                format => "csv", header => false, sep => "\t", inferSchema => true)""")
        
        spark.sql(f"""INSERT INTO {self.db_name2}.category
                        SELECT _c0 category_id,
                            _c1 name,
                            _c2 last_update
                        FROM read_files("/Volumes/dev/scholarnest/sql_data/dvdrental/category.dat", 
                                                format => "csv", header => false, sep => "\t", inferSchema => true)""")

        spark.sql(f"""INSERT INTO {self.db_name2}.film
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
                                                format => "csv", header => false, sep => "\t", inferSchema => true)""") 

        spark.sql(f"""INSERT INTO {self.db_name2}.film_actor
                        SELECT _c0 actor_id,
                            _c1 film_id,
                            _c2 last_update
                        FROM read_files("/Volumes/dev/scholarnest/sql_data/dvdrental/film_actor.dat", 
                                                format => "csv", header => false, sep => "\t", inferSchema => true)""")

        spark.sql(f"""INSERT INTO {self.db_name2}.film_category
                        SELECT _c0 film_id,
                            _c1 category_id,
                            _c2 last_update
                        FROM read_files("/Volumes/dev/scholarnest/sql_data/dvdrental/film_category.dat", 
                                                format => "csv", header => false, sep => "\t", inferSchema => true)""")

        spark.sql(f"""INSERT INTO {self.db_name2}.address
                        SELECT _c0 address_id,
                            _c1 address,
                            _c2 address2,
                            _c3 district,
                            _c4 city_id,
                            _c5 postal_code,
                            _c6 phone,
                            _c7 last_update
                        FROM read_files("/Volumes/dev/scholarnest/sql_data/dvdrental/address.dat", 
                                                format => "csv", header => false, sep => "\t", inferSchema => true)""")

        spark.sql(f"""INSERT INTO {self.db_name2}.city
                        SELECT _c0 city_id,
                            _c1 city,
                            _c2 country_id,
                            _c3 last_update
                        FROM read_files("/Volumes/dev/scholarnest/sql_data/dvdrental/city.dat", 
                                                format => "csv", header => false, sep => "\t", inferSchema => true)""")

        spark.sql(f"""INSERT INTO {self.db_name2}.country
                        SELECT _c0 country_id,
                            _c1 country,
                            _c2 last_update
                        FROM read_files("/Volumes/dev/scholarnest/sql_data/dvdrental/country.dat", 
                                                format => "csv", header => false, sep => "\t", inferSchema => true)""")

        spark.sql(f"""INSERT INTO {self.db_name2}.inventory
                        SELECT _c0 inventory_id,
                            _c1 film_id,
                            _c2 store_id,
                            _c3 last_update
                        FROM read_files("/Volumes/dev/scholarnest/sql_data/dvdrental/inventory.dat", 
                                                format => "csv", header => false, sep => "\t", inferSchema => true)""")

        spark.sql(f"""INSERT INTO {self.db_name2}.language
                        SELECT _c0 language_id,
                            _c1 name,
                            _c2 last_update
                        FROM read_files("/Volumes/dev/scholarnest/sql_data/dvdrental/language.dat", 
                                                format => "csv", header => false, sep => "\t", inferSchema => true)""")

        spark.sql(f"""INSERT INTO {self.db_name2}.payment
                        SELECT _c0 payment_id,
                            _c1 customer_id,
                            _c2 staff_id,
                            _c3 rental_id,
                            _c4 amount,
                            _c5 payment_date
                        FROM read_files("/Volumes/dev/scholarnest/sql_data/dvdrental/payment.dat", 
                                                format => "csv", header => false, sep => "\t", inferSchema => true)""")

        spark.sql(f"""INSERT INTO {self.db_name2}.staff
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
                                                format => "csv", header => false, sep => "\t", inferSchema => true)""")

        spark.sql(f"""INSERT INTO {self.db_name2}.store 
                        SELECT _c0 store_id,
                            _c1 manager_staff_id,
                            _c2 address_id,
                            _c3 last_update
                        FROM read_files("/Volumes/dev/scholarnest/sql_data/dvdrental/store.dat", 
                                                format => "csv", header => false, sep => "\t", inferSchema => true)""") 
        
        spark.sql(f"""INSERT INTO {self.db_name2}.rental
                SELECT _c0 rental_id,
                    _c1 rental_date,
                    _c2 inventory_id,
                    _c3 customer_id,
                    if(_c4='null', null, _c4) return_date,
                    _c5 staff_id,
                    _c6 last_update
                FROM read_files('/Volumes/dev/scholarnest/sql_data/dvdrental/rental.dat', 
                                        format => 'csv', header => false, 
                                        sep => '\t', inferSchema => true)""")

        

    def loadClubDB(self, spark):
        spark.sql(f"""insert into {self.db_name1}.facilities
                            select _c0 facility_id, 
                                _c1 facility_name, 
                                _c2 member_cost, 
                                _c3 guest_cost, 
                                _c4 initial_outlay, 
                                _c5 monthly_maintainance
                            from csv.`/Volumes/dev/scholarnest/sql_data/club/facilities.csv` offset 1""")
        
        spark.sql(f"""insert into {self.db_name1}.members
                            select _c0 member_i,
                                _c2 first_name,
                                _c1 last_name,
                                _c3 address,
                                _c4 zip_code,
                                _c5 telephone,
                                _c6 recommended_by,
                                _c7 joining_date
                            from csv.`/Volumes/dev/scholarnest/sql_data/club/members.csv` offset 1""")
        
        spark.sql(f"""insert into {self.db_name1}.bookings
                            select _c0 booking_id,
                                _c1 facility_id,
                                _c2 member_id,
                                _c3 start_time,
                                _c4 slots
                            from csv.`/Volumes/dev/scholarnest/sql_data/club/bookings.csv` offset 1""")


    def loadCorpDB(self, spark):
        spark.sql(f"""INSERT INTO corp_db.employees
                            SELECT emp_id, emp_name, emp_dept, emp_salary, 
                                   emp_yearsinorg emp_years_in_org, emp_age
                            FROM read_files("/Volumes/dev/scholarnest/sql_data/corp/employees.csv", 
                                                    format => "csv", header => true, inferSchema => true)""")
        
        spark.sql(f"""INSERT INTO corp_db.products
                            SELECT product_id, product_name, product_cost, qty_available, qty_sold, product_category
                            FROM read_files("/Volumes/dev/scholarnest/sql_data/corp/products.csv", 
                                                    format => "csv", header => true, inferSchema => true)""")
        
        spark.sql(f"""INSERT INTO corp_db.clients
                            SELECT cl_name, cl_age, cl_profession, cl_retention, product_id, total_puchase, cl_phone, emp_id
                            FROM read_files("/Volumes/dev/scholarnest/sql_data/corp/clients.csv", 
                                                    format => "csv", header => true, inferSchema => true)""")

DB = Setup()
DB.clean()