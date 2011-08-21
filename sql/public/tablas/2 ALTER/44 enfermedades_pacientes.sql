ALTER TABLE enfermedades_pacientes
	ADD COLUMN id_tip_enf_pac INTEGER REFERENCES tipos_micosis_pacientes MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE enfermedades_pacientes
	RENAME COLUMN id_tip_enf_pac to id_tip_mic_pac;