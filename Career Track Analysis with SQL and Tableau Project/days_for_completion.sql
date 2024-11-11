SELECT 
    ROW_NUMBER() OVER (ORDER BY student_id, track_name DESC) AS student_track_id,
    e.student_id,
    i.track_name,
    e.date_enrolled,
    e.date_completed,
    IF(date_completed IS NULL, 0, 1) AS track_completed,
    DATEDIFF(e.date_completed, e.date_enrolled) AS days_for_completion
FROM
    career_track_student_enrollments e
        JOIN
    career_track_info i ON e.track_id = i.track_id