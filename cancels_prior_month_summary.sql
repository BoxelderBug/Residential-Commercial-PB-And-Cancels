-- ============================================================
-- Cancels Summary — Prior Calendar Month  (vr_230 + t_locations)
-- Total cancel count and total annual value broken out by
-- Residential vs. Commercial for the prior calendar month.
-- ============================================================

SELECT
    CASE WHEN l.[residential_flag] = 1 THEN 'Residential' ELSE 'Commercial' END AS [res_com]
   ,COUNT(*)            AS [total_cancels]
   ,SUM(c.[annual_value]) AS [total_annual_value]
FROM [dbo].[vr_230]      AS c
JOIN [dbo].[t_locations] AS l ON l.[location_key] = c.[location_key]
WHERE
    c.[plan_end_dt] >= DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) - 1, 0)
    AND c.[plan_end_dt]  < DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()),     0)
GROUP BY
    l.[residential_flag]
ORDER BY
    l.[residential_flag] DESC;  -- Residential first, then Commercial
