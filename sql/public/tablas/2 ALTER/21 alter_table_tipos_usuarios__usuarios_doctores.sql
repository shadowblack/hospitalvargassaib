ALTER TABLE tipos_usuarios__usuarios
	DROP CONSTRAINT tipos_usuarios__usuarios_id_doc_fkey,
	ADD CONSTRAINT tipos_usuarios__usuarios_id_doc_fkey FOREIGN KEY(id_doc) REFERENCES doctores(id_doc)
	MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE
	