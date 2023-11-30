INSERT INTO vmanevannan.user_devices_cumulated
WITH
  yesterday AS (
    SELECT
      *
    FROM
      vmanevannan.user_devices_cumulated
    WHERE
      DATE = DATE('2022-12-31')
  ),
  today AS(
SELECT
      e.user_id,
      MAX(d.browser_type) as browser_type,
      CAST(DATE_TRUNC('day', event_time) AS DATE) AS event_date
 FROM
      bootcamp.web_events e
  LEFT JOIN bootcamp.devices d ON d.device_id = e.device_id
  WHERE
  DATE_TRUNC('day', e.event_time) = DATE('2023-01-01')
GROUP BY
      e.user_id,
      DATE_TRUNC('day', e.event_time)
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