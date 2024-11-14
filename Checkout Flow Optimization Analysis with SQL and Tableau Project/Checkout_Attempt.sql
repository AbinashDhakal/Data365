SELECT 
    CONCAT(MONTH(action_date), '-', YEAR(action_date)) AS month_year, -- Format month-year for readability
    COUNT(*) AS checkout_attempts                                    -- Count of checkout attempts per month
FROM 
    365_checkout_database.checkout_actions                                                     -- Replace 'user_actions' with your table name
WHERE 
    action_name LIKE 'checkout_annual_completepayment.click%'        -- Filters for checkout actions
GROUP BY 
	CONCAT(MONTH(action_date), '-', YEAR(action_date))
ORDER BY 
    checkout_attempts DESC                                           -- Orders to find the month with the highest attempts
