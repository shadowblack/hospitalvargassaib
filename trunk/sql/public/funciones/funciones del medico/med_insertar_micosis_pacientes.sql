-- Function: med_insertar_micosis_pacientes(character varying[])

-- DROP FUNCTION med_insertar_micosis_pacientes(character varying[]);

CREATE OR REPLACE FUNCTION med_insertar_micosis_pacientes(character varying[])
  RETURNS smallint AS
$BODY$
DECLARE
	_datos ALIAS FOR $1;

	_id_his			historiales_pacientes.id_his%TYPE;
		
	_id_tip_mic		tipos_micosis.id_tip_mic%TYPE;
	_str_enf_pac		TEXT;
	_str_les		TEXT;
	_str_tip_est_mic	TEXT;
	_str_chk_for_inf	TEXT;

	_id_otr_enf_mic		enfermedades_pacientes.id_enf_pac%TYPE;
	_str_otr_enf_mic	enfermedades_pacientes.otr_enf_mic%TYPE;

	_id_otr_for_inf		forma_infecciones__pacientes.id_for_inf%TYPE;
	_str_otr_for_inf	forma_infecciones__pacientes.otr_for_inf%TYPE;

	_str_pos		TEXT;

	-- variables para trabajar con otros
	_str_data_otr			TEXT; --partes del cuerpo y categorias
	_str_data_otr_est		TEXT; --estudios
	_arr_str_data_otr		TEXT[];
	_arr_str_data_otr_est		TEXT[];
	_arr_str_data_otr_elm		TEXT[];
	_arr_str_data_otr_elm_est	TEXT[];
	_bol_otr			BOOLEAN DEFAULT FALSE;

	-- cadena para manipular el array	
	_str		TEXT;	
		
	_id_doc		doctores.id_doc%TYPE;
	
	_arr_1	INTEGER[];	
	_arr_2	INTEGER[];
	_arr_3	TEXT[];	
	_arr_4	TEXT[];

	_id_tip_mic_pac	tipos_micosis_pacientes.id_tip_mic_pac%TYPE;
	
BEGIN


	-- pacientes
	_id_his			:= _datos[1];
	_id_tip_mic		:= _datos[2];
	_str_enf_pac		:= _datos[3];
	_str_les		:= _datos[4];	
	_str_tip_est_mic	:= _datos[5];
	_str_chk_for_inf	:= _datos[6];


	_str_otr_enf_mic	:= _datos[7];
	_id_otr_enf_mic 	:= _datos[8];
	
	_id_otr_for_inf		:= _datos[9];
	_str_otr_for_inf	:= _datos[10];

	_str_data_otr		:= _datos[11];
	_str_data_otr_est	:= _datos[12];	
	_str_pos		:= _datos[13];
	_id_doc			:= _datos[14];
	
	
	-- tipos de micosis del paciente
	IF NOT EXISTS  (SELECT 1 FROM tipos_micosis_pacientes WHERE id_his = _id_his AND id_tip_mic = _id_tip_mic) THEN
		
		INSERT INTO tipos_micosis_pacientes(
			id_tip_mic,
			id_his
		) VALUES (
			_id_tip_mic,
			_id_his
		);
		_id_tip_mic_pac:= CURRVAL('tipos_micosis_pacientes_id_tip_mic_pac_seq');			
	ELSE 
		RETURN 0;
	END IF;

	-- enfermedades del paciente
	--DELETE FROM enfermedades_paciente WHERE id_tip_mic_pac = _id_tip_mic_pac;

	_arr_1 := STRING_TO_ARRAY(_str_enf_pac,',');
	IF (ARRAY_UPPER(_arr_1,1) > 0)THEN
		FOR i IN 1..(ARRAY_UPPER(_arr_1,1)) LOOP

			IF (_id_otr_enf_mic = _arr_1[i])THEN
				INSERT INTO enfermedades_pacientes (
					id_tip_mic_pac,
					id_enf_mic,
					otr_enf_mic					
				) VALUES (
					_id_tip_mic_pac,
					_arr_1[i],
					_str_otr_enf_mic
				);
			ELSE
				INSERT INTO enfermedades_pacientes (
					id_tip_mic_pac,
					id_enf_mic					
				) VALUES (
					_id_tip_mic_pac,
					_arr_1[i]
				);
			END IF;
		END LOOP;
	END IF;

	-- tipo de consulta del paciente referidos al historico
	--DELETE FROM lesiones_partes_cuerpo__paciente WHERE id_his = _id_his;

	_arr_3 := STRING_TO_ARRAY(_str_les,',');
	
	IF (ARRAY_UPPER(_arr_3,1) > 0)THEN

		_arr_str_data_otr = STRING_TO_ARRAY(_str_data_otr,',');			
		FOR i IN 1..(ARRAY_UPPER(_arr_3,1)) LOOP
			_bol_otr := FALSE;
			_arr_2 := STRING_TO_ARRAY(replace(replace(_arr_3[i],'(',''),')',''),';');
			
			IF (_arr_str_data_otr IS NOT NULL)THEN
				<<mifor>>
				FOR j IN 1..(ARRAY_UPPER(_arr_str_data_otr,1))LOOP			
				
					_arr_str_data_otr_elm := STRING_TO_ARRAY(_arr_str_data_otr[j],';');
					IF(_arr_str_data_otr_elm[1]::INTEGER = _arr_2[1] AND _arr_str_data_otr_elm[2]::INTEGER = _arr_2[2])THEN
						_str_data_otr := _arr_str_data_otr_elm[3];					
						_bol_otr := TRUE;
						EXIT mifor;
					END IF;
				END LOOP mifor;
			END IF;

			--coloca los comentarios de los otros en lesiones
			IF _bol_otr THEN

				INSERT INTO lesiones_partes_cuerpos__pacientes (
					id_tip_mic_pac,
					id_cat_cue_les,
					id_par_cue_cat_cue,
					otr_les_par_cue
				) VALUES (
					_id_tip_mic_pac,
					_arr_2[1],
					_arr_2[2],	
					_str_data_otr			
				);
			ELSE			
				INSERT INTO lesiones_partes_cuerpos__pacientes 
				(
					id_tip_mic_pac,
					id_cat_cue_les,
					id_par_cue_cat_cue
				) VALUES (
					_id_tip_mic_pac,
					_arr_2[1],
					_arr_2[2]				
				);
			END IF;
		END LOOP;
	END IF;

	-- insertando los tipos de estudios micologicos pertenecientes a la enfermedad que padece el paciente
	_arr_1 := STRING_TO_ARRAY(_str_tip_est_mic,',');
	IF (ARRAY_UPPER(_arr_1,1) > 0)THEN
		FOR i IN 1..(ARRAY_UPPER(_arr_1,1)) LOOP
			_bol_otr := TRUE;
			_arr_str_data_otr_est := STRING_TO_ARRAY(_str_data_otr_est,',');
			IF (_arr_str_data_otr_est IS NOT NULL)THEN
				<<for_estudios>>
				FOR j IN 1..(ARRAY_UPPER(_arr_str_data_otr_est,1))LOOP
					_arr_str_data_otr_elm_est := STRING_TO_ARRAY(_arr_str_data_otr_est[j],';');				
					IF(_arr_str_data_otr_elm_est[1]::INTEGER = _arr_1[i])THEN
						_bol_otr := FALSE;
						INSERT INTO tipos_micosis_pacientes__tipos_estudios_micologicos (
							id_tip_mic_pac,
							id_tip_est_mic,
							otr_tip_est_mic
						) VALUES (
							_id_tip_mic_pac,
							_arr_1[i],
							_arr_str_data_otr_elm_est[2]
						);
						EXIT for_estudios;
					END IF;
				END LOOP;
			END IF;
			IF (_bol_otr)THEN
				INSERT INTO tipos_micosis_pacientes__tipos_estudios_micologicos (
					id_tip_mic_pac,
					id_tip_est_mic					
				) VALUES (
					_id_tip_mic_pac,
					_arr_1[i]
				);
			END IF;
		END LOOP;
	END IF;

	-- insertando la forma de infeccion de enfermedades del paciente
	_arr_1 := STRING_TO_ARRAY(_str_chk_for_inf,',');
	IF (ARRAY_UPPER(_arr_1,1) > 0)THEN
		FOR i IN 1..(ARRAY_UPPER(_arr_1,1)) LOOP
			IF _id_otr_for_inf = _arr_1[i] THEN 
				INSERT INTO forma_infecciones__pacientes (
					id_tip_mic_pac,
					id_for_inf,
					otr_for_inf					
				) VALUES (
					_id_tip_mic_pac,
					_arr_1[i],
					_str_otr_for_inf
				);
			ELSE
			
				INSERT INTO forma_infecciones__pacientes (
					id_tip_mic_pac,
					id_for_inf					
				) VALUES (
					_id_tip_mic_pac,
					_arr_1[i]
				);
			END IF;
		END LOOP;
	END IF;
	
	/*Examenes del paciente */
	_arr_3 := STRING_TO_ARRAY(_str_pos,',');
	IF (ARRAY_UPPER(_arr_3,1) > 0)THEN
		FOR i IN 1..(ARRAY_UPPER(_arr_3,1)) LOOP
			_arr_4 := STRING_TO_ARRAY(_arr_3[i],';');
			INSERT INTO examenes_pacientes (id_tip_mic_pac,id_tip_exa, exa_pac_est) VALUES (_id_tip_mic_pac,_arr_4[1]::integer,_arr_4[2]::integer);
		END LOOP;
	END IF;		

	RETURN 1;

END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION med_insertar_micosis_pacientes(character varying[]) OWNER TO desarrollo_g;
COMMENT ON FUNCTION med_insertar_micosis_pacientes(character varying[]) IS '
NOMBRE: med_insertar_micosis_pacientes
TIPO: Function (store procedure)

PARAMETROS: Recibe 4 Parámetros
	
	1:  Id del historico del paciente.
	2:  Id tipo micosis paciente.
	3:  String de las enfermedades del paciente, separados por ","
	4:  String de las lesiones del paciente.
	5:  Id del doctor.	

DESCRIPCION: 
	Inserta las enfermedades y las lesiones del paciente

RETORNO:
	1: La función se ejecutó exitosamente	
	 
EJEMPLO DE LLAMADA:
	SELECT med_insertar_micosis_pacientes(ARRAY[ 
		''16'', 
		''1'', 
		''1,4,7,18'', 
		''(3;1),(22;1),(7;2),(22;2),(13;3),(23;3),(14;4),(23;4)'', 
		''1,3,5'', 
		'''', 
		''super mic'', 
		''18'', 
		''-1'', 
		'''', 
		''22;1;uno,22;2;dos,23;3;tres,23;4;cuatro'', 
		''32'',
		''63,demo''
	] ) AS result

AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 15/08/2011

AUTOR DE MODIFICACIÓN: Lisseth Lozada
FECHA DE MODIFICACIÓN: 29/12/2011

AUTOR DE MODIFICACIÓN: Luis Raul
FECHA DE MODIFICACIÓN: 29/12/2011
DESCRIPCIÓN: Estableciendo campo otros para los estudios micológicos
';
