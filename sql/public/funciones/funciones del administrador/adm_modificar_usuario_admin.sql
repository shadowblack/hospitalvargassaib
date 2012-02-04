-- Function: adm_modificar_usuario_admin(character varying[])

-- DROP FUNCTION adm_modificar_usuario_admin(character varying[]);

CREATE OR REPLACE FUNCTION adm_modificar_usuario_admin(character varying[])
  RETURNS smallint AS
$BODY$
DECLARE
	datos ALIAS 	FOR $1;

	_id_usu_adm 	usuarios_administrativos.id_usu_adm%TYPE;
	_nom_usu_adm 	usuarios_administrativos.nom_usu_adm%TYPE;
	_ced_usu_adm 	usuarios_administrativos.ced_usu_adm%TYPE;
	_ape_usu_adm 	usuarios_administrativos.ape_usu_adm%TYPE;
	_tel_usu_adm 	usuarios_administrativos.tel_usu_adm%TYPE;
	_log_usu_adm 	usuarios_administrativos.log_usu_adm%TYPE;
	_cor_usu_adm	usuarios_administrativos.cor_usu_adm%TYPE;

	_des_tip_tra		VARCHAR := '';
	_des_tip_tra_ant	VARCHAR := '';

	_trans_adm	TEXT; 		-- transacciones a las cuales tiene permiso el administrador, o mejor dicho niveles de acceso
	_arr_trans_adm	INTEGER[]; 	-- transacciones a las cuales tiene permiso el administrador, o mejor dicho niveles de acceso
	_id_tip_usu_usu	INTEGER;


	_valorcampos 	VARCHAR := '';
	_id_usu_log 	usuarios_administrativos.id_usu_adm%TYPE;
	_tra_usu	transacciones.cod_tip_tra%TYPE;

	
	--Variable record
	_var_rec	RECORD;
	_reg_act	RECORD;
	_info		RECORD;
	_reg_usu	RECORD;
	_reg_tra	RECORD;

BEGIN
	_id_usu_adm	:= datos[1];
	_log_usu_adm	:= datos[2];
	_nom_usu_adm 	:= datos[3];
	_ape_usu_adm 	:= datos[4];
	_ced_usu_adm 	:= datos[5];
	_tel_usu_adm 	:= datos[6];
	_cor_usu_adm 	:= datos[7];
	_trans_adm	:= datos[8];
	_id_usu_log	:= datos[9];
	_tra_usu	:= datos[10];	

	/* Si se encuentra el usuario administrativo se modifica*/
	IF NOT EXISTS(SELECT 1 FROM usuarios_administrativos WHERE id_usu_adm <> _id_usu_adm AND log_usu_adm = _log_usu_adm)THEN

		/*Inserta registro en la tabla usuarios_administrativos*/	
		IF NOT EXISTS(SELECT 1 FROM usuarios_administrativos WHERE id_usu_adm <> _id_usu_adm AND ced_usu_adm = _ced_usu_adm)THEN

	
			SELECT INTO _var_rec * FROM usuarios_administrativos WHERE id_usu_adm = _id_usu_adm;
			IF FOUND THEN 

				/* Se modifica los datos del usuario administrativo */
				UPDATE usuarios_administrativos 
				SET 
					nom_usu_adm = _nom_usu_adm, 
					ape_usu_adm = _ape_usu_adm, 
					ced_usu_adm = _ced_usu_adm,
					tel_usu_adm = _tel_usu_adm,
					log_usu_adm = _log_usu_adm,
					cor_usu_adm = _cor_usu_adm
					
				WHERE id_usu_adm = _id_usu_adm;

				SELECT INTO _reg_act * FROM usuarios_administrativos WHERE id_usu_adm = _id_usu_adm;

				/* Se coloca el encabezado para los valores de los campos, así como el tag raíz y el inicio del tag tabla */
				_valorcampos := '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?><modificacion_de_pacientes>
					 <tabla nombre="pacientes">';
					_valorcampos := _valorcampos || 
					formato_campo_xml('Nombre',  		coalesce(_nom_usu_adm::text, 'ninguno'), 	coalesce(_reg_act.nom_usu_adm::text, 'ninguno'))||
					formato_campo_xml('Apellido', 		coalesce(_ape_usu_adm::text, 'ninguno'), 	coalesce(_reg_act.ape_usu_adm::text, 'ninguno'))||
					formato_campo_xml('Cédula', 		coalesce(_ced_usu_adm::text, 'ninguno'), 	coalesce(_reg_act.ced_usu_adm::text, 'ninguno'))||  
					formato_campo_xml('Teléfono',	 	coalesce(_tel_usu_adm::text, 'ninguno'), 	coalesce(_reg_act.tel_usu_adm::text, 'ninguno'))||  
					formato_campo_xml('Login', 		coalesce(_log_usu_adm::text, 'ninguno'), 	coalesce(_reg_act.log_usu_adm::text, 'ninguno'))||  
					formato_campo_xml('Correo	', 	coalesce(_cor_usu_adm::text, 'ninguno'), 	coalesce(_reg_act.cor_usu_adm::text, 'ninguno'));  
				/*ªª Se cierra el tag de la tabla */
				_valorcampos := _valorcampos || '</tabla>';
				_valorcampos := _valorcampos || '</modificacion_de_pacientes>';	
						
			

				/* Insertando las transacciones del usuario*/
				_id_tip_usu_usu := (SELECT id_tip_usu_usu FROM tipos_usuarios__usuarios WHERE id_usu_adm = _id_usu_adm);
				DELETE FROM transacciones_usuarios WHERE id_tip_usu_usu = _id_tip_usu_usu;	
				
				_arr_trans_adm := STRING_TO_ARRAY(_trans_adm,',');
						
				IF (ARRAY_UPPER(_arr_trans_adm,1) > 0)THEN							
					FOR i IN 1..(ARRAY_UPPER(_arr_trans_adm,1)) LOOP
						INSERT INTO transacciones_usuarios(
							id_tip_usu_usu,
							id_tip_tra
						)
						VALUES
						(					
							_id_tip_usu_usu,
							_arr_trans_adm[i]
						);

						SELECT des_tip_tra INTO _info 
						FROM transacciones_usuarios tu
							LEFT JOIN transacciones t ON tu.id_tip_tra = t.id_tip_tra
						WHERE tu.id_tip_tra = _arr_trans_adm[i];
						
						_des_tip_tra := _des_tip_tra || _info.des_tip_tra || ' ,';
				
					END LOOP;
				END IF;

				/*Obtengo el Id del tipo de usuario deacuerdo al usuario logueado*/
				SELECT id_tip_usu_usu INTO _reg_usu FROM tipos_usuarios__usuarios WHERE id_usu_adm = _id_usu_log;

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

				--raise notice '%',_valorcampos;

				/* La función se ejecutó exitosamente*/
				RETURN 1;

			ELSE     
				/* No existe el usuario administrativo a modificar */
				RETURN 0;
			END IF;
		ELSE
			RETURN 3; /* Existe un usuario administrativo con la misma cédula*/
		END IF;
		
	ELSE
		RETURN 2; /* Existe un usuario administrativo con el mismo login*/
	END IF;

END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION adm_modificar_usuario_admin(character varying[]) OWNER TO desarrollo_g;
COMMENT ON FUNCTION adm_modificar_usuario_admin(character varying[]) IS '
NOMBRE: adm_modificar_usuario_admin
TIPO: Function (store procedure)

PARAMETROS: Recibe 7 Parámetros
	1:  Identificador del usuario administrativo
	2:  Nombre del usuario administrativo
	3:  Apellido del usuario administrativo
	4:  Cédula del usuario administrativo
	5:  Teléfono del usuario administrativo
	6:  Correo del usuario administrativo
	7:  Transacciones del usuario administrativo

DESCRIPCION: 
	Modifica la información del usuario administrativo 

RETORNO:
	3: Existe un usuario administrativo con la misma cédula
	2: Existe un usuario administrativo con el mismo login
	1: La función se ejecutó exitosamente.
	0: No existe el usuario
	 
EJEMPLO DE LLAMADA:
	SELECT adm_modificar_usuario_admin(ARRAY[ ''23'', ''lmarin2'', ''lmarin'', ''marin'', ''45645645'', ''36222222'', ''lmarin@gmail.com'', ''22,23,24,25,26,27'' , ''22'', ''MUA'']) AS result

AUTOR DE CREACIÓN: Lisseth Lozada
FECHA DE CREACIÓN: 27/03/2011   

AUTOR DE MODIFICACIÓN: Luis Marin
FECHA DE MODIFICACIÓN: 22/04/2011    
DESCRIPCIÓN: Validación de log del usuario  

AUTOR DE MODIFICACIÓN: Lisseth Lozada
FECHA DE MODIFICACIÓN: 02/02/2012  
 
';
