-- crear clave primaria para los codigos de usuarios
ALTER TABLE tipos_usuarios
	ADD CONSTRAINT tipos_usuarios_unique UNIQUE(cod_tip_usu);