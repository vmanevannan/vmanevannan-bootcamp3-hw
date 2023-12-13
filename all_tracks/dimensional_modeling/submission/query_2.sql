INSERT INTO vmanevannan.actors

WITH
  last_year AS (
    SELECT
      *
    FROM
      vmanevannan.actors
    WHERE
      current_year = 1917
  ),
  current_year AS (
    SELECT
      actor,
      actor_id,
      film,
      YEAR,
      votes,
      rating,
      film_id,
      ROW_NUMBER() OVER (
        PARTITION BY
          actor_id
        ORDER BY
          YEAR DESC
      ) AS film_num
    FROM
      bootcamp.actor_films
    WHERE
      YEAR = 1918
  ),
  current_year_films AS (
    SELECT
      actor,
      actor_id,
      YEAR,
      ARRAY_AGG(
        ROW (film, votes, rating, film_id)
        ORDER BY
          film_id DESC
      ) AS films
    FROM
      current_year cy
    GROUP BY
      actor,
      actor_id,
      YEAR
  ),
  film_ratings AS (
    SELECT
      actor,
      actor_id,
      SUM(rating) / COUNT(*) AS avg_rating
    FROM
      current_year cy
    GROUP BY
      actor,
      actor_id
  )
SELECT
COALESCE(ly.actor, cyf.actor) AS actor,
COALESCE(ly.actor_id, cyf.actor_id) AS actor_id,
COALESCE(ly.films, ARRAY[]) ||
         CASE WHEN cyf.year IS NOT NULL -- if there's film data this year, create a new array with a single row representing this year's film data
         THEN cyf.films -- ROW creates a new row with the film stats
         ELSE ARRAY[] -- otherwise, create an empty array
         END AS films,
   COALESCE(fr.avg_rating, ly.yearly_rating) AS yearly_rating,
    (
    CASE
      WHEN COALESCE(fr.avg_rating, ly.yearly_rating) > 8 THEN 'star'
      WHEN COALESCE(fr.avg_rating, ly.yearly_rating) > 7 THEN 'good'
      WHEN COALESCE(fr.avg_rating, ly.yearly_rating) > 6 THEN 'average'
      ELSE 'bad'
    END
  ) AS quality_class,
   (
    CASE
      WHEN cyf.films IS NOT NULL THEN TRUE
      ELSE FALSE
    END
  ) AS is_active,
  1918 AS year

    FROM
  last_year ly
    FULL OUTER JOIN current_year_films cyf ON ly.actor_id = cyf.actor_id
    LEFT JOIN film_ratings fr ON fr.actor_id = cyf.actor_id