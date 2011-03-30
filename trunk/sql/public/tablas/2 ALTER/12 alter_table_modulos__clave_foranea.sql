ALTER TABLE modulos
	ADD COLUMN id_tip_usu INTEGER REFERENCES tipos_usuarios(id_tip_usu),	
	DROP CONSTRAINT modulos_cod_mod_unique,
	ADD CONSTRAINT modulos_cod_mod_unique UNIQUE(cod_mod,id_tip_usu);
	