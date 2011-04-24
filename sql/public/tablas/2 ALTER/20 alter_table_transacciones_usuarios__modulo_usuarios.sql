ALTER TABLE transacciones_usuarios
	DROP CONSTRAINT transacciones_usuarios_id_tip_usu_usu_fkey,
	DROP COLUMN id_tip_usu_usu,
	ADD COLUMN id_mod_usu INTEGER REFERENCES modulo_usuarios(id_mod_usu) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE transacciones_usuarios
	DROP CONSTRAINT transacciones_usuarios_id_tip_tra_fkey;
	
