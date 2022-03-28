{{ config(materialized='table') }}

with title_basics as (
    select * 
    from {{ ref('stg_title_basics_data') }}
),

title_ratings as (
    select *
    from {{ ref('stg_title_ratings_data')}}
)

select
    title_basics.tconst,
    title_genres,
    count(1) as numb
from title_basics
join unnest(split(title_basics.genres)) as title_genres
inner join title_ratings
on title_basics.tconst = title_ratings.tconst
where title_genres != '\\N'
group by 1, 2