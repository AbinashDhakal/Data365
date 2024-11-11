SELECT 
    se.student_id,
    se.date_watched,
    sp.date_purchased
FROM 
    db_course_conversions.student_engagement se
JOIN 
    db_course_conversions.student_purchases sp
ON 
    sp.student_id = se.student_id
WHERE 
    se.student_id = 268727;
