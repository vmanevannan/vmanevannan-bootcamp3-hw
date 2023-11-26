CREATE TABLE
  vmanevannan.actors (
    actor VARCHAR,
    actor_id VARCHAR,
    films ARRAY (
      ROW (
        film VARCHAR,
        votes INTEGER,
        rating DOUBLE,
        film_id VARCHAR
      )
    ),
    yearly_rating REAL,
    quality_class VARCHAR,
    is_active BOOLEAN,
    current_year INTEGER
  )
WITH
  (
    FORMAT = 'PARQUET',
    partitioning = ARRAY['current_year']
  )