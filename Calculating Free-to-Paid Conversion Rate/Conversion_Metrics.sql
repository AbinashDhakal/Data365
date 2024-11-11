WITH student_engagement_summary AS (
    SELECT 
        se.student_id,
        s.date_registered,
        MIN(se.date_watched) AS first_date_watched,
        MIN(sp.date_purchased) AS first_date_purchased,
        DATEDIFF(s.date_registered, MIN(se.date_watched)) AS date_diff_reg_watch,
        CASE 
            WHEN MIN(sp.date_purchased) IS NOT NULL THEN DATEDIFF(MIN(se.date_watched), MIN(sp.date_purchased))
            ELSE NULL 
        END AS date_diff_watch_purch
    FROM 
        db_course_conversions.student_engagement se
    LEFT JOIN 
        db_course_conversions.student_purchases sp ON se.student_id = sp.student_id
    JOIN 
        db_course_conversions.student_info s ON se.student_id = s.student_id
    GROUP BY 
        se.student_id, s.date_registered
),

conversion_metrics AS (
    SELECT
        COUNT(DISTINCT student_id) AS total_engaged_students,
        COUNT(DISTINCT CASE 
            WHEN first_date_purchased IS NOT NULL AND first_date_purchased >= first_date_watched THEN student_id
        END) AS total_converted_students
    FROM 
        student_engagement_summary
)

SELECT 
    total_converted_students,
    total_engaged_students,
    (CAST(total_converted_students AS FLOAT) / total_engaged_students) * 100 AS conversion_rate
FROM 
    conversion_metrics;
