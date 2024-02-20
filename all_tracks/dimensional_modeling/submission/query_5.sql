INSERT INTO
  vmanevannan.actors_history_scd
WITH
  last_year_scd AS (
    SELECT
      *
    FROM
      vmanevannan.actors_history_scd
    WHERE
      current_year = 1919
  ),
  current_year_scd AS (
    SELECT
      *
    FROM
      vmanevannan.actors
    WHERE
      current_year = 1920
  ),
  combined AS (
    SELECT
      COALESCE(ls.actor, cs.actor) AS actor,
      COALESCE(ls.start_date, cs.current_year) AS start_date,
      COALESCE(ls.end_date, cs.current_year) AS end_date,
      ls.is_active AS is_active_last_year,
      cs.is_active AS is_active_this_year,
      CASE
        WHEN ls.is_active <> cs.is_active
        OR ls.quality_class <> cs.quality_class THEN 1
        WHEN ls.is_active = cs.is_active
        AND ls.quality_class = cs.quality_class THEN 0
      END AS did_change,
      ls.quality_class AS qc_last_year,
      cs.quality_class AS qc_this_year,
      1920 AS current_year
    FROM
      last_year_scd ls
      FULL OUTER JOIN current_year_scd cs ON ls.actor = cs.actor
      AND ls.end_date + 1 = cs.current_year
  ),
  changes AS (
    SELECT
      actor,
      current_year,
      CASE
        WHEN did_change = 0 THEN ARRAY[
          CAST(
            ROW (
              qc_last_year,
              is_active_last_year,
              start_date,
              end_date + 1
            ) AS ROW (
              quality_class VARCHAR,
              is_active BOOLEAN,
              start_date INTEGER,
              end_date INTEGER
            )
          )
        ]
        WHEN did_change = 1 THEN ARRAY[
          CAST(
            ROW (
              qc_last_year,
              is_active_last_year,
              start_date,
              end_date
            ) AS ROW (
              quality_class VARCHAR,
              is_active BOOLEAN,
              start_date INTEGER,
              end_date INTEGER
            )
          ),
          CAST(
            ROW (
              qc_this_year,
              is_active_this_year,
              current_year,
              current_year
            ) AS ROW (
              quality_class VARCHAR,
              is_active BOOLEAN,
              start_date INTEGER,
              end_date INTEGER
            )
          )
        ]
        WHEN did_change IS NULL THEN ARRAY[
          CAST(
            ROW (
              COALESCE(qc_last_year, qc_this_year),
              COALESCE(is_active_last_year, is_active_this_year),
              start_date,
              end_date
            ) AS ROW (
              quality_class VARCHAR,
              is_active BOOLEAN,
              start_date INTEGER,
              end_date INTEGER
            )
          )
        ]
      END AS change_array
    FROM
      combined
  )
SELECT
  actor,
  arr.start_date,
  arr.end_date,
  arr.quality_class,
  arr.is_active,
  current_year
FROM
  changes
  CROSS JOIN UNNEST (change_array) AS arr