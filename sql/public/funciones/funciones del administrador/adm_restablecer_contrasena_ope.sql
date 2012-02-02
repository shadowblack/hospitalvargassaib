-- Function: adm_restablecer_contrasena_ope(character varying[])

-- DROP FUNCTION adm_restablecer_contrasena_ope(character varying[]);

CREATE OR REPLACE FUNCTION adm_restablecer_contrasena_ope(character varying[])
  RETURNS smallint AS
$BODY$

DECLARE
	
	--Variables
	_data 		ALIAS FOR $1;
	_id_doc		doctores.id_doc%TYPE;
	_pas_doc	doctores.pas_doc%TYPE;

	_tra_usu	transacciones.cod_tip_tra%TYPE;
	_valorcampos 	VARCHAR := '';
	
	_reg_ant	RECORD;
	_reg_act	RECORD;
	_reg_usu	RECORD;
	_reg_tra	RECORD;

BEGIN
	_id_doc 	:= _data[1];
	_pas_doc 	:= _data[2];
	_tra_usu	:= _data[3];
	
	IF EXISTS(SELECT 1 FROM doctores WHERE id_doc = _id_doc)THEN

		/*Busco el registro anterior del usuario medico o operador*/
		SELECT * INTO _reg_ant FROM doctores WHERE id_doc = _id_doc;

		/*Restablecer contraseña del usuario medico o operador*/
		UPDATE doctores SET 		
			pas_doc = _pas_doc		
		WHERE id_doc = _id_doc;

		/*Busco el registro actual del usuario operador*/
		SELECT * INTO _reg_act FROM doctores WHERE id_doc = _id_doc;

		/* Se coloca el encabezado para los valores de los campos, así como el tag raíz y el inicio del tag tabla */
		_valorcampos := '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?><restablecer_contraseña>
			 <tabla nombre="doctores">';
			_valorcampos := _valorcampos || 
			formato_campo_xml('Nombre', 	coalesce(_reg_act.nom_doc::text, 'ninguno'), 	coalesce(_reg_ant.nom_doc::text,'ninguno'))||
			formato_campo_xml('Apellido',  	coalesce(_reg_act.ape_doc::text, 'ninguno'), 	coalesce(_reg_ant.ape_doc::text,'ninguno'))||
			formato_campo_xml('Cédula', 	coalesce(_reg_act.ced_doc::text, 'ninguno'), 	coalesce(_reg_ant.ced_doc::text,'ninguno'))||
			formato_campo_xml('Contraseña', coalesce(_reg_act.pas_doc::text, 'ninguno'), 	coalesce(_reg_ant.pas_doc::text,'ninguno'));
			/*ªª Se cierra el tag de la tabla */
			_valorcampos := _valorcampos || '</tabla>';
		_valorcampos := _valorcampos || '</restablecer_contraseña>';

			
		/*Obtengo el Id del tipo de usuario deacuerdo al usuario logueado*/
		SELECT id_tip_usu_usu INTO _reg_usu FROM tipos_usuarios__usuarios WHERE  id_doc = _id_doc;

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
ALTER FUNCTION adm_restablecer_contrasena_ope(character varying[]) OWNER TO desarrollo_g;
COMMENT ON FUNCTION adm_restablecer_contrasena_ope(character varying[]) IS '
NOMBRE: adm_restablecer_contrasena_ope
TIPO: Function (store procedure)

PARAMETROS: Recibe 3 Parámetros
	1:  Id del usuario medico o operador
	2:  Nueva contraseña del usuario medico o operador. Por defecto "Ope123456"
	3:  Código de la transacción
DESCRIPCION: 
	Restablecer contraseña del usuario medico o operador. 

RETORNO:
	1: La función se ejecutó exitosamente
	0: No existe el usuario medico o operador a restablecer contraseña

EJEMPLO DE LLAMADA:
	   SELECT adm_restablecer_contrasena_ope(ARRAY[
                        ''37'',
                        ''25aa1214846cab21e6a4fb96089e1f00'',
                        ''RCO''                                 
                    ]) AS result


AUTOR DE CREACIÓN: Lisseth Lozada
FECHA DE CREACIÓN: 01/02/2012
';