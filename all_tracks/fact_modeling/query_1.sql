CREATE TABLE vmanevannan.nba_game_details
(
    game_id BIGINT,
    team_id BIGINT,
    team_abbreviation VARCHAR,
    team_city VARCHAR,
    player_id BIGINT,
    player_name VARCHAR,
    nickname	VARCHAR,
    start_position	VARCHAR,
    comment	VARCHAR,
    min	VARCHAR,
    fgm	DOUBLE,
    fga	DOUBLE,
    fg_pct		DOUBLE,
    fg3m		DOUBLE,
    fg3a		DOUBLE,
    fg3_pct		DOUBLE,
    ftm		DOUBLE,
    fta		DOUBLE,
    ft_pct		DOUBLE,
    oreb		DOUBLE,
    dreb	DOUBLE,
    reb	DOUBLE,
    ast	DOUBLE,
    stl	DOUBLE,
    blk	DOUBLE,
    to	DOUBLE,
    pf	DOUBLE,
    pts	DOUBLE,
    plus_minus	DOUBLE,
    n_game_details INT
  )
WITH
(
 FORMAT = 'PARQUET')


WITH record_copies_ranked as (
SELECT
  *,
  row_number()
OVER(
 PARTITION BY
  game_id,
  team_id,
  player_id
ORDER BY game_id, team_id, player_id) as n_game_details
FROM
  bootcamp.nba_game_details
ORDER BY n_game_details DESC
)

SELECT * FROM
record_copies_ranked r
WHERE r.n_game_details = 1











-