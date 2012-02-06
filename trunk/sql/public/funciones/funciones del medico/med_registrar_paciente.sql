-- Function: med_registrar_paciente(character varying[])

-- DROP FUNCTION med_registrar_paciente(character varying[]);

CREATE OR REPLACE FUNCTION med_registrar_paciente(character varying[])
  RETURNS smallint AS
$BODY$
DECLARE
	_datos ALIAS FOR $1;

	-- informacion del paciente
	_nom_pac 	pacientes.nom_pac%TYPE;
	_ape_pac 	pacientes.ape_pac%TYPE;
	_ced_pac	pacientes.ced_pac%TYPE;
	_fec_nac_pac 	pacientes.fec_nac_pac%TYPE;
	_nac_pac 	pacientes.nac_pac%TYPE;
	_tel_hab_pac	pacientes.tel_hab_pac%TYPE;
	_tel_cel_pac	pacientes.tel_cel_pac%TYPE;
	_ocu_pac	pacientes.ocu_pac%TYPE;
	_ciu_pac	pacientes.ciu_pac%TYPE;
	_id_pai		pacientes.id_pai%TYPE;
	_id_est		pacientes.id_est%TYPE;
	_id_mun		pacientes.id_mun%TYPE;
	_id_par		pacientes.id_par%TYPE;	
	_sex_pac	pacientes.sex_pac%TYPE;
	_ord_por	pacientes.ord_por%TYPE;
	_tra_usu	transacciones.cod_tip_tra%TYPE;
	
	_str_ant_per	TEXT;
	_arr_ant_per	INTEGER[];
	_valorcampos 	VARCHAR := '';
	_des_ant_per 	VARCHAR := '';
	
	_info		RECORD;
	_reg_pac	RECORD;
	_reg_act	RECORD;
	_reg_usu	RECORD;
	_reg_tra	RECORD;
	
	

	-- informacion del doctor

	_id_doc		doctores.id_doc%TYPE;
	
BEGIN
	-- pacientes
	_nom_pac 	:= _datos[1];
	_ape_pac 	:= _datos[2];
	_ced_pac	:= _datos[3];
	_fec_nac_pac 	:= _datos[4];
	_nac_pac 	:= _datos[5];
	_tel_hab_pac	:= _datos[6];
	_tel_cel_pac	:= _datos[7];
	_ocu_pac	:= _datos[8];
	_ciu_pac	:= _datos[9];
	_id_pai		:= _datos[10];
	_id_est		:= _datos[11];
	_id_mun		:= _datos[12];
	_str_ant_per	:= _datos[13];
	_id_doc		:= _datos[14];
	_tra_usu	:= _datos[15];
	_sex_pac	:= _datos[16];
	_ord_por	:= _datos[17];

	-- centros de salud pacientes
	

	/* validando pacientes */
	IF NOT EXISTS (SELECT 1 FROM pacientes WHERE ced_pac = _ced_pac) THEN     		
		
		/*insertando pacientes*/
		INSERT INTO pacientes
		(
			nom_pac,	
			ape_pac, 	
			ced_pac,	
			fec_nac_pac, 	
			nac_pac, 	
			tel_hab_pac,	
			tel_cel_pac,	
			ocu_pac,	
			ciu_pac,	
			id_pai,		
			id_est,		
			id_mun,
			num_pac,
			id_doc,
			sex_pac,
			ord_por	
		)
		VALUES 
		(
			_nom_pac, 	
			_ape_pac, 	
			_ced_pac,	
			_fec_nac_pac, 	
			_nac_pac, 	
			_tel_hab_pac,	
			_tel_cel_pac,	
			_ocu_pac,	
			_ciu_pac,	
			_id_pai,		
			_id_est,		
			_id_mun,
			((SELECT COUNT(id_pac) FROM pacientes )::INTEGER)+1,
			_id_doc,
			_sex_pac,
			_ord_por
		);

		/*Busco el registro anterior del paciente*/
		SELECT 	p.des_pai, e.des_est, m.des_mun,
			CASE 
				WHEN pa.nac_pac = '1' THEN 'Venezolano' ELSE 'Extranjero' 
			END AS nac_pac,
			CASE 
				WHEN pa.ocu_pac = '1' THEN 'Profesional'
				WHEN pa.ocu_pac = '2' THEN 'Técnico'
				WHEN pa.ocu_pac = '3' THEN 'Obrero'
				WHEN pa.ocu_pac = '4' THEN 'Agricultor'
				WHEN pa.ocu_pac = '5' THEN 'Jardinero'
				WHEN pa.ocu_pac = '6' THEN 'Otro'
			END AS ocu_pac  INTO _reg_pac
		FROM pacientes pa
			LEFT JOIN paises p USING(id_pai)
			LEFT JOIN estados e ON(p.id_pai = e.id_pai)
			LEFT JOIN municipios m ON(e.id_est = m.id_est)
		WHERE pa.id_pac = CURRVAL('pacientes_id_pac_seq')
			AND p.id_pai = _id_pai
			AND e.id_est = _id_est
			AND m.id_mun = _id_mun;


		/* Se coloca el encabezado para los valores de los campos, así como el tag raíz y el inicio del tag tabla */
		_valorcampos := '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?><registro_de_pacientes>
				 <tabla nombre="pacientes">';
				_valorcampos := _valorcampos || 
				formato_campo_xml('ID', 		coalesce(_id_doc::text, 'ninguno'), 		'ninguno')||
				formato_campo_xml('Nombre',  		coalesce(_nom_pac::text, 'ninguno'), 		'ninguno')||
				formato_campo_xml('Apellido', 		coalesce(_ape_pac::text, 'ninguno'), 		'ninguno')||
				formato_campo_xml('Cédula', 		coalesce(_ced_pac::text, 'ninguno'), 		'ninguno')||  
				formato_campo_xml('Fecha Nacimiento', 	coalesce(_fec_nac_pac::text, 'ninguno'), 	'ninguno')||
				formato_campo_xml('Sexo', 		coalesce(_sex_pac::text, 'ninguno'), 		'ninguno')||   
				formato_campo_xml('Nacionalidad', 	coalesce(_reg_pac.nac_pac::text, 'ninguno'), 	'ninguno')||  
				formato_campo_xml('Teléfono Habitación',coalesce(_tel_hab_pac::text, 'ninguno'), 	'ninguno')||
				formato_campo_xml('Teléfono Célular', 	coalesce(_tel_cel_pac::text, 'ninguno'), 	'ninguno')|| 
				formato_campo_xml('Ordenado por', 	coalesce(_ord_por::text, 'ninguno'), 		'ninguno')|| 
				formato_campo_xml('Ocupación', 		coalesce(_reg_pac.ocu_pac::text, 'ninguno'), 	'ninguno')||
				formato_campo_xml('País', 		coalesce(_reg_pac.des_pai::text, 'ninguno'), 	'ninguno')||
				formato_campo_xml('Estado', 		coalesce(_reg_pac.des_est::text, 'ninguno'), 	'ninguno')||
				formato_campo_xml('Municipio', 		coalesce(_reg_pac.des_mun::text, 'ninguno'), 	'ninguno')||
				formato_campo_xml('Ciudad', 		coalesce(_ciu_pac::text, 'ninguno'), 		'ninguno');  
			/*ªª Se cierra el tag de la tabla */
			_valorcampos := _valorcampos || '</tabla>';
		

		/* Antecedentes personales*/
		_arr_ant_per := STRING_TO_ARRAY(_str_ant_per,',');
		IF (ARRAY_UPPER(_arr_ant_per,1) > 0)THEN
			FOR i IN 1..(ARRAY_UPPER(_arr_ant_per,1)) LOOP
				INSERT INTO antecedentes_pacientes(
					id_pac,
					id_ant_per
				)
				VALUES
				(
					(CURRVAL('pacientes_id_pac_seq')),
					_arr_ant_per[i]
				);

				SELECT nom_ant_per INTO _info FROM antecedentes_personales WHERE id_ant_per = _arr_ant_per[i];
				_des_ant_per := _des_ant_per || _info.nom_ant_per || ' ,';
			END LOOP;
		END IF;	
		
		/* Se le quita la última de las comas a la variable */
		IF length(_des_ant_per) > 0 THEN
			_des_ant_per := substr(_des_ant_per, 1, length(_des_ant_per) - 1);
		END IF;	
			
			/* Se identifica la tabla en el formato xml */
			_valorcampos := _valorcampos || '<tabla nombre="antecedentes_personales">';
			/* Se completa el tag con el valor del campo */
				_valorcampos := _valorcampos || 
				formato_campo_xml('Antecedentes Personales', coalesce(_des_ant_per::text, 'ninguno'), 'ninguno');
			/* Se cierra el tag de la tabla */
			_valorcampos := _valorcampos || '</tabla>';
			
		_valorcampos := _valorcampos || '</registro_de_pacientes>';	

		
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
		
		-- La función se ejecutó exitosamente
		RETURN 1;
	ELSE
		-- Existe un usuario administrativo con el mismo login
		RETURN 0;
	END IF;

END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION med_registrar_paciente(character varying[]) OWNER TO desarrollo_g;
COMMENT ON FUNCTION med_registrar_paciente(character varying[]) IS '
NOMBRE: med_registrar_paciente
TIPO: Function (store procedure)

PARAMETROS: Recibe 12 Parámetros
	1:  Nombre paciente
	2:  Apellido del paciente
	3:  Cédula del paciente
	4:  Fecha de nacimiento del paciente
	5:  Nacionalidad del paciente
	6:  Teléfono de habitacion del paciente
	7:  Teléfono de celular del paciente
	8:  Ocupacion del paciente
	9:  Ciudad donde se encuentra el paciente
	10: Id del pais donde vive el paciente
	11: Id del estado donde vive el paciente.
	12: Id del municipio donde vive el paciente.
	13: Id de los antecedentes personales
	14: Id del doctor quien realizo la transacción
	15: Código de la transaccion
	16: Sexo del paciente
	17: Ordenado por 

DESCRIPCION: 
	Almacena la información de los pacientes

RETORNO:
	1: La función se ejecutó exitosamente
	0: Existe un usuario administrativo con el mismo login
	 
EJEMPLO DE LLAMADA:
	SELECT med_registrar_paciente(ARRAY[
                ''prueba'', 
                ''prueba'', 
                ''1789654233'',     
                ''1988-08-08'',
                ''1'',
                ''02129514789'',
                ''04269150755'',
                ''1'',
                ''guarenas'',
                ''1'',
                ''14'',
                ''193'',
                ''2,3,4,8'',
                ''32'',
                ''RP'',
                ''F'',
                ''Pepe perez''
            ]) AS result

AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 09/06/2011

AUTOR DE MODIFICACIÓN: Lisseth Lozada
FECHA DE MODIFICACIÓN: 16/08/2011
DESCRIPCIÓN: Se agregó en la función el armado del xml para la inserción de la auditoría de las transacciones.

AUTOR DE MODIFICACIÓN: Lisseth Lozada
FECHA DE MODIFICACIÓN: 05/02/2012
DESCRIPCIÓN: Se agregó en la función un nuevo campo sex_pac y el campo ord_por.
';
