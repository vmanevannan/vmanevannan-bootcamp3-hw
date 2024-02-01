WITH
  game_details AS (
    SELECT
      gd.game_id,
      MAX(g.game_date_est) AS game_date,
      MAX(g.home_team_wins) AS home_team_wins,
      MAX(gd.team_id) AS team_id,
      MAX(gd.team_abbreviation) AS team_abbreviation
    FROM
      bootcamp.nba_game_details gd
      JOIN bootcamp.nba_games g ON gd.game_id = g.game_id
    GROUP BY
      gd.game_id
  ),
lagged AS (
    SELECT
      *,
      LAG(home_team_wins,1) OVER (
        PARTITION BY
          team_id
        ORDER BY
          game_date
      ) AS did_win_game_before
    FROM
      game_details
    ORDER BY
      team_id,
      game_date
  ),
streak_changes AS (
SELECT
 *,
  CASE WHEN home_team_wins != did_win_game_before THEN 1 ELSE 0 
  END as streak_changed
FROM
lagged
),
streak_identified AS(
SELECT *,
SUM(streak_changed) OVER (
        PARTITION BY
          team_id
        ORDER BY
          game_date
      ) as streak_identifier
FROM
streak_changes),

record_counts AS (
SELECT *, 
ROW_NUMBER() OVER (PARTITION BY
          team_id, streak_identifier
        ORDER BY
          game_date
      ) as streak_length
FROM streak_identified
),   
ranked AS(
SELECT *,
RANK() OVER (PARTITION BY
          team_id, streak_identifier
        ORDER BY
          streak_length DESC
      ) as rank
FROM record_counts
)

SELECT team_id, 
       MAX(team_abbreviation),
       MAX(streak_length) AS longest_streak
FROM ranked
GROUP BY team_id
ORDER BY MAX(streak_length) DESC

