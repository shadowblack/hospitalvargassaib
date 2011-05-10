CREATE OR REPLACE FUNCTION adm_modificar_medico(character varying[])
  RETURNS smallint AS
$BODY$
DECLARE
	datos ALIAS 	FOR $1;
	_id_doc		doctores.id_doc%TYPE;
	_nom_doc 	doctores.nom_doc%TYPE;
	_ape_doc 	doctores.ape_doc%TYPE;
	_pas_doc	doctores.pas_doc%TYPE;
	_log_doc	doctores.log_doc%TYPE;
	_tel_doc 	doctores.tel_doc%TYPE;
	_trans_doc	TEXT; 		-- transacciones a las cuales tiene permiso el doctor, o mejor dicho niveles de acceso
	_arr_trans_doc	INTEGER[]; 	-- transacciones a las cuales tiene permiso el doctor, o mejor dicho niveles de acceso
	_vr_tip_usu 	RECORD;

	_id_tip_usu_usu	INTEGER;
	
BEGIN

	_id_doc		:= datos[1];
	_log_doc 	:= datos[2];
	_nom_doc 	:= datos[3];
	_ape_doc 	:= datos[4];
	_pas_doc	:= md5(datos[5]);		
	_tel_doc 	:= datos[6];
	_trans_doc	:= datos[7];
	
	
	IF EXISTS(SELECT 1 FROM doctores WHERE id_doc = _id_doc)THEN
		/* El usuario administrativo puede ser registrado */
		IF NOT EXISTS (SELECT 1 FROM doctores WHERE log_doc = _log_doc AND id_doc <> _id_doc) THEN     					
			/*Inserta registro en la tabla usuarios_administrativos*/	

			UPDATE doctores SET 
				nom_doc = _nom_doc,
				ape_doc = _ape_doc,
				pas_doc = _pas_doc,
				log_doc = _log_doc,
				tel_doc = _tel_doc					
			
			WHERE 
			id_doc = _id_doc
			;
			
			/* Insertando las transacciones del usuario*/
			_id_tip_usu_usu := (SELECT id_tip_usu_usu FROM tipos_usuarios__usuarios WHERE id_doc = _id_doc);
			DELETE FROM transacciones_usuarios WHERE id_tip_usu_usu = _id_tip_usu_usu;	
			
			_arr_trans_doc := STRING_TO_ARRAY(_trans_doc,',');
					
			IF (ARRAY_UPPER(_arr_trans_doc,1) > 0)THEN							
				FOR i IN 1..(ARRAY_UPPER(_arr_trans_doc,1)) LOOP
					INSERT INTO transacciones_usuarios(
						id_tip_usu_usu,
						id_tip_tra
					)
					VALUES
					(					
						_id_tip_usu_usu,
						_arr_trans_doc[i]
					);
				END LOOP;
			END IF;

			-- La función se ejecutó exitosamente
			RETURN 1;
			
		
		ELSE
			-- Existe un usuario administrativo con el mismo login
			RETURN 2;
		END IF;
	ELSE
		RETURN 0;
	END IF;

END;$BODY$
  LANGUAGE 'plpgsql' VOLATILE;
COMMENT ON FUNCTION adm_modificar_medico(character varying[]) IS '
NOMBRE: adm_modificar_medico
TIPO: Function (store procedure)

PARAMETROS: Recibe 7 Parámetros
	1:  Id del usuario doctor
	2:  Nombre del usuario doctor
	3:  Apellido del usuario doctor
	4:  Password del usuario doctor	
	5:  Login del usuario doctor
	6:  Teléfono del usuario doctor
	7:  Tipo de usuario (id_tip_usu_usu Usuarios, desde la tabla tipos_usuarios_usuarios)

DESCRIPCION: 
	Almacena la información del doctor

RETORNO:
	1: La función se ejecutó exitosamente
	0: Existe un usuario administrativo con el mismo login
	 
EJEMPLO DE LLAMADA:
	SELECT adm_modificar_medico(ARRAY[''1'',''Lisseth'', ''Lozada'', ''123'', ''llozada'',''04269150722'',''1,2,3'']);

AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 09/05/2011

';

--SELECT adm_modificar_medico(ARRAY['1','Lisseth', 'Lozada', '123', 'llozada3','04269150722','1']);
