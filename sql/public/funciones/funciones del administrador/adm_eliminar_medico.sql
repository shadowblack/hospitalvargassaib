CREATE OR REPLACE FUNCTION adm_eliminar_medico(character varying[])
  RETURNS smallint AS
$BODY$
DECLARE
	datos ALIAS 	FOR $1;
	_id_doc		doctores.id_doc%TYPE;
	_nom_doc 	doctores.nom_doc%TYPE;	
BEGIN

	_id_doc		:= datos[1];
			
	IF EXISTS(SELECT 1 FROM doctores WHERE id_doc = _id_doc)THEN
		/* El usuario administrativo puede ser eliminado */
					
			/*Eliminando doctor*/	

			DELETE FROM doctores 
			WHERE 
			id_doc = _id_doc
			;
						

			-- La función se ejecutó exitosamente
			RETURN 1;
	ELSE
		RETURN 0;
	END IF;

END;$BODY$
  LANGUAGE 'plpgsql' VOLATILE;
COMMENT ON FUNCTION adm_eliminar_medico(character varying[]) IS '
NOMBRE: adm_eliminar_medico
TIPO: Function (store procedure)

PARAMETROS: Recibe 1 Parámetros
	1:  Id del usuario doctor
	
DESCRIPCION: 
	Almacena la información del doctor

RETORNO:
	1: La función se ejecutó exitosamente
	0: Existe un usuario administrativo con el mismo login
	 
EJEMPLO DE LLAMADA:
	SELECT adm_modificar_medico(ARRAY[''1'']);

AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 10/05/2011

';

--SELECT adm_modificar_medico(ARRAY['1','Lisseth', 'Lozada', '123', 'llozada3','04269150722','1']);
