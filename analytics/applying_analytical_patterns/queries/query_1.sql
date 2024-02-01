CREATE TABLE vmanevannan.player_statechange_tracking
(
    player_name VARCHAR,
    first_active_season INTEGER,
    last_active_season INTEGER,
    yearly_active_state VARCHAR,
    active_seasons ARRAY (BIGINT),
    partition_date INTEGER
  )
WITH
  (
    FORMAT = 'PARQUET',
    partitioning = ARRAY['player_name', 'partition_date']
 )


INSERT INTO vmanevannan.player_statechange_tracking
WITH yesterday AS (
    SELECT * FROM  vmanevannan.player_statechange_tracking
     WHERE partition_date = 1996
),
today AS (
   SELECT
      CAST(p.player_name AS VARCHAR) as player_name,
      CASE WHEN p.is_active = true THEN
           MIN(p.start_season) OVER w END as first_active_season,
      CASE WHEN p.is_active = true THEN
          MAX(p.end_season)  OVER w END as last_active_season,
      CASE WHEN p.is_active = true THEN
           SEQUENCE(p.start_season,p.end_season, 1)
      END AS active_seasons,
      p.end_season as active_season
      FROM vmanevannan.nba_player_scd p
      WHERE p.end_season = 1997
      AND p.player_name IS NOT NULL
      WINDOW w as (PARTITION BY p.player_name ORDER BY p.start_season)
)
,
combined AS
(
SELECT COALESCE(y.player_name, t.player_name) as player_name,
      COALESCE(y.first_active_season, t.first_active_season) as first_active_season,
      COALESCE(t.last_active_season, y.last_active_season) AS last_active_season,
      t.active_season,
        CASE
        WHEN y.active_seasons IS NULL THEN t.active_seasons
        WHEN t.active_season IS NULL THEN y.active_seasons
      END AS active_seasons,
      1997 AS partition_date
    FROM
      yesterday y
      FULL OUTER JOIN today t ON y.player_name = t.player_name
  )

SELECT
  player_name,
  first_active_season,
  last_active_season,
  CASE
    WHEN active_season - first_active_season = 0 THEN 'new'
    WHEN active_season - last_active_season = 0 THEN 'continued playing'
    WHEN active_season -last_active_season > 1 THEN 'returned from retirement'
    WHEN partition_date - last_active_season >= 1 THEN
'stayed retired'
    ELSE 'stale'
  END AS yearly_active_state,
  active_seasons,
  partition_date
FROM combined
ORDER BY player_name