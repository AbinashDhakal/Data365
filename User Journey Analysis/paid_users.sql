SELECT
    user_id,
    MIN(date_purchased) AS first_order_date,
    CASE
        WHEN purchase_type = 0 THEN 'Monthly'
        WHEN purchase_type = 1 THEN 'Quarterly'
        WHEN purchase_type = 2 THEN 'Annual'
        ELSE 'Other'
    END AS subscription_type,
    purchase_price AS price
FROM 
    user_journey_data.student_purchases
WHERE
    purchase_price > 0
    AND date_purchased >= '2023-01-01'
    AND date_purchased < '2023-03-01'
GROUP BY 
    user_id, purchase_type, purchase_price;
