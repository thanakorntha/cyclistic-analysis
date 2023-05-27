@@ -1,80 +0,0 @@
/*************************************** 
 *   SETUP DATABASE AND IMPORT FILES   *
 ***************************************/

-- Create the "cyclistic" database
CREATE DATABASE IF NOT EXISTS cyclistic;

-- Set the "cyclistic" database as an active database
USE cyclistic;


/************************************************ 
 *   CREATE MONTH TABLES AND IMPORT CSV FILES   *
 ************************************************/

-- Create the "template" table with thirteen columns as a table reference
CREATE TABLE IF NOT EXISTS template (
    ride_id VARCHAR(20) DEFAULT NULL,
    rideable_type VARCHAR(20) DEFAULT NULL,
    started_at DATETIME DEFAULT NULL,
    ended_at DATETIME DEFAULT NULL,
    start_station_name VARCHAR(255) DEFAULT NULL,
    start_station_id VARCHAR(255) DEFAULT NULL,
    end_station_name VARCHAR(255) DEFAULT NULL,
    end_station_id VARCHAR(255) DEFAULT NULL,
    start_lat DOUBLE DEFAULT NULL,
    start_lng DOUBLE DEFAULT NULL,
    end_lat DOUBLE DEFAULT NULL,
    end_lng DOUBLE DEFAULT NULL,
    member_casual VARCHAR(10) DEFAULT NULL
); 

-- Create twelve month tables and then import twelve CSV files based on each month to the table
CREATE TABLE IF NOT EXISTS trip_01 LIKE template;
CREATE TABLE IF NOT EXISTS trip_02 LIKE template;
CREATE TABLE IF NOT EXISTS trip_03 LIKE template;
CREATE TABLE IF NOT EXISTS trip_04 LIKE template;
CREATE TABLE IF NOT EXISTS trip_05 LIKE template;
CREATE TABLE IF NOT EXISTS trip_06 LIKE template;
CREATE TABLE IF NOT EXISTS trip_07 LIKE template;
CREATE TABLE IF NOT EXISTS trip_08 LIKE template;
CREATE TABLE IF NOT EXISTS trip_09 LIKE template;
CREATE TABLE IF NOT EXISTS trip_10 LIKE template;
CREATE TABLE IF NOT EXISTS trip_11 LIKE template;
CREATE TABLE IF NOT EXISTS trip_12 LIKE template;


/********************************************
 *   COMBINE MONTH TABLES INTO ONE TABLE   *
 ********************************************/

-- Merge twelve month tables into one unified table, called "trip_data"
CREATE TABLE IF NOT EXISTS trip_data
(SELECT * FROM trip_01)
UNION DISTINCT (SELECT * FROM trip_02)
UNION DISTINCT (SELECT * FROM trip_03)
UNION DISTINCT (SELECT * FROM trip_04)
UNION DISTINCT (SELECT * FROM trip_05)
UNION DISTINCT (SELECT * FROM trip_06)
UNION DISTINCT (SELECT * FROM trip_07)
UNION DISTINCT (SELECT * FROM trip_08)
UNION DISTINCT (SELECT * FROM trip_09)
UNION DISTINCT (SELECT * FROM trip_10)
UNION DISTINCT (SELECT * FROM trip_11)
UNION DISTINCT (SELECT * FROM trip_12);

-- Display columns from the "trip_data" table
SHOW COLUMNS FROM trip_data;


/********************
 *   PREVIEW DATA   *
 ********************/

-- Count the total number of ride trips in the "trip_data" table
SELECT COUNT(*) AS trip_count 
FROM trip_data;

-- Preview the first 5 rows of ride trips in the "trip_data" table
SELECT * FROM trip_data LIMIT 5;