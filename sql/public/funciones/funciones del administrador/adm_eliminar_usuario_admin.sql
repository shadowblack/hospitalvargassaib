CREATE OR REPLACE FUNCTION adm_eliminar_usuario_admin(character varying)
  RETURNS smallint AS
$BODY$
DECLARE
	
	--Variables
	_ids_usu_eli 	ALIAS FOR $1;
	_consulta 	varchar := '';

	--Variable record
	_registro_usu	record;

BEGIN

	_consulta := 'SELECT * FROM usuarios_administrativos WHERE id_usu_adm IN (' || _ids_usu_eli || ')';


	/* Se obtienen los datos de cada uno de los usuario eliminados */
	FOR _registro_usu IN EXECUTE _consulta 
	LOOP
	       /* Se borran los registros asociados a los usuarios */
	       DELETE FROM usuarios_administrativos WHERE id_usu_adm = _registro_usu.id_usu_adm;

	END LOOP;
	RETURN 0;
END;$BODY$
  LANGUAGE 'plpgsql' VOLATILE;
COMMENT ON FUNCTION adm_eliminar_usuario_admin(character varying) IS '
NOMBRE: adm_eliminar_usuario_admin
TIPO: Function (store procedure)

PARAMETROS: Recibe 7 Parámetros
	1:  Identificador del usuario administrativo
	2:  Nombre del usuario administrativo
	3:  Apellido del usuario administrativo
	4:  Teléfono del usuario administrativo
	5:  Tipo de usuario

DESCRIPCION: 
	Elimina la información del usuario administrativo 

RETORNO:
	0: La función se ejecutó exitosamente
	
	 
EJEMPLO DE LLAMADA:
	SELECT adm_eliminar_usuario_admin(''1,2'');

AUTOR DE CREACIÓN: Lisseth Lozada
FECHA DE CREACIÓN: 27/03/2011      
';
