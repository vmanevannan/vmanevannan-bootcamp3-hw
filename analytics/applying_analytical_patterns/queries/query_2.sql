WITH agg_game_details AS
(
SELECT 
COALESCE(player_name,'(overall)') as player,
COALESCE(team_abbreviation,'(overall)') as team,
COALESCE(season,0) as season,
/* using 0 to denote 'all seasons' since TYPE(season) is INT*/
COUNT(1) as game_count
FROM bootcamp.nba_game_details gd
LEFT JOIN bootcamp.nba_games g ON gd.game_id = g.game_id
GROUP BY GROUPING SETS ((player_name, team_abbreviation),
(player_name,season),
(team_abbreviation)
)
)

SELECT * FROM agg_game_details
ORDER BY game_count DESC