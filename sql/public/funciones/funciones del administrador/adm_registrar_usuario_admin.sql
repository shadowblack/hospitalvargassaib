-- Function: adm_registrar_usuario_admin(character varying[])

-- DROP FUNCTION adm_registrar_usuario_admin(character varying[]);

CREATE OR REPLACE FUNCTION adm_registrar_usuario_admin(character varying[])
  RETURNS smallint AS
$BODY$
DECLARE
	datos ALIAS 	FOR $1;
	
	_nom_usu_adm 	usuarios_administrativos.nom_usu_adm%TYPE;
	_ape_usu_adm 	usuarios_administrativos.ape_usu_adm%TYPE;
	_pas_usu_adm	usuarios_administrativos.pas_usu_adm%TYPE;
	_log_usu_adm 	usuarios_administrativos.log_usu_adm%TYPE;
	_tel_usu_adm 	usuarios_administrativos.tel_usu_adm%TYPE;
	_ced_usu_adm 	usuarios_administrativos.ced_usu_adm%TYPE;
	_cor_usu_adm 	usuarios_administrativos.cor_usu_adm%TYPE;

	_des_tip_tra 	VARCHAR:='';	
	
	_trans_adm	TEXT; 	-- transacciones a las cuales tiene permiso el usuario administrador, o mejor dicho niveles de acceso
	_arr_trans_adm	INTEGER[]; -- transacciones a las cuales tiene permiso el usuario administrador, o mejor dicho niveles de acceso

	_valorcampos 	VARCHAR := '';
	_id_usu_adm 	usuarios_administrativos.id_usu_adm%TYPE;
	_tra_usu	transacciones.cod_tip_tra%TYPE;

	
	_info		RECORD;
	_reg_usu	RECORD;
	_reg_tra	RECORD;
BEGIN

	_nom_usu_adm 	:= datos[1];
	_ape_usu_adm 	:= datos[2];
	_pas_usu_adm	:= datos[3];	
	_log_usu_adm 	:= datos[4];
	_tel_usu_adm 	:= datos[5];
	_ced_usu_adm 	:= datos[6];
	_cor_usu_adm 	:= datos[7];
	_trans_adm	:= datos[8];
	_id_usu_adm	:= datos[9];
	_tra_usu	:= datos[10];
	
	

	/* El usuario administrativo puede ser registrado */
	IF NOT EXISTS (SELECT 1 FROM usuarios_administrativos WHERE log_usu_adm = _log_usu_adm) THEN  
		/*Comprobando si existe usuario administrativo con la cedula insertado por parametros*/
		IF NOT EXISTS (SELECT 1 FROM usuarios_administrativos WHERE ced_usu_adm = _ced_usu_adm) THEN   
		
			/*Inserta registro en la tabla usuarios_administrativos*/
			INSERT INTO usuarios_administrativos
			(
				nom_usu_adm,
				ape_usu_adm,
				pas_usu_adm,
				log_usu_adm,
				tel_usu_adm,			
				fec_reg_usu_adm,
				ced_usu_adm,
				cor_usu_adm
			)
			VALUES 
			(
				_nom_usu_adm,
				_ape_usu_adm,
				_pas_usu_adm,
				_log_usu_adm,
				_tel_usu_adm,			
				NOW(),
				_ced_usu_adm,
				_cor_usu_adm
			);	


				_valorcampos := '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?><registro_usuario_administrador>
					 <tabla nombre="usuarios_administrativos">';
					_valorcampos := _valorcampos || 
					formato_campo_xml('Nombre',  		coalesce(_nom_usu_adm::text, 'ninguno'), 	'ninguno')||
					formato_campo_xml('Apellido', 		coalesce(_ape_usu_adm::text, 'ninguno'), 	'ninguno')||
					formato_campo_xml('Cédula', 		coalesce(_ced_usu_adm::text, 'ninguno'), 	'ninguno')||  
					formato_campo_xml('Teléfono', 		coalesce(_tel_usu_adm::text, 'ninguno'), 	'ninguno')|| 
					formato_campo_xml('Correo', 		coalesce(_cor_usu_adm::text, 'ninguno'), 	'ninguno')||
					formato_campo_xml('Login', 		coalesce(_log_usu_adm::text, 'ninguno'), 	'ninguno');  
				/*ªª Se cierra el tag de la tabla */
				_valorcampos := _valorcampos || '</tabla>';
			
			
			/*Insertando tipo de usuario como administrador*/
			INSERT INTO tipos_usuarios__usuarios(
				id_usu_adm,
				id_tip_usu
			)
			VALUES
			(
				(CURRVAL('usuarios_administrativos_id_usu_adm_seq')),
				(SELECT id_tip_usu FROM tipos_usuarios WHERE cod_tip_usu = 'adm')
			);
				

				/* Se identifica la tabla en el formato xml */
				_valorcampos := _valorcampos || '<tabla nombre="tipos_usuarios__usuarios">';
				/* Se completa el tag con el valor del campo */
					_valorcampos := _valorcampos || 
					formato_campo_xml('ID', 		coalesce(CURRVAL('usuarios_administrativos_id_usu_adm_seq')::text, 'ninguno'), 'ninguno')||
					formato_campo_xml('Tipo Usuario', 	coalesce('Administrador', 'ninguno'), 	'ninguno'); 
				_valorcampos := _valorcampos || '</tabla>';

			

			/* Insertando las transacciones del usuario*/
			_arr_trans_adm := STRING_TO_ARRAY(_trans_adm,',');
			IF (ARRAY_UPPER(_arr_trans_adm,1) > 0)THEN
				FOR i IN 1..(ARRAY_UPPER(_arr_trans_adm,1)) LOOP
					INSERT INTO transacciones_usuarios(
						id_tip_usu_usu,
						id_tip_tra
					)
					VALUES
					(
						(CURRVAL('tipos_usuarios__usuarios_id_tip_usu_usu_seq')),
						_arr_trans_adm[i]
					);

					SELECT des_tip_tra INTO _info 
					FROM transacciones_usuarios tu
						LEFT JOIN transacciones t ON tu.id_tip_tra = t.id_tip_tra
					WHERE tu.id_tip_tra = _arr_trans_adm[i];
					
					_des_tip_tra := _des_tip_tra || _info.des_tip_tra || ' ,';
				END LOOP;
			END IF;

			
			/* Se le quita la última de las comas a la variable */
			IF length(_des_tip_tra) > 0 THEN
				_des_tip_tra := substr(_des_tip_tra, 1, length(_des_tip_tra) - 1);
			END IF;	

				/* Se identifica la tabla en el formato xml */
				_valorcampos := _valorcampos || '<tabla nombre="transacciones_usuarios">';
				/* Se completa el tag con el valor del campo */
					_valorcampos := _valorcampos || 
					formato_campo_xml('Tipo de transaccion', coalesce(_des_tip_tra::text, 'ninguno'), 'ninguno');
				/* Se cierra el tag de la tabla */
				_valorcampos := _valorcampos || '</tabla>';
				
			_valorcampos := _valorcampos || '</registro_usuario_administrador>';	


			/*Obtengo el Id del tipo de usuario deacuerdo al usuario logueado*/
			SELECT id_tip_usu_usu INTO _reg_usu FROM tipos_usuarios__usuarios WHERE id_usu_adm = _id_usu_adm;

			/*Obtengo el Id del tipo de transaccion deacuerdo a la transaccion del usuario*/
			SELECT id_tip_tra INTO _reg_tra FROM transacciones WHERE cod_tip_tra = _tra_usu;
			
			INSERT INTO auditoria_transacciones
			(
				fec_aud_tra, 
				id_tip_usu_usu,
				id_tip_tra, 
				data_xml
			)
			VALUES 
			(
				 NOW(), 
				_reg_usu.id_tip_usu_usu, 
				_reg_tra.id_tip_tra, 
				_valorcampos::XML
			);

					
			-- La función se ejecutó exitosamente
			RETURN 1;
			
		ELSE
			-- Existe un usuario administrativo con la misma cédula
			RETURN 2;
		END IF;
		
	
	ELSE
		-- Existe un usuario administrativo con el mismo login
		RETURN 0;
	END IF;

END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION adm_registrar_usuario_admin(character varying[]) OWNER TO desarrollo_g;
COMMENT ON FUNCTION adm_registrar_usuario_admin(character varying[]) IS '
NOMBRE: adm_registrar_usuario_admin
TIPO: Function (store procedure)

PARAMETROS: Recibe 7 Parámetros
	1:  Nombre del usuario administrativo
	2:  Apellido del usuario administrativo
	3:  Password del usuario administrativo
	4:  Login del usuario administrativo
	5:  Teléfono del usuario administrativo
	6:  Cédula del usuario administrativo
	7:  Correo del usuario administrativo

DESCRIPCION: 
	Almacena la información del usuario administrativo 

RETORNO:
	1: La función se ejecutó exitosamente
	0: Existe un usuario administrativo con el mismo login
	2: Existe un usuario administrativo con la misma cédula
	 
EJEMPLO DE LLAMADA:
	SELECT adm_registrar_usuario_admin(ARRAY[ ''jesus'', ''alfredo'', ''d6c002bf04cd6019786e58df9d251e62'', ''jalfredo'', ''04123818120'', ''83214989'', ''jalfredo@gmail.com'', ''25,26,22,23'', ''22'', ''AUA'' ]) AS result

AUTOR DE CREACIÓN: Lisseth Lozada
FECHA DE CREACIÓN: 27/03/2011

AUTOR DE MODIFICACIÓN: Lisseth Lozada
FECHA DE MODIFICACIÓN: 02/02/2012

';
