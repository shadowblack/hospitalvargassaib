ALTER TABLE usuarios_administrativos
	DROP COLUMN fec_reg_usu_adm;

ALTER TABLE usuarios_administrativos
	ADD COLUMN fec_reg_usu_adm TIMESTAMP;

COMMENT ON COLUMN usuarios_administrativos.fec_reg_usu_adm IS 'Fecha de registro de los usuarios'
