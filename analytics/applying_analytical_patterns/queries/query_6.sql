WITH game_details AS
(
   SELECT
      gd.game_id,
      MAX(g.game_date_est) as game_date,
      MAX(g.home_team_wins) as home_team_wins,
      MAX(gd.team_id) as team_id,
      MAX(gd.team_abbreviation) as team_abbreviation
    FROM
      bootcamp.nba_game_details gd JOIN bootcamp.nba_games g ON gd.game_id = g.game_id
    GROUP BY gd.game_id
)
WITH prev_game_details AS
(
SELECT *,
      ROW_NUMBER() OVER (
        PARTITION BY team_id
        ORDER BY
          game_date
      ) AS game_number,
      LAG(home_team_wins,1) OVER(
      PARTITION BY team_id
      ORDER BY game_date
      ) AS prev_game_status
FROM game_details
ORDER BY team_id, game_date
)
SELECT *
FROM prev_game_details 