ALTER TABLE antecedentes_pacientes
	DROP CONSTRAINT antecedentes_pacientes_id_his_fkey,
	DROP COLUMN id_his,
	ADD COLUMN id_pac INTEGER REFERENCES pacientes(id_pac) MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE antecedentes_pacientes
	DROP COLUMN otr_ant_per;