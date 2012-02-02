-- Function: adm_cambiar_contrasena_admin(character varying[])

-- DROP FUNCTION adm_cambiar_contrasena_admin(character varying[]);

CREATE OR REPLACE FUNCTION adm_cambiar_contrasena_admin(character varying[])
  RETURNS smallint AS
$BODY$
DECLARE
	datos ALIAS 	FOR $1;
	_id_usu_adm	usuarios_administrativos.id_usu_adm%TYPE;
	_pas_old 	usuarios_administrativos.pas_usu_adm%TYPE;
	_pas_new	usuarios_administrativos.pas_usu_adm%TYPE;
	
	
BEGIN

	_id_usu_adm	:= datos[1];
	_pas_old 	:= datos[2];
	_pas_new	:= datos[3];
	
	
	IF EXISTS(SELECT 1 FROM usuarios_administrativos WHERE pas_usu_adm = _pas_old AND id_usu_adm = _id_usu_adm)THEN
							
		UPDATE usuarios_administrativos SET 
			
			pas_usu_adm = _pas_new				
		
		WHERE id_usu_adm = _id_usu_adm;

		RETURN 1;
	ELSE
		RETURN 0;-- No existe la contraseña anterior 
	END IF;

END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION adm_cambiar_contrasena_admin(character varying[]) OWNER TO desarrollo_g;
COMMENT ON FUNCTION adm_cambiar_contrasena_admin(character varying[]) IS '
NOMBRE: adm_cambiar_contrasena_admin
TIPO: Function (store procedure)

PARAMETROS: Recibe 7 Parámetros
	1:  Id del usuario administrador loqueado
	2:  Contraseña anterior
	3:  Contraseña nueva
	
DESCRIPCION: 
	Realiza el cambio de contraseña

RETORNO:

	0: No existe la contraseña anterior 
	1: La función se ejecutó exitosamente
	
	 
EJEMPLO DE LLAMADA:


SELECT adm_cambiar_contrasena_admin(ARRAY[
                        ''22'',
                        ''8b0c4b40a5e71589bc1ea49327f48522'',
                        ''d6c002bf04cd6019786e58df9d251e62''
                    ]) AS result
                    
AUTOR DE CREACIÓN: Lisseth Lozada
FECHA DE CREACIÓN: 02/02/2012
';



SELECT adm_cambiar_contrasena_admin(ARRAY[
                        '22',
                        '8b0c4b40a5e71589bc1ea49327f48522',
                        'd6c002bf04cd6019786e58df9d251e62'
                    ]) AS result