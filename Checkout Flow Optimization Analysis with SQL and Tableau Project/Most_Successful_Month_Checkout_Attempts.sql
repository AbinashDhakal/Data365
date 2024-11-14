SELECT 
    MONTH(action_date) AS month,
    YEAR(action_date) AS year,
    COUNT(*) AS checkout_attempts
FROM 365_checkout_database.checkout_actions
WHERE action_name LIKE '%completepayment%' -- Filter for checkout actions
GROUP BY YEAR(action_date), MONTH(action_date)
ORDER BY checkout_attempts DESC
