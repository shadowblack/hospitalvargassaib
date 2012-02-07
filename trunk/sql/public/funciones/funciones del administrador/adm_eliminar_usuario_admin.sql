CREATE OR REPLACE FUNCTION adm_eliminar_usuario_admin(character varying[])
  RETURNS smallint AS
$BODY$
DECLARE
	--Variables
	_data 		ALIAS FOR $1;
	_id_usu_adm	usuarios_administrativos.id_usu_adm%TYPE;
	_id_usu_log	usuarios_administrativos.id_usu_adm%TYPE;
	_tra_usu	transacciones.cod_tip_tra%TYPE;

	_valorcampos 	VARCHAR := '';
	_reg_ant	RECORD;
	_reg_usu	RECORD;
	_reg_tra	RECORD;
BEGIN

	_id_usu_adm 	:= _data[1];
	_id_usu_log 	:= _data[2];
	_tra_usu	:= _data[3];

	
	IF EXISTS(SELECT 1 FROM usuarios_administrativos WHERE id_usu_adm = _id_usu_adm::INTEGER)THEN

		SELECT * INTO _reg_ant FROM usuarios_administrativos WHERE id_usu_adm = _id_usu_adm::INTEGER;

		/* Se coloca el encabezado para los valores de los campos, así como el tag raíz y el inicio del tag tabla */
		_valorcampos := '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?><eliminacion_usuarios_administrativos>
			 <tabla nombre="usuarios_administrativos">';
			_valorcampos := _valorcampos || 
			formato_campo_xml('Nombre', 		'ninguno', 	coalesce(_reg_ant.nom_usu_adm::text,'ninguno'))||
			formato_campo_xml('Apellido',  		'ninguno', 	coalesce(_reg_ant.ape_usu_adm::text,'ninguno'))||
			formato_campo_xml('Cédula', 		'ninguno', 	coalesce(_reg_ant.ced_usu_adm::text,'ninguno'))||
			formato_campo_xml('Usuario', 		'ninguno', 	coalesce(_reg_ant.log_usu_adm::text,'ninguno'))||
			formato_campo_xml('Teléfono', 		'ninguno', 	coalesce(_reg_ant.tel_usu_adm::text,'ninguno'))||
			formato_campo_xml('Correo', 		'ninguno', 	coalesce(_reg_ant.cor_usu_adm::text,'ninguno'));
			/*ªª Se cierra el tag de la tabla */
			_valorcampos := _valorcampos || '</tabla>';
		_valorcampos := _valorcampos || '</eliminacion_usuarios_administrativos>';

		/*Obtengo el Id del tipo de usuario deacuerdo al usuario logueado*/
		SELECT id_tip_usu_usu INTO _reg_usu 
		FROM tipos_usuarios__usuarios WHERE id_usu_adm = _id_usu_log;

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

		
		DELETE FROM usuarios_administrativos WHERE id_usu_adm = _id_usu_adm::INTEGER;
		RETURN 1;
	ELSE
		RETURN 0;
	END IF;

	
END;$BODY$
  LANGUAGE 'plpgsql' VOLATILE;
COMMENT ON FUNCTION adm_eliminar_usuario_admin(character varying[]) IS '
NOMBRE: adm_eliminar_usuario_admin
TIPO: Function (store procedure)

PARAMETROS: Recibe 7 Parámetros
	0:  El usuario no se encuentra registrado en el sistema
	1:  Se eliminó el usuario con éxito	

DESCRIPCION: 
	Elimina la información del usuario administrativo 

RETORNO:
	0: La función se ejecutó exitosamente
	
	 
EJEMPLO DE LLAMADA:
	SELECT adm_eliminar_usuario_admin(''1,2'');

AUTOR DE CREACIÓN: Lisseth Lozada
FECHA DE CREACIÓN: 27/03/2011      

AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 22/04/2011  
DESCRIPCIÓN: Modificación de las estructuras de control

AUTOR DE MODIFICACIÓN: Lisseth Lozada
FECHA DE MODIFICACIÓN: 06/02/2012
';
