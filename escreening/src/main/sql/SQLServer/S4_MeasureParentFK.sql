ALTER TABLE measure ADD CONSTRAINT fk_measure_parent FOREIGN KEY (parent_measure_id) REFERENCES measure(measure_id)
 ON DELETE NO ACTION
 ON UPDATE NO ACTION
GO