WITH highest_winning_team AS
(
SELECT home_team_id,
  SUM(home_team_wins) as wins
  FROM
  bootcamp.nba_games
GROUP BY home_team_id
ORDER BY wins DESC
LIMIT 1
)
SELECT team_abbreviation
FROM highest_winning_team h
INNER JOIN bootcamp.nba_game_details gd ON
h.home_team_id = gd.team_id
LIMIT 1