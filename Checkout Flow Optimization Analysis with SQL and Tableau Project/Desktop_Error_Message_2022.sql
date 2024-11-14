-- Query to identify the most frequent error message on desktop devices in September 2022
SELECT 
    error_message,
    COUNT(*) AS error_count
FROM 365_checkout_database.checkout_actions
WHERE device = 'desktop'  
    AND action_date BETWEEN '2022-09-01' AND '2022-09-30'
    AND action_name LIKE '%fail%'  
GROUP BY error_message
ORDER BY error_count DESC
