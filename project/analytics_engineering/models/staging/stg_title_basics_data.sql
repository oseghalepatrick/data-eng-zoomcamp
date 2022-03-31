{{ config(materialized='view') }}

SELECT
  tconst,
  titleType as title_type,
  primaryTitle as primary_title,
  originalTitle as original_title,
  cast(isAdult as integer) as is_adult,
  cast(startYear as integer) as start_year,
  cast(endYear as integer) as end_year,
  cast(runtimeMinutes as integer) as runtime_minutes,
  genres,
  concat("https://www.imdb.com/title/", tconst) as link
FROM
    {{ source('staging','title_basics_data') }}
WHERE
  titleType IN ('movie', 'tvSeries')
-- LIMIT 100