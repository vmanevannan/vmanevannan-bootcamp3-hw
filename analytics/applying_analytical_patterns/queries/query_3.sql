WITH agg_game_details AS
(
SELECT
COALESCE(player_name,'(overall)') as player,
COALESCE(team_abbreviation,'(overall)') as team,
SUM(pts) as total_points
FROM bootcamp.nba_game_details gd
GROUP BY GROUPING SETS ((player_name, team_abbreviation))
)

SELECT player FROM agg_game_details
ORDER BY total_points DESC
LIMIT 1