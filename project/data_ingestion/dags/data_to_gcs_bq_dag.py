import os
import logging

from airflow import DAG
from airflow.utils.dates import days_ago
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator
from airflow.providers.google.cloud.operators.bigquery import BigQueryCreateExternalTableOperator, BigQueryInsertJobOperator
from airflow.providers.google.cloud.transfers.gcs_to_gcs import GCSToGCSOperator

from google.cloud import storage

import pyarrow.csv as pv
import pyarrow.parquet as pq

import pyspark
from pyspark.sql import SparkSession, types

PROJECT_ID = os.environ.get("GCP_PROJECT_ID")
BUCKET = os.environ.get("GCP_GCS_BUCKET")

AIRFLOW_HOME = os.environ.get("AIRFLOW_HOME", "/opt/airflow/")
BIGQUERY_DATASET = os.environ.get("BIGQUERY_DATASET", 'all_movies_data')


spark = SparkSession.builder \
    .master("local[*]") \
    .appName('test') \
    .getOrCreate()

def read_data(file_name, dest_file, schema=None):
    url = f'https://datasets.imdbws.com/{file_name}.tsv.gz'
    spark.sparkContext.addFile(url)
    df = spark.read \
            .option('header', 'true') \
            .csv('file://'+pyspark.SparkFiles.get(file_name+'.tsv.gz'), sep='\t', schema=schema)
    df.repartition(7)\
        .write.parquet(dest_file, mode='overwrite')

