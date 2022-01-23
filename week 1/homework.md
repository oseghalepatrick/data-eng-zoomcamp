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

google_bigquery_dataset.dataset: Creating...
google_storage_bucket.data-lake-bucket: Creating...
google_storage_bucket.data-lake-bucket: Creation complete after 3s [id=dtc_data_lake_calm-brook-338805]
google_bigquery_dataset.dataset: Creation complete after 3s [id=projects/calm-brook-338805/datasets/trips_data_all]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

## Question 3. Count records 

How many taxi trips were there on January 15?

## Question 4. Average

Find the largest tip for each day. 
On which day it was the largest tip in January?

(note: it's not a typo, it's "tip", not "trip")

## Question 5. Most popular destination

What was the most popular destination for passengers picked up 
in central park on January 14?

Enter the district name (not id)

## Question 6. 

What's the pickup-dropoff pair with the largest 
average price for a ride (calculated based on `total_amount`)?


## Submitting the solutions

Form for sumitting (TBA)

Deadline: 24 January, 17:00 CET


