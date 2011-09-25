CREATE OR REPLACE FUNCTION med_modificar_micosis_pacientes(character varying[])
  RETURNS smallint AS
$BODY$
DECLARE
	_datos ALIAS FOR $1;	

	_id_tip_mic_pac tipos_micosis_pacientes.id_tip_mic_pac%TYPE;
	_id_tip_mic		tipos_micosis.id_tip_mic%TYPE;
	_str_enf_pac		TEXT;
	_str_les		TEXT;
	_str_tip_est_mic	TEXT;	

	-- cadena para manipular el array
	_str		TEXT;
		
	_id_doc		doctores.id_doc%TYPE;
	
	_arr_1	INTEGER[];	
	_arr_2	INTEGER[];
	_arr_3	TEXT[];	
	
	
BEGIN

	-- pacientes	
	_id_tip_mic_pac		:= _datos[1];
	_str_enf_pac		:= _datos[2];
	_str_les		:= _datos[3];
	_str_tip_est_mic	:= _datos[4];		
	_id_doc			:= _datos[5];	
		
	-- enfermedades del paciente
	DELETE FROM enfermedades_pacientes WHERE id_tip_mic_pac = _id_tip_mic_pac;

	_arr_1 := STRING_TO_ARRAY(_str_enf_pac,',');
	IF (ARRAY_UPPER(_arr_1,1) > 0)THEN
		FOR i IN 1..(ARRAY_UPPER(_arr_1,1)) LOOP
			INSERT INTO enfermedades_pacientes (
				id_tip_mic_pac,
				id_enf_mic					
			) VALUES (
				_id_tip_mic_pac,
				_arr_1[i]
			);
		END LOOP;
	END IF;

	-- tipo de consulta del paciente referidos al historico
	DELETE FROM lesiones_partes_cuerpos__pacientes WHERE id_tip_mic_pac = _id_tip_mic_pac;
	
	_arr_3 := STRING_TO_ARRAY(_str_les,',');
	
	IF (ARRAY_UPPER(_arr_3,1) > 0)THEN
	
		FOR i IN 1..(ARRAY_UPPER(_arr_3,1)) LOOP		
			_arr_2 := STRING_TO_ARRAY(replace(replace(_arr_3[i] ,'(',''),')',''),';');
			
			INSERT INTO lesiones_partes_cuerpos__pacientes (
				id_tip_mic_pac,
				id_cat_cue_les,
				id_par_cue_cat_cue
			) VALUES (
				_id_tip_mic_pac,
				_arr_2[1],
				_arr_2[2]				
			);
		END LOOP;
	END IF;

	-- enfermedades del paciente
	DELETE FROM tipos_micosis_pacientes__tipos_estudios_micologicos WHERE id_tip_mic_pac = _id_tip_mic_pac;

	_arr_1 := STRING_TO_ARRAY(_str_tip_est_mic,',');
	IF (ARRAY_UPPER(_arr_1,1) > 0)THEN
		FOR i IN 1..(ARRAY_UPPER(_arr_1,1)) LOOP
			INSERT INTO tipos_micosis_pacientes__tipos_estudios_micologicos (
				id_tip_mic_pac,
				id_tip_est_mic					
			) VALUES (
				_id_tip_mic_pac,
				_arr_1[i]
			);
		END LOOP;
	END IF;

	RETURN 1;

END;$BODY$
  LANGUAGE 'plpgsql' VOLATILE;
ALTER FUNCTION med_modificar_micosis_pacientes(character varying[]) OWNER TO desarrollo_g;
COMMENT ON FUNCTION med_modificar_micosis_pacientes(character varying[]) IS '
NOMBRE: med_modificar_micosis_pacientes
TIPO: Function (store procedure)

PARAMETROS: Recibe 4 Parámetros
		
	1:  Id tipo micosis paciente.
	2:  String de las enfermedades del paciente, separados por ","
	3:  String de las lesiones del paciente.
	4:  Id del doctor.	

DESCRIPCION: 
	Modifica las enfermedades y las lesiones del paciente

RETORNO:
	1: La función se ejecutó exitosamente	
	 
EJEMPLO DE LLAMADA:
	SELECT med_modificar_micosis_pacientes(ARRAY[                
                ''1'',               
                ''1,2'',
                ''(2;1)'',
                ''5'',
                ''6''              
		]
	    ) AS result 

AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 15/08/2011

';

