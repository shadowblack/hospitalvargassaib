CREATE OR REPLACE FUNCTION med_modificar_hitorial_paciente(character varying[])
  RETURNS smallint AS
$BODY$
DECLARE
	_datos ALIAS FOR $1;

	-- informacion del paciente
	_id_his 		historiales_pacientes.id_his%TYPE;
	_des_his 		historiales_pacientes.des_his%TYPE;
	_des_adi_pac_his	historiales_pacientes.des_adi_pac_his%TYPE;	
	
	-- informacion del doctor
	_id_doc			doctores.id_doc%TYPE;

	_tra_usu		transacciones.cod_tip_tra%TYPE;

	_valorcampos 		VARCHAR := '';
	_reg_ant		RECORD;
	_reg_act		RECORD;
	_reg_usu		RECORD;
	_reg_tra		RECORD;
	
BEGIN
	-- pacientes
	_id_his 		:= _datos[1];
	_des_his 		:= _datos[2];
	_des_adi_pac_his	:= _datos[3];

	-- doctor	
	_id_doc			:= _datos[4];
	_tra_usu		:= _datos[5];

	-- historial del paciente
		
	/*Busco el registro anterior del historial del paciente*/
	SELECT nom_pac,ape_pac,ced_pac,des_his,des_adi_pac_his,fec_his INTO _reg_ant
	FROM historiales_pacientes LEFT JOIN pacientes USING(id_pac) 
	WHERE id_his = _id_his;

	
	UPDATE historiales_pacientes SET 		
		des_his 	= _des_his, 	
		des_adi_pac_his = _des_adi_pac_his				
		WHERE id_his 	= _id_his;

	/*Busco el registro actuales del historial del paciente*/
	SELECT nom_pac,ape_pac,ced_pac,fec_his INTO _reg_act
	FROM historiales_pacientes LEFT JOIN pacientes USING(id_pac) 
	WHERE id_his = _id_his;

	/* Se coloca el encabezado para los valores de los campos, así como el tag raíz y el inicio del tag tabla */
	_valorcampos := '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?><modificacion_del_historial_paciente>
		 <tabla nombre="historiales_pacientes">';
		_valorcampos := _valorcampos || 
		formato_campo_xml('Nombre Paciente', 		coalesce(_reg_act.nom_pac::text, 'ninguno'), 	coalesce(_reg_ant.nom_pac::text,'ninguno'))||
		formato_campo_xml('Apellido Paciente',  	coalesce(_reg_act.ape_pac::text, 'ninguno'), 	coalesce(_reg_ant.ape_pac::text,'ninguno'))||
		formato_campo_xml('Cédula Paciente', 		coalesce(_reg_act.ced_pac::text, 'ninguno'), 	coalesce(_reg_ant.ced_pac::text,'ninguno'))||
		formato_campo_xml('Descripción de la Historia', coalesce(_des_his::text, 'ninguno'), 		coalesce(_reg_ant.des_his::text,'ninguno'))||
		formato_campo_xml('Descripción Adicional', 	coalesce(_des_adi_pac_his::text, 'ninguno'), 	coalesce(_reg_ant.des_adi_pac_his::text,'ninguno'))||
		formato_campo_xml('Fecha de Historia', 		coalesce(_reg_act.fec_his::text, 'ninguno'), 	coalesce(_reg_ant.fec_his::text,'ninguno'));
		/*ªª Se cierra el tag de la tabla */
		_valorcampos := _valorcampos || '</tabla>';
	_valorcampos := _valorcampos || '</modificacion_del_historial_paciente>';	

		
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
		
	RETURN 1; -- La función se ejecutó exitosamente	

END;$BODY$
  LANGUAGE 'plpgsql' VOLATILE;
ALTER FUNCTION med_modificar_hitorial_paciente(character varying[]) OWNER TO desarrollo_g;
COMMENT ON FUNCTION med_modificar_hitorial_paciente(character varying[]) IS '
NOMBRE: med_modificar_hitorial_paciente
TIPO: Function (store procedure)

PARAMETROS: Recibe 4 Parámetros

	1:  Id del historial.
	2:  Descripción delhec historico.
	3:  Descripción adicional del paciente.
	4:  Id del doctor que se encuentra logueado en el sistema.
	5:  Código de la transacción
DESCRIPCION: 
	Modifica la información del historico de los pacientes

RETORNO:
	1: La función se ejecutó exitosamente	
	 
EJEMPLO DE LLAMADA:
	SELECT med_registrar_hitorial_paciente(ARRAY[ ''7'', ''lkhlkjh'', ''jhgfjgf'', ''6'',''MHP'' ]) AS result

AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 26/06/2011


AUTOR DE MODIFICACIÓN: Lisseth Lozada
FECHA DE MODIFICACIÓN: 23/08/2011
DESCRIPCIÓN: Se agregó en la función el armado del xml para la inserción de la auditoría de las transacciones.
';

/*

SELECT med_modificar_hitorial_paciente(ARRAY[
                '16', 
                'demopsLISS', 
                'demosLISS', 
                '32',
                'MHP'               
            ]) AS result
            
*/