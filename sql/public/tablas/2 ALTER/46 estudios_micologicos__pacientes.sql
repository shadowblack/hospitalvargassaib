ALTER TABLE estudios_micologicos__pacientes
	DROP CONSTRAINT estudios_micologicos__pacientes_id_his_fkey,	
	ADD COLUMN id_tip_mic_pac INTEGER REFERENCES tipos_micosis_pacientes(id_tip_mic_pac) MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE;
