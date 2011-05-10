ALTER TABLE transacciones_usuarios
	DROP CONSTRAINT transacciones_usuarios_id_mod_usu_fkey,
	DROP COLUMN id_mod_usu;
ALTER TABLE transacciones_usuarios
	ADD COLUMN id_tip_usu_usu INTEGER REFERENCES tipos_usuarios__usuarios(id_tip_usu_usu) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE transacciones_usuarios
	DROP COLUMN id_tip_tra_usu;

ALTER TABLE transacciones_usuarios
	DROP CONSTRAINT transacciones_usuarios_pkey,
	ADD CONSTRAINT transacciones_usuarios_id_tip_tra_fkey FOREIGN KEY(id_tip_tra) REFERENCES transacciones(id_tip_tra) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE RESTRICT;
	

ALTER TABLE transacciones_usuarios
	ADD COLUMN id_tra_usu SERIAL PRIMARY KEY;
	
	

COMMENT ON COLUMN modulo_usuarios.id_tip_usu_usu IS 'Relación con los tipos_usuarios__usuarios para para la transacciones de los usuarios';