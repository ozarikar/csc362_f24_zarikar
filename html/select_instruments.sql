SELECT instrument_id, instrument_type, student_name
FROM instruments
LEFT JOIN students ON instruments.student_id = students.student_id;
