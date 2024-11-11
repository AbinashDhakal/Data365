
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
),
table_interactions AS( 

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
)




    SELECT 
        user_id,
        session_id,
        subscription_type,
        CASE
            WHEN event_source_url = 'https://365datascience.com/' THEN 'Homepage'
            WHEN event_source_url LIKE 'https://365datascience.com/login/%' THEN 'Log in'
            WHEN event_source_url LIKE 'https://365datascience.com/signup/%' THEN 'Sign up'
            WHEN event_source_url LIKE 'https://365datascience.com/resources-center/%' THEN 'Resources center'
            WHEN event_source_url LIKE 'https://365datascience.com/courses/%' THEN 'Courses'
            WHEN event_source_url LIKE 'https://365datascience.com/career-tracks/%' THEN 'Career tracks'
            WHEN event_source_url LIKE 'https://365datascience.com/upcoming-courses/%' THEN 'Upcoming courses'
            WHEN event_source_url LIKE 'https://365datascience.com/career-track-certificate/%' THEN 'Career track certificate'
            WHEN event_source_url LIKE 'https://365datascience.com/course-certificate/%' THEN 'Course certificate'
            WHEN event_source_url LIKE 'https://365datascience.com/success-stories/%' THEN 'Success stories'
            WHEN event_source_url LIKE 'https://365datascience.com/blog/%' THEN 'Blog'
            WHEN event_source_url LIKE 'https://365datascience.com/pricing/%' THEN 'Pricing'
            WHEN event_source_url LIKE 'https://365datascience.com/about-us/%' THEN 'About us'
            WHEN event_source_url LIKE 'https://365datascience.com/instructors/%' THEN 'Instructors'
            WHEN event_source_url LIKE 'https://365datascience.com/checkout/%' AND event_source_url LIKE '%coupon%' THEN 'Coupon'
            WHEN event_source_url LIKE 'https://365datascience.com/checkout/%' AND event_source_url NOT LIKE '%coupon%' THEN 'Checkout'
            ELSE 'Other'
        END AS source_page_alias,
        CASE
            WHEN event_destination_url = 'https://365datascience.com/' THEN 'Homepage'
            WHEN event_destination_url LIKE 'https://365datascience.com/login/%' THEN 'Log in'
            WHEN event_destination_url LIKE 'https://365datascience.com/signup/%' THEN 'Sign up'
            WHEN event_destination_url LIKE 'https://365datascience.com/resources-center/%' THEN 'Resources center'
            WHEN event_destination_url LIKE 'https://365datascience.com/courses/%' THEN 'Courses'
            WHEN event_destination_url LIKE 'https://365datascience.com/career-tracks/%' THEN 'Career tracks'
            WHEN event_destination_url LIKE 'https://365datascience.com/upcoming-courses/%' THEN 'Upcoming courses'
            WHEN event_destination_url LIKE 'https://365datascience.com/career-track-certificate/%' THEN 'Career track certificate'
            WHEN event_destination_url LIKE 'https://365datascience.com/course-certificate/%' THEN 'Course certificate'
            WHEN event_destination_url LIKE 'https://365datascience.com/success-stories/%' THEN 'Success stories'
            WHEN event_destination_url LIKE 'https://365datascience.com/blog/%' THEN 'Blog'
            WHEN event_destination_url LIKE 'https://365datascience.com/pricing/%' THEN 'Pricing'
            WHEN event_destination_url LIKE 'https://365datascience.com/about-us/%' THEN 'About us'
            WHEN event_destination_url LIKE 'https://365datascience.com/instructors/%' THEN 'Instructors'
            WHEN event_destination_url LIKE 'https://365datascience.com/checkout/%' AND event_destination_url LIKE '%coupon%' THEN 'Coupon'
            WHEN event_destination_url LIKE 'https://365datascience.com/checkout/%' AND event_destination_url NOT LIKE '%coupon%' THEN 'Checkout'
            ELSE 'Other'
        END AS destination_page_alias
    FROM
        table_interactions