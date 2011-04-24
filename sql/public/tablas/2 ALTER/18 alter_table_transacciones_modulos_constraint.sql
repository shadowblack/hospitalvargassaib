ALTER TABLE modulos
	DROP CONSTRAINT modulos_id_tip_usu_fkey,
	ADD CONSTRAINT modulos_id_tip_usu_fkey FOREIGN KEY (id_tip_usu)
	REFERENCES tipos_usuarios (id_tip_usu) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE RESTRICT;