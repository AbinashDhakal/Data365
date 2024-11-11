WITH paid_users AS (
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
		user_id, purchase_type, purchase_price
)





SELECT
	p.user_id,
	i.visitor_id,
	i.session_id,
	i.event_source_url, 
	i.event_destination_url,
	p.subscription_type
FROM
	paid_users AS p
INNER JOIN
	user_journey_data.front_visitors AS v ON v.user_id = p.user_id
INNER JOIN
	user_journey_data.front_interactions AS i ON i.visitor_id = v.visitor_id
WHERE
	i.event_date < p.first_order_date
