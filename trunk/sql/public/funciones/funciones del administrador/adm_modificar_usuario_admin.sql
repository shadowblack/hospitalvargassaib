-- Function: adm_modificar_usuario_admin(character varying[])

-- DROP FUNCTION adm_modificar_usuario_admin(character varying[]);

CREATE OR REPLACE FUNCTION adm_modificar_usuario_admin(character varying[])
  RETURNS smallint AS
$BODY$
DECLARE
	datos ALIAS 	FOR $1;

	_id_usu_adm 	usuarios_administrativos.id_usu_adm%TYPE;
	_nom_usu_adm 	usuarios_administrativos.nom_usu_adm%TYPE;
	_ced_usu_adm 	usuarios_administrativos.ced_usu_adm%TYPE;
	_ape_usu_adm 	usuarios_administrativos.ape_usu_adm%TYPE;
	_tel_usu_adm 	usuarios_administrativos.tel_usu_adm%TYPE;
	_log_usu_adm 	usuarios_administrativos.log_usu_adm%TYPE;
	_cor_usu_adm	usuarios_administrativos.cor_usu_adm%TYPE;

	_trans_adm	TEXT; 		-- transacciones a las cuales tiene permiso el administrador, o mejor dicho niveles de acceso
	_arr_trans_adm	INTEGER[]; 	-- transacciones a las cuales tiene permiso el administrador, o mejor dicho niveles de acceso
	_id_tip_usu_usu	INTEGER;

	--Variable record
	_var_rec	RECORD;

BEGIN
	_id_usu_adm	:= datos[1];
	_log_usu_adm	:= datos[2];
	_nom_usu_adm 	:= datos[3];
	_ape_usu_adm 	:= datos[4];
	_ced_usu_adm 	:= datos[5];
	_tel_usu_adm 	:= datos[6];
	_cor_usu_adm 	:= datos[7];
	_trans_adm	:= datos[8];	

	/* Si se encuentra el usuario administrativo se modifica*/
	IF NOT EXISTS(SELECT 1 FROM usuarios_administrativos WHERE id_usu_adm <> _id_usu_adm AND log_usu_adm = _log_usu_adm)THEN

		/*Inserta registro en la tabla usuarios_administrativos*/	
		IF NOT EXISTS(SELECT 1 FROM usuarios_administrativos WHERE id_usu_adm <> _id_usu_adm AND ced_usu_adm = _ced_usu_adm)THEN

	
			SELECT INTO _var_rec * FROM usuarios_administrativos WHERE id_usu_adm = _id_usu_adm;
			IF FOUND THEN 

				/* Se modifica los datos del usuario administrativo */
				UPDATE usuarios_administrativos 
				SET 
					nom_usu_adm = _nom_usu_adm, 
					ape_usu_adm = _ape_usu_adm, 
					ced_usu_adm = _ced_usu_adm,
					tel_usu_adm = _tel_usu_adm,
					log_usu_adm = _log_usu_adm,
					cor_usu_adm = _cor_usu_adm
					
				WHERE id_usu_adm = _id_usu_adm;

				/* Insertando las transacciones del usuario*/
				_id_tip_usu_usu := (SELECT id_tip_usu_usu FROM tipos_usuarios__usuarios WHERE id_usu_adm = _id_usu_adm);
				DELETE FROM transacciones_usuarios WHERE id_tip_usu_usu = _id_tip_usu_usu;	
				
				_arr_trans_adm := STRING_TO_ARRAY(_trans_adm,',');
						
				IF (ARRAY_UPPER(_arr_trans_adm,1) > 0)THEN							
					FOR i IN 1..(ARRAY_UPPER(_arr_trans_adm,1)) LOOP
						INSERT INTO transacciones_usuarios(
							id_tip_usu_usu,
							id_tip_tra
						)
						VALUES
						(					
							_id_tip_usu_usu,
							_arr_trans_adm[i]
						);
					END LOOP;
				END IF;
				

				/* La función se ejecutó exitosamente*/
				RETURN 1;

			ELSE     
				/* No existe el usuario administrativo a modificar */
				RETURN 0;
			END IF;
		ELSE
			RETURN 3; /* Existe un usuario administrativo con la misma cédula*/
		END IF;
		
	ELSE
		RETURN 2; /* Existe un usuario administrativo con el mismo login*/
	END IF;

END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION adm_modificar_usuario_admin(character varying[]) OWNER TO desarrollo_g;
COMMENT ON FUNCTION adm_modificar_usuario_admin(character varying[]) IS '
NOMBRE: adm_modificar_usuario_admin
TIPO: Function (store procedure)

PARAMETROS: Recibe 7 Parámetros
	1:  Identificador del usuario administrativo
	2:  Nombre del usuario administrativo
	3:  Apellido del usuario administrativo
	4:  Cédula del usuario administrativo
	5:  Teléfono del usuario administrativo
	6:  Correo del usuario administrativo
	7:  Transacciones del usuario administrativo

DESCRIPCION: 
	Modifica la información del usuario administrativo 

RETORNO:
	3: Existe un usuario administrativo con la misma cédula
	2: Existe un usuario administrativo con el mismo login
	1: La función se ejecutó exitosamente.
	0: No existe el usuario
	 
EJEMPLO DE LLAMADA:
	SELECT adm_modificar_usuario_admin(ARRAY[ ''23'', ''lmarin2'', ''lmarin'', ''marin'', ''45645645'', ''36222222'', ''lmarin@gmail.com'', ''22,23,24,25,26,27'' ]) AS result

AUTOR DE CREACIÓN: Lisseth Lozada
FECHA DE CREACIÓN: 27/03/2011   

AUTOR DE MODIFICACIÓN: Luis Marin
FECHA DE MODIFICACIÓN: 22/04/2011    
DESCRIPCIÓN: Validación de log del usuario  

AUTOR DE MODIFICACIÓN: Lisseth Lozada
FECHA DE MODIFICACIÓN: 28/01/2012  
 
';
