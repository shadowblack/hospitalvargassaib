ALTER TABLE transacciones_usuarios
	DROP CONSTRAINT transacciones_usuarios_id_tip_usu_usu_fkey,
	ADD CONSTRAINT transacciones_usuarios_id_tip_usu_usu_fkey FOREIGN KEY(id_tip_usu_usu) REFERENCES 
	tipos_usuarios__usuarios(id_tip_usu_usu) 
	MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE,

	DROP CONSTRAINT transacciones_usuarios_pkey,
	ADD CONSTRAINT transacciones_usuarios_pkey FOREIGN KEY(id_tip_tra) REFERENCES 
	transacciones(id_tip_tra) 
	MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT;
	