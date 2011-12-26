-- Function: med_muestra_clinica_paciente(character varying[])

-- DROP FUNCTION med_muestra_clinica_paciente(character varying[]);

CREATE OR REPLACE FUNCTION med_muestra_clinica_paciente(character varying[])
  RETURNS smallint AS
$BODY$
DECLARE
	_datos ALIAS FOR $1;

	-- informacion del paciente	
	_str_mue_cli		TEXT;	
	_id_doc			doctores.id_doc%TYPE;
	_id_his			historiales_pacientes.id_his%TYPE;
	_tra_usu		transacciones.cod_tip_tra%TYPE;

	_id_otr_mue_cli		muestras_pacientes.id_mue_pac%TYPE;
	_str_otr_mue_cli	muestras_pacientes.otr_mue_cli%TYPE;
	
	_nom_mue_cli_ant	VARCHAR;
	_nom_mue_cli_act	VARCHAR;
	_valorcampos 		VARCHAR := '';
	_reg_pac		RECORD;
	_reg_ant		RECORD;
	_reg_act		RECORD;

	_reg_usu		RECORD;
	_reg_tra		RECORD;
		
	_arr			INTEGER[];		
BEGIN
	-- pacientes
	_id_his			:= _datos[1];	
	_str_mue_cli		:= _datos[2];
	
	_id_otr_mue_cli		:= _datos[3];
	_str_otr_mue_cli	:= _datos[4];
			
	_id_doc			:= _datos[5];	
	_tra_usu		:= _datos[6];



	/*Busco el registro anterior del paciente*/
	SELECT nom_pac,ape_pac,ced_pac, id_his  INTO _reg_pac
	FROM pacientes p 
		LEFT JOIN historiales_pacientes hp USING(id_pac)
	WHERE id_his = _id_his;

	/*Busco el registro anterior del nombre de la muestra clinica del paciente*/
	FOR _reg_ant IN (SELECT nom_mue_cli FROM muestras_pacientes mp LEFT JOIN muestras_clinicas mc ON(mp.id_mue_cli = mc.id_mue_cli) WHERE mp.id_his = _id_his) LOOP
		_nom_mue_cli_ant := _nom_mue_cli_ant || _reg_ant.nom_mue_cli || ' ,';
	END LOOP;

	/* Se le quita la última de las comas a la variable */
	IF length(_nom_mue_cli_ant) > 0 THEN
		_nom_mue_cli_ant := substr(_nom_mue_cli_ant, 1, length(_nom_mue_cli_ant) - 1);
	END IF;
		
	
	DELETE FROM muestras_pacientes WHERE id_his = _id_his;

	_arr := STRING_TO_ARRAY(_str_mue_cli,',');
	IF (ARRAY_UPPER(_arr,1) > 0)THEN
		FOR i IN 1..(ARRAY_UPPER(_arr,1)) LOOP
			IF (_id_otr_mue_cli = _arr[i])THEN
				INSERT INTO muestras_pacientes (
					id_his,
					id_mue_cli,
					otr_mue_cli					
				) VALUES (
					_id_his,
					_arr[i],
					_str_otr_mue_cli
				);
			ELSE
				INSERT INTO muestras_pacientes (
					id_his,
					id_mue_cli					
				) VALUES (
					_id_his,
					_arr[i]
				);
			END IF;

			SELECT nom_mue_cli INTO _reg_act FROM muestras_pacientes mp LEFT JOIN muestras_clinicas mc ON(mp.id_mue_cli = mc.id_mue_cli) WHERE mc.id_mue_cli = _arr[i];

			_nom_mue_cli_act := _nom_mue_cli_act || _reg_act.nom_mue_cli || ' ,';
		END LOOP;
	END IF;


	/* Se le quita la última de las comas a la variable */
	IF length(_nom_mue_cli_act) > 0 THEN
		_nom_mue_cli_act := substr(_nom_mue_cli_act, 1, length(_nom_mue_cli_act) - 1);
	END IF;	

	/* Se coloca el encabezado para los valores de los campos, así como el tag raíz y el inicio del tag tabla */
	_valorcampos := '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?><registrar_muestra_clínica_paciente>
			 <tabla nombre="muestras_pacientes">';
			_valorcampos := _valorcampos || 
			formato_campo_xml('Nombre',  		coalesce(_reg_pac.nom_pac::text, 'ninguno'), 	coalesce(_reg_pac.nom_pac::text, 'ninguno'))||
			formato_campo_xml('Apellido', 		coalesce(_reg_pac.ape_pac::text, 'ninguno'), 	coalesce(_reg_pac.ape_pac::text, 'ninguno'))||
			formato_campo_xml('Cédula', 		coalesce(_reg_pac.ced_pac::text, 'ninguno'), 	coalesce(_reg_pac.ced_pac::text, 'ninguno'))||  
			formato_campo_xml('Muestra Clínica',  	coalesce(_nom_mue_cli_act::text, 'ninguno'), 	coalesce(_nom_mue_cli_ant::text, 'ninguno'));
			/* Se cierra el tag de la tabla */
			_valorcampos := _valorcampos || '</tabla>';
	_valorcampos := _valorcampos || '</registrar_muestra_clínica_paciente>';	

	
	/*Obtengo el Id del tipo de usuario deacuerdo al usuario logueado*/
	SELECT id_tip_usu_usu INTO _reg_usu FROM tipos_usuarios__usuarios WHERE id_doc = _id_doc;

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

	RETURN 1;

END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION med_muestra_clinica_paciente(character varying[]) OWNER TO desarrollo_g;
COMMENT ON FUNCTION med_muestra_clinica_paciente(character varying[]) IS '
NOMBRE: med_muestra_clinica_paciente
TIPO: Function (store procedure)

PARAMETROS: Recibe 3 Parámetros
	1:  Id del historico del paciente
	2:  Id de Muestras clínicas del paciente
	3:  Id del doctor quien realizo la transacción
	4:  Código de la transaccion	

DESCRIPCION: 
	Modifica la información de las muestras clínicas del paciente
RETORNO:
	1: La función se ejecutó exitosamente	
	 
EJEMPLO DE LLAMADA:
	SELECT med_muestra_clinica_paciente(ARRAY[
                ''16'',
                ''1,3,4,8,9,36'',
                ''36'',
                ''Otra Clinica'',               
                ''32'',
                ''MCP''                
                ]
            ) AS result 

AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 03/08/2011

AUTOR DE MODIFICACIÓN: Lisseth Lozada
FECHA DE MODIFICACIÓN: 25/08/2011
DESCRIPCIÓN: Se agregó en la función el armado del xml para la inserción de la auditoría de las transacciones.
';
