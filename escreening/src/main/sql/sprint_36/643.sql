/* Author: Robin Carnow for ticket 643 */

-- used to store json structure of rules send to server from UI
ALTER TABLE rule ADD COLUMN condition_json mediumtext;

-- add unique constraint to event table
ALTER TABLE event ADD CONSTRAINT ux_event_type_ref_obj UNIQUE (event_type_id, related_object_id);

-- fix blank or null measure.variable_name field entries
UPDATE measure m
join 
	(select m2.measure_id, ma.export_name 
	from measure m2
	join measure_answer ma on m2.measure_id=ma.measure_id
	where NULLIF(m2.variable_name, '') is NULL
	group by m2.measure_id
	) to_fix
ON to_fix.measure_id=m.measure_id
SET m.variable_name=to_fix.export_name;  

-- update rules which contain measure AVs so they also list each measure's answer AVs as well
INSERT INTO rule_assessment_variable (rule_id, assessment_variable_id)
    select r.rule_id, answer_av.assessment_variable_id
    from rule r
    join rule_assessment_variable rav on r.rule_id=rav.rule_id
    join assessment_variable measure_av on rav.assessment_variable_id=measure_av.assessment_variable_id
	join measure m on measure_av.measure_id=m.measure_id
	join measure_answer ma on m.measure_id=ma.measure_id
	join assessment_variable answer_av on ma.measure_answer_id=answer_av.measure_answer_id
    left join rule_assessment_variable answer_rav on 
		r.rule_id=answer_rav.rule_id AND answer_av.assessment_variable_id=answer_rav.assessment_variable_id
    WHERE 
		measure_av.assessment_variable_type_id=1 AND answer_rav.rule_assessment_variable_id is NULL;

-- update current question event names so they are set to the correct values
UPDATE `event` e 
JOIN measure m ON m.measure_id=e.related_object_id AND e.event_type_id = 4
SET e.name=SUBSTRING(
			IFNULL(NULLIF(m.variable_name, ''), 
    			IFNULL(NULLIF(m.measure_text, ''), 
		   			CONCAT('question_', CAST(m.measure_id AS CHAR)))),
			1, 50);

-- Update templates which contain measure AVs so they also list each measure's answer AVs as well
INSERT INTO variable_template (template_id, assessment_variable_id)
    select t.template_id, answer_av.assessment_variable_id
    from template t
    join variable_template vt on t.template_id=vt.template_id
    join assessment_variable measure_av on vt.assessment_variable_id=measure_av.assessment_variable_id
	join measure m on measure_av.measure_id=m.measure_id
	join measure_answer ma on m.measure_id=ma.measure_id
	join assessment_variable answer_av on ma.measure_answer_id=answer_av.measure_answer_id
    left join variable_template answer_vt on 
		t.template_id=answer_vt.template_id AND answer_av.assessment_variable_id=answer_vt.assessment_variable_id
    WHERE 
		measure_av.assessment_variable_type_id=1 AND answer_vt.variable_template_id is NULL;
		
-- add event for every question (name is set with first value that is non-null in this order: the variable name, or measure text, or question_[measure_id])
INSERT INTO `event` (event_type_id, `name`, related_object_id)
SELECT 4, SUBSTRING(
			IFNULL(NULLIF(m.variable_name, ''), 
    			IFNULL(NULLIF(m.measure_text, ''), 
		   			CONCAT('question_', CAST(m.measure_id AS CHAR)))),
			1, 50), m.measure_id
FROM measure m 
LEFT JOIN `event` e ON m.measure_id=e.related_object_id AND e.event_type_id = 4
WHERE m.measure_type_id != 8 AND e.event_id IS NULL;

-- update current health factor events so their names are the same as the HF they represent
UPDATE `event` e 
JOIN health_factor hf ON e.related_object_id=hf.health_factor_id AND e.event_type_id = 2
SET e.name=SUBSTRING(
			IFNULL(NULLIF(hf.name, ''), CONCAT('health_factor_', CAST(hf.health_factor_id AS CHAR))),
			1, 50)
WHERE e.event_type_id = 2;

-- add event for every health factor
INSERT INTO `event` (event_type_id, `name`, related_object_id)
SELECT 2, SUBSTRING(
			IFNULL(NULLIF(hf.name, ''),
				 CONCAT('health_factor_', CAST(hf.health_factor_id AS CHAR))),
			1, 50), hf.health_factor_id
FROM health_factor hf 
LEFT JOIN `event` e ON hf.health_factor_id=e.related_object_id AND e.event_type_id = 2
WHERE e.event_id IS NULL;

-- add event for every dashboard alert
INSERT INTO `event` (event_type_id, `name`, related_object_id)
SELECT 3, SUBSTRING(
			IFNULL(NULLIF(a.name, ''),
				 CONCAT('alert_', CAST(a.dashboard_alert_id AS CHAR))), 
			1, 50), a.dashboard_alert_id
FROM dashboard_alert a
LEFT JOIN `event` e ON a.dashboard_alert_id AND e.event_type_id = 3
WHERE e.event_id IS NULL;

-- remove duplicates and add unique constraint to assessment_var_children table
ALTER IGNORE TABLE assessment_var_children ADD CONSTRAINT ux_assessment_var_children_parent UNIQUE (variable_parent, variable_child);

-- Fix formulas so each one is associated with its children and if one of them is a formula, also its grand children, etc.
INSERT INTO assessment_var_children (variable_parent, variable_child)
select distinct parent_av.assessment_variable_id, grd_child_avc.variable_child
from assessment_variable parent_av
join assessment_var_children parent_avc on parent_av.assessment_variable_id=parent_avc.variable_parent
join assessment_variable child_av on parent_avc.variable_child=child_av.assessment_variable_id
join assessment_var_children grd_child_avc on child_av.assessment_variable_id=grd_child_avc.variable_parent
where
child_av.assessment_variable_type_id=4
and 0=(select count(*) 
	 from assessment_var_children avc_test
     where variable_parent=parent_av.assessment_variable_id
     and variable_child=grd_child_avc.variable_child);
     
INSERT INTO assessment_var_children (variable_parent, variable_child)
select distinct parent_av.assessment_variable_id, grd_child_avc.variable_child
from assessment_variable parent_av
join assessment_var_children parent_avc on parent_av.assessment_variable_id=parent_avc.variable_parent
join assessment_variable child_av on parent_avc.variable_child=child_av.assessment_variable_id
join assessment_var_children grd_child_avc on child_av.assessment_variable_id=grd_child_avc.variable_parent
where
child_av.assessment_variable_type_id=4
and 0=(select count(*) 
	 from assessment_var_children avc_test
     where variable_parent=parent_av.assessment_variable_id
     and variable_child=grd_child_avc.variable_child);

-- we removed the "f" from all numerical variables so we have to update this formula to keep it using 
UPDATE assessment_variable SET formula_template='( [140] * 12.0 ) + [141]' WHERE assessment_variable_id='10';