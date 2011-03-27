-- Function: canales.can_insertar_empresa(character varying[])

-- DROP FUNCTION canales.can_insertar_empresa(character varying[]);

DROP FUNCTION IF EXISTS validar_usuarios(_log_usu TEXT,_pas_usu TEXT,_tip_usu TEXT);
CREATE OR REPLACE FUNCTION validar_usuarios(_log_usu TEXT,_pas_usu TEXT,_tip_usu TEXT)
  RETURNS SETOF t_validar_usuarios AS
$BODY$

DECLARE
	--datos ALIAS FOR $1;
			
	_id_udu_adm		usuarios_administrativos.id_usu_adm%TYPE;
	_nom_usu_adm		usuarios_administrativos.nom_usu_adm%TYPE;
	_ape_usu_adm		usuarios_administrativos.ape_usu_adm%TYPE;
	_pas_usu_adm		usuarios_administrativos.pas_usu_adm%TYPE;
	_log_usu_adm		usuarios_administrativos.log_usu_adm%TYPE;
	_tel_usu_adm		usuarios_administrativos.tel_usu_adm%TYPE;
	_id_tip_usu		usuarios_administrativos.id_tip_usu%TYPE;
	_cod_tip_usu		Tipos_usuarios.cod_tip_usu%TYPE;
	_t_val_usu		t_validar_usuarios%ROWTYPE;
	_vr_usu_adm		RECORD;
BEGIN


	CASE _tip_usu

		WHEN 'adm' THEN

			IF EXISTS( SELECT 1 FROM usuarios_administrativos WHERE log_usu_adm = _log_usu) THEN
				
				SELECT ua.id_usu_adm,ua.nom_usu_adm,ua.ape_usu_adm,ua.log_usu_adm,ua.id_tip_usu,ua  INTO _vr_usu_adm FROM 
				usuarios_administrativos ua
				LEFT JOIN tipos_usuarios tu ON (ua.id_tip_usu = tu.id_tip_usu)

				WHERE lod_usu_adm = _log_usu LIMIT 1;
				
			END IF;
			--RETURN 1;
		WHEN 'doc' THEN		
		
	END CASE;
	
	--RETURN 0;
	
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE
  COST 100;
ALTER FUNCTION validar_usuarios(_log_usu TEXT,_pas_usu TEXT,_tip_usu TEXT) OWNER TO postgres;
COMMENT ON FUNCTION validar_usuarios(_log_usu TEXT,_pas_usu TEXT,_tip_usu TEXT) IS '
NOMBRE: validar_usuarios
TIPO: Function (store procedure)
PARAMETROS: 
	1:  Nombre de la empresa 
	2:  Login de la empresa
	3:  Password de seguridad

';

-- 
	SELECT validar_usuarios('A','B','adm');