ALTER TABLE modulo_usuarios
	DROP CONSTRAINT modulo_usuarios_id_mod_fkey,
	DROP CONSTRAINT modulo_usuarios_id_tip_usu_usu_fkey,

	ADD CONSTRAINT modulo_usuarios_id_mod_fkey FOREIGN KEY (id_mod)
	REFERENCES modulos (id_mod) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE RESTRICT,

	ADD CONSTRAINT modulo_usuarios_id_tip_usu_usu_fkey FOREIGN KEY (id_tip_usu_usu)
	REFERENCES tipos_usuarios__usuarios (id_tip_usu_usu) MATCH SIMPLE
	ON UPDATE NO ACTION ON DELETE RESTRICT

	
	