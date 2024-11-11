SELECT 
	se.student_id,
    ct.track_name,
	datediff(date_completed,date_enrolled) AS HW_completion_time
FROM sql_and_tableau.career_track_student_enrollments se
INNER JOIN
	sql_and_tableau.career_track_info ct
ON se.track_id = ct.track_id
 
WHERE date_completed IS NOT NULL
ORDER BY datediff(date_enrolled, date_completed) ASC;