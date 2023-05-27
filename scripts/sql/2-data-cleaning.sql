/******************************************************
 *   CREATE ANOTHER TABLE FOR DATA CLEANING PURPOSE   *
 ******************************************************/

-- Create the "trip_data_cleaned" table for data cleaning purpose
CREATE TABLE IF NOT EXISTS trip_data_cleaned
SELECT * FROM trip_data ORDER BY started_at;

-- Preview the first 5 rows of ride trips in the "trip_data_cleaned" table
SELECT * FROM trip_data_cleaned LIMIT 5;


/*******************************
 *   HANDLE DUPLICATE VALUES   *
 *******************************/

-- Count the unique number of ride trips in the "trip_data_cleaned" table
SELECT 
    COUNT(ride_id) AS trip_count, 
    COUNT(DISTINCT(ride_id)) AS unique_count
FROM trip_data_cleaned;

-- List all unique type of bike in the "trip_data_cleaned" table
SELECT DISTINCT(rideable_type)
FROM trip_data_cleaned;

-- List all unique type of rider in the "trip_data_cleaned" table
SELECT DISTINCT(member_casual)
FROM trip_data_cleaned;


/**********************************
 *   MANIPLULATE MISSING VALUES   *
 **********************************/

-- Count the total missing number of ride trips each column in the "trip_data_cleaned" table
SELECT 
	SUM(CASE WHEN ride_id IS NULL THEN 1 ELSE 0 END) AS ride_id,
	SUM(CASE WHEN rideable_type IS NULL THEN 1 ELSE 0 END) AS rideable_type,
	SUM(CASE WHEN started_at IS NULL THEN 1 ELSE 0 END) AS started_at,
	SUM(CASE WHEN ended_at IS NULL THEN 1 ELSE 0 END) AS ended_at,
	SUM(CASE WHEN start_station_name IS NULL THEN 1 ELSE 0 END) AS start_station_name,
	SUM(CASE WHEN start_station_id IS NULL THEN 1 ELSE 0 END) AS start_station_id,
	SUM(CASE WHEN end_station_name IS NULL THEN 1 ELSE 0 END) AS end_station_name,
	SUM(CASE WHEN end_station_id IS NULL THEN 1 ELSE 0 END) AS end_station_id,
	SUM(CASE WHEN start_lat IS NULL THEN 1 ELSE 0 END) AS start_lat,
	SUM(CASE WHEN start_lng IS NULL THEN 1 ELSE 0 END) AS start_lng,
	SUM(CASE WHEN end_lat IS NULL THEN 1 ELSE 0 END) AS end_lat,
	SUM(CASE WHEN end_lng IS NULL THEN 1 ELSE 0 END) AS end_lng,
	SUM(CASE WHEN member_casual IS NULL THEN 1 ELSE 0 END) AS member_casual
FROM trip_data_cleaned;

-- Remove all ride trips that are incomplete or missing data from the "trip_data_cleaned" table
DELETE FROM trip_data_cleaned 
WHERE start_station_name IS NULL 
    OR start_station_id IS NULL 
    OR end_station_name IS NULL 
    OR end_station_id IS NULL
    OR end_lat IS NULL 
    OR end_lng IS NULL;

-- Count the total number of ride trips in the "trip_data_cleaned" table
SELECT COUNT(*) AS trip_count 
FROM trip_data_cleaned;


/************************
 *   FIX STATION NAME   *
 ************************/

-- Check all starting stations
SELECT 
    start_station_id, 
    start_station_name, 
    COUNT(*) AS trip_count
FROM trip_data_cleaned
GROUP BY 
    start_station_name, 
    start_station_id
ORDER BY 
    start_station_name, 
    start_station_id;

-- Check all ending stations
SELECT 
    end_station_id, 
    end_station_name, 
    COUNT(*) AS trip_count
FROM trip_data_cleaned
GROUP BY 
    end_station_name, 
    end_station_id
ORDER BY 
    end_station_name, 
    end_station_id;

-- Count the number of ride trips, where the starting and ending stations are named in 8 station names
SELECT COUNT(*) AS trip_count
FROM trip_data_cleaned
WHERE 
    start_station_name IN ('Pawel Bialowas - Test- PBSC charging station', 'Hastings WH 2', 'DIVVY CASSETTE REPAIR MOBILE STATION', 'Base - 2132 W Hubbard Warehouse', 'Base - 2132 W Hubbard', 'NewHastings', 'WestChi', 'WEST CHI-WATSON') 
    OR end_station_name IN ('Pawel Bialowas - Test- PBSC charging station', 'Hastings WH 2', 'DIVVY CASSETTE REPAIR MOBILE STATION', 'Base - 2132 W Hubbard Warehouse', 'Base - 2132 W Hubbard', 'NewHastings', 'WestChi', 'WEST CHI-WATSON');

-- Remove all ride trips that are in 8 station names both starting and ending stations from the "trip_data_cleaned" table
DELETE FROM trip_data_cleaned
WHERE 
    start_station_name IN ('Pawel Bialowas - Test- PBSC charging station', 'Hastings WH 2', 'DIVVY CASSETTE REPAIR MOBILE STATION', 'Base - 2132 W Hubbard Warehouse', 'Base - 2132 W Hubbard', 'NewHastings', 'WestChi', 'WEST CHI-WATSON') 
    OR end_station_name IN ('Pawel Bialowas - Test- PBSC charging station', 'Hastings WH 2', 'DIVVY CASSETTE REPAIR MOBILE STATION', 'Base - 2132 W Hubbard Warehouse', 'Base - 2132 W Hubbard', 'NewHastings', 'WestChi', 'WEST CHI-WATSON');

-- Change some small error text in starting and ending stations
UPDATE trip_data_cleaned
SET start_station_name = REPLACE(start_station_name, '*', ''), 
    start_station_name = REPLACE(start_station_name, ' - Charging', ''), 
    start_station_name = REPLACE(start_station_name, ' (Temp)', ''), 
    start_station_name = REPLACE(start_station_name, 'amp;', ''),
    end_station_name = REPLACE(end_station_name, '*', ''), 
    end_station_name = REPLACE(end_station_name, ' - Charging', ''), 
    end_station_name = REPLACE(end_station_name, ' (Temp)', ''), 
    end_station_name = REPLACE(end_station_name, 'amp;', '');

-- Drop "start_station_id" and "end_station_id" columns due to unnecessity 
ALTER TABLE trip_data_cleaned
    DROP COLUMN start_station_id, 
    DROP COLUMN end_station_id;

-- Preview the first 5 rows of ride trips in the "trip_data_cleaned" table
SELECT * FROM trip_data_cleaned LIMIT 5;


/*************************************
 *   CREATE NEW CALCULATED COLUMNS   *
 *************************************/

-- Add the "ride_length" and "day_of_week" columns to the "trip_data_cleaned" table
ALTER TABLE trip_data_cleaned
ADD COLUMN (
    ride_length_sec INT,
    day_of_week INT
);

-- Update the "ride_length" column in minutes based on the diffrence between "started_at" and "ended_at" columns
-- Update the "day_of_week" column based on the "started_at" column (0 = Monday and 6 = Sunday)
UPDATE trip_data_cleaned
SET 
    ride_length_sec = TIME_TO_SEC(TIMEDIFF(ended_at, started_at)),
    day_of_week = WEEKDAY(started_at);

-- Preview the first 5 rows of ride trips in the "trip_data_cleaned" table
SELECT * FROM trip_data_cleaned LIMIT 5;


/***************************
 *   REMOVE ERROR VALUES   *
 ***************************/

-- Count the number of ride trips, where the "ride_length_sec" column is less than 60 seconds
SELECT COUNT(ride_length_sec) AS trip_count
FROM trip_data_cleaned
WHERE ride_length_sec < 60;

-- Count the number of ride trips, groupping by the "ride_length_sec" column
SELECT 
    ride_length_sec, 
    COUNT(ride_length_sec) AS trip_count
FROM trip_data_cleaned
WHERE ride_length_sec < 60
GROUP BY ride_length_sec
ORDER BY ride_length_sec;

-- Remove all ride trips, where the "ride_length_sec" column is less than 60 seconds
DELETE FROM trip_data_cleaned
WHERE ride_length_sec < 60;


/*****************************
 *   REMOVE OUTLIER VALUES   *
 *****************************/

-- Count the number of ride trips, where the "ride_length_sec" column is less than or more than 3 times standard deviation
WITH temp_table AS (
    SELECT 
        AVG(ride_length_sec) + (3 * STDDEV(ride_length_sec)) AS upper_limit,
        AVG(ride_length_sec) - (3 * STDDEV(ride_length_sec)) AS lower_limit
    FROM trip_data_cleaned
)
SELECT COUNT(ride_length_sec) AS trip_count
FROM trip_data_cleaned
WHERE ride_length_sec > (SELECT upper_limit FROM temp_table)
    OR ride_length_sec < (SELECT lower_limit FROM temp_table);

-- Count the number of ride trips, groupping by the "ride_length_sec" column
WITH temp_table AS (
    SELECT 
        AVG(ride_length_sec) + (3 * STDDEV(ride_length_sec)) AS upper_limit,
        AVG(ride_length_sec) - (3 * STDDEV(ride_length_sec)) AS lower_limit
    FROM trip_data_cleaned
)
SELECT 
    ride_length_sec, 
    COUNT(ride_length_sec) AS trip_count
FROM trip_data_cleaned
WHERE ride_length_sec > (SELECT upper_limit FROM temp_table)
    OR ride_length_sec < (SELECT lower_limit FROM temp_table)
GROUP BY ride_length_sec
ORDER BY ride_length_sec;

-- Remove all ride trips, where the "ride_length_sec" column is less than or more than 3 times of standard deviation
WITH temp_table AS (
    SELECT 
        AVG(ride_length_sec) + (3 * STDDEV(ride_length_sec)) AS upper_limit,
        AVG(ride_length_sec) - (3 * STDDEV(ride_length_sec)) AS lower_limit
    FROM trip_data_cleaned
)
DELETE FROM trip_data_cleaned
WHERE ride_length_sec > (SELECT upper_limit FROM temp_table)
    OR ride_length_sec < (SELECT lower_limit FROM temp_table);


/********************
 *   PREVIEW DATA   *
 ********************/

-- Count the total number of ride trips in the "trip_data_cleaned" table
SELECT COUNT(*) AS trip_count 
FROM trip_data_cleaned;

-- Preview the first 5 rows of ride trips in the "trip_data_cleaned" table
SELECT * FROM trip_data_cleaned LIMIT 5;