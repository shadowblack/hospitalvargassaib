ALTER TABLE usuarios_administrativos
	ADD COLUMN fec_reg_usu_adm CHARACTER VARYING(100);

COMMENT ON COLUMN usuarios_administrativos.fec_reg_usu_adm IS 'Fecha de registro de los usuarios'
