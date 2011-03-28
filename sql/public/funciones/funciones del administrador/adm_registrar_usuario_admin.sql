CREATE OR REPLACE FUNCTION adm_registrar_usuario_admin(character varying[])
  RETURNS smallint AS
$BODY$
DECLARE
	datos ALIAS 	FOR $1;

	_nom_usu_adm 	usuarios_administrativos.nom_usu_adm%TYPE;
	_ape_usu_adm 	usuarios_administrativos.ape_usu_adm%TYPE;
	_pas_usu_adm	usuarios_administrativos.pas_usu_adm%TYPE;
	_rep_pas_usu	usuarios_administrativos.pas_usu_adm%TYPE;
	_log_usu_adm 	usuarios_administrativos.log_usu_adm%TYPE;
	_tel_usu_adm 	usuarios_administrativos.tel_usu_adm%TYPE;

	_id_tip_usu 	tipos_usuarios.id_tip_usu%TYPE;
	
BEGIN

	_nom_usu_adm 	:= datos[1];
	_ape_usu_adm 	:= datos[2];
	_pas_usu_adm	:= datos[3];
	_rep_pas_usu	:= datos[4];
	_log_usu_adm 	:= datos[5];
	_tel_usu_adm 	:= datos[6];
	_id_tip_usu 	:= datos[7];
	
	

	/* El usuario administrativo puede ser registrado */
	IF NOT EXISTS (SELECT 1 FROM usuarios_administrativos WHERE log_usu_adm = _log_usu_adm) THEN     

		IF(_pas_usu_adm = _rep_pas_usu) THEN
		
			/*Inserta registro en la tabla usuarios_administrativos*/
			INSERT INTO usuarios_administrativos
			(
				nom_usu_adm,
				ape_usu_adm,
				pas_usu_adm,
				log_usu_adm,
				tel_usu_adm,
				id_tip_usu,
				fec_reg_usu_adm
			)
			VALUES 
			(
				_nom_usu_adm,
				_ape_usu_adm,
				_pas_usu_adm,
				_log_usu_adm,
				_tel_usu_adm,
				_id_tip_usu,
				NOW()
			);

			-- La función se ejecutó exitosamente
			RETURN 0;
		ELSE
			-- Las contraseñas son diferentes
			RETURN 1;

		END IF;
	
	ELSE
		-- Existe un usuario administrativo con el mismo login
		RETURN 2;
	END IF;

END;$BODY$
  LANGUAGE 'plpgsql' VOLATILE;
COMMENT ON FUNCTION adm_registrar_usuario_admin(character varying[]) IS '
NOMBRE: adm_registrar_usuario_admin
TIPO: Function (store procedure)

PARAMETROS: Recibe 7 Parámetros
	1:  Nombre del usuario administrativo
	2:  Apellido del usuario administrativo
	3:  Password del usuario administrativo
	4:  Repetición del Password del usuario administrativo
	5:  Login del usuario administrativo
	6:  Teléfono del usuario administrativo
	7:  Tipo de usuario

DESCRIPCION: 
	Almacena la información del usuario administrativo 

RETORNO:
	0: La función se ejecutó exitosamente
	1: Las contraseñas son diferentes
	2: Existe un usuario administrativo con el mismo login
	 
EJEMPLO DE LLAMADA:
	SELECT adm_registrar_usuario_admin(ARRAY[''Lisseth'', ''Lozada'', ''123'', ''123'', ''llozada'',''04269150722'', ''1'']);

AUTOR DE CREACIÓN: Lisseth Lozada
FECHA DE CREACIÓN: 27/03/2011

';

