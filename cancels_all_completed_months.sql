-- ============================================================
-- Cancels — All Completed Months  (vr_230 + t_locations)
-- Returns every plan record whose plan_end_dt falls within a
-- fully-closed calendar month, with residential vs. commercial
-- classification from t_locations.
-- ============================================================

SELECT
    c.[client_key]
   ,c.[branch_key]
   ,c.[branch_name]
   ,c.[location_key]
   ,c.[location_name]
   ,c.[address]
   ,c.[address2]
   ,c.[city]
   ,c.[state]
   ,c.[zip9]
   ,c.[location_url]
   ,c.[location_plan_url]
   ,c.[location_plan_key]
   ,c.[service_only_flag]
   ,c.[invoice_only_flag]
   ,c.[plan_key]
   ,c.[plan_description]
   ,c.[plan_begin_dt]
   ,c.[plan_end_dt]
   ,c.[days_effective]
   ,c.[active_flag]
   ,c.[price]
   ,c.[annual_value]
   ,c.[comment]
   ,c.[technician_key]
   ,c.[technician_name]
   ,l.[residential_flag]
   ,CASE WHEN l.[residential_flag] = 1 THEN 'Residential' ELSE 'Commercial' END AS [res_com]
FROM [dbo].[vr_230]        AS c
JOIN [dbo].[t_locations]   AS l ON l.[location_key] = c.[location_key]
WHERE
    c.[plan_end_dt] < DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)
ORDER BY
    c.[plan_end_dt]
   ,[res_com]
   ,c.[branch_name]
   ,c.[location_name];


-- ============================================================
-- Optional: monthly summary rollup by branch + res/com
-- ============================================================

/*
SELECT
    CAST(DATEADD(MONTH,
        DATEDIFF(MONTH, 0, c.[plan_end_dt]), 0)
        AS DATE)                                          AS [cancel_month]
   ,YEAR(c.[plan_end_dt])                                AS [year]
   ,DATENAME(MONTH, c.[plan_end_dt])                     AS [month_name]
   ,c.[branch_name]
   ,CASE WHEN l.[residential_flag] = 1
         THEN 'Residential' ELSE 'Commercial' END        AS [res_com]
   ,COUNT(*)                                             AS [cancel_count]
   ,SUM(c.[annual_value])                                AS [total_annual_value]
   ,SUM(c.[price])                                       AS [total_price]
FROM [dbo].[vr_230]        AS c
JOIN [dbo].[t_locations]   AS l ON l.[location_key] = c.[location_key]
WHERE
    c.[plan_end_dt] < DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)
GROUP BY
    DATEADD(MONTH, DATEDIFF(MONTH, 0, c.[plan_end_dt]), 0)
   ,YEAR(c.[plan_end_dt])
   ,DATENAME(MONTH, c.[plan_end_dt])
   ,c.[branch_name]
   ,l.[residential_flag]
ORDER BY
    [cancel_month]
   ,c.[branch_name]
   ,[res_com];
*/
