INSERT INTO
  vmanevannan.user_devices_cumulated
WITH
  yesterday AS (
    SELECT
      *
    FROM
      vmanevannan.user_devices_cumulated
    WHERE
      DATE = DATE('2022-12-31')
  ),
  today AS (
    SELECT
      E.user_id AS user_id,
      MAX(E.device_id) AS device_id,
      MAX(d.browser_type) AS browser_type,
      MAX(CAST(DATE_TRUNC('day', event_time) AS DATE)) AS event_date
    FROM
      bootcamp.web_events E
      LEFT JOIN bootcamp.devices d ON d.device_id = E.device_id
    WHERE
      DATE_TRUNC('day', E.event_time) = DATE('2023-01-01')
    GROUP BY
      E.user_id,
      d.device_id,
      d.browser_type
    ORDER BY
      user_id,
      browser_type
  )
SELECT
  COALESCE(y.user_id, t.user_id) AS user_id,
  COALESCE(y.browser_type, t.browser_type) AS browser_type,
  CASE
    WHEN y.dates_active IS NOT NULL THEN ARRAY[t.event_date] || y.dates_active
    ELSE ARRAY[t.event_date]
  END AS dates_active,
  DATE('2023-01-01') AS DATE
FROM
  yesterday y
  FULL OUTER JOIN today t ON y.user_id = t.user_id