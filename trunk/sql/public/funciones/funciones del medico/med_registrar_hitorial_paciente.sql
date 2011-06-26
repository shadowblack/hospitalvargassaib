CREATE OR REPLACE FUNCTION med_registrar_hitorial_paciente(character varying[])
  RETURNS smallint AS
$BODY$
DECLARE
	_datos ALIAS FOR $1;

	-- informacion del paciente
	_id_pac 		pacientes.id_pac%TYPE;
	_des_his 		historiales_pacientes.des_his%TYPE;
	_des_adi_pac_his	historiales_pacientes.des_adi_pac_his%TYPE;	
	
	-- informacion del doctor
	_id_doc		doctores.id_doc%TYPE;
	
BEGIN
	-- pacientes
	_id_pac 		:= _datos[1];
	_des_his 		:= _datos[2];
	_des_adi_pac_his	:= _datos[3];

	-- doctor	
	_id_doc			:= _datos[4];

	-- historial del paciente
	

	/*insertando pacientes*/
	INSERT INTO historiales_pacientes
	(
		id_pac,	
		des_his, 	
		des_adi_pac_his,
		num_his,
		id_doc		
	)
	VALUES 
	(
		_id_pac,	
		_des_his, 	
		_des_adi_pac_his,
		((SELECT COUNT(id_his) FROM historiales_pacientes WHERE id_pac = _id_pac)::INTEGER)+1,
		_id_doc
	);		
			
	-- La función se ejecutó exitosamente
	RETURN 1;
	
	
	

END;$BODY$
  LANGUAGE 'plpgsql' VOLATILE;
COMMENT ON FUNCTION med_registrar_hitorial_paciente(character varying[]) IS '
NOMBRE: med_registrar_hitorial_paciente
TIPO: Function (store procedure)

PARAMETROS: Recibe 4 Parámetros

	1:  Id del paciente.
	2:  Descripción delhec historico.
	3:  Descripción adicional del paciente.
	4:  Id del doctor que se encuentra logueado en el sistema.
	
DESCRIPCION: 
	Almacena la información del historico de los pacientes

RETORNO:
	1: La función se ejecutó exitosamente	
	 
EJEMPLO DE LLAMADA:
	SELECT med_registrar_hitorial_paciente(ARRAY[ ''7'', ''lkhlkjh'', ''jhgfjgf'', ''6'' ]) AS result

AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 26/06/2011

';

