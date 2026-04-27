-- ============================================================
-- Cancels — All Completed Months Year-to-Date
-- Returns every cancel record for all fully-closed calendar
-- months from the start of the data through end of last month.
-- "Completed month" = any month whose end date has already
-- passed, i.e., everything before the 1st of the current month.
-- ============================================================

SELECT
    [branch_key]
   ,[branch_name]
   ,[service_key]
   ,[service_code]
   ,[service_description]
   ,[user_key]
   ,[technician_key]
   ,[technician_name]
   ,[plan_dt]
   ,[quantity]
   ,[total]
FROM [dbo].[vr_210]
WHERE
    -- Exclude the current (in-progress) month
    [plan_dt] < DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)

    -- Uncomment and adjust if vr_210 is not already scoped to cancels:
    -- AND [service_code] = 'CANCEL'
    -- AND [service_description] LIKE '%cancel%'

ORDER BY
    [plan_dt]
   ,[branch_name]
   ,[technician_name];


-- ============================================================
-- Optional: summarized version — totals rolled up by month
-- and branch for reporting / charting use
-- ============================================================

/*
SELECT
    YEAR([plan_dt])                              AS [year]
   ,MONTH([plan_dt])                             AS [month_num]
   ,DATENAME(MONTH, [plan_dt])                   AS [month_name]
   ,CAST(DATEADD(MONTH,
        DATEDIFF(MONTH, 0, [plan_dt]), 0)
        AS DATE)                                 AS [month_start]
   ,[branch_name]
   ,SUM([total])                                 AS [total_cancels]
   ,SUM([quantity])                              AS [total_quantity]
   ,COUNT(*)                                     AS [record_count]
FROM [dbo].[vr_210]
WHERE
    [plan_dt] < DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)
    -- AND [service_code] = 'CANCEL'
GROUP BY
    YEAR([plan_dt])
   ,MONTH([plan_dt])
   ,DATENAME(MONTH, [plan_dt])
   ,DATEADD(MONTH, DATEDIFF(MONTH, 0, [plan_dt]), 0)
   ,[branch_name]
ORDER BY
    [month_start]
   ,[branch_name];
*/
