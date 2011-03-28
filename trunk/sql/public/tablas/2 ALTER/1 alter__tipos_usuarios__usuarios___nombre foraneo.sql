ALTER TABLE tipos_usuarios__usuarios
	RENAME COLUMN it_usu_adm TO id_usu_adm;

ALTER TABLE tipos_usuarios__usuarios
	DROP CONSTRAINT tipos_usuarios__usuarios_id_doc_fkey,
	DROP CONSTRAINT tipos_usuarios__usuarios_id_tip_adm_fkey,
	DROP CONSTRAINT tipos_usuarios__usuarios_id_tip_usu_fkey,

	ADD CONSTRAINT tipos_usuarios__usuarios_id_doc_fkey 
	FOREIGN KEY(id_doc) REFERENCES doctores(id_doc) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE RESTRICT,
	
	ADD CONSTRAINT tipos_usuarios__usuarios_id_usu_adm_fkey 
	FOREIGN KEY(id_usu_adm) REFERENCES usuarios_administrativos(id_usu_adm) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE RESTRICT,
	
	ADD CONSTRAINT tipos_usuarios__usuarios_id_tip_usu_fkey 
	FOREIGN KEY(id_tip_usu) REFERENCES tipos_usuarios(id_tip_usu) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE RESTRICT;
	