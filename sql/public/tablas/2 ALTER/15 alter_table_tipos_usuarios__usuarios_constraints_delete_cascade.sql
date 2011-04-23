ALTER TABLE tipos_usuarios__usuarios
	DROP CONSTRAINT tipos_usuarios__usuarios_id_usu_adm_fkey,
	ADD CONSTRAINT tipos_usuarios__usuarios_id_usu_adm_fkey FOREIGN KEY(id_usu_adm) REFERENCES usuarios_administrativos(id_usu_adm) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE CASCADE
;