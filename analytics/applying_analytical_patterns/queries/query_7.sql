WITH
   lebron_game_details AS (
    SELECT
      g.game_date_est,
      gd.player_name,
      gd.pts,
      gd.min IS NOT NULL played_in_game,
      CASE
        WHEN COALESCE(gd.pts, 0) > 10 THEN 1
        ELSE 0
      END scored_over_10_pts,
      gd.game_id,
      gd.team_city,
      ROW_NUMBER() OVER (
        ORDER BY
          game_date_est
      ) AS ROW_NUMBER,
      ROW_NUMBER() OVER (
        PARTITION BY
          CASE
            WHEN COALESCE(gd.pts, 0) > 10 THEN 1
            ELSE 0
          END
        ORDER BY
          game_date_est
      ) AS row_number_over_10_pts
    FROM
      bootcamp.nba_game_details gd
      JOIN bootcamp.nba_games g ON gd.game_id = g.game_id
    WHERE
      player_name = 'LeBron James'
      AND gd.min IS NOT NULL
  ),
  games_with_streak AS (
    SELECT
      *,
      ROW_NUMBER - row_number_over_10_pts AS streak_id,
      COUNT(1) OVER (
        PARTITION BY
          ROW_NUMBER - row_number_over_10_pts
        ORDER BY
          game_date_est
      ) AS streak_length
    FROM
      lebron_game_details
    ORDER BY
      ROW_NUMBER
  )
SELECT
  MAX(streak_length) as n_games
FROM
  games_with_streak