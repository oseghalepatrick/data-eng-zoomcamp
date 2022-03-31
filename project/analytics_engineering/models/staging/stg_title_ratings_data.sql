{{ config(materialized='view') }}

SELECT
  tconst,
  cast(averageRating as numeric) as average_rating,
  cast(numVotes as integer) as number_of_votes,
  {{ get_ratings_level('averageRating') }} AS rating_level
FROM
  {{ source('staging','title_ratings_data') }}
-- LIMIT
--   1000