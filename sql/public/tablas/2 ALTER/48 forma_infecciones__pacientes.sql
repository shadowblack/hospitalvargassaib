ALTER TABLE forma_infecciones__pacientes DROP CONSTRAINT forma_infecciones__pacientes_id_his_fkey;
ALTER TABLE forma_infecciones__pacientes DROP COLUMN id_his;


ALTER TABLE forma_infecciones__pacientes 
	ADD COLUMN id_tip_mic_pac INTEGER REFERENCES tipos_micosis_pacientes(id_tip_mic_pac) MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE;
	


