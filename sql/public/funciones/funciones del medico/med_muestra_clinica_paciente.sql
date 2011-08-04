CREATE OR REPLACE FUNCTION med_muestra_clinica_paciente(character varying[])
  RETURNS smallint AS
$BODY$
DECLARE
	_datos ALIAS FOR $1;

	-- informacion del paciente	
	_str_mue_cli	TEXT;	
	_id_doc		doctores.id_doc%TYPE;

	_id_his		historiales_pacientes.id_his%TYPE;
		
	_arr	INTEGER[];	
	
	
	
BEGIN
	-- pacientes
	_id_his			:= _datos[1];	
	_str_mue_cli		:= _datos[2];		
	_id_doc			:= _datos[7];	

	-- centro de salud del paciente referidos al historico
	DELETE FROM muestras_pacientes WHERE id_his = _id_his;

	_arr := STRING_TO_ARRAY(_str_mue_cli,',');
	IF (ARRAY_UPPER(_arr,1) > 0)THEN
		FOR i IN 1..(ARRAY_UPPER(_arr,1)) LOOP
			INSERT INTO muestras_pacientes (
				id_his,
				id_mue_cli					
			) VALUES (
				_id_his,
				_arr[i]
			);
		END LOOP;
	END IF;

	RETURN 1;

END;$BODY$
  LANGUAGE 'plpgsql' VOLATILE;
COMMENT ON FUNCTION med_muestra_clinica_paciente(character varying[]) IS '
NOMBRE: med_muestra_clinica_paciente
TIPO: Function (store procedure)

PARAMETROS: Recibe 3 Parámetros
	1:  Id del historico del paciente
	2:  Centro de salud del pacient	

DESCRIPCION: 
	Modifica la información de los tratamientos a realizar para el paciente

RETORNO:
	1: La función se ejecutó exitosamente	
	 
EJEMPLO DE LLAMADA:
	SELECT med_muestra_clinica_paciente(ARRAY[
                ''16'',
                ''7'',
                ''6,7'',
                ''3'',
                ''4'',
                ''1'',
                ''6''                
                ]
            ) AS result 

AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 03/08/2011

';

SELECT med_muestra_clinica_paciente(ARRAY[
                '16',
                '1',               
                '6'                
                ]
            ) AS result 
