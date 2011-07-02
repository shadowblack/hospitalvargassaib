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
	_id_doc		doctores.id_doc%TYPE;
	
BEGIN
	-- pacientes
	_id_his 		:= _datos[1];
	_des_his 		:= _datos[2];
	_des_adi_pac_his	:= _datos[3];

	-- doctor	
	_id_doc			:= _datos[4];

	-- historial del paciente
		

	UPDATE historiales_pacientes SET 		
		des_his 	= _des_his, 	
		des_adi_pac_his = _des_adi_pac_his				
		WHERE id_his 	= _id_his;
		
	RETURN 1; -- La función se ejecutó exitosamente
	
	
	

END;$BODY$
  LANGUAGE 'plpgsql' VOLATILE;
COMMENT ON FUNCTION med_modificar_hitorial_paciente(character varying[]) IS '
NOMBRE: med_modificar_hitorial_paciente
TIPO: Function (store procedure)

PARAMETROS: Recibe 4 Parámetros

	1:  Id del historial.
	2:  Descripción delhec historico.
	3:  Descripción adicional del paciente.
	4:  Id del doctor que se encuentra logueado en el sistema.
	
DESCRIPCION: 
	Modifica la información del historico de los pacientes

RETORNO:
	1: La función se ejecutó exitosamente	
	 
EJEMPLO DE LLAMADA:
	SELECT med_registrar_hitorial_paciente(ARRAY[ ''7'', ''lkhlkjh'', ''jhgfjgf'', ''6'' ]) AS result

AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 26/06/2011

';

