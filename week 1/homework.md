## Week 1 Homework

In this homework we'll prepare the environment 
and practice with terraform and SQL

## Question 1. Google Cloud SDK

Install Google Cloud SDK. What's the version you have? 

To get the version, run `gcloud --version`

Google Cloud SDK 369.0.0
bq 2.0.72
core 2022.01.14
gsutil 5.6


## Question 2. Terraform 

Now install terraform and go to the terraform directory (`week_1_basics_n_setup/1_terraform_gcp/terraform`)

After that, run

* `terraform init`
* `terraform plan`
* `terraform apply` 

Apply the plan and copy the output to the form

## Prepare Postgres 

Run Postgres and load data as shown in the videos

We'll use the yellow taxi trips from January 2021:

```bash
wget https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_2021-01.csv
```

Download this data and put it to Postgres

```
google_bigquery_dataset.dataset: Creating...
google_storage_bucket.data-lake-bucket: Creating...
google_storage_bucket.data-lake-bucket: Creation complete after 3s [id=dtc_data_lake_calm-brook-338805]
google_bigquery_dataset.dataset: Creation complete after 3s [id=projects/calm-brook-338805/datasets/trips_data_all]
```

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

## Question 3. Count records 

How many taxi trips were there on January 15?

```
SELECT 
	COUNT(CAST(tpep_pickup_datetime as date))
FROM
	yellow_taxi_trips
WHERE 
	CAST(tpep_pickup_datetime as date) = '2021-01-15';
```

```
53024
```

## Question 4. Average

Find the largest tip for each day. 
On which day it was the largest tip in January?

(note: it's not a typo, it's "tip", not "trip")

```
SELECT 
	CAST(tpep_pickup_datetime as date) as "Date",
	MAX(tip_amount) as max_tip
FROM
	yellow_taxi_trips
GROUP BY
	"Date"
ORDER BY
	max_tip DESC
LIMIT 1;
```
```
2021-01-20
```

## Question 5. Most popular destination

What was the most popular destination for passengers picked up 
in central park on January 14?

Enter the district name (not id)

```
SELECT 
	dp."Zone", COUNT(1) num_dropoff
FROM (
	SELECT
		t."DOLocationID", z."Zone"
	FROM
		yellow_taxi_trips t JOIN zones z
		ON t."DOLocationID" = z."LocationID"
		JOIN zones zpu
		ON t."PULocationID" = zpu."LocationID"
		WHERE zpu."Zone" = 'Central Park' AND
		CAST(tpep_pickup_datetime AS date)='2021-01-14'
	) AS dp
GROUP BY dp."Zone"
ORDER BY num_dropoff DESC
LIMIT 1;
```
```
Upper East Side South
```

## Question 6. 

What's the pickup-dropoff pair with the largest 
average price for a ride (calculated based on `total_amount`)?

```
SELECT
	p_d."pickup_dropoff", AVG(p_d."total_amount") avg_amount
FROM (
	SELECT
		concat(
			CASE
				WHEN zpu."Zone" IS null THEN 'Unknown'
				ELSE zpu."Zone" 
			END, 
			' / ', 
			CASE
				WHEN zdo."Zone" IS null THEN 'Unknown'
				ELSE zdo."Zone"
			END ) pickup_dropoff,
		t."total_amount"
	FROM
		yellow_taxi_trips t
		JOIN
		zones zpu
		ON t."PULocationID" = zpu."LocationID"
		JOIN
		zones zdo
		ON t."DOLocationID" = zdo."LocationID"
	) AS p_d
GROUP BY p_d."pickup_dropoff"
ORDER BY avg_amount DESC
LIMIT 1;
```

```
Alphabet City / Unknown
```


## Submitting the solutions

Form for sumitting (TBA)

Deadline: 24 January, 17:00 CET


