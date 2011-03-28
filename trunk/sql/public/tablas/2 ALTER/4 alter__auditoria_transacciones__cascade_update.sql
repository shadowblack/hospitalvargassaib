ALTER TABLE auditoria_transacciones
	DROP CONSTRAINT auditoria_transacciones_id_mod_fkey,
	DROP CONSTRAINT auditoria_transacciones_id_tip_tra_fkey,
	DROP CONSTRAINT auditoria_transacciones_id_tip_usu_usu_fkey,
	
	ADD CONSTRAINT auditoria_transacciones_id_mod_fkey FOREIGN KEY (id_mod)
	REFERENCES modulos (id_mod) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE NO ACTION,
	
	ADD CONSTRAINT auditoria_transacciones_id_tip_tra_fkey FOREIGN KEY (id_tip_tra)
	REFERENCES transacciones (id_tip_tra) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE NO ACTION,
	
	ADD CONSTRAINT auditoria_transacciones_id_tip_usu_usu_fkey FOREIGN KEY (id_tip_usu_usu)
	REFERENCES tipos_usuarios__usuarios (id_tip_usu_usu) MATCH SIMPLE
	ON UPDATE CASCADE ON DELETE NO ACTION