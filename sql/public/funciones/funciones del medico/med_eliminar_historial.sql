CREATE OR REPLACE FUNCTION med_eliminar_historial(character varying[])
  RETURNS smallint AS
$BODY$
DECLARE
	
	--Variables
	_data 		ALIAS FOR $1;
	_id_his		historiales_pacientes.id_his%TYPE;
	_id_doc		historiales_pacientes.id_doc%TYPE;

	_tra_usu	transacciones.cod_tip_tra%TYPE;

	_valorcampos 	VARCHAR := '';
	_reg_ant	RECORD;
	_reg_usu	RECORD;
	_reg_tra	RECORD;

BEGIN
	_id_his 	:= _data[1];
	_id_doc 	:= _data[2];
	_tra_usu	:= _data[3];
	
	IF EXISTS(SELECT 1 FROM historiales_pacientes WHERE id_his = _id_his::INTEGER)THEN

		/*Busco el registro anterior del historial del paciente*/
		SELECT nom_pac,ape_pac,ced_pac,des_his,des_adi_pac_his,fec_his INTO _reg_ant
		FROM historiales_pacientes LEFT JOIN pacientes USING(id_pac) 
		WHERE id_his = _id_his;

		/* Se coloca el encabezado para los valores de los campos, así como el tag raíz y el inicio del tag tabla */
		_valorcampos := '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?><eliminacion_del_historial_paciente>
			 <tabla nombre="historiales_pacientes">';
			_valorcampos := _valorcampos || 
			formato_campo_xml('Nombre Paciente', 		'ninguno', 	coalesce(_reg_ant.nom_pac::text,'ninguno'))||
			formato_campo_xml('Apellido Paciente',  	'ninguno', 	coalesce(_reg_ant.ape_pac::text,'ninguno'))||
			formato_campo_xml('Cédula Paciente', 		'ninguno', 	coalesce(_reg_ant.ced_pac::text,'ninguno'))||
			formato_campo_xml('Descripción de la Historia', 'ninguno', 	coalesce(_reg_ant.des_his::text,'ninguno'))||
			formato_campo_xml('Descripción Adicional', 	'ninguno', 	coalesce(_reg_ant.des_adi_pac_his::text,'ninguno'))||
			formato_campo_xml('Fecha de Historia', 		'ninguno', 	coalesce(_reg_ant.fec_his::text,'ninguno'));
			/*ªª Se cierra el tag de la tabla */
			_valorcampos := _valorcampos || '</tabla>';
		_valorcampos := _valorcampos || '</eliminacion_del_historial_paciente>';	

			
		/*Obtengo el Id del tipo de usuario deacuerdo al usuario logueado*/
		SELECT id_tip_usu_usu INTO _reg_usu FROM tipos_usuarios__usuarios WHERE id_doc = _id_doc;

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
		
		DELETE FROM historiales_pacientes WHERE id_his = _id_his::INTEGER;
		RETURN 1;
	ELSE
		RETURN 0;
	END IF;

	
END;$BODY$
  LANGUAGE 'plpgsql' VOLATILE;
  ALTER FUNCTION med_eliminar_historial(character varying[]) OWNER TO desarrollo_g;
COMMENT ON FUNCTION med_eliminar_historial(character varying[]) IS '
NOMBRE: med_eliminar_historial
TIPO: Function (store procedure)

PARAMETROS: Recibe 2 Parámetros
	1:  Id del Historial a eliminar
	2:  Id del doctor que se encuentra actualmente logueado	
	3:  Código de la transacción
DESCRIPCION: 
	Elimina la información del usuario administrativo 

RETORNO:
	1: La función se ejecutó exitosamente
	0: No existe el historial a eliminar

EJEMPLO DE LLAMADA:
	SELECT adm_eliminar_usuario_admin(ARRAY[''16'',''32'',''EHP'']);


AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 01/07/2011 
DESCRIPCIÓN: Eliminacion de los historicos

AUTOR DE MODIFICACIÓN: Lisseth Lozada
FECHA DE MODIFICACIÓN: 23/08/2011
DESCRIPCIÓN: Se agregó en la función el armado del xml para la inserción de la auditoría de las transacciones.
';

/*

SELECT med_eliminar_historial(ARRAY[
                '16',
                '32',
                'EHP'
            ]) AS result
*/