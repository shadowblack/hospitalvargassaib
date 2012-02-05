-- Function: med_cambiar_contrasena_ope(character varying[])

-- DROP FUNCTION med_cambiar_contrasena_ope(character varying[]);

CREATE OR REPLACE FUNCTION med_cambiar_contrasena_ope(character varying[])
  RETURNS smallint AS
$BODY$
DECLARE
	datos ALIAS 	FOR $1;
	_id_doc		doctores.id_doc%TYPE;
	_pas_old 	doctores.pas_doc%TYPE;
	_pas_new	doctores.pas_doc%TYPE;
	
	
BEGIN

	_id_doc		:= datos[1];
	_pas_old 	:= datos[2];
	_pas_new	:= datos[3];
	
	
	IF EXISTS(SELECT 1 FROM doctores WHERE pas_doc = _pas_old AND id_doc = _id_doc)THEN
							
		UPDATE doctores SET 
			
			pas_doc = _pas_new				
		
		WHERE id_doc = _id_doc;

		RETURN 1;
	ELSE
		RETURN 0;-- No existe la contraseña anterior 
	END IF;

END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION med_cambiar_contrasena_ope(character varying[]) OWNER TO desarrollo_g;
COMMENT ON FUNCTION med_cambiar_contrasena_ope(character varying[]) IS '
NOMBRE: med_cambiar_contrasena_ope
TIPO: Function (store procedure)

PARAMETROS: Recibe 3 Parámetros
	1:  Id del usuario operador loqueado
	2:  Contraseña anterior
	3:  Contraseña nueva
	
DESCRIPCION: 
	Realiza el cambio de contraseña

RETORNO:

	0: No existe la contraseña anterior 
	1: La función se ejecutó exitosamente
	
	 
EJEMPLO DE LLAMADA:


SELECT med_cambiar_contrasena_ope(ARRAY[
                        ''22'',
                        ''8b0c4b40a5e71589bc1ea49327f48522'',
                        ''d6c002bf04cd6019786e58df9d251e62''
                    ]) AS result
                    
AUTOR DE CREACIÓN: Lisseth Lozada
FECHA DE CREACIÓN: 04/02/2012
';