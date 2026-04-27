-- ============================================================
-- Cancels Summary — All Completed Months YTD  (vr_230 + t_locations)
-- Total cancel count and total annual value broken out by
-- month and Residential vs. Commercial for all fully-closed
-- calendar months of the current year through end of last month.
-- ============================================================

SELECT
    CAST(DATEADD(MONTH,
        DATEDIFF(MONTH, 0, c.[plan_end_dt]), 0)
        AS DATE)                                          AS [cancel_month]
   ,YEAR(c.[plan_end_dt])                                AS [year]
   ,MONTH(c.[plan_end_dt])                               AS [month_num]
   ,DATENAME(MONTH, c.[plan_end_dt])                     AS [month_name]
   ,CASE WHEN l.[residential_flag] = 1
         THEN 'Residential' ELSE 'Commercial' END        AS [res_com]
   ,COUNT(*)                                             AS [total_cancels]
   ,SUM(c.[annual_value])                                AS [total_annual_value]
FROM [dbo].[vr_230]      AS c
JOIN [dbo].[t_locations] AS l ON l.[location_key] = c.[location_key]
WHERE
    c.[plan_end_dt] >= DATEFROMPARTS(YEAR(GETDATE()), 1, 1)
    AND c.[plan_end_dt]  < DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)
GROUP BY
    DATEADD(MONTH, DATEDIFF(MONTH, 0, c.[plan_end_dt]), 0)
   ,YEAR(c.[plan_end_dt])
   ,MONTH(c.[plan_end_dt])
   ,DATENAME(MONTH, c.[plan_end_dt])
   ,l.[residential_flag]
ORDER BY
    [cancel_month]
   ,l.[residential_flag] DESC;  -- Residential first, then Commercial
