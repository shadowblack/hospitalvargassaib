CREATE OR REPLACE FUNCTION med_registrar_informacion_adicional(character varying[])
  RETURNS smallint AS
$BODY$
DECLARE
	_datos ALIAS FOR $1;

	-- informacion del paciente	
	_str_cen_sal	TEXT;
	_str_tip_con	TEXT;
	_str_con_ani	TEXT;
	_str_tra_pre	TEXT;
	_tie_evo	tiempo_evoluciones.tie_evo%TYPE;
	_id_doc		doctores.id_doc%TYPE;

	_id_his		historiales_pacientes.id_his%TYPE;
		
	_arr	INTEGER[];	
	
	
	
BEGIN
	-- pacientes
	_id_his			:= _datos[1];	
	_str_cen_sal		:= _datos[2];	
	_str_tip_con		:= _datos[3];	
	_str_con_ani		:= _datos[4];	
	_str_tra_pre		:= _datos[5];	
	_tie_evo		:= _datos[6];	
	_id_doc			:= _datos[7];	

	-- centro de salud del paciente referidos al historico
	DELETE FROM centro_salud_pacientes WHERE id_his = _id_his;

	_arr := STRING_TO_ARRAY(_str_cen_sal,',');
	IF (ARRAY_UPPER(_arr,1) > 0)THEN
		FOR i IN 1..(ARRAY_UPPER(_arr,1)) LOOP
			INSERT INTO centro_salud_pacientes (
				id_his,
				id_cen_sal					
			) VALUES (
				_id_his,
				_arr[i]
			);
		END LOOP;
	END IF;

	-- tipo de consulta del paciente referidos al historico
	DELETE FROM tipos_consultas_pacientes WHERE id_his = _id_his;

	_arr := STRING_TO_ARRAY(_str_tip_con,',');
	IF (ARRAY_UPPER(_arr,1) > 0)THEN
		FOR i IN 1..(ARRAY_UPPER(_arr,1)) LOOP
			INSERT INTO tipos_consultas_pacientes (
				id_his,
				id_tip_con					
			) VALUES (
				_id_his,
				_arr[i]
			);
		END LOOP;
	END IF;

	-- contacto animales del paciente referidos al historico
	DELETE FROM contactos_animales WHERE id_his = _id_his;

	_arr := STRING_TO_ARRAY(_str_con_ani,',');
	IF (ARRAY_UPPER(_arr,1) > 0)THEN
		FOR i IN 1..(ARRAY_UPPER(_arr,1)) LOOP
			INSERT INTO contactos_animales (
				id_his,
				id_ani					
			) VALUES (
				_id_his,
				_arr[i]
			);
		END LOOP;
	END IF;	

	-- contacto animales del paciente referidos al historico
	DELETE FROM tratamientos_pacientes WHERE id_his = _id_his;

	_arr := STRING_TO_ARRAY(_str_tra_pre,',');
	IF (ARRAY_UPPER(_arr,1) > 0)THEN
		FOR i IN 1..(ARRAY_UPPER(_arr,1)) LOOP
			INSERT INTO tratamientos_pacientes (
				id_his,
				id_tra					
			) VALUES (
				_id_his,
				_arr[i]
			);
		END LOOP;
	END IF;
	
	-- centros de salud pacientes
	
	/* insertando tiempo de evoluciones */	
	IF NOT EXISTS (SELECT 1 FROM tiempo_evoluciones WHERE id_his = _id_his::integer) THEN  
		INSERT INTO tiempo_evoluciones(
			id_his,
			tie_evo
		) VALUES (
			_id_his,
			_tie_evo
		);
	ELSE
		UPDATE tiempo_evoluciones SET 
			tie_evo = _tie_evo
		WHERE id_his = _id_his ;
	END IF;

	RETURN 1;

END;$BODY$
  LANGUAGE 'plpgsql' VOLATILE;
ALTER FUNCTION med_registrar_informacion_adicional(character varying[]) OWNER TO desarrollo_g;
COMMENT ON FUNCTION med_registrar_informacion_adicional(character varying[]) IS '
NOMBRE: med_registrar_informacion_adicional
TIPO: Function (store procedure)

PARAMETROS: Recibe 7 Parámetros
	1:  Id del historico del paciente
	2:  Centro de salud del pacient
	3:  Tipo de consulta
	4:  Contacto con animales
	5:  Tratamientos previos
	6:  Tiempo de evolución
	7:  Id del usuario logueado, en este caso el doctor		

DESCRIPCION: 
	Modifica la información adicional de los pacientes

RETORNO:
	1: La función se ejecutó exitosamente	
	 
EJEMPLO DE LLAMADA:
	SELECT med_registrar_informacion_adicional(ARRAY[
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
FECHA DE CREACIÓN: 09/06/2011

';
