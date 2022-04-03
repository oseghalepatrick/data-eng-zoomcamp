# Project Proposal

## Problem description - IMDB Movies and Series Rating
IMDB is a popular online and authorative source for movies and TV shows review and ratings and has database of infomation related to films, TV series and streaming content online including cast and production crew.

Lovers of films and reviewer will like the know the most popular movies of all time and their total reviews, distribution of films by year of release from 1923 till date, the top rated movies in the current year.

For this solution to be possible, the data engineer and analytic will need to create data pipeline to extract the raw data from the IMDB online database to datalake (GCS) which will be transform, structure and storage in Data Warehouse (Bigquery). Thereafter populated into actionable dashboard.

Although the data is updated daily on the IMDB database, the pipeline will be set to refresh weekly and henceforth updating the dashboard.

## Dataset
The data is a subset of IMDB dataset which is available for access on the [IMDB Datasets](https://datasets.imdbws.com/){:target="\_blank"} which is been refreshed daily. Each dataset is contained in a gzipped, tab-separated-values (TSV) formatted file in the UTF-8 character set.

## High Level Design


## Data Pipeline


## Technologies
1. Cloud: GCP
2. Infrastructure as code (IaC): Terraform
3. Datalake: GCP Bucket
4. Workflow orchestration: Airflow 
5. Data Warehouse: BigQuery 
6. Transformations: dbt
7. Dashboard with Data Studio

### 1. Cloud: GCP
The Google Cloud Platform is used for deploying the pipeline, Google Cloud Storage (GCS) as Data Lake and BigQuery as Data Warehouse.

### 2. Infrastructure as code (IaC): Terraform
Terraform is an open source tool which is been used for provisioning infrastructure resources in this case, used to create GCP Infra by creating the following [files](./terraform):
- `main.tf`
- `variables.tf`
- `.tfstate`

The necessary configurations were made to ensure the successful execution and also set the resources as `google_storage_bucket, google_bigquery_dataset, google_bigquery_tabl`.

*Execution steps*
`terraform init`:
* Initializes & configures the backend, installs plugins/providers, & checks out an existing configuration from a version control
`terraform plan`:
* Matches/previews local changes against a remote state, and proposes an Execution Plan.
`terraform apply`:
* Asks for approval to the proposed plan, and applies changes to cloud.



## Dashboard