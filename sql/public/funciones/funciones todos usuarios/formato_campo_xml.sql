CREATE OR REPLACE FUNCTION formato_campo_xml(character varying, character varying, character varying)
  RETURNS text AS
$BODY$
DECLARE
	_nomcolumna 	ALIAS FOR $1;
	_valoract 	ALIAS FOR $2;
	_valorant 	ALIAS FOR $3;
	_campoxml 	VARCHAR;

BEGIN
	_campoxml := '<campo nombre=' || CHR(34) || _nomcolumna || CHR(34) || '><actual>' || _valoract || '</actual><anterior>' || _valorant || '</anterior></campo>';

	RETURN _campoxml;

END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
COMMENT ON FUNCTION formato_campo_xml(character varying, character varying, character varying) IS '
NOMBRE: formato_campo_xml
TIPO: Function (store procedure)

PARAMETROS: Recibe 3 Parámetros
	1:  Nombre del campo
	2:  Valor del campo actual
	3:  Valor del campo anterior
	
DESCRIPCION: 
	Arma el xml para las transacciones

RETORNO:
	Retorna una cadena xml
	 
EJEMPLO DE LLAMADA:
	SELECT formato_campo_xml(''nombre de la columna'', ''valor actual'', ''valor anterior'')

AUTOR DE CREACIÓN: Lisseth Lozada
FECHA DE CREACIÓN: 08/08/2011
';



