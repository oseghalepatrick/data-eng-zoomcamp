-- What is count for fhv vehicles data for year 2019
SELECT count(*) FROM `calm-brook-338805.trips_data_all.fhv_tripdata_external_table`;


-- How many distinct dispatching_base_num we have in fhv for 2019
SELECT count(distinct  dispatching_base_num) FROM `calm-brook-338805.trips_data_all.fhv_tripdata_external_table`;


-- Creating a partition by dropoff_datetime and cluster by dispatching_base_num
CREATE OR REPLACE TABLE calm-brook-338805.trips_data_all.fhv_tripdata_partitoned_clustered
PARTITION BY DATE(dropoff_datetime)
CLUSTER BY dispatching_base_num AS
SELECT * FROM calm-brook-338805.trips_data_all.fhv_tripdata_external_table;

-- Creating a partition by dropoff_datetime
CREATE OR REPLACE TABLE calm-brook-338805.trips_data_all.fhv_tripdata_partitoned
PARTITION BY DATE(dropoff_datetime) AS
SELECT * FROM calm-brook-338805.trips_data_all.fhv_tripdata_external_table;

-- Creating a cluster by dispatching_base_num
CREATE OR REPLACE TABLE calm-brook-338805.trips_data_all.fhv_tripdata_clustered
CLUSTER BY dispatching_base_num AS
SELECT * FROM calm-brook-338805.trips_data_all.fhv_tripdata_external_table;

-- Best strategy to optimise if query always filter by dropoff_datetime and order by dispatching_base_num
SELECT * 
FROM calm-brook-338805.trips_data_all.fhv_tripdata_partitoned_clustered
WHERE DATE(dropoff_datetime) BETWEEN '2019-01-01' AND '2019-03-31'
ORDER BY dispatching_base_num;

SELECT * 
FROM calm-brook-338805.trips_data_all.fhv_tripdata_partitoned
WHERE DATE(dropoff_datetime) BETWEEN '2019-01-01' AND '2019-03-31'
ORDER BY dispatching_base_num;

SELECT * 
FROM calm-brook-338805.trips_data_all.fhv_tripdata_clustered
WHERE DATE(dropoff_datetime) BETWEEN '2019-01-01' AND '2019-03-31'
ORDER BY dispatching_base_num;


-- What is the count, estimated and actual data processed for query which counts trip 
-- between 2019/01/01 and 2019/03/31 for dispatching_base_num B00987, B02060, B02279
SELECT COUNT(*) 
FROM calm-brook-338805.trips_data_all.fhv_tripdata_partitoned_clustered
WHERE dropoff_datetime BETWEEN '2019-01-01' AND '2019-03-31'
    AND dispatching_base_num IN ('B00987', 'B02060', 'B02279');
