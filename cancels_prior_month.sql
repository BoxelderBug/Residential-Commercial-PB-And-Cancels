-- ============================================================
-- Cancels — Prior Calendar Month
-- Returns all cancel records from the month immediately before
-- the current month, regardless of when this query is run.
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
    -- Prior month window (inclusive start, exclusive end)
    [plan_dt] >= DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) - 1, 0)
    AND [plan_dt]  < DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()),     0)

    -- Uncomment and adjust if vr_210 is not already scoped to cancels:
    -- AND [service_code] = 'CANCEL'
    -- AND [service_description] LIKE '%cancel%'

ORDER BY
    [branch_name]
   ,[plan_dt]
   ,[technician_name];
