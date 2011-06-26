ALTER TABLE historiales_pacientes
	DROP COLUMN nun_mic;

ALTER TABLE historiales_pacientes
	ADD COLUMN id_doc INTEGER REFERENCES doctores (id_doc) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT;


ALTER TABLE historiales_pacientes
	DROP COLUMN nom_med, 
	DROP COLUMN ape_med;
	
ALTER TABLE historiales_pacientes
	ADD COLUMN des_adi_pac_his CHARACTER VARYING(255);
	
COMMENT ON COLUMN historiales_pacientes.des_adi_pac_his is '
	Discripción adicional de si el paciente padece o no una enfermedad u otra cosa adicional.
';

ALTER TABLE historiales_pacientes
	ALTER COLUMN des_his TYPE CHARACTER VARYING(255);

ALTER TABLE historiales_pacientes
	ALTER COLUMN fec_his TYPE TIMESTAMP 