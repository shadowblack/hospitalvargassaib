-- Function: med_registrar_hitorial_paciente(character varying[])

-- DROP FUNCTION med_registrar_hitorial_paciente(character varying[]);

CREATE OR REPLACE FUNCTION med_registrar_hitorial_paciente(character varying[])
  RETURNS smallint AS
$BODY$
DECLARE
	_datos ALIAS FOR $1;

	-- informacion del paciente
	_id_pac 		pacientes.id_pac%TYPE;
	_des_his 		historiales_pacientes.des_his%TYPE;
	_des_adi_pac_his	historiales_pacientes.des_adi_pac_his%TYPE;
	_id_his			historiales_pacientes.id_his%TYPE;
	
	-- informacion del doctor
	_id_doc			doctores.id_doc%TYPE;
	_tra_usu		transacciones.cod_tip_tra%TYPE;

	_valorcampos 		VARCHAR := '';
	_reg_act		RECORD;
	_reg_usu		RECORD;
	_reg_tra		RECORD;
	
BEGIN
	-- pacientes
	_id_pac 		:= _datos[1];
	_des_his 		:= _datos[2];
	_des_adi_pac_his	:= _datos[3];

	-- doctor	
	_id_doc			:= _datos[4];
	_tra_usu		:= _datos[5];

	-- historial del paciente
	

	/*insertando pacientes*/
	INSERT INTO historiales_pacientes
	(
		id_pac,	
		des_his, 	
		des_adi_pac_his,		
		id_doc		
	)
	VALUES 
	(
		_id_pac,	
		_des_his, 	
		_des_adi_pac_his,		
		_id_doc
	);	

	_id_his:= CURRVAL('historiales_pacientes_id_his_seq');	

	/*Busco el registro actual del historial del paciente*/
	SELECT nom_pac,ape_pac,ced_pac,des_his,des_adi_pac_his,fec_his INTO _reg_act
	FROM historiales_pacientes LEFT JOIN pacientes USING(id_pac) 
	WHERE id_his = _id_his;
	
	/* Se coloca el encabezado para los valores de los campos, así como el tag raíz y el inicio del tag tabla */
	_valorcampos := '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?><registro_del_historial_paciente>
		 <tabla nombre="historiales_pacientes">';
		_valorcampos := _valorcampos || 
		formato_campo_xml('Nombre Paciente', 		coalesce(_reg_act.nom_pac::text, 'ninguno'), 	'ninguno')||
		formato_campo_xml('Apellido Paciente',  	coalesce(_reg_act.ape_pac::text, 'ninguno'), 	'ninguno')||
		formato_campo_xml('Cédula Paciente', 		coalesce(_reg_act.ced_pac::text, 'ninguno'), 	'ninguno')||
		formato_campo_xml('Descripción de la Historia', coalesce(_des_his::text, 'ninguno'), 		'ninguno')||  
		formato_campo_xml('Descripción Adicional', 	coalesce(_des_adi_pac_his::text, 'ninguno'), 	'ninguno')||  
		formato_campo_xml('Fecha de Historia', 		coalesce(_reg_act.fec_his::text, 'ninguno'), 	'ninguno');  
		/*ªª Se cierra el tag de la tabla */
		_valorcampos := _valorcampos || '</tabla>';
	

		INSERT INTO tiempo_evoluciones(
			id_his
		) VALUES (
			_id_his
		);

		SELECT * INTO _reg_act FROM tiempo_evoluciones;


	/* Se identifica la tabla en el formato xml */
		_valorcampos := _valorcampos || '<tabla nombre="tiempo_evoluciones">';
		/* Se completa el tag con el valor del campo */
			_valorcampos := _valorcampos || 
			formato_campo_xml('Tiempo de Evolución', coalesce(_reg_act.tie_evo::text, 'ninguno'), 'ninguno');
		/* Se cierra el tag de la tabla */
		_valorcampos := _valorcampos || '</tabla>';
		
	_valorcampos := _valorcampos || '</registro_del_historial_paciente>';	

		
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

END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION med_registrar_hitorial_paciente(character varying[]) OWNER TO desarrollo_g;
COMMENT ON FUNCTION med_registrar_hitorial_paciente(character varying[]) IS '
NOMBRE: med_registrar_hitorial_paciente
TIPO: Function (store procedure)

PARAMETROS: Recibe 4 Parámetros

	1:  Id del paciente.
	2:  Descripción delhec historico.
	3:  Descripción adicional del paciente.
	4:  Id del doctor que se encuentra logueado en el sistema.
	5:  Código de la transacción
DESCRIPCION: 
	Almacena la información del historico de los pacientes

RETORNO:
	1: La función se ejecutó exitosamente	
	 
EJEMPLO DE LLAMADA:
	SELECT med_registrar_hitorial_paciente(ARRAY[ ''7'', ''lkhlkjh'', ''jhgfjgf'', ''6'',''RHP'' ]) AS result

AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 26/06/2011

AUTOR DE MODIFICACIÓN: Lisseth Lozada
FECHA DE MODIFICACIÓN: 17/08/2011
DESCRIPCIÓN: Se agregó en la función el armado del xml para la inserción de la auditoría de las transacciones.
';
