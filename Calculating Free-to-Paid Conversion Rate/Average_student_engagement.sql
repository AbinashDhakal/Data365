WITH student_engagement_summary AS (
    SELECT 
        se.student_id,
        s.date_registered,
        MIN(se.date_watched) AS first_date_watched,
        MIN(sp.date_purchased) AS first_date_purchased,
        MIN(s.date_registered) AS first_date_registered,
        DATEDIFF(  MIN(se.date_watched),MIN(s.date_registered) ) AS date_diff_reg_watch
    FROM 
        db_course_conversions.student_engagement se
    LEFT JOIN 
        db_course_conversions.student_purchases sp ON se.student_id = sp.student_id
    JOIN 
        db_course_conversions.student_info s ON se.student_id = s.student_id
    GROUP BY 
        se.student_id, s.date_registered
)



SELECT 
	AVG(date_diff_reg_watch)
FROM 
    student_engagement_summary
WHERE 
first_date_purchased IS NOT NULL
