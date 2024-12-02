SELECT
    instruments.instrument_id,
    instruments.instrument_type, 
    students.student_name
FROM
    instruments
LEFT JOIN
    student_instruments ON instruments.instrument_id = student_instruments.instrument_id
LEFT JOIN
    students ON student_instruments.student_id = students.student_id;