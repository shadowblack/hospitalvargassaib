ALTER TABLE usuarios_administrativos
	ADD COLUMN adm_usu BOOLEAN
;
COMMENT ON COLUMN usuarios_administrativos.adm_usu IS '
	TRUE: si es un super usuario
	FALSE: si es usuario com limitaciones
';