CREATE OR REPLACE FUNCTION adm_eliminar_medico(character varying[])
  RETURNS smallint AS
$BODY$
DECLARE
	datos ALIAS 	FOR $1;
	_id_doc		doctores.id_doc%TYPE;
	_nom_doc 	doctores.nom_doc%TYPE;	
BEGIN

	_id_doc		:= datos[1];

	-- Si existe un paciente que tenga una id del doctor retorna 2
	IF (EXISTS(SELECT 1 FROM pacientes JOIN doctores USING(id_doc) WHERE id_doc = _id_doc))THEN
		RETURN 2;
	END IF;
			
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
	/*EXCEPTION
	WHEN foreign_key_violation THEN
		IF (STRPOS(SQLERRM,))THEN
		--RAISE EXCEPTION '%','';
		 --RAISE LOG '%, via LOG','msg';
		--RAISE EXCEPTION  '%',SQLERRM;
	RETURN 2;*/
	
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
	1: La función se ejecutó exitosamente.
	0: Existe un usuario administrativo con el mismo login.
	2: No se puede eliminar este doctor porque tiene pacientes asociados.
	 
EJEMPLO DE LLAMADA:
	SELECT adm_modificar_medico(ARRAY[''1'']);

AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 10/05/2011

';

--SELECT adm_modificar_medico(ARRAY['1','Lisseth', 'Lozada', '123', 'llozada3','04269150722','1']);
