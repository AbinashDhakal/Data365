SELECT 
    CONCAT(MONTH(action_date), '-', YEAR(action_date)) AS month_year,  -- Format month-year
    COUNT(*) AS successful_purchase_count                              -- Count of successful purchases per month
FROM 
    365_checkout_database.checkout_actions                                                       -- Replace with your actual table name
WHERE 
    action_name LIKE '%checkout%'                 -- Filters for successful checkout actions
GROUP BY 
	CONCAT(MONTH(action_date), '-', YEAR(action_date))
ORDER BY 
    successful_purchase_count DESC                                     -- Orders by the highest count of successful purchases
