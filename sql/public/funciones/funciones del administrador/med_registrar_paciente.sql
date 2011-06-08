CREATE OR REPLACE FUNCTION med_registrar_paciente(character varying[])
  RETURNS smallint AS
$BODY$
DECLARE
	_datos ALIAS 	FOR $1;

	_nom_pac 	pacientes.nom_pac%TYPE;
	_ape_pac 	pacientes.ape_pac%TYPE;
	_ced_pac	pacientes.ced_pac%TYPE;
	_fec_nac_pac 	pacientes.fec_nac_pac%TYPE;
	_nac_pac 	pacientes.nac_pac%TYPE;
	_tel_hab_pac	pacientes.tel_hab_pac%TYPE;
	_tel_cel_pac	pacientes.tel_cel_pac%TYPE;
	_ocu_pac	pacientes.ocu_pac%TYPE;
	_ciu_pac	pacientes.ciu_pac%TYPE;
	_id_pai		pacientes.id_pai%TYPE;
	_id_est		pacientes.id_est%TYPE;
	_id_num		pacientes.id_num%TYPE;
	_id_par		pacientes.id_par%TYPE;
	
	_vr_tip_usu 	RECORD;
	
BEGIN
	-- pacientes
	_nom_pac 	_datos[1];
	_ape_pac 	_datos[2];
	_ced_pac	_datos[3];
	_fec_nac_pac 	_datos[4];
	_nac_pac 	_datos[5];
	_tel_hab_pac	_datos[6];
	_tel_cel_pac	_datos[7];
	_ocu_pac	_datos[8];
	_ciu_pac	_datos[9];
	_id_pai		_datos[10];
	_id_est		_datos[10];
	_id_num		_datos[12];
	_id_par		_datos[13];

	-- centros de salud pacientes
	

	/* validando pacientes */
	IF NOT EXISTS (SELECT 1 FROM pacientes WHERE ced_pac = _ced_pac) THEN     		
		
		/*insertando pacientes*/
		INSERT INTO usuarios_administrativos
		(
			_nom_pac 	
			_ape_pac 	
			_ced_pac	
			_fec_nac_pac 	
			_nac_pac 	
			_tel_hab_pac	
			_tel_cel_pac	
			_ocu_pac	
			_ciu_pac	
			_id_pai		
			_id_est		
			_id_num		
			_id_par		
		)
		VALUES 
		(
			nom_pac 	
			ape_pac 	
			ced_pac	
			fec_nac_pac 	
			nac_pac 	
			tel_hab_pac	
			tel_cel_pac	
			ocu_pac	
			ciu_pac	
			id_pai		
			id_est		
			id_num		
			id_par		
		);		
		
		/*Insertando tipo de usuario como administrador*/
		INSERT INTO tipos_usuarios__usuarios(
			id_usu_adm,
			id_tip_usu
		)VALUES
		(
			(CURRVAL('usuarios_administrativos_id_usu_adm_seq')),
			(SELECT id_tip_usu FROM tipos_usuarios WHERE cod_tip_usu = 'adm')
		);

		-- La función se ejecutó exitosamente
		RETURN 1;
		
	
	ELSE
		-- Existe un usuario administrativo con el mismo login
		RETURN 0;
	END IF;

END;$BODY$
  LANGUAGE 'plpgsql' VOLATILE;
COMMENT ON FUNCTION med_registrar_paciente(character varying[]) IS '
NOMBRE: adm_registrar_usuario_admin
TIPO: Function (store procedure)

PARAMETROS: Recibe 7 Parámetros
	1:  Nombre del usuario administrativo
	2:  Apellido del usuario administrativo
	3:  Password del usuario administrativo
	4:  Repetición del Password del usuario administrativo
	5:  Login del usuario administrativo
	6:  Teléfono del usuario administrativo
	7:  Tipo de usuario

DESCRIPCION: 
	Almacena la información del usuario administrativo 

RETORNO:
	1: La función se ejecutó exitosamente
	0: Existe un usuario administrativo con el mismo login
	 
EJEMPLO DE LLAMADA:
	SELECT adm_registrar_usuario_admin(ARRAY[''Lisseth'', ''Lozada'', ''123'', ''llozada'',''04269150722'',1]);

AUTOR DE CREACIÓN: Lisseth Lozada
FECHA DE CREACIÓN: 27/03/2011

';

--SELECT adm_registrar_usuario_admin(ARRAY['Lisseth', 'Lozada', '123', 'llozada2','04269150722']);
