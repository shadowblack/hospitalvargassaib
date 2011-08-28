CREATE OR REPLACE FUNCTION med_eliminar_paciente(character varying[])
  RETURNS smallint AS
$BODY$
DECLARE
	
	--Variables
	_data 		ALIAS FOR $1;
	_id_pac		pacientes.id_pac%TYPE;
	_id_doc		doctores.id_doc%TYPE;
	_tra_usu	transacciones.cod_tip_tra%TYPE;

	_valorcampos 	VARCHAR := '';
	_des_ant_per_ant VARCHAR := '';	

	_reg_pac	RECORD;
	_reg_ant	RECORD;
	_reg_usu	RECORD;
	_reg_tra	RECORD;

BEGIN
	_id_pac 	:= _data[1];
	_id_doc 	:= _data[2];
	_tra_usu	:= _data[3];
	
	IF EXISTS(SELECT 1 FROM pacientes WHERE id_pac = _id_pac::INTEGER)THEN

		/*Busco el registro anterior del paciente*/
		SELECT 	id_pac,ape_pac,nom_pac,ced_pac,fec_nac_pac,tel_hab_pac,tel_cel_pac,ciu_pac,id_pai,id_est,id_mun, 
			CASE 
				WHEN nac_pac = '1' THEN 'Venezolano' ELSE 'Extranjero' 
			END AS nac_pac,
			CASE 
				WHEN ocu_pac = '1' THEN 'Profesional'
				WHEN ocu_pac = '2' THEN 'Técnico'
				WHEN ocu_pac = '3' THEN 'Obrero'
				WHEN ocu_pac = '4' THEN 'Agricultor'
				WHEN ocu_pac = '5' THEN 'Jardinero'
				WHEN ocu_pac = '6' THEN 'Otro'
			END AS ocu_pac  INTO _reg_pac
		FROM pacientes 
		WHERE id_pac = _id_pac;
		
				
		/*Busco la descripción del país, estado y municipio*/
		SELECT des_pai, des_est, des_mun INTO _reg_ant
		FROM paises p
			LEFT JOIN estados e ON(p.id_pai = e.id_pai)
			LEFT JOIN municipios m ON(e.id_est = m.id_est)
		WHERE p.id_pai = _reg_pac.id_pai
			AND e.id_est = _reg_pac.id_est
			AND m.id_mun = _reg_pac.id_mun;

		/* Se coloca el encabezado para los valores de los campos, así como el tag raíz y el inicio del tag tabla */
		_valorcampos := '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?><eliminacion_de_pacientes>
				 <tabla nombre="pacientes">';
				_valorcampos := _valorcampos || 
				formato_campo_xml('ID', 		'ninguno', 	coalesce(_reg_pac.id_pac::text, 'ninguno'))||
				formato_campo_xml('Nombre',  		'ninguno', 	coalesce(_reg_pac.nom_pac::text, 'ninguno'))||
				formato_campo_xml('Apellido', 		'ninguno', 	coalesce(_reg_pac.ape_pac::text, 'ninguno'))||
				formato_campo_xml('Cédula', 		'ninguno', 	coalesce(_reg_pac.ced_pac::text, 'ninguno'))||  
				formato_campo_xml('Fecha Nacimiento', 	'ninguno', 	coalesce(_reg_pac.fec_nac_pac::text, 'ninguno'))||  
				formato_campo_xml('Nacionalidad', 	'ninguno', 	coalesce(_reg_pac.nac_pac::text, 'ninguno'))||  
				formato_campo_xml('Teléfono Habitación','ninguno', 	coalesce(_reg_pac.tel_hab_pac::text, 'ninguno'))||
				formato_campo_xml('Teléfono Célular', 	'ninguno', 	coalesce(_reg_pac.tel_cel_pac::text, 'ninguno'))|| 
				formato_campo_xml('Ocupación', 		'ninguno', 	coalesce(_reg_pac.ocu_pac::text, 'ninguno'))||
				formato_campo_xml('País', 		'ninguno', 	coalesce(_reg_ant.des_pai::text, 'ninguno'))||
				formato_campo_xml('Estado', 		'ninguno', 	coalesce(_reg_ant.des_est::text, 'ninguno'))||
				formato_campo_xml('Municipio', 		'ninguno', 	coalesce(_reg_ant.des_mun::text, 'ninguno'))||
				formato_campo_xml('Ciudad', 		'ninguno', 	coalesce(_reg_pac.ciu_pac::text, 'ninguno'));  
			/*ªª Se cierra el tag de la tabla */
			_valorcampos := _valorcampos || '</tabla>';

			/*Busco el registro anterior del nombre antecedente personal*/
			FOR _reg_ant IN (SELECT nom_ant_per FROM antecedentes_pacientes LEFT JOIN antecedentes_personales USING(id_ant_per) WHERE id_pac = _id_pac) LOOP
				_des_ant_per_ant := _des_ant_per_ant || _reg_ant.nom_ant_per || ' ,';
			END LOOP;

			/* Se le quita la última de las comas a la variable */
			IF length(_des_ant_per_ant) > 0 THEN
				_des_ant_per_ant := substr(_des_ant_per_ant, 1, length(_des_ant_per_ant) - 1);
			END IF;

			/* Se identifica la tabla en el formato xml */
			_valorcampos := _valorcampos || '<tabla nombre="antecedentes_pacientes">';
			/* Se completa el tag con el valor del campo */
				_valorcampos := _valorcampos || 
				formato_campo_xml('Antecedentes Personales', 'ninguno', coalesce(_des_ant_per_ant::text));
			/* Se cierra el tag de la tabla */
			_valorcampos := _valorcampos || '</tabla>';
			
		_valorcampos := _valorcampos || '</eliminacion_de_pacientes>';	
		
			
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

		DELETE FROM pacientes WHERE id_pac = _id_pac::INTEGER;
		
		RETURN 1;
	ELSE
		RETURN 0;
	END IF;

	
END;$BODY$
  LANGUAGE 'plpgsql' VOLATILE;
COMMENT ON FUNCTION med_eliminar_paciente(character varying[]) IS '
NOMBRE: med_eliminar_paciente
TIPO: Function (store procedure)

PARAMETROS: Recibe 2 Parámetros
	1:  Id del paciente a eliminar
	2:  Id del doctor que se encuentra actualmente logueado	
	3:  Código de la transaccion
	
DESCRIPCION: 
	Elimina la información del usuario administrativo 

RETORNO:
	1: La función se ejecutó exitosamente
	0: No existe el paciente a eliminar

EJEMPLO DE LLAMADA:
	SELECT adm_eliminar_usuario_admin(ARRAY[''1'',''2'',''EP'']);


AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 22/04/2011 
DESCRIPCIÓN: Eliminacion de los pacientes

AUTOR DE MODIFICACIÓN: Lisseth Lozada
FECHA DE MODIFICACIÓN: 21/08/2011
DESCRIPCIÓN: Se agregó en la función el armado del xml para la inserción de la auditoría de las transacciones.
';
/*
            
SELECT med_eliminar_paciente(ARRAY[
                '62',
                '32',
                'EP']
            ) AS result

*/