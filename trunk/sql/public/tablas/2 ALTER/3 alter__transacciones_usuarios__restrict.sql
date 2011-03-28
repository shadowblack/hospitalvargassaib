ALTER TABLE transacciones_usuarios
	DROP CONSTRAINT transacciones_usuarios_id_tip_usu_usu_fkey,
	ADD CONSTRAINT transacciones_usuarios_id_tip_usu_usu_fkey FOREIGN KEY (id_tip_usu_usu)
	REFERENCES tipos_usuarios__usuarios (id_tip_usu_usu) MATCH SIMPLE
	ON UPDATE NO ACTION ON DELETE RESTRICT;