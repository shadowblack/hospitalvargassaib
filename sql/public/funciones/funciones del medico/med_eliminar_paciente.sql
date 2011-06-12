CREATE OR REPLACE FUNCTION med_eliminar_paciente(character varying[])
  RETURNS smallint AS
$BODY$
DECLARE
	
	--Variables
	_data 	ALIAS FOR $1;
	_id_pac		pacientes.id_pac%TYPE;
	_id_doc		doctores.id_doc%TYPE;

BEGIN
	_id_pac := _data[1];
	_id_doc := _data[2];
	
	IF EXISTS(SELECT 1 FROM pacientes WHERE id_pac = _id_pac::INTEGER)THEN
		DELETE FROM pacientes WHERE id_pac = _id_pac::INTEGER;
		RETURN 1;
	ELSE
		RETURN 0;
	END IF;

	
END;$BODY$
  LANGUAGE 'plpgsql' VOLATILE;
COMMENT ON FUNCTION med_eliminar_paciente(character varying[]) IS '
NOMBRE: med_eliminar_paciente
TIPO: Function (store procedure)

PARAMETROS: Recibe 2 Parámetros
	1:  Id del paciente a eliminar
	2:  Id del doctor que se encuentra actualmente logueado	

DESCRIPCION: 
	Elimina la información del usuario administrativo 

RETORNO:
	1: La función se ejecutó exitosamente
	0: No existe el paciente a eliminar

EJEMPLO DE LLAMADA:
	SELECT adm_eliminar_usuario_admin(ARRAY[''1'',''2'']);


AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 22/04/2011 
 
DESCRIPCIÓN: Eliminacion de los pacientes
';
