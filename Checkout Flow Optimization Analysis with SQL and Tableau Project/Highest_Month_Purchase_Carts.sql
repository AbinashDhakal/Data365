-- Query to identify the month with the highest number of purchase carts
SELECT 
    MONTH(action_date) AS month,
    YEAR(action_date) AS year,
    COUNT(*) AS purchase_carts
FROM 365_checkout_database.checkout_carts
GROUP BY YEAR(action_date), MONTH(action_date)
ORDER BY purchase_carts DESC
