ALTER TABLE transacciones
	ADD CONSTRAINT transacciones_cod_tip_tra__id_mod UNIQUE(id_mod,cod_tip_tra);