CREATE TRIGGER [dbo].[tr_survey_measure_response_modified]
ON [dbo].[survey_measure_response]
AFTER UPDATE
AS
BEGIN

  UPDATE survey_measure_response
  SET date_modified = getdate()
  FROM survey_measure_response s INNER JOIN inserted i
   ON s.survey_measure_response_id = i.survey_measure_response_id

END
GO