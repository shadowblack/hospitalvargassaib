ALTER TABLE auditoria_transacciones
	ADD COLUMN data_xml xml;
COMMENT ON TABLE auditoria_transacciones IS 'Se guarda todos los eventos generados por los usuarios';
COMMENT ON COLUMN auditoria_transacciones.data_xml IS 'Se guarda las modificaciones de la tabla y atributos realizada por los usuarios, todo en forma de XML';