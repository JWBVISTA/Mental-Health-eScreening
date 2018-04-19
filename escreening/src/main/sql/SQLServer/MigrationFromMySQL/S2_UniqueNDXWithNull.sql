CREATE UNIQUE NONCLUSTERED INDEX ux_assessment_variable_measure_id ON assessment_variable (measure_id) WHERE measure_id IS NOT NULL
GO

CREATE UNIQUE NONCLUSTERED INDEX ux_assessment_variable_measure_answer_id ON assessment_variable (measure_answer_id) WHERE measure_answer_id IS NOT NULL
GO

ALTER TABLE veteran ADD Hash AS (lower(last_name) + '%->' + ssn_last_four + '%->' + ISNULL(convert(varchar(10), birth_date, 20), '{[DATE]}') + '%->' + ISNULL(lower(middle_name), '{[MIDDLE]}'))
GO

CREATE INDEX key_veteran_assessment_id_measure_id ON survey_measure_response (veteran_assessment_id,measure_id) 
go
CREATE INDEX key_veteran_assessment_id_measure_answer_id ON survey_measure_response (veteran_assessment_id,measure_answer_id) 
go