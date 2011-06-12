ALTER TABLE pacientes
	ADD COLUMN num_pac INTEGER;

ALTER TABLE pacientes
	ADD COLUMN id_doc INTEGER REFERENCES doctores(id_doc) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE pacientes
	ALTER COLUMN tel_hab_pac TYPE CHARACTER VARYING(12);

ALTER TABLE pacientes
	ALTER COLUMN tel_cel_pac TYPE CHARACTER VARYING(12);

ALTER TABLE pacientes
	ADD COLUMN fec_reg_pac timestamp WITH TIME ZONE DEFAULT NOW();
COMMENT ON COLUMN pacientes.fec_reg_pac IS 'Fecha de registro del paciente';