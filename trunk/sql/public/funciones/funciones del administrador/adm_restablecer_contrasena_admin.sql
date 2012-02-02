-- Function: adm_restablecer_contrasena_admin(character varying[])

-- DROP FUNCTION adm_restablecer_contrasena_admin(character varying[]);

CREATE OR REPLACE FUNCTION adm_restablecer_contrasena_admin(character varying[])
  RETURNS smallint AS
$BODY$

DECLARE
	
	--Variables
	_data 		ALIAS FOR $1;
	_id_usu_adm	usuarios_administrativos.id_usu_adm%TYPE;
	_pas_usu_adm	usuarios_administrativos.pas_usu_adm%TYPE;

	_tra_usu	transacciones.cod_tip_tra%TYPE;
	_valorcampos 	VARCHAR := '';
	
	_reg_ant	RECORD;
	_reg_act	RECORD;
	_reg_usu	RECORD;
	_reg_tra	RECORD;

BEGIN
	_id_usu_adm 	:= _data[1];
	_pas_usu_adm 	:= _data[2];
	_tra_usu	:= _data[3];
	
	IF EXISTS(SELECT 1 FROM usuarios_administrativos WHERE id_usu_adm = _id_usu_adm)THEN

		/*Busco el registro anterior del usuario administrador*/
		SELECT * INTO _reg_ant FROM usuarios_administrativos WHERE id_usu_adm = _id_usu_adm;

		/*Restablecer contraseña del usuario administrador*/
		UPDATE usuarios_administrativos SET 		
			pas_usu_adm = _pas_usu_adm				
		WHERE id_usu_adm = _id_usu_adm;

		/*Busco el registro actual del usuario administrador*/
		SELECT * INTO _reg_act FROM usuarios_administrativos WHERE id_usu_adm = _id_usu_adm;

		/* Se coloca el encabezado para los valores de los campos, así como el tag raíz y el inicio del tag tabla */
		_valorcampos := '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?><restablecer_contraseña>
			 <tabla nombre="usuarios_administrativos">';
			_valorcampos := _valorcampos || 
			formato_campo_xml('Nombre', 	coalesce(_reg_act.nom_usu_adm::text, 'ninguno'), 	coalesce(_reg_ant.nom_usu_adm::text,'ninguno'))||
			formato_campo_xml('Apellido',  	coalesce(_reg_act.ape_usu_adm::text, 'ninguno'), 	coalesce(_reg_ant.ape_usu_adm::text,'ninguno'))||
			formato_campo_xml('Cédula', 	coalesce(_reg_act.ced_usu_adm::text, 'ninguno'), 	coalesce(_reg_ant.ced_usu_adm::text,'ninguno'))||
			formato_campo_xml('Contraseña', coalesce(_reg_act.pas_usu_adm::text, 'ninguno'), 	coalesce(_reg_ant.pas_usu_adm::text,'ninguno'));
			/*ªª Se cierra el tag de la tabla */
			_valorcampos := _valorcampos || '</tabla>';
		_valorcampos := _valorcampos || '</restablecer_contraseña>';

			
		/*Obtengo el Id del tipo de usuario deacuerdo al usuario logueado*/
		SELECT id_tip_usu_usu INTO _reg_usu FROM tipos_usuarios__usuarios WHERE  id_usu_adm = _id_usu_adm;

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
		
		RETURN 1;
	ELSE
		RETURN 0;
	END IF;

	
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION adm_restablecer_contrasena_admin(character varying[]) OWNER TO desarrollo_g;
COMMENT ON FUNCTION adm_restablecer_contrasena_admin(character varying[]) IS '
NOMBRE: adm_restablecer_contrasena_admin
TIPO: Function (store procedure)

PARAMETROS: Recibe 3 Parámetros
	1:  Id del usuario administrador
	2:  Nueva contraseña del usuario administrador. Por defecto "Admin123456"
	3:  Código de la transacción
DESCRIPCION: 
	Restablecer contraseña del usuario administrativo 

RETORNO:
	1: La función se ejecutó exitosamente
	0: No existe el usuario administrador a restablecer contraseña

EJEMPLO DE LLAMADA:
	   SELECT adm_restablecer_contrasena_admin(ARRAY[
                        ''28'',
			''be05977add575832dc52655d4ad5c42e'',
			''RCA''                                 
                    ]) AS result;


AUTOR DE CREACIÓN: Lisseth Lozada
FECHA DE CREACIÓN: 01/02/2012
';
