CREATE TRIGGER [dbo].[upd_question_presence] 
ON [dbo].[veteran_assessment]
FOR UPDATE
AS
BEGIN

insert into veteran_assessment_question_presence (veteran_assessment_id, measure_id, skipped)

SELECT veteran_assessment_id, all_measures.measure_id, isnull(answered_measures.measure_id, -1) response
FROM
(SELECT spm.survey_page_id, m.measure_id as measure_id, i.veteran_assessment_id
 FROM measure m LEFT OUTER JOIN veteran_assessment_measure_visibility vamv ON m.measure_id=vamv.measure_id 
 INNER JOIN inserted i on vamv.veteran_assessment_id = i.veteran_assessment_id
 INNER JOIN deleted d on
 i.veteran_assessment_id = d.veteran_assessment_id
 INNER JOIN survey_page_measure spm ON isnull(m.parent_measure_id, m.measure_id)=spm.measure_id
 INNER JOIN survey_page sp ON spm.survey_page_id=sp.survey_page_id
 INNER JOIN veteran_assessment_survey vas ON sp.survey_id=vas.survey_id
 WHERE m.measure_type_id IN (1,2,3,4,6,7)
 AND (i.date_completed is not null AND d.date_completed is null)
 AND vamv.is_visible = 1
 GROUP BY spm.survey_page_id, m.measure_id, i.veteran_assessment_id) all_measures
LEFT OUTER JOIN (SELECT DISTINCT m.measure_id
                 FROM survey_measure_response smr INNER JOIN measure m ON smr.measure_id=m.measure_id
                 INNER JOIN survey_page_measure spm on isnull(m.parent_measure_id, m.measure_id)=spm.measure_id
                 INNER JOIN survey s ON smr.survey_id=s.survey_id
                 WHERE m.measure_type_id IN (1,2,3,4,6,7)
                 AND ((m.measure_id=smr.measure_id AND (smr.boolean_value = 1 OR smr.number_value IS NOT NULL OR smr.text_value IS NOT NULL) )
                 OR (0 NOT IN (SELECT COUNT(*) 
                               FROM survey_measure_response smr2 INNER JOIN measure m ON smr2.measure_id=m.measure_id
                               WHERE m.parent_measure_id = spm.measure_id )
                 AND 0 NOT IN (SELECT isnull(sum(case when smr2.boolean_value = 1 OR smr2.number_value IS NOT NULL OR smr2.text_value IS NOT NULL then 1 else 0 END),0) answer_count
                               FROM survey_measure_response smr2
                               INNER JOIN survey s ON smr2.survey_id=s.survey_id
                               INNER JOIN measure m ON smr2.measure_id=m.measure_id
                               WHERE m.parent_measure_id = spm.measure_id
                               AND m.measure_type_id IN (  1,2,3,4,6,7 )
                               GROUP BY smr2.measure_id, smr2.tabular_row 
							   )))) answered_measures ON answered_measures.measure_id=all_measures.measure_id

END