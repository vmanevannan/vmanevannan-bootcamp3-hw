CREATE TABLE
  vmanevannan.actors_history_scd (
    actor VARCHAR,
    start_date INTEGER,
    end_date INTEGER,
    quality_class VARCHAR,
    is_active INTEGER,
    current_year INTEGER
  )
WITH
  (
    FORMAT = 'PARQUET',
    partitioning = ARRAY['current_year']
  )