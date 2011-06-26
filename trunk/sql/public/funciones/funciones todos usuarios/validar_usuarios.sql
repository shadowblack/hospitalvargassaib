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
	_id_tip_usu		tipos_usuarios.id_tip_usu%TYPE;
	_cod_tip_usu		tipos_usuarios.cod_tip_usu%TYPE;
	_t_val_usu		t_validar_usuarios%ROWTYPE;
	_vr_usu		RECORD;
BEGIN


	CASE _tip_usu

		WHEN 'adm' THEN

			IF EXISTS( SELECT 1 FROM usuarios_administrativos WHERE log_usu_adm = _log_usu) THEN
				
				SELECT ua.id_usu_adm, ua.nom_usu_adm, ua.ape_usu_adm, ua.log_usu_adm, ua.tel_usu_adm, tu.id_tip_usu, tu.cod_tip_usu, tu.des_tip_usu, tuu.id_tip_usu_usu INTO _vr_usu  FROM 
				usuarios_administrativos ua
				LEFT JOIN tipos_usuarios__usuarios tuu ON (ua.id_usu_adm = tuu.id_usu_adm)
				LEFT JOIN tipos_usuarios tu ON (tuu.id_tip_usu = tu.id_tip_usu)
				WHERE ua.log_usu_adm = _log_usu
				AND ua.pas_usu_adm = md5(_pas_usu)
				AND tu.cod_tip_usu = _tip_usu;
				
				_t_val_usu.str_trans := ARRAY_TO_STRING (
					ARRAY	(
							SELECT t.cod_tip_tra 
							FROM transacciones_usuarios tu 
							LEFT JOIN transacciones t ON(tu.id_tip_tra = t.id_tip_tra)
							LEFT JOIN tipos_usuarios__usuarios ttu ON(ttu.id_tip_usu_usu = tu.id_tip_usu_usu)
							WHERE ttu.id_tip_usu_usu = _vr_usu.id_tip_usu_usu
					)
				,',');

				_t_val_usu.id_usu 		:=	_vr_usu.id_usu_adm;
				_t_val_usu.nom_usu		:=	_vr_usu.nom_usu_adm;
				_t_val_usu.ape_usu 		:=	_vr_usu.ape_usu_adm;
				_t_val_usu.pas_usu 		:=	'no colocado';
				_t_val_usu.log_usu 		:=	_vr_usu.log_usu_adm;
				_t_val_usu.tel_usu 		:=	_vr_usu.tel_usu_adm;
				_t_val_usu.id_tip_usu 		:=	_vr_usu.id_tip_usu;
				_t_val_usu.id_tip_usu_usu 	:=	_vr_usu.id_tip_usu_usu;				
				_t_val_usu.cod_tip_usu 		:=	_vr_usu.cod_tip_usu;				
				_t_val_usu.des_tip_usu 		:=	_vr_usu.des_tip_usu;
				
			END IF;
			
		WHEN 'med' THEN		
			IF EXISTS( SELECT 1 FROM doctores WHERE log_doc = _log_usu) THEN				
				SELECT d.id_doc, d.nom_doc, d.ape_doc, d.log_doc, d.tel_doc, tu.id_tip_usu, tu.cod_tip_usu, tu.des_tip_usu, tuu.id_tip_usu_usu INTO _vr_usu  FROM 
				doctores d
				LEFT JOIN tipos_usuarios__usuarios tuu ON (d.id_doc = tuu.id_doc)
				LEFT JOIN tipos_usuarios tu ON (tuu.id_tip_usu = tu.id_tip_usu)
				WHERE d.log_doc = _log_usu
				AND d.pas_doc = md5(_pas_usu)
				AND tu.cod_tip_usu = _tip_usu;
				
				_t_val_usu.str_trans := ARRAY_TO_STRING (
					ARRAY	(
							SELECT t.cod_tip_tra 
							FROM transacciones_usuarios tu 
							LEFT JOIN transacciones t ON(tu.id_tip_tra = t.id_tip_tra)
							LEFT JOIN tipos_usuarios__usuarios ttu ON(ttu.id_tip_usu_usu = tu.id_tip_usu_usu)
							WHERE ttu.id_tip_usu_usu = _vr_usu.id_tip_usu_usu
					)
				,',');

				_t_val_usu.id_usu 		:=	_vr_usu.id_doc;
				_t_val_usu.nom_usu		:=	_vr_usu.nom_doc;
				_t_val_usu.ape_usu 		:=	_vr_usu.ape_doc;
				_t_val_usu.pas_usu 		:=	'no colocado';
				_t_val_usu.log_usu 		:=	_vr_usu.log_doc;
				_t_val_usu.tel_usu 		:=	_vr_usu.tel_doc;
				_t_val_usu.id_tip_usu 		:=	_vr_usu.id_tip_usu;
				_t_val_usu.id_tip_usu_usu 	:=	_vr_usu.id_tip_usu_usu;				
				_t_val_usu.cod_tip_usu 		:=	_vr_usu.cod_tip_usu;				
				_t_val_usu.des_tip_usu 		:=	_vr_usu.des_tip_usu;
				
			END IF;
	END CASE;
	
	RETURN NEXT _t_val_usu;
	
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

EJEMPLO: SELECT str_mods FROM validar_usuarios(''hitokiri83'',''123'',''adm'');

';

-- 
	--SELECT * FROM validar_usuarios('lmarin','Ayanami909','med');