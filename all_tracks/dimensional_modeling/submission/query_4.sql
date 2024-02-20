INSERT INTO vmanevannan.actors_history_scd
WITH
  lagged AS (
    SELECT
      actor,
      CAST(is_active AS INT) as is_active,
      CASE
        WHEN LAG(is_active, 1) OVER (
          PARTITION BY
            actor
          ORDER BY
            current_year
        ) THEN 1
        ELSE 0
      END AS is_active_last_year,
      quality_class,
      LAG(quality_class, 1) OVER (
          PARTITION BY
            actor
          ORDER BY
            current_year)
      AS qc_last_year,
      current_year
    FROM
      vmanevannan.actors
    WHERE
      current_year <= 1919
  ),
 streaked AS (
    SELECT
      *,
      SUM(
        CASE
          WHEN is_active <> is_active_last_year or
               quality_class <> qc_last_year
          THEN 1
          ELSE 0
        END
      ) OVER (
        PARTITION BY
          actor
        ORDER BY
          current_year
      ) AS streak_identifier
     FROM
      lagged
  )

SELECT
actor,
MIN(current_year) AS start_date,
MAX(current_year) AS end_date,
MAX(quality_class) AS quality_class,
MAX(is_active) AS is_active,
MAX(current_year) AS current_year
FROM
  streaked
GROUP BY
  actor,
  streak_identifier