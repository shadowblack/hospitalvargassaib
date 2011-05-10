CREATE OR REPLACE FUNCTION adm_registrar_medico(character varying[])
  RETURNS smallint AS
$BODY$
DECLARE
	datos ALIAS 	FOR $1;

	_nom_doc 	doctores.nom_doc%TYPE;
	_ape_doc 	doctores.ape_doc%TYPE;
	_pas_doc	doctores.pas_doc%TYPE;
	_log_doc	doctores.log_doc%TYPE;
	_tel_doc 	doctores.tel_doc%TYPE;
	_trans_doc	TEXT; 		-- transacciones a las cuales tiene permiso el doctor, o mejor dicho niveles de acceso
	_arr_trans_doc	INTEGER[]; 	-- transacciones a las cuales tiene permiso el doctor, o mejor dicho niveles de acceso
	_vr_tip_usu 	RECORD;
	
	
BEGIN

	_nom_doc 	:= datos[1];
	_ape_doc 	:= datos[2];
	_pas_doc	:= md5(datos[3]);	
	_log_doc 	:= datos[4];
	_tel_doc 	:= datos[5];
	_trans_doc	:= datos[6];
		
	/* El usuario administrativo puede ser registrado */
	IF NOT EXISTS (SELECT 1 FROM doctores WHERE log_doc = _log_doc) THEN     		
		
		/*Inserta registro en la tabla usuarios_administrativos*/
		INSERT INTO doctores
		(
			nom_doc,
			ape_doc,
			pas_doc,
			log_doc,
			tel_doc,			
			fec_reg_doc			
		)
		VALUES 
		(
			_nom_doc,
			_ape_doc,
			_pas_doc,
			_log_doc,
			_tel_doc,			
			NOW()			
		);		
		
		/*Insertando tipo de usuario como administrador*/
		INSERT INTO tipos_usuarios__usuarios(
			id_doc ,
			id_tip_usu
		)VALUES
		(
			(CURRVAL('doctores_id_doc_seq')),
			(SELECT id_tip_usu FROM tipos_usuarios WHERE cod_tip_usu = 'med')
		);

		/* Insertando las transacciones del usuario*/
		_arr_trans_doc := STRING_TO_ARRAY(_trans_doc,',');
		IF (ARRAY_UPPER(_arr_trans_doc,1) > 0)THEN
			FOR i IN 1..(ARRAY_UPPER(_arr_trans_doc,1)) LOOP
				INSERT INTO transacciones_usuarios(
					id_tip_usu_usu,
					id_tip_tra
				)
				VALUES
				(
					(CURRVAL('tipos_usuarios__usuarios_id_tip_usu_usu_seq')),
					_arr_trans_doc[i]
				);
			END LOOP;
		END IF;

		-- La función se ejecutó exitosamente
		RETURN 1;
		
	
	ELSE
		-- Existe un usuario administrativo con el mismo login
		RETURN 0;
	END IF;

END;$BODY$
  LANGUAGE 'plpgsql' VOLATILE;
COMMENT ON FUNCTION adm_registrar_medico(character varying[]) IS '
NOMBRE: adm_registrar_medico
TIPO: Function (store procedure)

PARAMETROS: Recibe 6 Parámetros
	1:  Nombre del usuario doctor
	2:  Apellido del usuario doctor
	3:  Password del usuario doctor	
	4:  Login del usuario doctor
	5:  Teléfono del usuario doctor
	6:  Tipo de usuario (id_tip_usu_usu Usuarios, desde la tabla tipos_usuarios_usuarios)

DESCRIPCION: 
	Almacena la información del usuario administrativo 

RETORNO:
	1: La función se ejecutó exitosamente
	0: Existe un usuario administrativo con el mismo login
	 
EJEMPLO DE LLAMADA:
	SELECT adm_registrar_medico(ARRAY[''Lisseth'', ''Lozada'', ''123'', ''llozada'',''04269150722'',''1,2,3'']);

AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 04/05/2011

';

--SELECT adm_registrar_medico(ARRAY['Lisseth', 'Lozada', '123', 'llozada3','04269150722']);
