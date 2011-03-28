ALTER TABLE modulos
	RENAME COLUMN nom_mod TO cod_mod;

ALTER TABLE modulos	
	ALTER COLUMN cod_mod TYPE CHARACTER VARYING(3) ,
	ADD CONSTRAINT modulos_cod_mod_unique UNIQUE(cod_mod);
	