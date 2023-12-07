WITH agg_game_details AS
(
SELECT
COALESCE(player_name,'(overall)') as player,
SUM(pts) as total_points,
COALESCE(season,0) as season
/* using 0 to denote 'all seasons' since TYPE(season) is INT*/
FROM bootcamp.nba_game_details gd
LEFT JOIN bootcamp.nba_games g ON gd.game_id = g.game_id
GROUP BY GROUPING SETS ((player_name,season))
)

SELECT player FROM agg_game_details
ORDER BY total_points DESC
LIMIT 1