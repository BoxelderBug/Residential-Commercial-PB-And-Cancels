-- ============================================================
-- Cancels — Prior Calendar Month  (vr_230)
-- Returns plan records whose plan_end_dt (cancellation date)
-- falls within the calendar month immediately before today.
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
    -- Plan ended (cancelled) within the prior calendar month
    [plan_end_dt] >= DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()) - 1, 0)
    AND [plan_end_dt]  < DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE()),     0)

ORDER BY
    [branch_name]
   ,[plan_end_dt]
   ,[location_name];
