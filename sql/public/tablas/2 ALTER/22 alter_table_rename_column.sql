ALTER TABLE doctores
	RENAME log_dog  TO doc;

ALTER TABLE doctores
	ADD COLUMN fec_reg_doc TIMESTAMP;

ALTER TABLE doctores
	RENAME tef_doc TO tel_doc;

ALTER TABLE doctores
	ADD COLUMN log_doc CHARACTER VARYING(100);
	
COMMENT ON COLUMN doctores.id_doc IS 'identificador único para los doctores';
COMMENT ON COLUMN doctores.nom_doc IS 'Nombre del doctor';
COMMENT ON COLUMN doctores.ape_doc IS 'Apellido del doctor';
COMMENT ON COLUMN doctores.ced_doc IS 'Cédula del doctor';
COMMENT ON COLUMN doctores.doc IS 'Documento del doctor';
COMMENT ON COLUMN doctores.pas_doc IS 'Contraseña del doctor';
COMMENT ON COLUMN doctores.tel_doc IS 'Teléfono del doctor';
COMMENT ON COLUMN doctores.cor_doc IS 'Correo electronico del doctor';
COMMENT ON COLUMN doctores.fec_reg_doc IS 'Fecha de registro del doctor';
COMMENT ON COLUMN doctores.log_doc IS 'Login con el que se loguara el doctor';
COMMENT ON TABLE doctores IS 'Registro de todos los doctores que del aplicativo';