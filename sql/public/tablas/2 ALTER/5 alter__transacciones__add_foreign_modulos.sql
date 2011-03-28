ALTER TABLE transacciones
	ADD COLUMN id_mod INTEGER REFERENCES modulos(id_mod);


	ALTER TABLE transacciones
	DROP CONSTRAINT transacciones_id_mod_fkey,
	ADD CONSTRAINT transacciones_id_mod_fkey FOREIGN KEY(id_mod)
	REFERENCES modulos(id_mod)
	MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE RESTRICT;
	