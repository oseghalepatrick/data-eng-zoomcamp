{{ config(materialized='view') }}

SELECT
  nconst,
  primaryName as act_name,
  cast(birthYear as integer) as birth_year,
  cast(deathYear as integer) as death_year,
  primaryProfession as primary_profession,
  knownForTitles as known_for_titles --EXCEPT(profession)
FROM
  {{ source('staging','name_basics_data') }} AS star_names
JOIN
  UNNEST(SPLIT(star_names.primaryProfession)) AS profession
WHERE
  profession LIKE 'act%'
-- LIMIT
--   100000