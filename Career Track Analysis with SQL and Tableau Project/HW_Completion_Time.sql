SELECT 
	datediff(date_completed,date_enrolled) AS HW_completion_time
FROM sql_and_tableau.career_track_student_enrollments
WHERE date_completed IS NOT NULL
ORDER BY datediff(date_enrolled, date_completed) ASC;