-- ============================================================
-- Cancels — All Completed Months  (vr_230)
-- Returns every plan record whose plan_end_dt falls within a
-- fully-closed calendar month (i.e., before the 1st of the
-- current month).  Excludes the current in-progress month.
-- ============================================================

SELECT
    [client_key]
   ,[branch_key]
   ,[branch_name]
   ,[location_url]
   ,[location_key]
   ,[location_name]
   ,[address]
   ,[address2]
   ,[city]
   ,[state]
   ,[zip9]
   ,[location_plan_url]
   ,[location_plan_key]
   ,[service_only_flag]
   ,[invoice_only_flag]
   ,[plan_key]
   ,[plan_description]
   ,[plan_begin_dt]
   ,[plan_end_dt]
   ,[days_effective]
   ,[active_flag]
   ,[price]
   ,[annual_value]
   ,[comment]
   ,[technician_key]
   ,[technician_name]
FROM [dbo].[vr_230]
WHERE
    -- All fully-closed months; excludes the current in-progress month
    [plan_end_dt] < DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)

ORDER BY
    [plan_end_dt]
   ,[branch_name]
   ,[location_name];


-- ============================================================
-- Optional: monthly summary rollup by branch
-- ============================================================

/*
SELECT
    CAST(DATEADD(MONTH,
        DATEDIFF(MONTH, 0, [plan_end_dt]), 0)
        AS DATE)                          AS [cancel_month]
   ,DATENAME(MONTH, [plan_end_dt])        AS [month_name]
   ,YEAR([plan_end_dt])                   AS [year]
   ,[branch_name]
   ,COUNT(*)                              AS [cancel_count]
   ,SUM([annual_value])                   AS [total_annual_value]
   ,SUM([price])                          AS [total_price]
FROM [dbo].[vr_230]
WHERE
    [plan_end_dt] < DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()), 0)
GROUP BY
    DATEADD(MONTH, DATEDIFF(MONTH, 0, [plan_end_dt]), 0)
   ,DATENAME(MONTH, [plan_end_dt])
   ,YEAR([plan_end_dt])
   ,[branch_name]
ORDER BY
    [cancel_month]
   ,[branch_name];
*/
