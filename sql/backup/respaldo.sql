PGDMP     2         	            o            saib    9.0.3    9.0.3    5	           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            6	           0    0 
   STDSTRINGS 
   STDSTRINGS     )   SET standard_conforming_strings = 'off';
                       false            7	           1262    30788    saib    DATABASE     �   CREATE DATABASE saib WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Spanish, Bolivarian Republic of Venezuela' LC_CTYPE = 'Spanish, Bolivarian Republic of Venezuela';
    DROP DATABASE saib;
             postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
             postgres    false            8	           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                  postgres    false    7            9	           0    0    public    ACL     �   REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;
                  postgres    false    7                        2615    30789 
   saib_model    SCHEMA        CREATE SCHEMA saib_model;
    DROP SCHEMA saib_model;
             postgres    false            �           2612    11574    plpgsql    PROCEDURAL LANGUAGE     /   CREATE OR REPLACE PROCEDURAL LANGUAGE plpgsql;
 "   DROP PROCEDURAL LANGUAGE plpgsql;
             postgres    false            F           1247    30792    t_validar_usuarios    TYPE     �   CREATE TYPE t_validar_usuarios AS (
	id_usu integer,
	nom_usu text,
	ape_usu text,
	pas_usu text,
	log_usu text,
	tel_usu text,
	id_tip_usu integer,
	id_tip_usu_usu integer,
	cod_tip_usu text,
	str_trans text,
	des_tip_usu text
);
 %   DROP TYPE public.t_validar_usuarios;
       public       postgres    false    7    1668            :	           0    0    TYPE t_validar_usuarios    COMMENT     �   COMMENT ON TYPE t_validar_usuarios IS '
NOMBRE: t_validar_usuarios
TIPO: TIPO
	
CREADOR: Luis Raul Marin	
MODIFICADO: 
FECHA: 20/03/2011
';
            public       postgres    false    326                        1255    30793 (   adm_eliminar_medico(character varying[])    FUNCTION     �  CREATE FUNCTION adm_eliminar_medico(character varying[]) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$
DECLARE
	datos ALIAS 	FOR $1;
	_id_doc		doctores.id_doc%TYPE;
	_nom_doc 	doctores.nom_doc%TYPE;	
BEGIN

	_id_doc		:= datos[1];

	-- Si existe un paciente que tenga una id del doctor retorna 2
	IF (EXISTS(SELECT 1 FROM pacientes JOIN doctores USING(id_doc) WHERE id_doc = _id_doc))THEN
		RETURN 2;
	END IF;
			
	IF EXISTS(SELECT 1 FROM doctores WHERE id_doc = _id_doc)THEN
		/* El usuario administrativo puede ser eliminado */
					
			/*Eliminando doctor*/	

			DELETE FROM doctores 
			WHERE 
			id_doc = _id_doc
			;
						

			-- La función se ejecutó exitosamente
			RETURN 1;
	ELSE
		RETURN 0;
	END IF;
	/*EXCEPTION
	WHEN foreign_key_violation THEN
		IF (STRPOS(SQLERRM,))THEN
		--RAISE EXCEPTION '%','';
		 --RAISE LOG '%, via LOG','msg';
		--RAISE EXCEPTION  '%',SQLERRM;
	RETURN 2;*/
	
END;$_$;
 ?   DROP FUNCTION public.adm_eliminar_medico(character varying[]);
       public       desarrollo_g    false    7    476            ;	           0    0 1   FUNCTION adm_eliminar_medico(character varying[])    COMMENT     +  COMMENT ON FUNCTION adm_eliminar_medico(character varying[]) IS '
NOMBRE: adm_eliminar_medico
TIPO: Function (store procedure)

PARAMETROS: Recibe 1 Parámetros
	1:  Id del usuario doctor
	
DESCRIPCION: 
	Almacena la información del doctor

RETORNO:
	1: La función se ejecutó exitosamente.
	0: Existe un usuario administrativo con el mismo login.
	2: No se puede eliminar este doctor porque tiene pacientes asociados.
	 
EJEMPLO DE LLAMADA:
	SELECT adm_modificar_medico(ARRAY[''1'']);

AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 10/05/2011

';
            public       desarrollo_g    false    19                        1255    30794 -   adm_eliminar_usuario_admin(character varying)    FUNCTION     n  CREATE FUNCTION adm_eliminar_usuario_admin(character varying) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$
DECLARE
	
	--Variables
	_id_usu_adm 	ALIAS FOR $1;
	--_consulta 	varchar := '';

	--Variable record
	--_registro_usu	record;

BEGIN

	/*_consulta := 'SELECT * FROM usuarios_administrativos WHERE id_usu_adm IN (' || _ids_usu_eli || ')';*/


	/* Se obtienen los datos de cada uno de los usuario eliminados */
	/*FOR _registro_usu IN EXECUTE _consulta 
	LOOP*/
	       /* Se borran los registros asociados a los usuarios */
	       --DELETE FROM usuarios_administrativos WHERE id_usu_adm = _registro_usu.id_usu_adm;

	/*END LOOP;
	RETURN 0;*/

	IF EXISTS(SELECT 1 FROM usuarios_administrativos WHERE id_usu_adm = _id_usu_adm::INTEGER)THEN
		DELETE FROM usuarios_administrativos WHERE id_usu_adm = _id_usu_adm::INTEGER;
		RETURN 1;
	ELSE
		RETURN 0;
	END IF;

	
END;$_$;
 D   DROP FUNCTION public.adm_eliminar_usuario_admin(character varying);
       public       desarrollo_g    false    7    476            <	           0    0 6   FUNCTION adm_eliminar_usuario_admin(character varying)    COMMENT     �  COMMENT ON FUNCTION adm_eliminar_usuario_admin(character varying) IS '
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
';
            public       desarrollo_g    false    20                        1255    30795 )   adm_modificar_medico(character varying[])    FUNCTION     �
  CREATE FUNCTION adm_modificar_medico(character varying[]) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$
DECLARE
	datos ALIAS 	FOR $1;
	_id_doc		doctores.id_doc%TYPE;
	_ced_doc	doctores.ced_doc%TYPE;
	_nom_doc 	doctores.nom_doc%TYPE;
	_ape_doc 	doctores.ape_doc%TYPE;
	_pas_doc	doctores.pas_doc%TYPE;
	_log_doc	doctores.log_doc%TYPE;
	_tel_doc 	doctores.tel_doc%TYPE;
	_cor_doc 	doctores.cor_doc%TYPE;
	_cen_sal 	centro_salud_doctores.id_cen_sal%TYPE;
	_trans_doc	TEXT; 		-- transacciones a las cuales tiene permiso el doctor, o mejor dicho niveles de acceso
	_arr_trans_doc	INTEGER[]; 	-- transacciones a las cuales tiene permiso el doctor, o mejor dicho niveles de acceso
	_vr_tip_usu 	RECORD;

	_id_tip_usu_usu	INTEGER;
	
BEGIN

	_id_doc		:= datos[1];
	_log_doc 	:= datos[2];
	_ced_doc	:= datos[3];
	_nom_doc 	:= datos[4];
	_ape_doc 	:= datos[5];
	_pas_doc	:= md5(datos[6]);		
	_tel_doc 	:= datos[7];
	_cor_doc 	:= datos[8];
	_cen_sal 	:= datos[9];
	_trans_doc	:= datos[10];
	
	
	IF EXISTS(SELECT 1 FROM doctores WHERE id_doc = _id_doc)THEN
		/* El usuario administrativo puede ser registrado */
		IF NOT EXISTS (SELECT 1 FROM doctores WHERE log_doc = _log_doc AND id_doc <> _id_doc) THEN     					
			/*Inserta registro en la tabla usuarios_administrativos*/	

			IF NOT EXISTS(SELECT 1 FROM doctores WHERE ced_doc = _ced_doc AND id_doc <> _id_doc) THEN     					
				UPDATE doctores SET 
					
					nom_doc = _nom_doc,
					ape_doc = _ape_doc,
					pas_doc = _pas_doc,
					ced_doc	= _ced_doc,
					log_doc = _log_doc,
					tel_doc = _tel_doc,
					cor_doc = _cor_doc					
				
				WHERE id_doc = _id_doc;

				/*Elimino el centro de salud del doctor y lo vuelvo a insertar*/
				DELETE FROM centro_salud_doctores WHERE id_doc = _id_doc;
				INSERT INTO centro_salud_doctores(
					id_cen_sal, 
					id_doc, 
					otr_cen_sal
				)
				VALUES 
				(
					_cen_sal, 
					_id_doc, 
					NULL
				);
				
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
			ELSE
				RETURN 3;
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

END;$_$;
 @   DROP FUNCTION public.adm_modificar_medico(character varying[]);
       public       desarrollo_g    false    476    7            =	           0    0 2   FUNCTION adm_modificar_medico(character varying[])    COMMENT     x  COMMENT ON FUNCTION adm_modificar_medico(character varying[]) IS '
NOMBRE: adm_modificar_medico
TIPO: Function (store procedure)

PARAMETROS: Recibe 7 Parámetros
	1:  Id del usuario doctor
	2:  Login del usuario doctor
	3:  Cédula del usuario doctor
	4:  Nombre del usuario doctor
	5:  Apellido del usuario doctor
	6:  Password del usuario doctor	
	7:  Teléfono del usuario doctor
	8:  Correo Electrónico del usuario doctor
	9:  Centro de salud del usuario doctor 
	10: Tipo de usuario (id_tip_usu_usu Usuarios, desde la tabla tipos_usuarios_usuarios)
	
DESCRIPCION: 
	Almacena la información del doctor

RETORNO:

	0: Existe un usuario administrativo con el mismo login
	1: La función se ejecutó exitosamente
	2: Ya existe un usuario administrativo con este login
	3: Ya existe un usuario administrativo con la misma cédula
	
	 
EJEMPLO DE LLAMADA:
	SELECT adm_modificar_medico(ARRAY[''1'',''Lisseth'', ''Lozada'', ''123'', ''llozada'',''04269150722'',''risusefu@gmail.com'',''4'',''1,2,3'']);

AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 09/05/2011

AUTOR DE MODIFICACIÓN: Lisseth Lozada
FECHA DE MODIFICACIÓN: 24/06/2011
';
            public       desarrollo_g    false    21                        1255    30796 0   adm_modificar_usuario_admin(character varying[])    FUNCTION     �  CREATE FUNCTION adm_modificar_usuario_admin(character varying[]) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$
DECLARE
	datos ALIAS 	FOR $1;

	_id_usu_adm 	usuarios_administrativos.id_usu_adm%TYPE;
	_nom_usu_adm 	usuarios_administrativos.nom_usu_adm%TYPE;
	_pas_usu_adm 	usuarios_administrativos.pas_usu_adm%TYPE;
	_ape_usu_adm 	usuarios_administrativos.ape_usu_adm%TYPE;
	_tel_usu_adm 	usuarios_administrativos.tel_usu_adm%TYPE;
	_log_usu_adm 	usuarios_administrativos.log_usu_adm%TYPE;

	--Variable record
	_var_rec	record;

BEGIN
	_id_usu_adm	:= datos[1];
	_log_usu_adm	:= datos[2];
	_nom_usu_adm 	:= datos[3];
	_ape_usu_adm 	:= datos[4];
	_pas_usu_adm 	:= md5(datos[5]);
	_tel_usu_adm 	:= datos[6];	

	/* Si se encuentra el usuario administrativo se modifica*/
	IF NOT EXISTS(SELECT 1 FROM usuarios_administrativos WHERE id_usu_adm <> _id_usu_adm AND log_usu_adm = _log_usu_adm)THEN
	
		SELECT INTO _var_rec * FROM usuarios_administrativos WHERE id_usu_adm = _id_usu_adm;
		IF FOUND THEN 

			/* Se modifica los datos del usuario administrativo */
			UPDATE usuarios_administrativos 
			SET 
				nom_usu_adm = _nom_usu_adm, 
				ape_usu_adm = _ape_usu_adm, 
				pas_usu_adm = _pas_usu_adm,
				tel_usu_adm = _tel_usu_adm,
				log_usu_adm = _log_usu_adm
				
			WHERE id_usu_adm = _id_usu_adm;

			/* La función se ejecutó exitosamente*/
			RETURN 1;

		ELSE     
			/* No existe el usuario administrativo a modificar */
			RETURN 0;
		END IF;
	ELSE
		RETURN 2;
	END IF;

END;$_$;
 G   DROP FUNCTION public.adm_modificar_usuario_admin(character varying[]);
       public       desarrollo_g    false    7    476            >	           0    0 9   FUNCTION adm_modificar_usuario_admin(character varying[])    COMMENT     �  COMMENT ON FUNCTION adm_modificar_usuario_admin(character varying[]) IS '
NOMBRE: adm_modificar_usuario_admin
TIPO: Function (store procedure)

PARAMETROS: Recibe 7 Parámetros
	1:  Identificador del usuario administrativo
	2:  Nombre del usuario administrativo
	3:  Apellido del usuario administrativo
	4:  Teléfono del usuario administrativo
	5:  Tipo de usuario

DESCRIPCION: 
	Modifica la información del usuario administrativo 

RETORNO:
	2: Existe un usuario administrativo con el mismo login
	1: La función se ejecutó exitosamente.
	0: No existe el usuario
	 
EJEMPLO DE LLAMADA:
	SELECT adm_modificar_usuario_admin(ARRAY[''1'',''llozasa'' ''Lisseth'', ''Lozada'',''123456contraseña'', ''04269150722'']);

AUTOR DE CREACIÓN: Lisseth Lozada
FECHA DE CREACIÓN: 27/03/2011   

AUTOR DE MODIFICACIÓN: Luis Marin
FECHA DE CREACIÓN: 22/04/2011    
DESCRIPCIÓN: Validación de log del usuario   
';
            public       desarrollo_g    false    22                        1255    30797 )   adm_registrar_medico(character varying[])    FUNCTION     H
  CREATE FUNCTION adm_registrar_medico(character varying[]) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$
DECLARE
	datos ALIAS 	FOR $1;

	_nom_doc 	doctores.nom_doc%TYPE;
	_ape_doc 	doctores.ape_doc%TYPE;
	_ced_doc	doctores.ced_doc%TYPE;
	_pas_doc	doctores.pas_doc%TYPE;
	_log_doc	doctores.log_doc%TYPE;
	_tel_doc 	doctores.tel_doc%TYPE;
	_cor_doc 	doctores.cor_doc%TYPE;
	_cen_sal 	centro_salud_doctores.id_cen_sal%TYPE;
	_trans_doc	TEXT; 	-- transacciones a las cuales tiene permiso el doctor, o mejor dicho niveles de acceso
	_arr_trans_doc	INTEGER[]; -- transacciones a las cuales tiene permiso el doctor, o mejor dicho niveles de acceso
	_vr_tip_usu 	RECORD;
	
	
BEGIN

	_nom_doc 	:= datos[1];
	_ape_doc 	:= datos[2];
	_ced_doc	:= datos[3];
	_pas_doc	:= md5(datos[4]);	
	_log_doc 	:= datos[5];
	_tel_doc 	:= datos[6];
	_cor_doc 	:= datos[7];
	_cen_sal 	:= datos[8];
	_trans_doc	:= datos[9];
		
	/* El usuario administrativo puede ser registrado */
	IF NOT EXISTS (SELECT 1 FROM doctores WHERE log_doc = _log_doc) THEN     		
		/*Comprobando si existe un doctor con la cedula insertado por parametros*/
		IF NOT EXISTS (SELECT 1 FROM doctores WHERE ced_doc = _ced_doc) THEN     		
			/*Inserta registro en la tabla usuarios_administrativos*/
			INSERT INTO doctores
			(
				nom_doc,
				ape_doc,
				ced_doc,
				pas_doc,
				log_doc,
				tel_doc,
				cor_doc,			
				fec_reg_doc			
			)
			VALUES 
			(
				_nom_doc,
				_ape_doc,
				_ced_doc,
				_pas_doc,
				_log_doc,
				_tel_doc,
				_cor_doc,			
				NOW()			
			);

			INSERT INTO centro_salud_doctores(
				id_cen_sal, 
				id_doc, 
				otr_cen_sal
			)
			VALUES 
			(
				_cen_sal, 
				(CURRVAL('doctores_id_doc_seq')),
				null
			);
    		
			
			/*Insertando tipo de usuario como administrador*/
			INSERT INTO tipos_usuarios__usuarios(
				id_doc ,
				id_tip_usu
			)
			VALUES
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
			RETURN 2;-- Existe un usuario medico con la misma cedula.
		END IF;
	
	ELSE
		-- Existe un usuario administrativo con el mismo login
		RETURN 0;
	END IF;

END;$_$;
 @   DROP FUNCTION public.adm_registrar_medico(character varying[]);
       public       desarrollo_g    false    476    7            ?	           0    0 2   FUNCTION adm_registrar_medico(character varying[])    COMMENT     &  COMMENT ON FUNCTION adm_registrar_medico(character varying[]) IS '
NOMBRE: adm_registrar_medico
TIPO: Function (store procedure)

PARAMETROS: Recibe 6 Parámetros
	1:  Nombre del usuario doctor
	2:  Apellido del usuario doctor
	3:  Cédula del doctor
	4:  Password del usuario doctor	
	5:  Login del usuario doctor
	6:  Teléfono del usuario doctor
	7:  Correo Electrónico del usuario doctor
	8:  Centro de salud del usuario doctor
	9:  Tipo de usuario (id_tip_usu_usu Usuarios, desde la tabla tipos_usuarios_usuarios)

DESCRIPCION: 
	Almacena la información del usuario administrativo 

RETORNO:
	1: La función se ejecutó exitosamente.
	0: Existe un usuario administrativo con el mismo login.
	2: Existe un usuario medico con la misma cedula.
	 
EJEMPLO DE LLAMADA:
	SELECT adm_registrar_medico(ARRAY[''Lisseth'', ''Lozada'',''123456'', ''123'', ''llozada'',''04269150722'',''risusefu@gmail.com'',''7'',''1,2,3'']);

AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 04/05/2011

AUTOR DE MODIFICACIÓN: Lisseth Lozada
FECHA DE MODIFICACIÓN: 24/06/2011
';
            public       desarrollo_g    false    23                        1255    30798 0   adm_registrar_usuario_admin(character varying[])    FUNCTION     	  CREATE FUNCTION adm_registrar_usuario_admin(character varying[]) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$
DECLARE
	datos ALIAS 	FOR $1;

	_nom_usu_adm 	usuarios_administrativos.nom_usu_adm%TYPE;
	_ape_usu_adm 	usuarios_administrativos.ape_usu_adm%TYPE;
	_pas_usu_adm	usuarios_administrativos.pas_usu_adm%TYPE;
	_log_usu_adm 	usuarios_administrativos.log_usu_adm%TYPE;
	_tel_usu_adm 	usuarios_administrativos.tel_usu_adm%TYPE;
	_vr_tip_usu 	RECORD;
	
BEGIN

	_nom_usu_adm 	:= datos[1];
	_ape_usu_adm 	:= datos[2];
	_pas_usu_adm	:= md5(datos[3]);	
	_log_usu_adm 	:= datos[4];
	_tel_usu_adm 	:= datos[5];	
	
	

	/* El usuario administrativo puede ser registrado */
	IF NOT EXISTS (SELECT 1 FROM usuarios_administrativos WHERE log_usu_adm = _log_usu_adm) THEN     		
		
		/*Inserta registro en la tabla usuarios_administrativos*/
		INSERT INTO usuarios_administrativos
		(
			nom_usu_adm,
			ape_usu_adm,
			pas_usu_adm,
			log_usu_adm,
			tel_usu_adm,			
			fec_reg_usu_adm,
			adm_usu
		)
		VALUES 
		(
			_nom_usu_adm,
			_ape_usu_adm,
			_pas_usu_adm,
			_log_usu_adm,
			_tel_usu_adm,			
			NOW(),
			TRUE
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

END;$_$;
 G   DROP FUNCTION public.adm_registrar_usuario_admin(character varying[]);
       public       desarrollo_g    false    476    7            @	           0    0 9   FUNCTION adm_registrar_usuario_admin(character varying[])    COMMENT     A  COMMENT ON FUNCTION adm_registrar_usuario_admin(character varying[]) IS '
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
	SELECT adm_registrar_usuario_admin(ARRAY[''Lisseth'', ''Lozada'', ''123'', ''llozada'',''04269150722'']);

AUTOR DE CREACIÓN: Lisseth Lozada
FECHA DE CREACIÓN: 27/03/2011

';
            public       desarrollo_g    false    25                        1255    30799 J   formato_campo_xml(character varying, character varying, character varying)    FUNCTION     �  CREATE FUNCTION formato_campo_xml(character varying, character varying, character varying) RETURNS text
    LANGUAGE plpgsql
    AS $_$
DECLARE
	_nomcolumna 	ALIAS FOR $1;
	_valoract 	ALIAS FOR $2;
	_valorant 	ALIAS FOR $3;
	_campoxml 	VARCHAR;

BEGIN
	_campoxml := '<campo nombre=' || CHR(34) || _nomcolumna || CHR(34) || '><actual>' || _valoract || '</actual><anterior>' || _valorant || '</anterior></campo>';

	RETURN _campoxml;

END;$_$;
 a   DROP FUNCTION public.formato_campo_xml(character varying, character varying, character varying);
       public       desarrollo_g    false    476    7            A	           0    0 S   FUNCTION formato_campo_xml(character varying, character varying, character varying)    COMMENT       COMMENT ON FUNCTION formato_campo_xml(character varying, character varying, character varying) IS '
NOMBRE: formato_campo_xml
TIPO: Function (store procedure)

PARAMETROS: Recibe 3 Parámetros
	1:  Nombre del campo
	2:  Valor del campo actual
	3:  Valor del campo anterior
	
DESCRIPCION: 
	Arma el xml para las transacciones

RETORNO:
	Retorna una cadena xml
	 
EJEMPLO DE LLAMADA:
	SELECT formato_campo_xml(''nombre de la columna'', ''valor actual'', ''valor anterior'')

AUTOR DE CREACIÓN: Lisseth Lozada
FECHA DE CREACIÓN: 08/08/2011
';
            public       desarrollo_g    false    26                        1255    30800 +   med_eliminar_historial(character varying[])    FUNCTION     �	  CREATE FUNCTION med_eliminar_historial(character varying[]) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$
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

	
END;$_$;
 B   DROP FUNCTION public.med_eliminar_historial(character varying[]);
       public       desarrollo_g    false    7    476            B	           0    0 4   FUNCTION med_eliminar_historial(character varying[])    COMMENT     D  COMMENT ON FUNCTION med_eliminar_historial(character varying[]) IS '
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
            public       desarrollo_g    false    27                        1255    30801 2   med_eliminar_micosis_paciente(character varying[])    FUNCTION     �  CREATE FUNCTION med_eliminar_micosis_paciente(character varying[]) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$
DECLARE
	
	--Variables
	_data 		ALIAS FOR $1;
	_id_tip_mic_pac	tipos_micosis_pacientes.id_tip_mic_pac%TYPE;
	_id_doc		historiales_pacientes.id_doc%TYPE;

	_tra_usu	transacciones.cod_tip_tra%TYPE;

	_valorcampos 	VARCHAR := '';
	_reg_ant	RECORD;
	_reg_usu	RECORD;
	_reg_tra	RECORD;

BEGIN
	_id_tip_mic_pac 	:= _data[1];
	_id_doc 		:= _data[2];
	--_tra_usu		:= _data[3];

	IF EXISTS(SELECT 1 FROM tipos_micosis_pacientes WHERE id_tip_mic_pac = _id_tip_mic_pac) THEN
		DELETE FROM tipos_micosis_pacientes WHERE id_tip_mic_pac = _id_tip_mic_pac;
		RETURN 1;
	ELSE
		RETURN 0;
	END IF;
	
END;$_$;
 I   DROP FUNCTION public.med_eliminar_micosis_paciente(character varying[]);
       public       desarrollo_g    false    476    7            C	           0    0 ;   FUNCTION med_eliminar_micosis_paciente(character varying[])    COMMENT     �  COMMENT ON FUNCTION med_eliminar_micosis_paciente(character varying[]) IS '
NOMBRE: med_eliminar_micosis_paciente
TIPO: Function (store procedure)

PARAMETROS: Recibe 2 Parámetros
	1:  Tipo de enfermedad del paciente
	2:  Id del doctor que se encuentra actualmente logueado	
	3:  Código de la transacción
DESCRIPCION: 
	Elimina la información del usuario administrativo 

RETORNO:
	1: La función se ejecutó exitosamente
	0: No existe la enfermedad a  eliminar

EJEMPLO DE LLAMADA:
	SELECT adm_eliminar_usuario_admin(ARRAY[''16'',''32'']);


AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 04/09/2011 
DESCRIPCIÓN: Eliminación de enfermedades del paciente.

';
            public       desarrollo_g    false    24                        1255    30802 *   med_eliminar_paciente(character varying[])    FUNCTION     q  CREATE FUNCTION med_eliminar_paciente(character varying[]) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$
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

	
END;$_$;
 A   DROP FUNCTION public.med_eliminar_paciente(character varying[]);
       public       desarrollo_g    false    476    7            D	           0    0 3   FUNCTION med_eliminar_paciente(character varying[])    COMMENT     =  COMMENT ON FUNCTION med_eliminar_paciente(character varying[]) IS '
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
            public       desarrollo_g    false    28            &            1255    30804 3   med_insertar_micosis_pacientes(character varying[])    FUNCTION     �  CREATE FUNCTION med_insertar_micosis_pacientes(character varying[]) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$
DECLARE
	_datos ALIAS FOR $1;

	_id_his			historiales_pacientes.id_his%TYPE;
		
	_id_tip_mic		tipos_micosis.id_tip_mic%TYPE;
	_str_enf_pac		TEXT;
	_str_les		TEXT;
	_str_tip_est_mic	TEXT;
	_str_chk_for_inf	TEXT;

	_id_otr_enf_mic		enfermedades_pacientes.id_enf_pac%TYPE;
	_str_otr_enf_mic	enfermedades_pacientes.otr_enf_mic%TYPE;

	_id_otr_for_inf		forma_infecciones__pacientes.id_for_inf%TYPE;
	_str_otr_for_inf	forma_infecciones__pacientes.otr_for_inf%TYPE;	

	-- variables para trabajar con otros
	_str_data_otr		TEXT;
	_arr_str_data_otr	TEXT[];
	_arr_str_data_otr_elm	TEXT[];
	_bol_otr		BOOLEAN DEFAULT FALSE;

	-- cadena para manipular el array	
	_str		TEXT;	
		
	_id_doc		doctores.id_doc%TYPE;
	
	_arr_1	INTEGER[];	
	_arr_2	INTEGER[];
	_arr_3	TEXT[];	

	_id_tip_mic_pac	tipos_micosis_pacientes.id_tip_mic_pac%TYPE;
	
BEGIN


	-- pacientes
	_id_his			:= _datos[1];
	_id_tip_mic		:= _datos[2];
	_str_enf_pac		:= _datos[3];
	_str_les		:= _datos[4];	
	_str_tip_est_mic	:= _datos[5];
	_str_chk_for_inf	:= _datos[6];


	_str_otr_enf_mic	:= _datos[7];
	_id_otr_enf_mic 	:= _datos[8];
	
	_id_otr_for_inf		:= _datos[9];
	_str_otr_for_inf	:= _datos[10];

	_str_data_otr		:= _datos[11];
		
	_id_doc			:= _datos[12];	
	
	-- tipos de micosis del paciente
	IF NOT EXISTS  (SELECT 1 FROM tipos_micosis_pacientes WHERE id_his = _id_his AND id_tip_mic = _id_tip_mic) THEN
		
		INSERT INTO tipos_micosis_pacientes(
			id_tip_mic,
			id_his
		) VALUES (
			_id_tip_mic,
			_id_his
		);
		_id_tip_mic_pac:= CURRVAL('tipos_micosis_pacientes_id_tip_mic_pac_seq');			
	ELSE 
		RETURN 0;
	END IF;

	-- enfermedades del paciente
	--DELETE FROM enfermedades_paciente WHERE id_tip_mic_pac = _id_tip_mic_pac;

	_arr_1 := STRING_TO_ARRAY(_str_enf_pac,',');
	IF (ARRAY_UPPER(_arr_1,1) > 0)THEN
		FOR i IN 1..(ARRAY_UPPER(_arr_1,1)) LOOP

			IF (_id_otr_enf_mic = _arr_1[i])THEN
				INSERT INTO enfermedades_pacientes (
					id_tip_mic_pac,
					id_enf_mic,
					otr_enf_mic					
				) VALUES (
					_id_tip_mic_pac,
					_arr_1[i],
					_str_otr_enf_mic
				);
			ELSE
				INSERT INTO enfermedades_pacientes (
					id_tip_mic_pac,
					id_enf_mic					
				) VALUES (
					_id_tip_mic_pac,
					_arr_1[i]
				);
			END IF;
		END LOOP;
	END IF;

	-- tipo de consulta del paciente referidos al historico
	--DELETE FROM lesiones_partes_cuerpo__paciente WHERE id_his = _id_his;

	_arr_3 := STRING_TO_ARRAY(_str_les,',');
	
	IF (ARRAY_UPPER(_arr_3,1) > 0)THEN

		_arr_str_data_otr = STRING_TO_ARRAY(_str_data_otr,',');	
		
	
		FOR i IN 1..(ARRAY_UPPER(_arr_3,1)) LOOP
			_bol_otr := FALSE;
			_arr_2 := STRING_TO_ARRAY(replace(replace(_arr_3[i],'(',''),')',''),';');

			<<mifor>>
			FOR i IN 1..(ARRAY_UPPER(_arr_str_data_otr,1))LOOP			
				_arr_str_data_otr_elm := STRING_TO_ARRAY(_arr_str_data_otr[i],';');
				IF(_arr_str_data_otr_elm[1]::INTEGER = _arr_2[1] AND _arr_str_data_otr_elm[2]::INTEGER = _arr_2[2])THEN
					_str_data_otr := _arr_str_data_otr_elm[3];					
					_bol_otr := TRUE;
					EXIT mifor;
				END IF;
			END LOOP mifor;

			--coloca los comentarios de los otros en lesiones
			IF _bol_otr THEN

				INSERT INTO lesiones_partes_cuerpos__pacientes (
					id_tip_mic_pac,
					id_cat_cue_les,
					id_par_cue_cat_cue,
					otr_les_par_cue
				) VALUES (
					_id_tip_mic_pac,
					_arr_2[1],
					_arr_2[2],	
					_str_data_otr			
				);
			ELSE
			
				INSERT INTO lesiones_partes_cuerpos__pacientes 
				(
					id_tip_mic_pac,
					id_cat_cue_les,
					id_par_cue_cat_cue
				) VALUES (
					_id_tip_mic_pac,
					_arr_2[1],
					_arr_2[2]				
				);
			END IF;
		END LOOP;
	END IF;

	-- insertando los tipos de estudios micologicos pertenecientes a la enfermedad que padece el paciente
	_arr_1 := STRING_TO_ARRAY(_str_tip_est_mic,',');
	IF (ARRAY_UPPER(_arr_1,1) > 0)THEN
		FOR i IN 1..(ARRAY_UPPER(_arr_1,1)) LOOP
			INSERT INTO tipos_micosis_pacientes__tipos_estudios_micologicos (
				id_tip_mic_pac,
				id_tip_est_mic					
			) VALUES (
				_id_tip_mic_pac,
				_arr_1[i]
			);
		END LOOP;
	END IF;

	-- insertando la forma de infeccion de enfermedades del paciente
	_arr_1 := STRING_TO_ARRAY(_str_chk_for_inf,',');
	IF (ARRAY_UPPER(_arr_1,1) > 0)THEN
		FOR i IN 1..(ARRAY_UPPER(_arr_1,1)) LOOP
			IF _id_otr_for_inf = _arr_1[i] THEN 
				INSERT INTO forma_infecciones__pacientes (
					id_tip_mic_pac,
					id_for_inf,
					otr_for_inf					
				) VALUES (
					_id_tip_mic_pac,
					_arr_1[i],
					_str_otr_for_inf
				);
			ELSE
			
				INSERT INTO forma_infecciones__pacientes (
					id_tip_mic_pac,
					id_for_inf					
				) VALUES (
					_id_tip_mic_pac,
					_arr_1[i]
				);
			END IF;
		END LOOP;
	END IF;

	RETURN 1;

END;$_$;
 J   DROP FUNCTION public.med_insertar_micosis_pacientes(character varying[]);
       public       desarrollo_g    false    7    476            E	           0    0 <   FUNCTION med_insertar_micosis_pacientes(character varying[])    COMMENT     �  COMMENT ON FUNCTION med_insertar_micosis_pacientes(character varying[]) IS '
NOMBRE: med_insertar_micosis_pacientes
TIPO: Function (store procedure)

PARAMETROS: Recibe 4 Parámetros
	
	1:  Id del historico del paciente.
	2:  Id tipo micosis paciente.
	3:  String de las enfermedades del paciente, separados por ","
	4:  String de las lesiones del paciente.
	5:  Id del doctor.	

DESCRIPCION: 
	Inserta las enfermedades y las lesiones del paciente

RETORNO:
	1: La función se ejecutó exitosamente	
	 
EJEMPLO DE LLAMADA:
	SELECT med_insertar_micosis_pacientes(ARRAY[ 
		''16'', 
		''1'', 
		''1,4,7,18'', 
		''(3;1),(22;1),(7;2),(22;2),(13;3),(23;3),(14;4),(23;4)'', 
		''1,3,5'', 
		'''', 
		''super mic'', 
		''18'', 
		''-1'', 
		'''', 
		''22;1;uno,22;2;dos,23;3;tres,23;4;cuatro'', 
		''32'' 
	] ) AS result

AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 15/08/2011

AUTOR DE MODIFICACIÓN: Lisseth Lozada
FECHA DE MODIFICACIÓN: 29/12/2011

';
            public       desarrollo_g    false    38                        1255    30805 4   med_modificar_hitorial_paciente(character varying[])    FUNCTION     x  CREATE FUNCTION med_modificar_hitorial_paciente(character varying[]) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$
DECLARE
	_datos ALIAS FOR $1;

	-- informacion del paciente
	_id_his 		historiales_pacientes.id_his%TYPE;
	_des_his 		historiales_pacientes.des_his%TYPE;
	_des_adi_pac_his	historiales_pacientes.des_adi_pac_his%TYPE;	
	
	-- informacion del doctor
	_id_doc			doctores.id_doc%TYPE;

	_tra_usu		transacciones.cod_tip_tra%TYPE;

	_valorcampos 		VARCHAR := '';
	_reg_ant		RECORD;
	_reg_act		RECORD;
	_reg_usu		RECORD;
	_reg_tra		RECORD;
	
BEGIN
	-- pacientes
	_id_his 		:= _datos[1];
	_des_his 		:= _datos[2];
	_des_adi_pac_his	:= _datos[3];

	-- doctor	
	_id_doc			:= _datos[4];
	_tra_usu		:= _datos[5];

	-- historial del paciente
		
	/*Busco el registro anterior del historial del paciente*/
	SELECT nom_pac,ape_pac,ced_pac,des_his,des_adi_pac_his,fec_his INTO _reg_ant
	FROM historiales_pacientes LEFT JOIN pacientes USING(id_pac) 
	WHERE id_his = _id_his;

	
	UPDATE historiales_pacientes SET 		
		des_his 	= _des_his, 	
		des_adi_pac_his = _des_adi_pac_his				
		WHERE id_his 	= _id_his;

	/*Busco el registro actuales del historial del paciente*/
	SELECT nom_pac,ape_pac,ced_pac,fec_his INTO _reg_act
	FROM historiales_pacientes LEFT JOIN pacientes USING(id_pac) 
	WHERE id_his = _id_his;

	/* Se coloca el encabezado para los valores de los campos, así como el tag raíz y el inicio del tag tabla */
	_valorcampos := '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?><modificacion_del_historial_paciente>
		 <tabla nombre="historiales_pacientes">';
		_valorcampos := _valorcampos || 
		formato_campo_xml('Nombre Paciente', 		coalesce(_reg_act.nom_pac::text, 'ninguno'), 	coalesce(_reg_ant.nom_pac::text,'ninguno'))||
		formato_campo_xml('Apellido Paciente',  	coalesce(_reg_act.ape_pac::text, 'ninguno'), 	coalesce(_reg_ant.ape_pac::text,'ninguno'))||
		formato_campo_xml('Cédula Paciente', 		coalesce(_reg_act.ced_pac::text, 'ninguno'), 	coalesce(_reg_ant.ced_pac::text,'ninguno'))||
		formato_campo_xml('Descripción de la Historia', coalesce(_des_his::text, 'ninguno'), 		coalesce(_reg_ant.des_his::text,'ninguno'))||
		formato_campo_xml('Descripción Adicional', 	coalesce(_des_adi_pac_his::text, 'ninguno'), 	coalesce(_reg_ant.des_adi_pac_his::text,'ninguno'))||
		formato_campo_xml('Fecha de Historia', 		coalesce(_reg_act.fec_his::text, 'ninguno'), 	coalesce(_reg_ant.fec_his::text,'ninguno'));
		/*ªª Se cierra el tag de la tabla */
		_valorcampos := _valorcampos || '</tabla>';
	_valorcampos := _valorcampos || '</modificacion_del_historial_paciente>';	

		
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
		
	RETURN 1; -- La función se ejecutó exitosamente	

END;$_$;
 K   DROP FUNCTION public.med_modificar_hitorial_paciente(character varying[]);
       public       desarrollo_g    false    476    7            F	           0    0 =   FUNCTION med_modificar_hitorial_paciente(character varying[])    COMMENT     z  COMMENT ON FUNCTION med_modificar_hitorial_paciente(character varying[]) IS '
NOMBRE: med_modificar_hitorial_paciente
TIPO: Function (store procedure)

PARAMETROS: Recibe 4 Parámetros

	1:  Id del historial.
	2:  Descripción delhec historico.
	3:  Descripción adicional del paciente.
	4:  Id del doctor que se encuentra logueado en el sistema.
	5:  Código de la transacción
DESCRIPCION: 
	Modifica la información del historico de los pacientes

RETORNO:
	1: La función se ejecutó exitosamente	
	 
EJEMPLO DE LLAMADA:
	SELECT med_registrar_hitorial_paciente(ARRAY[ ''7'', ''lkhlkjh'', ''jhgfjgf'', ''6'',''MHP'' ]) AS result

AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 26/06/2011


AUTOR DE MODIFICACIÓN: Lisseth Lozada
FECHA DE MODIFICACIÓN: 23/08/2011
DESCRIPCIÓN: Se agregó en la función el armado del xml para la inserción de la auditoría de las transacciones.
';
            public       desarrollo_g    false    29            %            1255    30806 4   med_modificar_micosis_pacientes(character varying[])    FUNCTION     5  CREATE FUNCTION med_modificar_micosis_pacientes(character varying[]) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$
DECLARE
	_datos ALIAS FOR $1;	

	_id_tip_mic_pac tipos_micosis_pacientes.id_tip_mic_pac%TYPE;
	_id_tip_mic		tipos_micosis.id_tip_mic%TYPE;
	_str_enf_pac		TEXT;
	_str_les		TEXT;
	_str_tip_est_mic	TEXT;	
	_str_chk_for_inf	TEXT;

	_str_otr_enf_pac	enfermedades_pacientes.otr_enf_mic%TYPE;
	_id_otr_enf_pac		enfermedades_pacientes.id_enf_pac%TYPE;

	_id_otr_for_inf		forma_infecciones__pacientes.id_for_inf%TYPE;
	_str_otr_for_inf	forma_infecciones__pacientes.otr_for_inf%TYPE;

	-- variables para trabajar con otros
	_str_data_otr		TEXT;
	_arr_str_data_otr	TEXT[];
	_arr_str_data_otr_elm	TEXT[];
	_bol_otr		BOOLEAN DEFAULT FALSE;
	
	-- cadena para manipular el array
	_str		TEXT;
		
	_id_doc		doctores.id_doc%TYPE;
	
	_arr_1	INTEGER[];	
	_arr_2	INTEGER[];
	_arr_3	TEXT[];	
	
	
BEGIN

	-- pacientes	
	_id_tip_mic_pac		:= _datos[1];
	_str_enf_pac		:= _datos[2];
	_str_les		:= _datos[3];
	_str_tip_est_mic	:= _datos[4];		
	_str_chk_for_inf	:= _datos[5];

	_str_otr_enf_pac	:= _datos[6];
	_id_otr_enf_pac		:= _datos[7];
	
	_str_data_otr		:= _datos[8];

	_id_otr_for_inf		:= _datos[9];
	_str_otr_for_inf	:= _datos[10];
	
	_id_doc			:= _datos[11];	
		
	-- enfermedades del paciente
	DELETE FROM enfermedades_pacientes WHERE id_tip_mic_pac = _id_tip_mic_pac;

	_arr_1 := STRING_TO_ARRAY(_str_enf_pac,',');
	IF (ARRAY_UPPER(_arr_1,1) > 0)THEN
		FOR i IN 1..(ARRAY_UPPER(_arr_1,1)) LOOP
			IF _id_otr_enf_pac = _arr_1[i] THEN
				INSERT INTO enfermedades_pacientes (
					id_tip_mic_pac,
					id_enf_mic,
					otr_enf_mic					
				) VALUES (
					_id_tip_mic_pac,
					_arr_1[i],
					_str_otr_enf_pac
				);
			ELSE
				INSERT INTO enfermedades_pacientes (
					id_tip_mic_pac,
					id_enf_mic					
				) VALUES (
					_id_tip_mic_pac,
					_arr_1[i]
				);
			END IF;
		END LOOP;
	END IF;

	-- tipo de consulta del paciente referidos al historico
	DELETE FROM lesiones_partes_cuerpos__pacientes WHERE id_tip_mic_pac = _id_tip_mic_pac;
	
	_arr_3 := STRING_TO_ARRAY(_str_les,',');
	
	IF (ARRAY_UPPER(_arr_3,1) > 0)THEN
	
		_arr_str_data_otr = STRING_TO_ARRAY(_str_data_otr,',');		
		
		
		FOR i IN 1..(ARRAY_UPPER(_arr_3,1)) LOOP
			_bol_otr := FALSE;
			_arr_2 := STRING_TO_ARRAY(replace(replace(_arr_3[i] ,'(',''),')',''),';');

			<<mifor>>
			FOR i IN 1..(ARRAY_UPPER(_arr_str_data_otr,1))LOOP			
				_arr_str_data_otr_elm := STRING_TO_ARRAY(_arr_str_data_otr[i],';');
				IF(_arr_str_data_otr_elm[1]::INTEGER = _arr_2[1] AND _arr_str_data_otr_elm[2]::INTEGER = _arr_2[2])THEN
					_str_data_otr := _arr_str_data_otr_elm[3];					
					_bol_otr := TRUE;
					EXIT mifor;
				END IF;
			END LOOP mifor;
			
			--coloca los comentarios de los otros en lesiones
			IF _bol_otr THEN

				INSERT INTO lesiones_partes_cuerpos__pacientes (
					id_tip_mic_pac,
					id_cat_cue_les,
					id_par_cue_cat_cue,
					otr_les_par_cue
				) VALUES (
					_id_tip_mic_pac,
					_arr_2[1],
					_arr_2[2],	
					_str_data_otr			
				);

			ELSE

				INSERT INTO lesiones_partes_cuerpos__pacientes (
					id_tip_mic_pac,
					id_cat_cue_les,
					id_par_cue_cat_cue
				) VALUES (
					_id_tip_mic_pac,
					_arr_2[1],
					_arr_2[2]				
				);
			
			END IF;
		END LOOP;
	END IF;

	-- enfermedades del paciente
	DELETE FROM tipos_micosis_pacientes__tipos_estudios_micologicos WHERE id_tip_mic_pac = _id_tip_mic_pac;

	_arr_1 := STRING_TO_ARRAY(_str_tip_est_mic,',');
	IF (ARRAY_UPPER(_arr_1,1) > 0)THEN
		FOR i IN 1..(ARRAY_UPPER(_arr_1,1)) LOOP
			INSERT INTO tipos_micosis_pacientes__tipos_estudios_micologicos (
				id_tip_mic_pac,
				id_tip_est_mic					
			) VALUES (
				_id_tip_mic_pac,
				_arr_1[i]
			);
		END LOOP;
	END IF;

	-- forma de infeccion
	DELETE FROM forma_infecciones__pacientes WHERE id_tip_mic_pac = _id_tip_mic_pac;

	_arr_1 := STRING_TO_ARRAY(_str_chk_for_inf,',');
	IF (ARRAY_UPPER(_arr_1,1) > 0)THEN
		FOR i IN 1..(ARRAY_UPPER(_arr_1,1)) LOOP

			IF _id_otr_for_inf = _arr_1[i] THEN 

				INSERT INTO forma_infecciones__pacientes (
					id_tip_mic_pac,
					id_for_inf,
					otr_for_inf					
				) VALUES (
					_id_tip_mic_pac,
					_arr_1[i],
					_str_otr_for_inf
				);
			ELSE
				INSERT INTO forma_infecciones__pacientes (
					id_tip_mic_pac,
					id_for_inf					
				) VALUES (
					_id_tip_mic_pac,
					_arr_1[i]
				);
			END IF;
		END LOOP;
	END IF;

	RETURN 1;

END;$_$;
 K   DROP FUNCTION public.med_modificar_micosis_pacientes(character varying[]);
       public       desarrollo_g    false    7    476            G	           0    0 =   FUNCTION med_modificar_micosis_pacientes(character varying[])    COMMENT     5  COMMENT ON FUNCTION med_modificar_micosis_pacientes(character varying[]) IS '
NOMBRE: med_modificar_micosis_pacientes
TIPO: Function (store procedure)

PARAMETROS: Recibe 4 Parámetros
		
	1:  Id tipo micosis paciente.
	2:  String de las enfermedades del paciente, separados por ","
	3:  String de las lesiones del paciente.
	4:  String nombre de la otra micosis
	5:  Id de la otra micosis	
	6:  Id del doctor.	

DESCRIPCION: 
	Modifica las enfermedades y las lesiones del paciente

RETORNO:
	1: La función se ejecutó exitosamente	
	 
EJEMPLO DE LLAMADA:
	SELECT med_modificar_micosis_pacientes(ARRAY[ 
		''60'', 
		''1,4,5,7,18'', 
		''(3;1),(22;1),(2;1),(7;2),(22;2),(5;2),(13;3),(23;3),(10;3),(14;4),(21;4),(23;4)'', 
		''1,3,5,7'', 
		'''', 
		''super mic'', 
		''18'', 
		''22;1;uno,22;2;dos,23;3;tres,23;4;cuatro'', 
		''-1'', 
		'''', 
		''32'' 
	] ) AS result
AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 15/08/2011

AUTOR DE MODIFICACION: Luis Marin
FECHA DE MODIFICACION: 27/12/2011

AUTOR DE MODIFICACION: Lisseth Lozada
FECHA DE MODIFICACION: 29/12/2011
';
            public       desarrollo_g    false    37                        1255    30807 +   med_modificar_paciente(character varying[])    FUNCTION     &   CREATE FUNCTION med_modificar_paciente(character varying[]) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$
DECLARE
	_datos ALIAS FOR $1;

	-- informacion del paciente
	_id_pac		pacientes.id_pac%TYPE;
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
	_id_mun		pacientes.id_mun%TYPE;
	_id_par		pacientes.id_par%TYPE;
	_sex_pac	pacientes.sex_pac%TYPE;
	_tra_usu	transacciones.cod_tip_tra%TYPE;
	_str_ant_per	TEXT;
	_arr_ant_per	INTEGER[];
	_valorcampos 	VARCHAR := '';
	_des_ant_per 	VARCHAR := '';
	_des_ant_per_ant VARCHAR := '';	
	
	-- informacion del doctor

	_id_doc		doctores.id_doc%TYPE;

	_reg_pac	RECORD;
	_reg_ant	RECORD;
	_reg_act	RECORD;

	_reg_usu	RECORD;
	_reg_tra	RECORD;
	
BEGIN
	-- pacientes
	_id_pac		:= _datos[1];	
	_nom_pac 	:= _datos[2];
	_ape_pac 	:= _datos[3];
	_ced_pac	:= _datos[4];
	_fec_nac_pac 	:= _datos[5];
	_nac_pac 	:= _datos[6];
	_tel_hab_pac	:= _datos[7];
	_tel_cel_pac	:= _datos[8];
	_ocu_pac	:= _datos[9];
	_ciu_pac	:= _datos[10];
	_id_pai		:= _datos[11];
	_id_est		:= _datos[12];
	_id_mun		:= _datos[13];
	_str_ant_per	:= _datos[14];	
	_id_doc		:= _datos[15];
	_tra_usu	:= _datos[16];
	_sex_pac	:= _datos[17];

	-- centros de salud pacientes
	
	
	/* validando pacientes */
	IF EXISTS (SELECT 1 FROM pacientes WHERE id_pac = _id_pac::integer) THEN  

		/*Busco el registro anterior del paciente*/
		SELECT 	id_pac,ape_pac,nom_pac,ced_pac,fec_nac_pac,tel_hab_pac,tel_cel_pac,ciu_pac,id_pai,id_est,id_mun,sex_pac, 
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
			END AS ocu_pac INTO _reg_pac
		FROM pacientes 
		WHERE id_pac = _id_pac;
		
				
		/*Busco el registro anterior de la descripción del país, estado y municipio*/
		SELECT des_pai, des_est, des_mun INTO _reg_ant
		FROM paises p
			LEFT JOIN estados e ON(p.id_pai = e.id_pai)
			LEFT JOIN municipios m ON(e.id_est = m.id_est)
		WHERE p.id_pai = _reg_pac.id_pai
			AND e.id_est = _reg_pac.id_est
			AND m.id_mun = _reg_pac.id_mun;
			
		/*Modificando pacientes*/
		UPDATE  pacientes SET
			nom_pac 	= _nom_pac,	
			ape_pac 	= _ape_pac, 	
			ced_pac 	= _ced_pac,	
			fec_nac_pac 	= _fec_nac_pac, 	
			nac_pac 	= _nac_pac, 	
			tel_hab_pac 	= _tel_hab_pac,	
			tel_cel_pac 	= _tel_cel_pac,	
			ocu_pac 	= _ocu_pac,	
			ciu_pac 	= _ciu_pac,	
			id_pai 		= _id_pai,		
			id_est 		= _id_est,		
			id_mun 		= _id_mun,
			sex_pac		= _sex_pac			

			WHERE id_pac = _id_pac
		;

		/*Busco todos los registros actuales del paciente*/
		SELECT 	p.des_pai, e.des_est, m.des_mun,
			CASE 
				WHEN pa.nac_pac = '1' THEN 'Venezolano' ELSE 'Extranjero' 
			END AS nac_pac,
			CASE 
				WHEN pa.ocu_pac = '1' THEN 'Profesional'
				WHEN pa.ocu_pac = '2' THEN 'Técnico'
				WHEN pa.ocu_pac = '3' THEN 'Obrero'
				WHEN pa.ocu_pac = '4' THEN 'Agricultor'
				WHEN pa.ocu_pac = '5' THEN 'Jardinero'
				WHEN pa.ocu_pac = '6' THEN 'Otro'
			END AS ocu_pac  INTO _reg_act
		FROM pacientes pa
			LEFT JOIN paises p USING(id_pai)
			LEFT JOIN estados e ON(p.id_pai = e.id_pai)
			LEFT JOIN municipios m ON(e.id_est = m.id_est)
		WHERE pa.id_pac = _id_pac
			AND p.id_pai = _id_pai
			AND e.id_est = _id_est
			AND m.id_mun = _id_mun;



		/* Se coloca el encabezado para los valores de los campos, así como el tag raíz y el inicio del tag tabla */
		_valorcampos := '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?><modificacion_de_pacientes>
				 <tabla nombre="pacientes">';
				_valorcampos := _valorcampos || 
				formato_campo_xml('Nombre',  		coalesce(_nom_pac::text, 'ninguno'), 		coalesce(_reg_pac.nom_pac::text, 'ninguno'))||
				formato_campo_xml('Apellido', 		coalesce(_ape_pac::text, 'ninguno'), 		coalesce(_reg_pac.ape_pac::text, 'ninguno'))||
				formato_campo_xml('Cédula', 		coalesce(_ced_pac::text, 'ninguno'), 		coalesce(_reg_pac.ced_pac::text, 'ninguno'))||  
				formato_campo_xml('Fecha Nacimiento', 	coalesce(_fec_nac_pac::text, 'ninguno'), 	coalesce(_reg_pac.fec_nac_pac::text, 'ninguno'))||  
				formato_campo_xml('Sexo', 		coalesce(_sex_pac::text, 'ninguno'), 		coalesce(_reg_pac.sex_pac::text, 'ninguno'))||  
				formato_campo_xml('Nacionalidad', 	coalesce(_reg_act.nac_pac::text, 'ninguno'), 	coalesce(_reg_pac.nac_pac::text, 'ninguno'))||  
				formato_campo_xml('Teléfono Habitación',coalesce(_tel_hab_pac::text, 'ninguno'), 	coalesce(_reg_pac.tel_hab_pac::text, 'ninguno'))||
				formato_campo_xml('Teléfono Célular', 	coalesce(_tel_cel_pac::text, 'ninguno'), 	coalesce(_reg_pac.tel_cel_pac::text, 'ninguno'))|| 
				formato_campo_xml('Ocupación', 		coalesce(_reg_act.ocu_pac::text, 'ninguno'), 	coalesce(_reg_pac.ocu_pac::text, 'ninguno'))||
				formato_campo_xml('País', 		coalesce(_reg_act.des_pai::text, 'ninguno'), 	coalesce(_reg_ant.des_pai::text, 'ninguno'))||
				formato_campo_xml('Estado', 		coalesce(_reg_act.des_est::text, 'ninguno'), 	coalesce(_reg_ant.des_est::text, 'ninguno'))||
				formato_campo_xml('Municipio', 		coalesce(_reg_act.des_mun::text, 'ninguno'), 	coalesce(_reg_ant.des_mun::text, 'ninguno'))||
				formato_campo_xml('Ciudad', 		coalesce(_ciu_pac::text, 'ninguno'), 		coalesce(_reg_pac.ciu_pac::text, 'ninguno'));  
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
			
			DELETE FROM antecedentes_pacientes WHERE id_pac = _id_pac;
			_arr_ant_per := STRING_TO_ARRAY(_str_ant_per,',');
			IF (ARRAY_UPPER(_arr_ant_per,1) > 0)THEN
				FOR i IN 1..(ARRAY_UPPER(_arr_ant_per,1)) LOOP
					INSERT INTO antecedentes_pacientes (
						id_pac,
						id_ant_per					
					) VALUES (
						_id_pac,
						_arr_ant_per[i]
					);
					SELECT nom_ant_per INTO _reg_act FROM antecedentes_personales WHERE id_ant_per = _arr_ant_per[i];
					_des_ant_per := _des_ant_per || _reg_act.nom_ant_per || ' ,';
				END LOOP;
			END IF;


			/* Se le quita la última de las comas a la variable */
			IF length(_des_ant_per) > 0 THEN
				_des_ant_per := substr(_des_ant_per, 1, length(_des_ant_per) - 1);
			END IF;	
			
			/* Se identifica la tabla en el formato xml */
			_valorcampos := _valorcampos || '<tabla nombre="antecedentes_personales">';
			/* Se completa el tag con el valor del campo */
				_valorcampos := _valorcampos || 
				formato_campo_xml('Antecedentes Personales', coalesce(_des_ant_per::text, 'ninguno'), coalesce(_des_ant_per_ant::text));
			/* Se cierra el tag de la tabla */
			_valorcampos := _valorcampos || '</tabla>';
			
		_valorcampos := _valorcampos || '</modificacion_de_pacientes>';	

		
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
		
		-- La función se ejecutó exitosamente
		RETURN 1;
		
	
	ELSE
		-- Existe un usuario administrativo con el mismo login
		RETURN 0;
	END IF;

END;$_$;
 B   DROP FUNCTION public.med_modificar_paciente(character varying[]);
       public       desarrollo_g    false    476    7            H	           0    0 4   FUNCTION med_modificar_paciente(character varying[])    COMMENT     U  COMMENT ON FUNCTION med_modificar_paciente(character varying[]) IS '
NOMBRE: med_modificar_paciente
TIPO: Function (store procedure)

PARAMETROS: Recibe 12 Parámetros
	1:  Id del paciente a modificar
	2:  Nombre paciente
	3:  Apellido del paciente
	4:  Cédula del paciente
	5:  Fecha de nacimiento del paciente
	6:  Nacionalidad del paciente
	7:  Teléfono de habitacion del paciente
	8:  Teléfono de celular del paciente
	9:  Ocupacion del paciente
	10:  Ciudad donde se encuentra el paciente
	11: Id del pais donde vive el paciente
	12: Id del estado donde vive el paciente.
	13: Id del municipio donde vive el paciente.
	14: Id de los antecedentes personales
	15: Id del doctor quien realizo la transacción
	16: Código de la transaccion
	17: Sexo del paciente

DESCRIPCION: 
	Modifica la información de los pacientes

RETORNO:
	1: La función se ejecutó exitosamente
	0: Existe un usuario administrativo con el mismo login
	 
EJEMPLO DE LLAMADA:
	SELECT med_modificar_paciente(ARRAY[
                ''66'',
                ''pruebalis'', 
                ''pruebalis'', 
                ''1789654232'', 
                ''1987-08-08'',
                ''2'',
                ''02129514777'',
                ''777777777'',
                ''2'',
                ''css'',
                ''1'',
                ''15'',
                ''200'',
                ''2,3,4,5,8'',
                ''32'',
                ''MP'',
                ''F''
            ]) AS result;

AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 09/06/2011

AUTOR DE MODIFICACIÓN: Lisseth Lozada
FECHA DE MODIFICACIÓN: 16/08/2011
DESCRIPCIÓN: Se agregó en la función el armado del xml para la inserción de la auditoría de las transacciones.

AUTOR DE MODIFICACIÓN: Lisseth Lozada
FECHA DE MODIFICACIÓN: 24/10/2011
DESCRIPCIÓN: Se agregó en la función un nuevo campo sex_pac.
';
            public       desarrollo_g    false    30            $            1255    30809 1   med_muestra_clinica_paciente(character varying[])    FUNCTION     �  CREATE FUNCTION med_muestra_clinica_paciente(character varying[]) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$
DECLARE
	_datos ALIAS FOR $1;

	-- informacion del paciente	
	_str_mue_cli		TEXT;	
	_id_doc			doctores.id_doc%TYPE;
	_id_his			historiales_pacientes.id_his%TYPE;
	_tra_usu		transacciones.cod_tip_tra%TYPE;

	_id_otr_mue_cli		muestras_pacientes.id_mue_pac%TYPE;
	_str_otr_mue_cli	muestras_pacientes.otr_mue_cli%TYPE;
	
	_nom_mue_cli_ant	VARCHAR;
	_nom_mue_cli_act	VARCHAR;
	_valorcampos 		VARCHAR := '';
	_reg_pac		RECORD;
	_reg_ant		RECORD;
	_reg_act		RECORD;

	_reg_usu		RECORD;
	_reg_tra		RECORD;
		
	_arr			INTEGER[];		
BEGIN
	-- pacientes
	_id_his			:= _datos[1];	
	_str_mue_cli		:= _datos[2];
	
	_id_otr_mue_cli		:= _datos[3];
	_str_otr_mue_cli	:= _datos[4];
			
	_id_doc			:= _datos[5];	
	_tra_usu		:= _datos[6];



	/*Busco el registro anterior del paciente*/
	SELECT nom_pac,ape_pac,ced_pac, id_his  INTO _reg_pac
	FROM pacientes p 
		LEFT JOIN historiales_pacientes hp USING(id_pac)
	WHERE id_his = _id_his;

	/*Busco el registro anterior del nombre de la muestra clinica del paciente*/
	FOR _reg_ant IN (SELECT nom_mue_cli FROM muestras_pacientes mp LEFT JOIN muestras_clinicas mc ON(mp.id_mue_cli = mc.id_mue_cli) WHERE mp.id_his = _id_his) LOOP
		_nom_mue_cli_ant := _nom_mue_cli_ant || _reg_ant.nom_mue_cli || ' ,';
	END LOOP;

	/* Se le quita la última de las comas a la variable */
	IF length(_nom_mue_cli_ant) > 0 THEN
		_nom_mue_cli_ant := substr(_nom_mue_cli_ant, 1, length(_nom_mue_cli_ant) - 1);
	END IF;
		
	
	DELETE FROM muestras_pacientes WHERE id_his = _id_his;

	_arr := STRING_TO_ARRAY(_str_mue_cli,',');
	IF (ARRAY_UPPER(_arr,1) > 0)THEN
		FOR i IN 1..(ARRAY_UPPER(_arr,1)) LOOP
			IF (_id_otr_mue_cli = _arr[i])THEN
				INSERT INTO muestras_pacientes (
					id_his,
					id_mue_cli,
					otr_mue_cli					
				) VALUES (
					_id_his,
					_arr[i],
					_str_otr_mue_cli
				);
			ELSE
				INSERT INTO muestras_pacientes (
					id_his,
					id_mue_cli					
				) VALUES (
					_id_his,
					_arr[i]
				);
			END IF;

			SELECT nom_mue_cli INTO _reg_act FROM muestras_pacientes mp LEFT JOIN muestras_clinicas mc ON(mp.id_mue_cli = mc.id_mue_cli) WHERE mc.id_mue_cli = _arr[i];

			_nom_mue_cli_act := _nom_mue_cli_act || _reg_act.nom_mue_cli || ' ,';
		END LOOP;
	END IF;


	/* Se le quita la última de las comas a la variable */
	IF length(_nom_mue_cli_act) > 0 THEN
		_nom_mue_cli_act := substr(_nom_mue_cli_act, 1, length(_nom_mue_cli_act) - 1);
	END IF;	

	/* Se coloca el encabezado para los valores de los campos, así como el tag raíz y el inicio del tag tabla */
	_valorcampos := '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?><registrar_muestra_clínica_paciente>
			 <tabla nombre="muestras_pacientes">';
			_valorcampos := _valorcampos || 
			formato_campo_xml('Nombre',  		coalesce(_reg_pac.nom_pac::text, 'ninguno'), 	coalesce(_reg_pac.nom_pac::text, 'ninguno'))||
			formato_campo_xml('Apellido', 		coalesce(_reg_pac.ape_pac::text, 'ninguno'), 	coalesce(_reg_pac.ape_pac::text, 'ninguno'))||
			formato_campo_xml('Cédula', 		coalesce(_reg_pac.ced_pac::text, 'ninguno'), 	coalesce(_reg_pac.ced_pac::text, 'ninguno'))||  
			formato_campo_xml('Muestra Clínica',  	coalesce(_nom_mue_cli_act::text, 'ninguno'), 	coalesce(_nom_mue_cli_ant::text, 'ninguno'));
			/* Se cierra el tag de la tabla */
			_valorcampos := _valorcampos || '</tabla>';
	_valorcampos := _valorcampos || '</registrar_muestra_clínica_paciente>';	

	
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

	RETURN 1;

END;$_$;
 H   DROP FUNCTION public.med_muestra_clinica_paciente(character varying[]);
       public       desarrollo_g    false    476    7            I	           0    0 :   FUNCTION med_muestra_clinica_paciente(character varying[])    COMMENT       COMMENT ON FUNCTION med_muestra_clinica_paciente(character varying[]) IS '
NOMBRE: med_muestra_clinica_paciente
TIPO: Function (store procedure)

PARAMETROS: Recibe 3 Parámetros
	1:  Id del historico del paciente
	2:  Id de Muestras clínicas del paciente
	3:  Id del doctor quien realizo la transacción
	4:  Código de la transaccion	

DESCRIPCION: 
	Modifica la información de las muestras clínicas del paciente
RETORNO:
	1: La función se ejecutó exitosamente	
	 
EJEMPLO DE LLAMADA:
	SELECT med_muestra_clinica_paciente(ARRAY[
                ''16'',
                ''1,3,4,8,9,36'',
                ''36'',
                ''Otra Clinica'',               
                ''32'',
                ''MCP''                
                ]
            ) AS result 

AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 03/08/2011

AUTOR DE MODIFICACIÓN: Lisseth Lozada
FECHA DE MODIFICACIÓN: 25/08/2011
DESCRIPCIÓN: Se agregó en la función el armado del xml para la inserción de la auditoría de las transacciones.
';
            public       desarrollo_g    false    36                        1255    30810 4   med_registrar_hitorial_paciente(character varying[])    FUNCTION     �  CREATE FUNCTION med_registrar_hitorial_paciente(character varying[]) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$
DECLARE
	_datos ALIAS FOR $1;

	-- informacion del paciente
	_id_pac 		pacientes.id_pac%TYPE;
	_des_his 		historiales_pacientes.des_his%TYPE;
	_des_adi_pac_his	historiales_pacientes.des_adi_pac_his%TYPE;
	_id_his			historiales_pacientes.id_his%TYPE;
	
	-- informacion del doctor
	_id_doc			doctores.id_doc%TYPE;
	_tra_usu		transacciones.cod_tip_tra%TYPE;

	_valorcampos 		VARCHAR := '';
	_reg_act		RECORD;
	_reg_usu		RECORD;
	_reg_tra		RECORD;
	
BEGIN
	-- pacientes
	_id_pac 		:= _datos[1];
	_des_his 		:= _datos[2];
	_des_adi_pac_his	:= _datos[3];

	-- doctor	
	_id_doc			:= _datos[4];
	_tra_usu		:= _datos[5];

	-- historial del paciente
	

	/*insertando pacientes*/
	INSERT INTO historiales_pacientes
	(
		id_pac,	
		des_his, 	
		des_adi_pac_his,		
		id_doc		
	)
	VALUES 
	(
		_id_pac,	
		_des_his, 	
		_des_adi_pac_his,		
		_id_doc
	);	

	_id_his:= CURRVAL('historiales_pacientes_id_his_seq');	

	/*Busco el registro actual del historial del paciente*/
	SELECT nom_pac,ape_pac,ced_pac,des_his,des_adi_pac_his,fec_his INTO _reg_act
	FROM historiales_pacientes LEFT JOIN pacientes USING(id_pac) 
	WHERE id_his = _id_his;
	
	/* Se coloca el encabezado para los valores de los campos, así como el tag raíz y el inicio del tag tabla */
	_valorcampos := '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?><registro_del_historial_paciente>
		 <tabla nombre="historiales_pacientes">';
		_valorcampos := _valorcampos || 
		formato_campo_xml('Nombre Paciente', 		coalesce(_reg_act.nom_pac::text, 'ninguno'), 	'ninguno')||
		formato_campo_xml('Apellido Paciente',  	coalesce(_reg_act.ape_pac::text, 'ninguno'), 	'ninguno')||
		formato_campo_xml('Cédula Paciente', 		coalesce(_reg_act.ced_pac::text, 'ninguno'), 	'ninguno')||
		formato_campo_xml('Descripción de la Historia', coalesce(_des_his::text, 'ninguno'), 		'ninguno')||  
		formato_campo_xml('Descripción Adicional', 	coalesce(_des_adi_pac_his::text, 'ninguno'), 	'ninguno')||  
		formato_campo_xml('Fecha de Historia', 		coalesce(_reg_act.fec_his::text, 'ninguno'), 	'ninguno');  
		/*ªª Se cierra el tag de la tabla */
		_valorcampos := _valorcampos || '</tabla>';
	

		INSERT INTO tiempo_evoluciones(
			id_his
		) VALUES (
			_id_his
		);

		SELECT * INTO _reg_act FROM tiempo_evoluciones;


	/* Se identifica la tabla en el formato xml */
		_valorcampos := _valorcampos || '<tabla nombre="tiempo_evoluciones">';
		/* Se completa el tag con el valor del campo */
			_valorcampos := _valorcampos || 
			formato_campo_xml('Tiempo de Evolución', coalesce(_reg_act.tie_evo::text, 'ninguno'), 'ninguno');
		/* Se cierra el tag de la tabla */
		_valorcampos := _valorcampos || '</tabla>';
		
	_valorcampos := _valorcampos || '</registro_del_historial_paciente>';	

		
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
		
			
	-- La función se ejecutó exitosamente
	RETURN 1;

END;$_$;
 K   DROP FUNCTION public.med_registrar_hitorial_paciente(character varying[]);
       public       desarrollo_g    false    476    7            J	           0    0 =   FUNCTION med_registrar_hitorial_paciente(character varying[])    COMMENT     p  COMMENT ON FUNCTION med_registrar_hitorial_paciente(character varying[]) IS '
NOMBRE: med_registrar_hitorial_paciente
TIPO: Function (store procedure)

PARAMETROS: Recibe 4 Parámetros

	1:  Id del paciente.
	2:  Descripción delhec historico.
	3:  Descripción adicional del paciente.
	4:  Id del doctor que se encuentra logueado en el sistema.
	5:  Código de la transacción
DESCRIPCION: 
	Almacena la información del historico de los pacientes

RETORNO:
	1: La función se ejecutó exitosamente	
	 
EJEMPLO DE LLAMADA:
	SELECT med_registrar_hitorial_paciente(ARRAY[ ''7'', ''lkhlkjh'', ''jhgfjgf'', ''6'' ]) AS result

AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 26/06/2011

AUTOR DE MODIFICACIÓN: Lisseth Lozada
FECHA DE MODIFICACIÓN: 17/08/2011
DESCRIPCIÓN: Se agregó en la función el armado del xml para la inserción de la auditoría de las transacciones.
';
            public       desarrollo_g    false    31            !            1255    30811 8   med_registrar_informacion_adicional(character varying[])    FUNCTION     ,  CREATE FUNCTION med_registrar_informacion_adicional(character varying[]) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$
DECLARE
	_datos ALIAS FOR $1;

	-- informacion del paciente	
	_str_cen_sal		TEXT;
	_str_tip_con		TEXT;
	_str_con_ani		TEXT;
	_str_tra_pre		TEXT;
	_tie_evo		tiempo_evoluciones.tie_evo%TYPE;
	_id_doc			doctores.id_doc%TYPE;
	_tra_usu		transacciones.cod_tip_tra%TYPE;
	_str_otr_ani		contactos_animales.otr_ani%TYPE;
	_id_otr_ani		contactos_animales.id_ani%TYPE;
	_str_otr_tip_con	tipos_consultas_pacientes.otr_tip_con%TYPE;
	_id_otr_tip_con		tipos_consultas_pacientes.id_tip_con%TYPE;

	_str_otr_cen_sal	centro_salud_pacientes.otr_cen_sal%TYPE;
	_id_otr_cen_sal		centro_salud_pacientes.id_cen_sal%TYPE;
	
	_str_otr_tra		tratamientos_pacientes.otr_tra%TYPE;
	_id_otr_tra		tratamientos_pacientes.id_tra_pac%TYPE;
	
	_id_his		historiales_pacientes.id_his%TYPE;
		
	_arr		INTEGER[];
	_valorcampos 	VARCHAR := '';
	_reg_ant	RECORD;
	_reg_act	RECORD;
	_reg_usu	RECORD;
	_reg_tra	RECORD;
		
	/*Centro de Salud*/
	_anterior	VARCHAR:= '';
	_actual		VARCHAR:= '';
	
BEGIN
	-- pacientes
	_id_his			:= _datos[1];	
	_str_cen_sal		:= _datos[2];	
	_str_tip_con		:= _datos[3];	
	_str_con_ani		:= _datos[4];	
	_str_tra_pre		:= _datos[5];	
	_tie_evo		:= _datos[6];
	
	_id_otr_ani		:= _datos[7];	
	_str_otr_ani		:= _datos[8];
	
	_id_otr_tip_con 	:= _datos[9];
	_str_otr_tip_con	:= _datos[10];

	_id_otr_cen_sal		:= _datos[11];
	_str_otr_cen_sal	:= _datos[12];
	
	_id_otr_tra 		:= _datos[13];
	_str_otr_tra		:= _datos[14];
		
	_id_doc			:= _datos[15];	
	_tra_usu		:= _datos[16];


	/****************************************CENTRO DE SALUD********************************************/
	
	/*Busco el registro anterior del Centro de Salud del paciante*/
	FOR _reg_ant IN (SELECT nom_cen_sal FROM centro_salud_pacientes	 LEFT JOIN centro_saluds USING(id_cen_sal) WHERE id_his = _id_his) LOOP
		_anterior := _anterior || _reg_ant.nom_cen_sal || ' ,';
	END LOOP;

	
	/* Se le quita la última de las comas a la variable */
	IF length(_anterior) > 0 THEN
		_anterior := substr(_anterior, 1, length(_anterior) - 1);
	END IF;

	-- centro de salud del paciente referidos al historico
	DELETE FROM centro_salud_pacientes WHERE id_his = _id_his;

	_arr := STRING_TO_ARRAY(_str_cen_sal,',');
	IF (ARRAY_UPPER(_arr,1) > 0)THEN
		FOR i IN 1..(ARRAY_UPPER(_arr,1)) LOOP
			IF (_id_otr_cen_sal = _arr[i])THEN
				INSERT INTO centro_salud_pacientes (
					id_his,
					id_cen_sal,
					otr_cen_sal					
				) VALUES (
					_id_his,
					_arr[i],
					_str_otr_cen_sal
				);
			ELSE
				INSERT INTO centro_salud_pacientes (
					id_his,
					id_cen_sal					
				) VALUES (
					_id_his,
					_arr[i]
				);
			END IF;
			
			/*Busco el registro actual del Centro de Salud del paciante*/
			SELECT nom_cen_sal INTO _reg_act FROM centro_salud_pacientes LEFT JOIN centro_saluds USING(id_cen_sal) WHERE id_cen_sal = _arr[i];
			_actual := _actual || _reg_act.nom_cen_sal || ' ,';
		END LOOP;
	END IF;

	/* Se le quita la última de las comas a la variable */
	IF length(_actual) > 0 THEN
		_actual := substr(_actual, 1, length(_actual) - 1);
	END IF;	


	/* Se coloca el encabezado para los valores de los campos, así como el tag raíz y el inicio del tag tabla */
	_valorcampos := '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes">';
			_valorcampos := _valorcampos || 
			formato_campo_xml('Centros de Salud',  	coalesce(_actual::text, 'ninguno'), 	coalesce(_anterior::text, 'ninguno'));  
		/*ªª Se cierra el tag de la tabla */
		_valorcampos := _valorcampos || '</tabla>';


	/****************************************TIPOS DE CONSULTAS********************************************/


	/*Busco el registro anterior del tipo de consulta del paciante*/
	FOR _reg_ant IN (SELECT nom_tip_con FROM tipos_consultas_pacientes LEFT JOIN tipos_consultas USING(id_tip_con) WHERE id_his = _id_his) LOOP
		_anterior := _anterior || _reg_ant.nom_tip_con || ' ,';
	END LOOP;

	/* Se le quita la última de las comas a la variable */
	IF length(_anterior) > 0 THEN
		_anterior := substr(_anterior, 1, length(_anterior) - 1);
	END IF;
	

	-- tipo de consulta del paciente referidos al historico
	DELETE FROM tipos_consultas_pacientes WHERE id_his = _id_his;

	_arr := STRING_TO_ARRAY(_str_tip_con,',');
	IF (ARRAY_UPPER(_arr,1) > 0)THEN
		FOR i IN 1..(ARRAY_UPPER(_arr,1)) LOOP
			
			IF (_id_otr_tip_con = _arr[i])THEN
				INSERT INTO tipos_consultas_pacientes (
					id_his,
					id_tip_con,
					otr_tip_con					
				) VALUES (
					_id_his,
					_arr[i],
					_str_otr_tip_con
				);
			ELSE
				INSERT INTO tipos_consultas_pacientes (
					id_his,
					id_tip_con					
				) VALUES (
					_id_his,
					_arr[i]
				);
			END IF;
			
			/*Busco el registro actual del tipo de consulta del paciante*/
			SELECT nom_tip_con INTO _reg_act FROM tipos_consultas_pacientes LEFT JOIN tipos_consultas USING(id_tip_con) WHERE id_tip_con = _arr[i];
			_actual := _actual || _reg_act.nom_tip_con || ' ,';
		END LOOP;
	END IF;

	/* Se le quita la última de las comas a la variable */
	IF length(_actual) > 0 THEN
		_actual := substr(_actual, 1, length(_actual) - 1);
	END IF;	

	/* Se identifica la tabla en el formato xml */
	_valorcampos := _valorcampos || '<tabla nombre="tipos_consultas_pacientes">';
	/* Se completa el tag con el valor del campo */
		_valorcampos := _valorcampos || 
		formato_campo_xml('Tipos de Consultas', coalesce(_actual::text, 'ninguno'), coalesce(_anterior::text));
	/* Se cierra el tag de la tabla */
	_valorcampos := _valorcampos || '</tabla>';


	
	/****************************************CONTACTOS CON ANIMALES********************************************/

	/*Busco el registro anterior del contacto con animales del paciante*/
	FOR _reg_ant IN (SELECT nom_ani FROM contactos_animales LEFT JOIN animales USING(id_ani) WHERE id_his = _id_his) LOOP
		_anterior := _anterior || _reg_ant.nom_ani || ' ,';
	END LOOP;

	/* Se le quita la última de las comas a la variable */
	IF length(_anterior) > 0 THEN
		_anterior := substr(_anterior, 1, length(_anterior) - 1);
	END IF;

	
	-- contacto animales del paciente referidos al historico
	DELETE FROM contactos_animales WHERE id_his = _id_his;

	_arr := STRING_TO_ARRAY(_str_con_ani,',');
	IF (ARRAY_UPPER(_arr,1) > 0)THEN
		FOR i IN 1..(ARRAY_UPPER(_arr,1)) LOOP
			-- Verificando si el id del animal es igual al id del animal otros que viene por parametro
			IF (_id_otr_ani = _arr[i])THEN
				INSERT INTO contactos_animales (
					id_his,
					id_ani,
					otr_ani					
				) VALUES (
					_id_his,
					_arr[i],
					_str_otr_ani					
				);				
			ELSE
				INSERT INTO contactos_animales (
					id_his,
					id_ani					
				) VALUES (
					_id_his,
					_arr[i]
				);
			END IF;
			
			
			/*Busco el registro actual del contacto con animales del paciante*/
			SELECT nom_ani INTO _reg_act FROM contactos_animales LEFT JOIN animales USING(id_ani) WHERE id_ani = _arr[i];
			_actual := _actual || _reg_act.nom_ani || ' ,';
		END LOOP;
	END IF;

	/* Se le quita la última de las comas a la variable */
	IF length(_actual) > 0 THEN
		_actual := substr(_actual, 1, length(_actual) - 1);
	END IF;	

	/* Se identifica la tabla en el formato xml */
	_valorcampos := _valorcampos || '<tabla nombre="contactos_animales">';
	/* Se completa el tag con el valor del campo */
		_valorcampos := _valorcampos || 
		formato_campo_xml('Animales', coalesce(_actual::text, 'ninguno'), coalesce(_anterior::text));
	/* Se cierra el tag de la tabla */
	_valorcampos := _valorcampos || '</tabla>';

	

	/****************************************TRATAMIENTOS********************************************/

	/*Busco el registro anterior del tratamiento del paciante*/
	FOR _reg_ant IN (SELECT nom_tra FROM tratamientos_pacientes LEFT JOIN tratamientos USING(id_tra) WHERE id_his = _id_his) LOOP
		_anterior := _anterior || _reg_ant.nom_tra || ' ,';
	END LOOP;

	/* Se le quita la última de las comas a la variable */
	IF length(_anterior) > 0 THEN
		_anterior := substr(_anterior, 1, length(_anterior) - 1);
	END IF;

	
	-- Tratamientos del paciente referidos al historico
	DELETE FROM tratamientos_pacientes WHERE id_his = _id_his;

	_arr := STRING_TO_ARRAY(_str_tra_pre,',');
	IF (ARRAY_UPPER(_arr,1) > 0)THEN
		FOR i IN 1..(ARRAY_UPPER(_arr,1)) LOOP
		
			IF (_id_otr_tra = _arr[i])THEN
				INSERT INTO tratamientos_pacientes (
					id_his,
					id_tra,
					otr_tra					
				) VALUES (
					_id_his,
					_arr[i],
					_str_otr_tra
				);
			ELSE
				INSERT INTO tratamientos_pacientes (
					id_his,
					id_tra					
				) VALUES (
					_id_his,
					_arr[i]
				);
			END IF;
			/*Busco el registro actual del tratamiento del paciante*/
			SELECT nom_tra INTO _reg_act FROM tratamientos_pacientes LEFT JOIN tratamientos USING(id_tra) WHERE id_tra = _arr[i];
			_actual := _actual || _reg_act.nom_tra || ' ,';
		END LOOP;
	END IF;

	/* Se le quita la última de las comas a la variable */
	IF length(_actual) > 0 THEN
		_actual := substr(_actual, 1, length(_actual) - 1);
	END IF;	

	/* Se identifica la tabla en el formato xml */
	_valorcampos := _valorcampos || '<tabla nombre="tratamientos_pacientes">';
	/* Se completa el tag con el valor del campo */
		_valorcampos := _valorcampos || 
		formato_campo_xml('Tratamientos', coalesce(_actual::text, 'ninguno'), coalesce(_anterior::text));
	/* Se cierra el tag de la tabla */
	_valorcampos := _valorcampos || '</tabla>';
	
	

	/****************************************TIEMPO DE EVOLUCIÓN********************************************/

	/*Busco el registro anterior del Tiempo de Evolución del paciante*/
	SELECT tie_evo INTO _reg_ant FROM tiempo_evoluciones WHERE id_his = _id_his;
	
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

	/*Busco el registro anterior del Tiempo de Evolución del paciante*/
	SELECT tie_evo INTO _reg_act FROM tiempo_evoluciones WHERE id_his = _id_his;

	/* Se identifica la tabla en el formato xml */
	_valorcampos := _valorcampos || '<tabla nombre="tiempo_evoluciones">';
	/* Se completa el tag con el valor del campo */
		_valorcampos := _valorcampos || 
		formato_campo_xml('Evolución', coalesce(_reg_act.tie_evo::text, 'ninguno'), coalesce(_reg_ant.tie_evo::text));
	/* Se cierra el tag de la tabla */
	_valorcampos := _valorcampos || '</tabla>';

	_valorcampos := _valorcampos || '</Información_adicional>';


	--raise notice '_valorcampos5-->%',_valorcampos;
	
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
	
	RETURN 1;

END;$_$;
 O   DROP FUNCTION public.med_registrar_informacion_adicional(character varying[]);
       public       desarrollo_g    false    476    7            K	           0    0 A   FUNCTION med_registrar_informacion_adicional(character varying[])    COMMENT     �  COMMENT ON FUNCTION med_registrar_informacion_adicional(character varying[]) IS '
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
	8: Código de la transaccion		

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
                ''6'',
				''IAP''               
                ]
            ) AS result 

AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 09/06/2011

AUTOR DE MODIFICACIÓN: Lisseth Lozada
FECHA DE MODIFICACIÓN: 16/08/2011
DESCRIPCIÓN: Se agregó en la función el armado del xml para la inserción de la auditoría de las transacciones.

AUTOR DE MODIFICACIÓN: Luis Marin
FECHA DE MODIFICACIÓN:14/12/2011
DESCRIPCIÓN: Se agregó la opción de poder agregar otros animales.
';
            public       desarrollo_g    false    33                         1255    30813 +   med_registrar_paciente(character varying[])    FUNCTION       CREATE FUNCTION med_registrar_paciente(character varying[]) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$
DECLARE
	_datos ALIAS FOR $1;

	-- informacion del paciente
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
	_id_mun		pacientes.id_mun%TYPE;
	_id_par		pacientes.id_par%TYPE;	
	_sex_pac	pacientes.sex_pac%TYPE;
	_tra_usu	transacciones.cod_tip_tra%TYPE;
	_str_ant_per	TEXT;
	_arr_ant_per	INTEGER[];
	_valorcampos 	VARCHAR := '';
	_des_ant_per 	VARCHAR := '';
	
	_info		RECORD;
	_reg_pac	RECORD;
	_reg_act	RECORD;
	_reg_usu	RECORD;
	_reg_tra	RECORD;
	
	

	-- informacion del doctor

	_id_doc		doctores.id_doc%TYPE;
	
BEGIN
	-- pacientes
	_nom_pac 	:= _datos[1];
	_ape_pac 	:= _datos[2];
	_ced_pac	:= _datos[3];
	_fec_nac_pac 	:= _datos[4];
	_nac_pac 	:= _datos[5];
	_tel_hab_pac	:= _datos[6];
	_tel_cel_pac	:= _datos[7];
	_ocu_pac	:= _datos[8];
	_ciu_pac	:= _datos[9];
	_id_pai		:= _datos[10];
	_id_est		:= _datos[11];
	_id_mun		:= _datos[12];
	_str_ant_per	:= _datos[13];
	_id_doc		:= _datos[14];
	_tra_usu	:= _datos[15];
	_sex_pac	:= _datos[16];

	-- centros de salud pacientes
	

	/* validando pacientes */
	IF NOT EXISTS (SELECT 1 FROM pacientes WHERE ced_pac = _ced_pac) THEN     		
		
		/*insertando pacientes*/
		INSERT INTO pacientes
		(
			nom_pac,	
			ape_pac, 	
			ced_pac,	
			fec_nac_pac, 	
			nac_pac, 	
			tel_hab_pac,	
			tel_cel_pac,	
			ocu_pac,	
			ciu_pac,	
			id_pai,		
			id_est,		
			id_mun,
			num_pac,
			id_doc,
			sex_pac		
		)
		VALUES 
		(
			_nom_pac, 	
			_ape_pac, 	
			_ced_pac,	
			_fec_nac_pac, 	
			_nac_pac, 	
			_tel_hab_pac,	
			_tel_cel_pac,	
			_ocu_pac,	
			_ciu_pac,	
			_id_pai,		
			_id_est,		
			_id_mun,
			((SELECT COUNT(id_pac) FROM pacientes )::INTEGER)+1,
			_id_doc,
			_sex_pac
		);

		/*Busco el registro anterior del paciente*/
		SELECT 	p.des_pai, e.des_est, m.des_mun,
			CASE 
				WHEN pa.nac_pac = '1' THEN 'Venezolano' ELSE 'Extranjero' 
			END AS nac_pac,
			CASE 
				WHEN pa.ocu_pac = '1' THEN 'Profesional'
				WHEN pa.ocu_pac = '2' THEN 'Técnico'
				WHEN pa.ocu_pac = '3' THEN 'Obrero'
				WHEN pa.ocu_pac = '4' THEN 'Agricultor'
				WHEN pa.ocu_pac = '5' THEN 'Jardinero'
				WHEN pa.ocu_pac = '6' THEN 'Otro'
			END AS ocu_pac  INTO _reg_pac
		FROM pacientes pa
			LEFT JOIN paises p USING(id_pai)
			LEFT JOIN estados e ON(p.id_pai = e.id_pai)
			LEFT JOIN municipios m ON(e.id_est = m.id_est)
		WHERE pa.id_pac = CURRVAL('pacientes_id_pac_seq')
			AND p.id_pai = _id_pai
			AND e.id_est = _id_est
			AND m.id_mun = _id_mun;


		/* Se coloca el encabezado para los valores de los campos, así como el tag raíz y el inicio del tag tabla */
		_valorcampos := '<?xml version="1.0" encoding="UTF-8" standalone="yes" ?><registro_de_pacientes>
				 <tabla nombre="pacientes">';
				_valorcampos := _valorcampos || 
				formato_campo_xml('ID', 		coalesce(_id_doc::text, 'ninguno'), 		'ninguno')||
				formato_campo_xml('Nombre',  		coalesce(_nom_pac::text, 'ninguno'), 		'ninguno')||
				formato_campo_xml('Apellido', 		coalesce(_ape_pac::text, 'ninguno'), 		'ninguno')||
				formato_campo_xml('Cédula', 		coalesce(_ced_pac::text, 'ninguno'), 		'ninguno')||  
				formato_campo_xml('Fecha Nacimiento', 	coalesce(_fec_nac_pac::text, 'ninguno'), 	'ninguno')||
				formato_campo_xml('Sexo', 		coalesce(_sex_pac::text, 'ninguno'), 		'ninguno')||   
				formato_campo_xml('Nacionalidad', 	coalesce(_reg_pac.nac_pac::text, 'ninguno'), 	'ninguno')||  
				formato_campo_xml('Teléfono Habitación',coalesce(_tel_hab_pac::text, 'ninguno'), 	'ninguno')||
				formato_campo_xml('Teléfono Célular', 	coalesce(_tel_cel_pac::text, 'ninguno'), 	'ninguno')|| 
				formato_campo_xml('Ocupación', 		coalesce(_reg_pac.ocu_pac::text, 'ninguno'), 	'ninguno')||
				formato_campo_xml('País', 		coalesce(_reg_pac.des_pai::text, 'ninguno'), 	'ninguno')||
				formato_campo_xml('Estado', 		coalesce(_reg_pac.des_est::text, 'ninguno'), 	'ninguno')||
				formato_campo_xml('Municipio', 		coalesce(_reg_pac.des_mun::text, 'ninguno'), 	'ninguno')||
				formato_campo_xml('Ciudad', 		coalesce(_ciu_pac::text, 'ninguno'), 		'ninguno');  
			/*ªª Se cierra el tag de la tabla */
			_valorcampos := _valorcampos || '</tabla>';
		

		/* Antecedentes personales*/
		_arr_ant_per := STRING_TO_ARRAY(_str_ant_per,',');
		IF (ARRAY_UPPER(_arr_ant_per,1) > 0)THEN
			FOR i IN 1..(ARRAY_UPPER(_arr_ant_per,1)) LOOP
				INSERT INTO antecedentes_pacientes(
					id_pac,
					id_ant_per
				)
				VALUES
				(
					(CURRVAL('pacientes_id_pac_seq')),
					_arr_ant_per[i]
				);

				SELECT nom_ant_per INTO _info FROM antecedentes_personales WHERE id_ant_per = _arr_ant_per[i];
				_des_ant_per := _des_ant_per || _info.nom_ant_per || ' ,';
			END LOOP;
		END IF;	
		
		/* Se le quita la última de las comas a la variable */
		IF length(_des_ant_per) > 0 THEN
			_des_ant_per := substr(_des_ant_per, 1, length(_des_ant_per) - 1);
		END IF;	
			
			/* Se identifica la tabla en el formato xml */
			_valorcampos := _valorcampos || '<tabla nombre="antecedentes_personales">';
			/* Se completa el tag con el valor del campo */
				_valorcampos := _valorcampos || 
				formato_campo_xml('Antecedentes Personales', coalesce(_des_ant_per::text, 'ninguno'), 'ninguno');
			/* Se cierra el tag de la tabla */
			_valorcampos := _valorcampos || '</tabla>';
			
		_valorcampos := _valorcampos || '</registro_de_pacientes>';	

		
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
		
		-- La función se ejecutó exitosamente
		RETURN 1;
	ELSE
		-- Existe un usuario administrativo con el mismo login
		RETURN 0;
	END IF;

END;$_$;
 B   DROP FUNCTION public.med_registrar_paciente(character varying[]);
       public       desarrollo_g    false    7    476            L	           0    0 4   FUNCTION med_registrar_paciente(character varying[])    COMMENT       COMMENT ON FUNCTION med_registrar_paciente(character varying[]) IS '
NOMBRE: med_registrar_paciente
TIPO: Function (store procedure)

PARAMETROS: Recibe 12 Parámetros
	1:  Nombre paciente
	2:  Apellido del paciente
	3:  Cédula del paciente
	4:  Fecha de nacimiento del paciente
	5:  Nacionalidad del paciente
	6:  Teléfono de habitacion del paciente
	7:  Teléfono de celular del paciente
	8:  Ocupacion del paciente
	9:  Ciudad donde se encuentra el paciente
	10: Id del pais donde vive el paciente
	11: Id del estado donde vive el paciente.
	12: Id del municipio donde vive el paciente.
	13: Id de los antecedentes personales
	14: Id del doctor quien realizo la transacción
	15: Código de la transaccion
	16: Sexo del paciente
	

DESCRIPCION: 
	Almacena la información de los pacientes

RETORNO:
	1: La función se ejecutó exitosamente
	0: Existe un usuario administrativo con el mismo login
	 
EJEMPLO DE LLAMADA:
	SELECT med_registrar_paciente(ARRAY[
                ''prueba'', 
                ''prueba'', 
                ''1789654233'',     
                ''1988-08-08'',
                ''1'',
                ''02129514789'',
                ''04269150755'',
                ''1'',
                ''guarenas'',
                ''1'',
                ''14'',
                ''193'',
                ''2,3,4,8'',
                ''32'',
                ''RP''
                ''F''
            ]) AS result

AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 09/06/2011

AUTOR DE MODIFICACIÓN: Lisseth Lozada
FECHA DE MODIFICACIÓN: 16/08/2011
DESCRIPCIÓN: Se agregó en la función el armado del xml para la inserción de la auditoría de las transacciones.

AUTOR DE MODIFICACIÓN: Lisseth Lozada
FECHA DE MODIFICACIÓN: 24/10/2011
DESCRIPCIÓN: Se agregó en la función un nuevo campo sex_pac.
';
            public       desarrollo_g    false    32            "            1255    30815 &   reg_transacciones(character varying[])    FUNCTION     v  CREATE FUNCTION reg_transacciones(character varying[]) RETURNS void
    LANGUAGE plpgsql
    AS $_$
DECLARE
	_datos ALIAS 	FOR $1;

	_id_tip_usu_usu		auditoria_transacciones.id_tip_usu_usu%TYPE;
	_id_tip_tra		auditoria_transacciones.id_tip_tra%TYPE;	
	_xml			auditoria_transacciones.data_xml%TYPE;	
	
BEGIN
	_id_tip_usu_usu := _datos[1];
	_id_tip_tra 	:= _datos[2];
	_xml 		:= _datos[3]::XML;

	_xml := '<?xml version="1.0" encoding="UTF-8" ?>' || _xml;

	INSERT INTO auditoria_transacciones(
		fec_aud_tra,
		id_tip_usu_usu,
		id_tip_tra,
		data_xml
	) VALUES (
		now(),
		_id_tip_usu_usu,
		_id_tip_tra,
		_xml		
	);

END;
$_$;
 =   DROP FUNCTION public.reg_transacciones(character varying[]);
       public       desarrollo_g    false    7    476            M	           0    0 /   FUNCTION reg_transacciones(character varying[])    COMMENT     �  COMMENT ON FUNCTION reg_transacciones(character varying[]) IS '
NOMBRE: reg_transacciones
TIPO: Function (store procedure)

PARAMETROS: Recibe 7 Parámetros
	1:  Id del tipo de usuarios usuarios (id_tip_usu_usu)
	2:  Id tip de transacciones de la tabla transacciones
	3:  XML de las tablas a modificar	

DESCRIPCION: 
	Almacena la información de las transacciones de las tablas y los atributos, todas estas transacciones son originadas por los usuarios

RETORNO:
	void
	 
EJEMPLO DE LLAMADA:
	SELECT reg_transacciones(ARRAY[''1'',''1'',''<?xml version="1.0" encoding="UTF-8" ?>'']);

AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 05/06/2011

';
            public       desarrollo_g    false    34            #            1255    30816 "   validar_usuarios(text, text, text)    FUNCTION     �  CREATE FUNCTION validar_usuarios(_log_usu text, _pas_usu text, _tip_usu text) RETURNS SETOF t_validar_usuarios
    LANGUAGE plpgsql
    AS $_$

DECLARE
	--datos ALIAS FOR $1;
			
	_id_udu_adm		usuarios_administrativos.id_usu_adm%TYPE;
	_nom_usu_adm		usuarios_administrativos.nom_usu_adm%TYPE;
	_ape_usu_adm		usuarios_administrativos.ape_usu_adm%TYPE;
	_pas_usu_adm		usuarios_administrativos.pas_usu_adm%TYPE;
	_log_usu_adm		usuarios_administrativos.log_usu_adm%TYPE;
	_tel_usu_adm		usuarios_administrativos.tel_usu_adm%TYPE;
	_id_tip_usu		tipos_usuarios.id_tip_usu%TYPE;
	_cod_tip_usu		tipos_usuarios.cod_tip_usu%TYPE;
	_t_val_usu		t_validar_usuarios%ROWTYPE;
	_vr_usu		RECORD;
BEGIN


	CASE _tip_usu

		WHEN 'adm' THEN

			IF EXISTS( SELECT 1 FROM usuarios_administrativos WHERE log_usu_adm = _log_usu) THEN
				
				SELECT ua.id_usu_adm, ua.nom_usu_adm, ua.ape_usu_adm, ua.log_usu_adm, ua.tel_usu_adm, tu.id_tip_usu, tu.cod_tip_usu, tu.des_tip_usu, tuu.id_tip_usu_usu INTO _vr_usu  FROM 
				usuarios_administrativos ua
				LEFT JOIN tipos_usuarios__usuarios tuu ON (ua.id_usu_adm = tuu.id_usu_adm)
				LEFT JOIN tipos_usuarios tu ON (tuu.id_tip_usu = tu.id_tip_usu)
				WHERE ua.log_usu_adm = _log_usu
				AND ua.pas_usu_adm = md5(_pas_usu)
				AND tu.cod_tip_usu = _tip_usu;
				
				_t_val_usu.str_trans := ARRAY_TO_STRING (
					ARRAY	(
							SELECT t.cod_tip_tra 
							FROM transacciones_usuarios tu 
							LEFT JOIN transacciones t ON(tu.id_tip_tra = t.id_tip_tra)
							LEFT JOIN tipos_usuarios__usuarios ttu ON(ttu.id_tip_usu_usu = tu.id_tip_usu_usu)
							WHERE ttu.id_tip_usu_usu = _vr_usu.id_tip_usu_usu
					)
				,',');

				_t_val_usu.id_usu 		:=	_vr_usu.id_usu_adm;
				_t_val_usu.nom_usu		:=	_vr_usu.nom_usu_adm;
				_t_val_usu.ape_usu 		:=	_vr_usu.ape_usu_adm;
				_t_val_usu.pas_usu 		:=	'no colocado';
				_t_val_usu.log_usu 		:=	_vr_usu.log_usu_adm;
				_t_val_usu.tel_usu 		:=	_vr_usu.tel_usu_adm;
				_t_val_usu.id_tip_usu 		:=	_vr_usu.id_tip_usu;
				_t_val_usu.id_tip_usu_usu 	:=	_vr_usu.id_tip_usu_usu;				
				_t_val_usu.cod_tip_usu 		:=	_vr_usu.cod_tip_usu;				
				_t_val_usu.des_tip_usu 		:=	_vr_usu.des_tip_usu;
				
			END IF;
			
		WHEN 'med' THEN		
			IF EXISTS( SELECT 1 FROM doctores WHERE log_doc = _log_usu) THEN				
				SELECT d.id_doc, d.nom_doc, d.ape_doc, d.log_doc, d.tel_doc, tu.id_tip_usu, tu.cod_tip_usu, tu.des_tip_usu, tuu.id_tip_usu_usu INTO _vr_usu  FROM 
				doctores d
				LEFT JOIN tipos_usuarios__usuarios tuu ON (d.id_doc = tuu.id_doc)
				LEFT JOIN tipos_usuarios tu ON (tuu.id_tip_usu = tu.id_tip_usu)
				WHERE d.log_doc = _log_usu
				AND d.pas_doc = md5(_pas_usu)
				AND tu.cod_tip_usu = _tip_usu;
				
				_t_val_usu.str_trans := ARRAY_TO_STRING (
					ARRAY	(
							SELECT t.cod_tip_tra 
							FROM transacciones_usuarios tu 
							LEFT JOIN transacciones t ON(tu.id_tip_tra = t.id_tip_tra)
							LEFT JOIN tipos_usuarios__usuarios ttu ON(ttu.id_tip_usu_usu = tu.id_tip_usu_usu)
							WHERE ttu.id_tip_usu_usu = _vr_usu.id_tip_usu_usu
					)
				,',');

				_t_val_usu.id_usu 		:=	_vr_usu.id_doc;
				_t_val_usu.nom_usu		:=	_vr_usu.nom_doc;
				_t_val_usu.ape_usu 		:=	_vr_usu.ape_doc;
				_t_val_usu.pas_usu 		:=	'no colocado';
				_t_val_usu.log_usu 		:=	_vr_usu.log_doc;
				_t_val_usu.tel_usu 		:=	_vr_usu.tel_doc;
				_t_val_usu.id_tip_usu 		:=	_vr_usu.id_tip_usu;
				_t_val_usu.id_tip_usu_usu 	:=	_vr_usu.id_tip_usu_usu;				
				_t_val_usu.cod_tip_usu 		:=	_vr_usu.cod_tip_usu;				
				_t_val_usu.des_tip_usu 		:=	_vr_usu.des_tip_usu;
				
			END IF;
	END CASE;
	
	RETURN NEXT _t_val_usu;
	
END;
$_$;
 T   DROP FUNCTION public.validar_usuarios(_log_usu text, _pas_usu text, _tip_usu text);
       public       desarrollo_g    false    476    7    326            N	           0    0 F   FUNCTION validar_usuarios(_log_usu text, _pas_usu text, _tip_usu text)    COMMENT     B  COMMENT ON FUNCTION validar_usuarios(_log_usu text, _pas_usu text, _tip_usu text) IS '
NOMBRE: validar_usuarios
TIPO: Function (store procedure)
PARAMETROS: 
	1:  Nombre de la empresa 
	2:  Login de la empresa
	3:  Password de seguridad

EJEMPLO: SELECT str_mods FROM validar_usuarios(''hitokiri83'',''123'',''adm'');

';
            public       desarrollo_g    false    35            �           1259    30817    animales    TABLE     Z   CREATE TABLE animales (
    id_ani integer NOT NULL,
    nom_ani character varying(20)
);
    DROP TABLE public.animales;
       public    saib    desarrollo_g    false    7            �           1259    30820    animales_id_ani_seq    SEQUENCE     u   CREATE SEQUENCE animales_id_ani_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.animales_id_ani_seq;
       public       desarrollo_g    false    1669    7            O	           0    0    animales_id_ani_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE animales_id_ani_seq OWNED BY animales.id_ani;
            public       desarrollo_g    false    1670            P	           0    0    animales_id_ani_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('animales_id_ani_seq', 1, false);
            public       desarrollo_g    false    1670            �           1259    30822    antecedentes_pacientes    TABLE     ~   CREATE TABLE antecedentes_pacientes (
    id_ant_pac integer NOT NULL,
    id_ant_per integer NOT NULL,
    id_pac integer
);
 *   DROP TABLE public.antecedentes_pacientes;
       public    saib    desarrollo_g    false    7            �           1259    30825 %   antecedentes_pacientes_id_ant_pac_seq    SEQUENCE     �   CREATE SEQUENCE antecedentes_pacientes_id_ant_pac_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 <   DROP SEQUENCE public.antecedentes_pacientes_id_ant_pac_seq;
       public       desarrollo_g    false    7    1671            Q	           0    0 %   antecedentes_pacientes_id_ant_pac_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE antecedentes_pacientes_id_ant_pac_seq OWNED BY antecedentes_pacientes.id_ant_pac;
            public       desarrollo_g    false    1672            R	           0    0 %   antecedentes_pacientes_id_ant_pac_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('antecedentes_pacientes_id_ant_pac_seq', 40, true);
            public       desarrollo_g    false    1672            �           1259    30827    antecedentes_personales    TABLE     r   CREATE TABLE antecedentes_personales (
    id_ant_per integer NOT NULL,
    nom_ant_per character varying(100)
);
 +   DROP TABLE public.antecedentes_personales;
       public    saib    desarrollo_g    false    7            �           1259    30830 &   antecedentes_personales_id_ant_per_seq    SEQUENCE     �   CREATE SEQUENCE antecedentes_personales_id_ant_per_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 =   DROP SEQUENCE public.antecedentes_personales_id_ant_per_seq;
       public       desarrollo_g    false    1673    7            S	           0    0 &   antecedentes_personales_id_ant_per_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE antecedentes_personales_id_ant_per_seq OWNED BY antecedentes_personales.id_ant_per;
            public       desarrollo_g    false    1674            T	           0    0 &   antecedentes_personales_id_ant_per_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('antecedentes_personales_id_ant_per_seq', 1, false);
            public       desarrollo_g    false    1674            �           1259    30832    auditoria_transacciones    TABLE     �   CREATE TABLE auditoria_transacciones (
    id_aud_tra integer NOT NULL,
    fec_aud_tra timestamp without time zone,
    id_tip_usu_usu integer NOT NULL,
    id_tip_tra integer NOT NULL,
    data_xml xml
);
 +   DROP TABLE public.auditoria_transacciones;
       public    saib    desarrollo_g    false    7            U	           0    0    TABLE auditoria_transacciones    COMMENT     f   COMMENT ON TABLE auditoria_transacciones IS 'Se guarda todos los eventos generados por los usuarios';
            public       desarrollo_g    false    1675            V	           0    0 '   COLUMN auditoria_transacciones.data_xml    COMMENT     �   COMMENT ON COLUMN auditoria_transacciones.data_xml IS 'Se guarda las modificaciones de la tabla y atributos realizada por los usuarios, todo en forma de XML';
            public       desarrollo_g    false    1675            �           1259    30838 &   auditoria_transacciones_id_aud_tra_seq    SEQUENCE     �   CREATE SEQUENCE auditoria_transacciones_id_aud_tra_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 =   DROP SEQUENCE public.auditoria_transacciones_id_aud_tra_seq;
       public       desarrollo_g    false    1675    7            W	           0    0 &   auditoria_transacciones_id_aud_tra_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE auditoria_transacciones_id_aud_tra_seq OWNED BY auditoria_transacciones.id_aud_tra;
            public       desarrollo_g    false    1676            X	           0    0 &   auditoria_transacciones_id_aud_tra_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('auditoria_transacciones_id_aud_tra_seq', 56, true);
            public       desarrollo_g    false    1676            �           1259    30840    categorias__cuerpos_micosis    TABLE     �   CREATE TABLE categorias__cuerpos_micosis (
    id_cat_cue_mic integer NOT NULL,
    id_cat_cue integer NOT NULL,
    id_tip_mic integer NOT NULL
);
 /   DROP TABLE public.categorias__cuerpos_micosis;
       public    saib    desarrollo_g    false    7            �           1259    30843 .   categorias__cuerpos_micosis_id_cat_cue_mic_seq    SEQUENCE     �   CREATE SEQUENCE categorias__cuerpos_micosis_id_cat_cue_mic_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 E   DROP SEQUENCE public.categorias__cuerpos_micosis_id_cat_cue_mic_seq;
       public       desarrollo_g    false    7    1677            Y	           0    0 .   categorias__cuerpos_micosis_id_cat_cue_mic_seq    SEQUENCE OWNED BY     s   ALTER SEQUENCE categorias__cuerpos_micosis_id_cat_cue_mic_seq OWNED BY categorias__cuerpos_micosis.id_cat_cue_mic;
            public       desarrollo_g    false    1678            Z	           0    0 .   categorias__cuerpos_micosis_id_cat_cue_mic_seq    SEQUENCE SET     V   SELECT pg_catalog.setval('categorias__cuerpos_micosis_id_cat_cue_mic_seq', 17, true);
            public       desarrollo_g    false    1678            �           1259    30845    categorias_cuerpos    TABLE     l   CREATE TABLE categorias_cuerpos (
    id_cat_cue integer NOT NULL,
    nom_cat_cue character varying(20)
);
 &   DROP TABLE public.categorias_cuerpos;
       public    saib    desarrollo_g    false    7            �           1259    30848    categorias_cuerpos__lesiones    TABLE        CREATE TABLE categorias_cuerpos__lesiones (
    id_cat_cue_les integer NOT NULL,
    id_les integer,
    id_cat_cue integer
);
 0   DROP TABLE public.categorias_cuerpos__lesiones;
       public    saib    desarrollo_g    false    7            �           1259    30851 !   categorias_cuerpos_id_cat_cue_seq    SEQUENCE     �   CREATE SEQUENCE categorias_cuerpos_id_cat_cue_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.categorias_cuerpos_id_cat_cue_seq;
       public       desarrollo_g    false    1679    7            [	           0    0 !   categorias_cuerpos_id_cat_cue_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE categorias_cuerpos_id_cat_cue_seq OWNED BY categorias_cuerpos.id_cat_cue;
            public       desarrollo_g    false    1681            \	           0    0 !   categorias_cuerpos_id_cat_cue_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('categorias_cuerpos_id_cat_cue_seq', 4, true);
            public       desarrollo_g    false    1681            �           1259    30853    centro_salud_doctores    TABLE     �   CREATE TABLE centro_salud_doctores (
    id_cen_sal_doc integer NOT NULL,
    id_cen_sal integer NOT NULL,
    id_doc integer NOT NULL,
    otr_cen_sal character varying(100)
);
 )   DROP TABLE public.centro_salud_doctores;
       public         desarrollo_g    false    7            ]	           0    0 +   COLUMN centro_salud_doctores.id_cen_sal_doc    COMMENT     l   COMMENT ON COLUMN centro_salud_doctores.id_cen_sal_doc IS 'Identificación del Centro de Salud del doctor';
            public       desarrollo_g    false    1682            ^	           0    0 '   COLUMN centro_salud_doctores.id_cen_sal    COMMENT     ]   COMMENT ON COLUMN centro_salud_doctores.id_cen_sal IS 'Identificación del Centro de Salud';
            public       desarrollo_g    false    1682            _	           0    0 #   COLUMN centro_salud_doctores.id_doc    COMMENT     P   COMMENT ON COLUMN centro_salud_doctores.id_doc IS 'Identificación del doctor';
            public       desarrollo_g    false    1682            `	           0    0 (   COLUMN centro_salud_doctores.otr_cen_sal    COMMENT     O   COMMENT ON COLUMN centro_salud_doctores.otr_cen_sal IS 'Otro Centro de Salud';
            public       desarrollo_g    false    1682            �           1259    30856 (   centro_salud_doctores_id_cen_sal_doc_seq    SEQUENCE     �   CREATE SEQUENCE centro_salud_doctores_id_cen_sal_doc_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ?   DROP SEQUENCE public.centro_salud_doctores_id_cen_sal_doc_seq;
       public       desarrollo_g    false    7    1682            a	           0    0 (   centro_salud_doctores_id_cen_sal_doc_seq    SEQUENCE OWNED BY     g   ALTER SEQUENCE centro_salud_doctores_id_cen_sal_doc_seq OWNED BY centro_salud_doctores.id_cen_sal_doc;
            public       desarrollo_g    false    1683            b	           0    0 (   centro_salud_doctores_id_cen_sal_doc_seq    SEQUENCE SET     P   SELECT pg_catalog.setval('centro_salud_doctores_id_cen_sal_doc_seq', 11, true);
            public       desarrollo_g    false    1683            �           1259    30858    centro_saluds    TABLE     �   CREATE TABLE centro_saluds (
    id_cen_sal integer NOT NULL,
    nom_cen_sal character varying(100) NOT NULL,
    des_cen_sal character varying(100)
);
 !   DROP TABLE public.centro_saluds;
       public    saib    desarrollo_g    false    7            �           1259    30861    centro_salud_id_cen_sal_seq    SEQUENCE     }   CREATE SEQUENCE centro_salud_id_cen_sal_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.centro_salud_id_cen_sal_seq;
       public       desarrollo_g    false    7    1684            c	           0    0    centro_salud_id_cen_sal_seq    SEQUENCE OWNED BY     N   ALTER SEQUENCE centro_salud_id_cen_sal_seq OWNED BY centro_saluds.id_cen_sal;
            public       desarrollo_g    false    1685            d	           0    0    centro_salud_id_cen_sal_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('centro_salud_id_cen_sal_seq', 35, true);
            public       desarrollo_g    false    1685            �           1259    30863    centro_salud_pacientes    TABLE     �   CREATE TABLE centro_salud_pacientes (
    id_cen_sal_pac integer NOT NULL,
    id_his integer NOT NULL,
    id_cen_sal integer NOT NULL,
    otr_cen_sal character varying(20)
);
 *   DROP TABLE public.centro_salud_pacientes;
       public    saib    desarrollo_g    false    7            �           1259    30866 )   centro_salud_pacientes_id_cen_sal_pac_seq    SEQUENCE     �   CREATE SEQUENCE centro_salud_pacientes_id_cen_sal_pac_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 @   DROP SEQUENCE public.centro_salud_pacientes_id_cen_sal_pac_seq;
       public       desarrollo_g    false    1686    7            e	           0    0 )   centro_salud_pacientes_id_cen_sal_pac_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE centro_salud_pacientes_id_cen_sal_pac_seq OWNED BY centro_salud_pacientes.id_cen_sal_pac;
            public       desarrollo_g    false    1687            f	           0    0 )   centro_salud_pacientes_id_cen_sal_pac_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('centro_salud_pacientes_id_cen_sal_pac_seq', 198, true);
            public       desarrollo_g    false    1687            �           1259    30868    contactos_animales    TABLE     �   CREATE TABLE contactos_animales (
    id_con_ani integer NOT NULL,
    id_his integer NOT NULL,
    id_ani integer NOT NULL,
    otr_ani character varying(20)
);
 &   DROP TABLE public.contactos_animales;
       public    saib    desarrollo_g    false    7            �           1259    30871 !   contactos_animales_id_con_ani_seq    SEQUENCE     �   CREATE SEQUENCE contactos_animales_id_con_ani_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.contactos_animales_id_con_ani_seq;
       public       desarrollo_g    false    7    1688            g	           0    0 !   contactos_animales_id_con_ani_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE contactos_animales_id_con_ani_seq OWNED BY contactos_animales.id_con_ani;
            public       desarrollo_g    false    1689            h	           0    0 !   contactos_animales_id_con_ani_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('contactos_animales_id_con_ani_seq', 173, true);
            public       desarrollo_g    false    1689            �           1259    30873    doctores    TABLE     j  CREATE TABLE doctores (
    id_doc integer NOT NULL,
    nom_doc character varying(100),
    ape_doc character varying(100),
    ced_doc character varying(20),
    pas_doc character varying(100),
    tel_doc character varying(100),
    cor_doc character varying(100),
    log_doc character varying(100),
    fec_reg_doc timestamp with time zone DEFAULT now()
);
    DROP TABLE public.doctores;
       public    saib    desarrollo_g    false    2054    7            i	           0    0    TABLE doctores    COMMENT     R   COMMENT ON TABLE doctores IS 'Registro de todos los doctores que del aplicativo';
            public       desarrollo_g    false    1690            j	           0    0    COLUMN doctores.id_doc    COMMENT     O   COMMENT ON COLUMN doctores.id_doc IS 'identificador único para los doctores';
            public       desarrollo_g    false    1690            k	           0    0    COLUMN doctores.nom_doc    COMMENT     ;   COMMENT ON COLUMN doctores.nom_doc IS 'Nombre del doctor';
            public       desarrollo_g    false    1690            l	           0    0    COLUMN doctores.ape_doc    COMMENT     =   COMMENT ON COLUMN doctores.ape_doc IS 'Apellido del doctor';
            public       desarrollo_g    false    1690            m	           0    0    COLUMN doctores.ced_doc    COMMENT     <   COMMENT ON COLUMN doctores.ced_doc IS 'Cédula del doctor';
            public       desarrollo_g    false    1690            n	           0    0    COLUMN doctores.pas_doc    COMMENT     @   COMMENT ON COLUMN doctores.pas_doc IS 'Contraseña del doctor';
            public       desarrollo_g    false    1690            o	           0    0    COLUMN doctores.tel_doc    COMMENT     >   COMMENT ON COLUMN doctores.tel_doc IS 'Teléfono del doctor';
            public       desarrollo_g    false    1690            p	           0    0    COLUMN doctores.cor_doc    COMMENT     G   COMMENT ON COLUMN doctores.cor_doc IS 'Correo electronico del doctor';
            public       desarrollo_g    false    1690            q	           0    0    COLUMN doctores.log_doc    COMMENT     O   COMMENT ON COLUMN doctores.log_doc IS 'Login con el que se loguara el doctor';
            public       desarrollo_g    false    1690            �           1259    30880    doctores_id_doc_seq    SEQUENCE     u   CREATE SEQUENCE doctores_id_doc_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.doctores_id_doc_seq;
       public       desarrollo_g    false    1690    7            r	           0    0    doctores_id_doc_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE doctores_id_doc_seq OWNED BY doctores.id_doc;
            public       desarrollo_g    false    1691            s	           0    0    doctores_id_doc_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('doctores_id_doc_seq', 34, true);
            public       desarrollo_g    false    1691            �           1259    30882    enfermedades_micologicas    TABLE     �   CREATE TABLE enfermedades_micologicas (
    id_enf_mic integer NOT NULL,
    nom_enf_mic character varying(100) NOT NULL,
    id_tip_mic integer NOT NULL
);
 ,   DROP TABLE public.enfermedades_micologicas;
       public    saib    desarrollo_g    false    7            �           1259    30885 '   enfermedades_micologicas_id_enf_mic_seq    SEQUENCE     �   CREATE SEQUENCE enfermedades_micologicas_id_enf_mic_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 >   DROP SEQUENCE public.enfermedades_micologicas_id_enf_mic_seq;
       public       desarrollo_g    false    1692    7            t	           0    0 '   enfermedades_micologicas_id_enf_mic_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE enfermedades_micologicas_id_enf_mic_seq OWNED BY enfermedades_micologicas.id_enf_mic;
            public       desarrollo_g    false    1693            u	           0    0 '   enfermedades_micologicas_id_enf_mic_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('enfermedades_micologicas_id_enf_mic_seq', 28, true);
            public       desarrollo_g    false    1693            �           1259    30887    enfermedades_pacientes    TABLE     �   CREATE TABLE enfermedades_pacientes (
    id_enf_pac integer NOT NULL,
    id_enf_mic integer NOT NULL,
    otr_enf_mic character varying(20),
    esp_enf_mic character varying(20),
    id_tip_mic_pac integer
);
 *   DROP TABLE public.enfermedades_pacientes;
       public    saib    desarrollo_g    false    7            �           1259    30890 %   enfermedades_pacientes_id_enf_pac_seq    SEQUENCE     �   CREATE SEQUENCE enfermedades_pacientes_id_enf_pac_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 <   DROP SEQUENCE public.enfermedades_pacientes_id_enf_pac_seq;
       public       desarrollo_g    false    1694    7            v	           0    0 %   enfermedades_pacientes_id_enf_pac_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE enfermedades_pacientes_id_enf_pac_seq OWNED BY enfermedades_pacientes.id_enf_pac;
            public       desarrollo_g    false    1695            w	           0    0 %   enfermedades_pacientes_id_enf_pac_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('enfermedades_pacientes_id_enf_pac_seq', 368, true);
            public       desarrollo_g    false    1695            �           1259    30892    estados    TABLE     n   CREATE TABLE estados (
    id_est integer NOT NULL,
    des_est character varying(100),
    id_pai integer
);
    DROP TABLE public.estados;
       public         desarrollo_g    false    7            �           1259    30895    estados_id_est_seq    SEQUENCE     t   CREATE SEQUENCE estados_id_est_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.estados_id_est_seq;
       public       desarrollo_g    false    1696    7            x	           0    0    estados_id_est_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE estados_id_est_seq OWNED BY estados.id_est;
            public       desarrollo_g    false    1697            y	           0    0    estados_id_est_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('estados_id_est_seq', 6, true);
            public       desarrollo_g    false    1697            �           1259    30897    forma_infecciones    TABLE     l   CREATE TABLE forma_infecciones (
    id_for_inf integer NOT NULL,
    des_for_inf character varying(255)
);
 %   DROP TABLE public.forma_infecciones;
       public    saib    desarrollo_g    false    7            �           1259    30900    forma_infecciones__pacientes    TABLE     �   CREATE TABLE forma_infecciones__pacientes (
    id_for_pac integer NOT NULL,
    id_for_inf integer NOT NULL,
    otr_for_inf character varying(100),
    id_tip_mic_pac integer
);
 0   DROP TABLE public.forma_infecciones__pacientes;
       public    saib    desarrollo_g    false    7            �           1259    30903 +   forma_infecciones__pacientes_id_for_pac_seq    SEQUENCE     �   CREATE SEQUENCE forma_infecciones__pacientes_id_for_pac_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 B   DROP SEQUENCE public.forma_infecciones__pacientes_id_for_pac_seq;
       public       desarrollo_g    false    7    1699            z	           0    0 +   forma_infecciones__pacientes_id_for_pac_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE forma_infecciones__pacientes_id_for_pac_seq OWNED BY forma_infecciones__pacientes.id_for_pac;
            public       desarrollo_g    false    1700            {	           0    0 +   forma_infecciones__pacientes_id_for_pac_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('forma_infecciones__pacientes_id_for_pac_seq', 55, true);
            public       desarrollo_g    false    1700            �           1259    30905     forma_infecciones__tipos_micosis    TABLE     �   CREATE TABLE forma_infecciones__tipos_micosis (
    id_for_inf_tip_mic integer NOT NULL,
    id_tip_mic integer NOT NULL,
    id_for_inf integer NOT NULL
);
 4   DROP TABLE public.forma_infecciones__tipos_micosis;
       public    saib    desarrollo_g    false    7            �           1259    30908 7   forma_infecciones__tipos_micosis_id_for_inf_tip_mic_seq    SEQUENCE     �   CREATE SEQUENCE forma_infecciones__tipos_micosis_id_for_inf_tip_mic_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 N   DROP SEQUENCE public.forma_infecciones__tipos_micosis_id_for_inf_tip_mic_seq;
       public       desarrollo_g    false    7    1701            |	           0    0 7   forma_infecciones__tipos_micosis_id_for_inf_tip_mic_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE forma_infecciones__tipos_micosis_id_for_inf_tip_mic_seq OWNED BY forma_infecciones__tipos_micosis.id_for_inf_tip_mic;
            public       desarrollo_g    false    1702            }	           0    0 7   forma_infecciones__tipos_micosis_id_for_inf_tip_mic_seq    SEQUENCE SET     _   SELECT pg_catalog.setval('forma_infecciones__tipos_micosis_id_for_inf_tip_mic_seq', 21, true);
            public       desarrollo_g    false    1702            �           1259    30910     forma_infecciones_id_for_inf_seq    SEQUENCE     �   CREATE SEQUENCE forma_infecciones_id_for_inf_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.forma_infecciones_id_for_inf_seq;
       public       desarrollo_g    false    1698    7            ~	           0    0     forma_infecciones_id_for_inf_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE forma_infecciones_id_for_inf_seq OWNED BY forma_infecciones.id_for_inf;
            public       desarrollo_g    false    1703            	           0    0     forma_infecciones_id_for_inf_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('forma_infecciones_id_for_inf_seq', 12, true);
            public       desarrollo_g    false    1703            �           1259    30912    historiales_pacientes    TABLE     �   CREATE TABLE historiales_pacientes (
    id_his integer NOT NULL,
    id_pac integer NOT NULL,
    des_his character varying(255),
    id_doc integer,
    des_adi_pac_his character varying(255),
    fec_his timestamp with time zone DEFAULT now()
);
 )   DROP TABLE public.historiales_pacientes;
       public    saib    desarrollo_g    false    2062    7            �	           0    0 ,   COLUMN historiales_pacientes.des_adi_pac_his    COMMENT     �   COMMENT ON COLUMN historiales_pacientes.des_adi_pac_his IS '
	Discripción adicional de si el paciente padece o no una enfermedad u otra cosa adicional.
';
            public       desarrollo_g    false    1704            �           1259    30919     historiales_pacientes_id_his_seq    SEQUENCE     �   CREATE SEQUENCE historiales_pacientes_id_his_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.historiales_pacientes_id_his_seq;
       public       desarrollo_g    false    1704    7            �	           0    0     historiales_pacientes_id_his_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE historiales_pacientes_id_his_seq OWNED BY historiales_pacientes.id_his;
            public       desarrollo_g    false    1705            �	           0    0     historiales_pacientes_id_his_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('historiales_pacientes_id_his_seq', 19, true);
            public       desarrollo_g    false    1705            �           1259    30921    lesiones    TABLE     [   CREATE TABLE lesiones (
    id_les integer NOT NULL,
    nom_les character varying(100)
);
    DROP TABLE public.lesiones;
       public         desarrollo_g    false    7            �           1259    30924 +   lesiones__partes_cuerpos_id_les_par_cue_seq    SEQUENCE     �   CREATE SEQUENCE lesiones__partes_cuerpos_id_les_par_cue_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 B   DROP SEQUENCE public.lesiones__partes_cuerpos_id_les_par_cue_seq;
       public       desarrollo_g    false    1680    7            �	           0    0 +   lesiones__partes_cuerpos_id_les_par_cue_seq    SEQUENCE OWNED BY     q   ALTER SEQUENCE lesiones__partes_cuerpos_id_les_par_cue_seq OWNED BY categorias_cuerpos__lesiones.id_cat_cue_les;
            public       desarrollo_g    false    1707            �	           0    0 +   lesiones__partes_cuerpos_id_les_par_cue_seq    SEQUENCE SET     T   SELECT pg_catalog.setval('lesiones__partes_cuerpos_id_les_par_cue_seq', 115, true);
            public       desarrollo_g    false    1707            �           1259    30926    lesiones_id_les_seq    SEQUENCE     u   CREATE SEQUENCE lesiones_id_les_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.lesiones_id_les_seq;
       public       desarrollo_g    false    7    1706            �	           0    0    lesiones_id_les_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE lesiones_id_les_seq OWNED BY lesiones.id_les;
            public       desarrollo_g    false    1708            �	           0    0    lesiones_id_les_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('lesiones_id_les_seq', 71, true);
            public       desarrollo_g    false    1708            �           1259    30928 "   lesiones_partes_cuerpos__pacientes    TABLE     �   CREATE TABLE lesiones_partes_cuerpos__pacientes (
    id_les_par_cue_pac integer NOT NULL,
    otr_les_par_cue character varying(20),
    id_cat_cue_les integer,
    id_par_cue_cat_cue integer,
    id_tip_mic_pac integer
);
 6   DROP TABLE public.lesiones_partes_cuerpos__pacientes;
       public    saib    desarrollo_g    false    7            �	           0    0 <   COLUMN lesiones_partes_cuerpos__pacientes.id_les_par_cue_pac    COMMENT     r   COMMENT ON COLUMN lesiones_partes_cuerpos__pacientes.id_les_par_cue_pac IS 'Leciones parted del cuerpo paciente';
            public       desarrollo_g    false    1709            �	           0    0 9   COLUMN lesiones_partes_cuerpos__pacientes.otr_les_par_cue    COMMENT     ~   COMMENT ON COLUMN lesiones_partes_cuerpos__pacientes.otr_les_par_cue IS 'Otras leciones de la parte del cuerpo del paciente';
            public       desarrollo_g    false    1709            �           1259    30931 9   lesiones_partes_cuerpos__pacientes_id_les_par_cue_pac_seq    SEQUENCE     �   CREATE SEQUENCE lesiones_partes_cuerpos__pacientes_id_les_par_cue_pac_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 P   DROP SEQUENCE public.lesiones_partes_cuerpos__pacientes_id_les_par_cue_pac_seq;
       public       desarrollo_g    false    7    1709            �	           0    0 9   lesiones_partes_cuerpos__pacientes_id_les_par_cue_pac_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE lesiones_partes_cuerpos__pacientes_id_les_par_cue_pac_seq OWNED BY lesiones_partes_cuerpos__pacientes.id_les_par_cue_pac;
            public       desarrollo_g    false    1710            �	           0    0 9   lesiones_partes_cuerpos__pacientes_id_les_par_cue_pac_seq    SEQUENCE SET     b   SELECT pg_catalog.setval('lesiones_partes_cuerpos__pacientes_id_les_par_cue_pac_seq', 309, true);
            public       desarrollo_g    false    1710            �           1259    30933    localizaciones_cuerpos    TABLE     �   CREATE TABLE localizaciones_cuerpos (
    id_loc_cue integer NOT NULL,
    nom_loc_cue character varying(20) NOT NULL,
    id_par_cue integer
);
 *   DROP TABLE public.localizaciones_cuerpos;
       public    saib    desarrollo_g    false    7            �           1259    30936 %   localizaciones_cuerpos_id_loc_cue_seq    SEQUENCE     �   CREATE SEQUENCE localizaciones_cuerpos_id_loc_cue_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 <   DROP SEQUENCE public.localizaciones_cuerpos_id_loc_cue_seq;
       public       desarrollo_g    false    1711    7            �	           0    0 %   localizaciones_cuerpos_id_loc_cue_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE localizaciones_cuerpos_id_loc_cue_seq OWNED BY localizaciones_cuerpos.id_loc_cue;
            public       desarrollo_g    false    1712            �	           0    0 %   localizaciones_cuerpos_id_loc_cue_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('localizaciones_cuerpos_id_loc_cue_seq', 1, false);
            public       desarrollo_g    false    1712            �           1259    30938    modulos    TABLE     �   CREATE TABLE modulos (
    id_mod integer NOT NULL,
    cod_mod character varying(3),
    des_mod character varying(100),
    id_tip_usu integer
);
    DROP TABLE public.modulos;
       public    saib    desarrollo_g    false    7            �           1259    30941    modulos_id_mod_seq    SEQUENCE     t   CREATE SEQUENCE modulos_id_mod_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.modulos_id_mod_seq;
       public       desarrollo_g    false    1713    7            �	           0    0    modulos_id_mod_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE modulos_id_mod_seq OWNED BY modulos.id_mod;
            public       desarrollo_g    false    1714            �	           0    0    modulos_id_mod_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('modulos_id_mod_seq', 2, true);
            public       desarrollo_g    false    1714            �           1259    30943    muestras_clinicas    TABLE     u   CREATE TABLE muestras_clinicas (
    id_mue_cli integer NOT NULL,
    nom_mue_cli character varying(100) NOT NULL
);
 %   DROP TABLE public.muestras_clinicas;
       public    saib    desarrollo_g    false    7            �	           0    0 #   COLUMN muestras_clinicas.id_mue_cli    COMMENT     Z   COMMENT ON COLUMN muestras_clinicas.id_mue_cli IS 'Identificacion de la muestra clinica';
            public       desarrollo_g    false    1715            �	           0    0 $   COLUMN muestras_clinicas.nom_mue_cli    COMMENT     M   COMMENT ON COLUMN muestras_clinicas.nom_mue_cli IS 'Nombre muestra clinica';
            public       desarrollo_g    false    1715            �           1259    30946     muestras_clinicas_id_mue_cli_seq    SEQUENCE     �   CREATE SEQUENCE muestras_clinicas_id_mue_cli_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 7   DROP SEQUENCE public.muestras_clinicas_id_mue_cli_seq;
       public       desarrollo_g    false    1715    7            �	           0    0     muestras_clinicas_id_mue_cli_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE muestras_clinicas_id_mue_cli_seq OWNED BY muestras_clinicas.id_mue_cli;
            public       desarrollo_g    false    1716            �	           0    0     muestras_clinicas_id_mue_cli_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('muestras_clinicas_id_mue_cli_seq', 1, false);
            public       desarrollo_g    false    1716            �           1259    30948    muestras_pacientes    TABLE     �   CREATE TABLE muestras_pacientes (
    id_mue_pac integer NOT NULL,
    id_his integer NOT NULL,
    id_mue_cli integer NOT NULL,
    otr_mue_cli character varying(20)
);
 &   DROP TABLE public.muestras_pacientes;
       public    saib    desarrollo_g    false    7            �	           0    0 $   COLUMN muestras_pacientes.id_mue_pac    COMMENT     T   COMMENT ON COLUMN muestras_pacientes.id_mue_pac IS 'Id de la meustra del paciente';
            public       desarrollo_g    false    1717            �	           0    0     COLUMN muestras_pacientes.id_his    COMMENT     C   COMMENT ON COLUMN muestras_pacientes.id_his IS 'Id del historial';
            public       desarrollo_g    false    1717            �	           0    0 $   COLUMN muestras_pacientes.id_mue_cli    COMMENT     E   COMMENT ON COLUMN muestras_pacientes.id_mue_cli IS 'Id muestra cli';
            public       desarrollo_g    false    1717            �	           0    0 %   COLUMN muestras_pacientes.otr_mue_cli    COMMENT     L   COMMENT ON COLUMN muestras_pacientes.otr_mue_cli IS 'Otra meustra clinica';
            public       desarrollo_g    false    1717            �           1259    30951 !   muestras_pacientes_id_mue_pac_seq    SEQUENCE     �   CREATE SEQUENCE muestras_pacientes_id_mue_pac_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.muestras_pacientes_id_mue_pac_seq;
       public       desarrollo_g    false    7    1717            �	           0    0 !   muestras_pacientes_id_mue_pac_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE muestras_pacientes_id_mue_pac_seq OWNED BY muestras_pacientes.id_mue_pac;
            public       desarrollo_g    false    1718            �	           0    0 !   muestras_pacientes_id_mue_pac_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('muestras_pacientes_id_mue_pac_seq', 100, true);
            public       desarrollo_g    false    1718            �           1259    30953 
   municipios    TABLE     q   CREATE TABLE municipios (
    id_mun integer NOT NULL,
    des_mun character varying(100),
    id_est integer
);
    DROP TABLE public.municipios;
       public         desarrollo_g    false    7            �           1259    30956    municipios_id_mun_seq    SEQUENCE     w   CREATE SEQUENCE municipios_id_mun_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.municipios_id_mun_seq;
       public       desarrollo_g    false    7    1719            �	           0    0    municipios_id_mun_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE municipios_id_mun_seq OWNED BY municipios.id_mun;
            public       desarrollo_g    false    1720            �	           0    0    municipios_id_mun_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('municipios_id_mun_seq', 335, true);
            public       desarrollo_g    false    1720            �           1259    30958 	   pacientes    TABLE     a  CREATE TABLE pacientes (
    id_pac integer NOT NULL,
    ape_pac character varying(20) NOT NULL,
    nom_pac character varying(100),
    ced_pac character varying(20),
    fec_nac_pac date NOT NULL,
    nac_pac character varying(100) NOT NULL,
    tel_hab_pac character varying(12),
    tel_cel_pac character varying(12),
    ocu_pac character varying(100),
    ciu_pac character varying(100),
    id_pai integer,
    id_est integer,
    id_mun integer,
    id_par integer,
    num_pac integer,
    id_doc integer,
    fec_reg_pac timestamp with time zone DEFAULT now(),
    sex_pac character(1) NOT NULL
);
    DROP TABLE public.pacientes;
       public    saib    desarrollo_g    false    2071    7            �	           0    0    COLUMN pacientes.id_pac    COMMENT     5   COMMENT ON COLUMN pacientes.id_pac IS 'Id paciente';
            public       desarrollo_g    false    1721            �	           0    0    COLUMN pacientes.ape_pac    COMMENT     @   COMMENT ON COLUMN pacientes.ape_pac IS 'Apellido del paciente';
            public       desarrollo_g    false    1721            �	           0    0    COLUMN pacientes.nom_pac    COMMENT     >   COMMENT ON COLUMN pacientes.nom_pac IS 'Nombre del paciente';
            public       desarrollo_g    false    1721            �	           0    0    COLUMN pacientes.ced_pac    COMMENT     >   COMMENT ON COLUMN pacientes.ced_pac IS 'Cedula del paciente';
            public       desarrollo_g    false    1721            �	           0    0    COLUMN pacientes.fec_nac_pac    COMMENT     O   COMMENT ON COLUMN pacientes.fec_nac_pac IS 'Fecha de nacimiento del paciente';
            public       desarrollo_g    false    1721            �	           0    0    COLUMN pacientes.nac_pac    COMMENT     D   COMMENT ON COLUMN pacientes.nac_pac IS 'Nacionalidad del paciente';
            public       desarrollo_g    false    1721            �	           0    0    COLUMN pacientes.ocu_pac    COMMENT     A   COMMENT ON COLUMN pacientes.ocu_pac IS 'Ocupacion del paciente';
            public       desarrollo_g    false    1721            �	           0    0    COLUMN pacientes.ciu_pac    COMMENT     >   COMMENT ON COLUMN pacientes.ciu_pac IS 'Ciudad del paciente';
            public       desarrollo_g    false    1721            �	           0    0    COLUMN pacientes.fec_reg_pac    COMMENT     M   COMMENT ON COLUMN pacientes.fec_reg_pac IS 'Fecha de registro del paciente';
            public       desarrollo_g    false    1721            �           1259    30962    pacientes_id_pac_seq    SEQUENCE     v   CREATE SEQUENCE pacientes_id_pac_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.pacientes_id_pac_seq;
       public       desarrollo_g    false    1721    7            �	           0    0    pacientes_id_pac_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE pacientes_id_pac_seq OWNED BY pacientes.id_pac;
            public       desarrollo_g    false    1722            �	           0    0    pacientes_id_pac_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('pacientes_id_pac_seq', 28, true);
            public       desarrollo_g    false    1722            �           1259    30964    paises    TABLE     {   CREATE TABLE paises (
    id_pai integer NOT NULL,
    des_pai character varying(100),
    cod_pai character varying(3)
);
    DROP TABLE public.paises;
       public         desarrollo_g    false    7            �           1259    30967    paises_id_pai_seq    SEQUENCE     s   CREATE SEQUENCE paises_id_pai_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.paises_id_pai_seq;
       public       desarrollo_g    false    1723    7            �	           0    0    paises_id_pai_seq    SEQUENCE OWNED BY     9   ALTER SEQUENCE paises_id_pai_seq OWNED BY paises.id_pai;
            public       desarrollo_g    false    1724            �	           0    0    paises_id_pai_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('paises_id_pai_seq', 1, false);
            public       desarrollo_g    false    1724            �           1259    30969 
   parroquias    TABLE     q   CREATE TABLE parroquias (
    id_par integer NOT NULL,
    des_par character varying(100),
    id_mun integer
);
    DROP TABLE public.parroquias;
       public         desarrollo_g    false    7            �           1259    30972    parroquias_id_par_seq    SEQUENCE     w   CREATE SEQUENCE parroquias_id_par_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.parroquias_id_par_seq;
       public       desarrollo_g    false    1725    7            �	           0    0    parroquias_id_par_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE parroquias_id_par_seq OWNED BY parroquias.id_par;
            public       desarrollo_g    false    1726            �	           0    0    parroquias_id_par_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('parroquias_id_par_seq', 1, false);
            public       desarrollo_g    false    1726            �           1259    30974    partes_cuerpos    TABLE     h   CREATE TABLE partes_cuerpos (
    id_par_cue integer NOT NULL,
    nom_par_cue character varying(20)
);
 "   DROP TABLE public.partes_cuerpos;
       public    saib    desarrollo_g    false    7            �           1259    30977 "   partes_cuerpos__categorias_cuerpos    TABLE     �   CREATE TABLE partes_cuerpos__categorias_cuerpos (
    id_par_cue_cat_cue integer NOT NULL,
    id_cat_cue integer NOT NULL,
    id_par_cue integer NOT NULL
);
 6   DROP TABLE public.partes_cuerpos__categorias_cuerpos;
       public         desarrollo_g    false    7            �	           0    0 (   TABLE partes_cuerpos__categorias_cuerpos    COMMENT     |   COMMENT ON TABLE partes_cuerpos__categorias_cuerpos IS 'Permite seleccionar a que categoria pertenece la parte del cuerpo';
            public       desarrollo_g    false    1728            �           1259    30980 9   partes_cuerpos__categorias_cuerpos_id_par_cue_cat_cue_seq    SEQUENCE     �   CREATE SEQUENCE partes_cuerpos__categorias_cuerpos_id_par_cue_cat_cue_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 P   DROP SEQUENCE public.partes_cuerpos__categorias_cuerpos_id_par_cue_cat_cue_seq;
       public       desarrollo_g    false    1728    7            �	           0    0 9   partes_cuerpos__categorias_cuerpos_id_par_cue_cat_cue_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE partes_cuerpos__categorias_cuerpos_id_par_cue_cat_cue_seq OWNED BY partes_cuerpos__categorias_cuerpos.id_par_cue_cat_cue;
            public       desarrollo_g    false    1729            �	           0    0 9   partes_cuerpos__categorias_cuerpos_id_par_cue_cat_cue_seq    SEQUENCE SET     `   SELECT pg_catalog.setval('partes_cuerpos__categorias_cuerpos_id_par_cue_cat_cue_seq', 9, true);
            public       desarrollo_g    false    1729            �           1259    30982    partes_cuerpos_id_par_cue_seq    SEQUENCE        CREATE SEQUENCE partes_cuerpos_id_par_cue_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.partes_cuerpos_id_par_cue_seq;
       public       desarrollo_g    false    1727    7            �	           0    0    partes_cuerpos_id_par_cue_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE partes_cuerpos_id_par_cue_seq OWNED BY partes_cuerpos.id_par_cue;
            public       desarrollo_g    false    1730            �	           0    0    partes_cuerpos_id_par_cue_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('partes_cuerpos_id_par_cue_seq', 19, true);
            public       desarrollo_g    false    1730            �           1259    30984    tiempo_evoluciones    TABLE     x   CREATE TABLE tiempo_evoluciones (
    id_tie_evo integer NOT NULL,
    id_his integer,
    tie_evo integer DEFAULT 0
);
 &   DROP TABLE public.tiempo_evoluciones;
       public         desarrollo_g    false    2077    7            �           1259    30988 !   tiempo_evoluciones_id_tie_evo_seq    SEQUENCE     �   CREATE SEQUENCE tiempo_evoluciones_id_tie_evo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 8   DROP SEQUENCE public.tiempo_evoluciones_id_tie_evo_seq;
       public       desarrollo_g    false    7    1731            �	           0    0 !   tiempo_evoluciones_id_tie_evo_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE tiempo_evoluciones_id_tie_evo_seq OWNED BY tiempo_evoluciones.id_tie_evo;
            public       desarrollo_g    false    1732            �	           0    0 !   tiempo_evoluciones_id_tie_evo_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('tiempo_evoluciones_id_tie_evo_seq', 5, true);
            public       desarrollo_g    false    1732            �           1259    30990    tipos_consultas    TABLE     r   CREATE TABLE tipos_consultas (
    id_tip_con integer NOT NULL,
    nom_tip_con character varying(50) NOT NULL
);
 #   DROP TABLE public.tipos_consultas;
       public    saib    desarrollo_g    false    7            �	           0    0 !   COLUMN tipos_consultas.id_tip_con    COMMENT     F   COMMENT ON COLUMN tipos_consultas.id_tip_con IS 'id tipos consultas';
            public       desarrollo_g    false    1733            �           1259    30993    tipos_consultas_id_tip_con_seq    SEQUENCE     �   CREATE SEQUENCE tipos_consultas_id_tip_con_seq
    START WITH 9
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.tipos_consultas_id_tip_con_seq;
       public       desarrollo_g    false    7    1733            �	           0    0    tipos_consultas_id_tip_con_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE tipos_consultas_id_tip_con_seq OWNED BY tipos_consultas.id_tip_con;
            public       desarrollo_g    false    1734            �	           0    0    tipos_consultas_id_tip_con_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('tipos_consultas_id_tip_con_seq', 9, true);
            public       desarrollo_g    false    1734            �           1259    30995    tipos_consultas_pacientes    TABLE     �   CREATE TABLE tipos_consultas_pacientes (
    id_tip_con_pac integer NOT NULL,
    id_tip_con integer NOT NULL,
    id_his integer NOT NULL,
    otr_tip_con character varying(50)
);
 -   DROP TABLE public.tipos_consultas_pacientes;
       public    saib    desarrollo_g    false    7            �	           0    0 /   COLUMN tipos_consultas_pacientes.id_tip_con_pac    COMMENT     _   COMMENT ON COLUMN tipos_consultas_pacientes.id_tip_con_pac IS 'Id tipos de consulta paciente';
            public       desarrollo_g    false    1735            �	           0    0 +   COLUMN tipos_consultas_pacientes.id_tip_con    COMMENT     R   COMMENT ON COLUMN tipos_consultas_pacientes.id_tip_con IS 'Id tipos de consulta';
            public       desarrollo_g    false    1735            �	           0    0 '   COLUMN tipos_consultas_pacientes.id_his    COMMENT     F   COMMENT ON COLUMN tipos_consultas_pacientes.id_his IS 'Id historico';
            public       desarrollo_g    false    1735            �	           0    0 ,   COLUMN tipos_consultas_pacientes.otr_tip_con    COMMENT     T   COMMENT ON COLUMN tipos_consultas_pacientes.otr_tip_con IS 'Otro tipo de consulta';
            public       desarrollo_g    false    1735            �           1259    30998 ,   tipos_consultas_pacientes_id_tip_con_pac_seq    SEQUENCE     �   CREATE SEQUENCE tipos_consultas_pacientes_id_tip_con_pac_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 C   DROP SEQUENCE public.tipos_consultas_pacientes_id_tip_con_pac_seq;
       public       desarrollo_g    false    7    1735            �	           0    0 ,   tipos_consultas_pacientes_id_tip_con_pac_seq    SEQUENCE OWNED BY     o   ALTER SEQUENCE tipos_consultas_pacientes_id_tip_con_pac_seq OWNED BY tipos_consultas_pacientes.id_tip_con_pac;
            public       desarrollo_g    false    1736            �	           0    0 ,   tipos_consultas_pacientes_id_tip_con_pac_seq    SEQUENCE SET     U   SELECT pg_catalog.setval('tipos_consultas_pacientes_id_tip_con_pac_seq', 186, true);
            public       desarrollo_g    false    1736            �           1259    31000    tipos_estudios_micologicos    TABLE     �   CREATE TABLE tipos_estudios_micologicos (
    id_tip_est_mic integer NOT NULL,
    id_tip_mic integer NOT NULL,
    nom_tip_est_mic character varying(255),
    id_tip_exa integer
);
 .   DROP TABLE public.tipos_estudios_micologicos;
       public    saib    desarrollo_g    false    7            �           1259    31003 -   tipos_estudios_micologicos_id_tip_est_mic_seq    SEQUENCE     �   CREATE SEQUENCE tipos_estudios_micologicos_id_tip_est_mic_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 D   DROP SEQUENCE public.tipos_estudios_micologicos_id_tip_est_mic_seq;
       public       desarrollo_g    false    7    1737            �	           0    0 -   tipos_estudios_micologicos_id_tip_est_mic_seq    SEQUENCE OWNED BY     q   ALTER SEQUENCE tipos_estudios_micologicos_id_tip_est_mic_seq OWNED BY tipos_estudios_micologicos.id_tip_est_mic;
            public       desarrollo_g    false    1738            �	           0    0 -   tipos_estudios_micologicos_id_tip_est_mic_seq    SEQUENCE SET     U   SELECT pg_catalog.setval('tipos_estudios_micologicos_id_tip_est_mic_seq', 62, true);
            public       desarrollo_g    false    1738            �           1259    31005    tipos_examenes    TABLE     i   CREATE TABLE tipos_examenes (
    id_tip_exa integer NOT NULL,
    nom_tip_exa character varying(255)
);
 "   DROP TABLE public.tipos_examenes;
       public         desarrollo_g    false    7            �           1259    31008    tipos_examenes_id_tip_exa_seq    SEQUENCE        CREATE SEQUENCE tipos_examenes_id_tip_exa_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.tipos_examenes_id_tip_exa_seq;
       public       desarrollo_g    false    7    1739            �	           0    0    tipos_examenes_id_tip_exa_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE tipos_examenes_id_tip_exa_seq OWNED BY tipos_examenes.id_tip_exa;
            public       desarrollo_g    false    1740            �	           0    0    tipos_examenes_id_tip_exa_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('tipos_examenes_id_tip_exa_seq', 3, false);
            public       desarrollo_g    false    1740            �           1259    31010    tipos_micosis    TABLE     g   CREATE TABLE tipos_micosis (
    id_tip_mic integer NOT NULL,
    nom_tip_mic character varying(20)
);
 !   DROP TABLE public.tipos_micosis;
       public    saib    desarrollo_g    false    7            �           1259    31013    tipos_micosis_id_tip_mic_seq    SEQUENCE     ~   CREATE SEQUENCE tipos_micosis_id_tip_mic_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.tipos_micosis_id_tip_mic_seq;
       public       desarrollo_g    false    7    1741            �	           0    0    tipos_micosis_id_tip_mic_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE tipos_micosis_id_tip_mic_seq OWNED BY tipos_micosis.id_tip_mic;
            public       desarrollo_g    false    1742            �	           0    0    tipos_micosis_id_tip_mic_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('tipos_micosis_id_tip_mic_seq', 4, false);
            public       desarrollo_g    false    1742            �           1259    31015    tipos_micosis_pacientes    TABLE     z   CREATE TABLE tipos_micosis_pacientes (
    id_tip_mic_pac integer NOT NULL,
    id_tip_mic integer,
    id_his integer
);
 +   DROP TABLE public.tipos_micosis_pacientes;
       public         desarrollo_g    false    7            �           1259    31018 3   tipos_micosis_pacientes__tipos_estudios_micologicos    TABLE     �   CREATE TABLE tipos_micosis_pacientes__tipos_estudios_micologicos (
    id_tip_mic_pac_tip_est_mic integer NOT NULL,
    id_tip_mic_pac integer,
    id_tip_est_mic integer
);
 G   DROP TABLE public.tipos_micosis_pacientes__tipos_estudios_micologicos;
       public         desarrollo_g    false    7            �           1259    31021 ?   tipos_micosis_pacientes__tipos_e_id_tip_mic_pac_tip_est_mic_seq    SEQUENCE     �   CREATE SEQUENCE tipos_micosis_pacientes__tipos_e_id_tip_mic_pac_tip_est_mic_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 V   DROP SEQUENCE public.tipos_micosis_pacientes__tipos_e_id_tip_mic_pac_tip_est_mic_seq;
       public       desarrollo_g    false    7    1744            �	           0    0 ?   tipos_micosis_pacientes__tipos_e_id_tip_mic_pac_tip_est_mic_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE tipos_micosis_pacientes__tipos_e_id_tip_mic_pac_tip_est_mic_seq OWNED BY tipos_micosis_pacientes__tipos_estudios_micologicos.id_tip_mic_pac_tip_est_mic;
            public       desarrollo_g    false    1745            �	           0    0 ?   tipos_micosis_pacientes__tipos_e_id_tip_mic_pac_tip_est_mic_seq    SEQUENCE SET     g   SELECT pg_catalog.setval('tipos_micosis_pacientes__tipos_e_id_tip_mic_pac_tip_est_mic_seq', 61, true);
            public       desarrollo_g    false    1745            �           1259    31023 *   tipos_micosis_pacientes_id_tip_mic_pac_seq    SEQUENCE     �   CREATE SEQUENCE tipos_micosis_pacientes_id_tip_mic_pac_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 A   DROP SEQUENCE public.tipos_micosis_pacientes_id_tip_mic_pac_seq;
       public       desarrollo_g    false    7    1743            �	           0    0 *   tipos_micosis_pacientes_id_tip_mic_pac_seq    SEQUENCE OWNED BY     k   ALTER SEQUENCE tipos_micosis_pacientes_id_tip_mic_pac_seq OWNED BY tipos_micosis_pacientes.id_tip_mic_pac;
            public       desarrollo_g    false    1746            �	           0    0 *   tipos_micosis_pacientes_id_tip_mic_pac_seq    SEQUENCE SET     R   SELECT pg_catalog.setval('tipos_micosis_pacientes_id_tip_mic_pac_seq', 60, true);
            public       desarrollo_g    false    1746            �           1259    31025    tipos_usuarios    TABLE     �   CREATE TABLE tipos_usuarios (
    id_tip_usu integer NOT NULL,
    cod_tip_usu character varying(3) NOT NULL,
    des_tip_usu character varying(100)
);
 "   DROP TABLE public.tipos_usuarios;
       public    saib    desarrollo_g    false    7            �           1259    31028    tipos_usuarios__usuarios    TABLE     �   CREATE TABLE tipos_usuarios__usuarios (
    id_tip_usu_usu integer NOT NULL,
    id_doc integer,
    id_usu_adm integer,
    id_tip_usu integer NOT NULL
);
 ,   DROP TABLE public.tipos_usuarios__usuarios;
       public    saib    desarrollo_g    false    7            �           1259    31031 +   tipos_usuarios__usuarios_id_tip_usu_usu_seq    SEQUENCE     �   CREATE SEQUENCE tipos_usuarios__usuarios_id_tip_usu_usu_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 B   DROP SEQUENCE public.tipos_usuarios__usuarios_id_tip_usu_usu_seq;
       public       desarrollo_g    false    7    1748            �	           0    0 +   tipos_usuarios__usuarios_id_tip_usu_usu_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE tipos_usuarios__usuarios_id_tip_usu_usu_seq OWNED BY tipos_usuarios__usuarios.id_tip_usu_usu;
            public       desarrollo_g    false    1749            �	           0    0 +   tipos_usuarios__usuarios_id_tip_usu_usu_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('tipos_usuarios__usuarios_id_tip_usu_usu_seq', 52, true);
            public       desarrollo_g    false    1749            �           1259    31033    tipos_usuarios_id_tip_usu_seq    SEQUENCE        CREATE SEQUENCE tipos_usuarios_id_tip_usu_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE public.tipos_usuarios_id_tip_usu_seq;
       public       desarrollo_g    false    7    1747            �	           0    0    tipos_usuarios_id_tip_usu_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE tipos_usuarios_id_tip_usu_seq OWNED BY tipos_usuarios.id_tip_usu;
            public       desarrollo_g    false    1750            �	           0    0    tipos_usuarios_id_tip_usu_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('tipos_usuarios_id_tip_usu_seq', 2, true);
            public       desarrollo_g    false    1750            �           1259    31035    transacciones    TABLE     �   CREATE TABLE transacciones (
    id_tip_tra integer NOT NULL,
    cod_tip_tra character varying(3) NOT NULL,
    des_tip_tra character varying(100),
    id_mod integer
);
 !   DROP TABLE public.transacciones;
       public    saib    desarrollo_g    false    7            �           1259    31038    transacciones_id_tip_tra_seq    SEQUENCE     ~   CREATE SEQUENCE transacciones_id_tip_tra_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.transacciones_id_tip_tra_seq;
       public       desarrollo_g    false    7    1751            �	           0    0    transacciones_id_tip_tra_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE transacciones_id_tip_tra_seq OWNED BY transacciones.id_tip_tra;
            public       desarrollo_g    false    1752            �	           0    0    transacciones_id_tip_tra_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('transacciones_id_tip_tra_seq', 16, true);
            public       desarrollo_g    false    1752            �           1259    31040    transacciones_usuarios    TABLE     �   CREATE TABLE transacciones_usuarios (
    id_tip_tra integer NOT NULL,
    id_tip_usu_usu integer,
    id_tra_usu integer NOT NULL
);
 *   DROP TABLE public.transacciones_usuarios;
       public    saib    desarrollo_g    false    7            �           1259    31043 %   transacciones_usuarios_id_tra_usu_seq    SEQUENCE     �   CREATE SEQUENCE transacciones_usuarios_id_tra_usu_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 <   DROP SEQUENCE public.transacciones_usuarios_id_tra_usu_seq;
       public       desarrollo_g    false    1753    7            �	           0    0 %   transacciones_usuarios_id_tra_usu_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE transacciones_usuarios_id_tra_usu_seq OWNED BY transacciones_usuarios.id_tra_usu;
            public       desarrollo_g    false    1754            �	           0    0 %   transacciones_usuarios_id_tra_usu_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('transacciones_usuarios_id_tra_usu_seq', 116, true);
            public       desarrollo_g    false    1754            �           1259    31045    tratamientos    TABLE     _   CREATE TABLE tratamientos (
    id_tra integer NOT NULL,
    nom_tra character varying(100)
);
     DROP TABLE public.tratamientos;
       public    saib    desarrollo_g    false    7            �           1259    31048    tratamientos_id_tra_seq    SEQUENCE     y   CREATE SEQUENCE tratamientos_id_tra_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.tratamientos_id_tra_seq;
       public       desarrollo_g    false    1755    7            �	           0    0    tratamientos_id_tra_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE tratamientos_id_tra_seq OWNED BY tratamientos.id_tra;
            public       desarrollo_g    false    1756            �	           0    0    tratamientos_id_tra_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('tratamientos_id_tra_seq', 1, false);
            public       desarrollo_g    false    1756            �           1259    31050    tratamientos_pacientes    TABLE     �   CREATE TABLE tratamientos_pacientes (
    id_tra_pac integer NOT NULL,
    id_his integer NOT NULL,
    id_tra integer NOT NULL,
    otr_tra character varying(20)
);
 *   DROP TABLE public.tratamientos_pacientes;
       public    saib    desarrollo_g    false    7            �	           0    0 (   COLUMN tratamientos_pacientes.id_tra_pac    COMMENT     R   COMMENT ON COLUMN tratamientos_pacientes.id_tra_pac IS 'Id transaccion paciente';
            public       desarrollo_g    false    1757            �	           0    0 $   COLUMN tratamientos_pacientes.id_his    COMMENT     C   COMMENT ON COLUMN tratamientos_pacientes.id_his IS 'Id historico';
            public       desarrollo_g    false    1757            �	           0    0 $   COLUMN tratamientos_pacientes.id_tra    COMMENT     E   COMMENT ON COLUMN tratamientos_pacientes.id_tra IS 'Id tratamiento';
            public       desarrollo_g    false    1757            �	           0    0 %   COLUMN tratamientos_pacientes.otr_tra    COMMENT     H   COMMENT ON COLUMN tratamientos_pacientes.otr_tra IS 'Otro tratamiento';
            public       desarrollo_g    false    1757            �           1259    31053 %   tratamientos_pacientes_id_tra_pac_seq    SEQUENCE     �   CREATE SEQUENCE tratamientos_pacientes_id_tra_pac_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 <   DROP SEQUENCE public.tratamientos_pacientes_id_tra_pac_seq;
       public       desarrollo_g    false    7    1757            �	           0    0 %   tratamientos_pacientes_id_tra_pac_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE tratamientos_pacientes_id_tra_pac_seq OWNED BY tratamientos_pacientes.id_tra_pac;
            public       desarrollo_g    false    1758            �	           0    0 %   tratamientos_pacientes_id_tra_pac_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('tratamientos_pacientes_id_tra_pac_seq', 247, true);
            public       desarrollo_g    false    1758            �           1259    31055    usuarios_administrativos    TABLE     f  CREATE TABLE usuarios_administrativos (
    id_usu_adm integer NOT NULL,
    nom_usu_adm character varying(100),
    ape_usu_adm character varying(100),
    pas_usu_adm character varying(100),
    log_usu_adm character varying(100),
    tel_usu_adm character varying(20),
    fec_reg_usu_adm timestamp without time zone DEFAULT now(),
    adm_usu boolean
);
 ,   DROP TABLE public.usuarios_administrativos;
       public    saib    desarrollo_g    false    2092    7            �	           0    0 /   COLUMN usuarios_administrativos.fec_reg_usu_adm    COMMENT     c   COMMENT ON COLUMN usuarios_administrativos.fec_reg_usu_adm IS 'Fecha de registro de los usuarios';
            public       desarrollo_g    false    1759            �	           0    0 '   COLUMN usuarios_administrativos.adm_usu    COMMENT     �   COMMENT ON COLUMN usuarios_administrativos.adm_usu IS '
	TRUE: si es un super usuario
	FALSE: si es usuario com limitaciones
';
            public       desarrollo_g    false    1759            �           1259    31059 '   usuarios_administrativos_id_usu_adm_seq    SEQUENCE     �   CREATE SEQUENCE usuarios_administrativos_id_usu_adm_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 >   DROP SEQUENCE public.usuarios_administrativos_id_usu_adm_seq;
       public       desarrollo_g    false    1759    7            �	           0    0 '   usuarios_administrativos_id_usu_adm_seq    SEQUENCE OWNED BY     e   ALTER SEQUENCE usuarios_administrativos_id_usu_adm_seq OWNED BY usuarios_administrativos.id_usu_adm;
            public       desarrollo_g    false    1760            �	           0    0 '   usuarios_administrativos_id_usu_adm_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('usuarios_administrativos_id_usu_adm_seq', 23, true);
            public       desarrollo_g    false    1760            �           1259    31061    view_auditoria_transacciones    VIEW     �  CREATE VIEW view_auditoria_transacciones AS
    SELECT to_char(at.fec_aud_tra, 'DD/MM/YYYY HH12:MI:SS AM'::text) AS fecha_tran, (((d.nom_doc)::text || ' '::text) || (d.ape_doc)::text) AS nom_ape_usu, d.log_doc AS log_usu, CASE WHEN (at.data_xml IS NOT NULL) THEN 'Si'::text ELSE 'No'::text END AS detalle, at.id_tip_usu_usu, at.data_xml, at.id_tip_tra, t.cod_tip_tra, t.id_mod FROM (((auditoria_transacciones at LEFT JOIN transacciones t USING (id_tip_tra)) LEFT JOIN tipos_usuarios__usuarios tuu USING (id_tip_usu_usu)) LEFT JOIN doctores d ON ((tuu.id_doc = d.id_doc))) ORDER BY to_char(at.fec_aud_tra, 'DD/MM/YYYY HH12:MI:SS AM'::text) DESC;
 /   DROP VIEW public.view_auditoria_transacciones;
       public       desarrollo_g    false    1850    7            �           1259    31066    view_tipo_enfermedades_mic_pac    VIEW     �  CREATE VIEW view_tipo_enfermedades_mic_pac AS
    SELECT hp.id_his, to_char(hp.fec_his, 'DD/MM/YYYY HH12:MI:SS AM'::text) AS fec_his, tm.id_tip_mic, tm.nom_tip_mic, hp.id_pac, (hp.id_his)::text AS num_his FROM ((tipos_micosis tm LEFT JOIN tipos_micosis_pacientes tmp USING (id_tip_mic)) LEFT JOIN historiales_pacientes hp ON ((tmp.id_his = hp.id_his))) WHERE (hp.id_his IS NOT NULL) ORDER BY tm.nom_tip_mic;
 1   DROP VIEW public.view_tipo_enfermedades_mic_pac;
       public       desarrollo_g    false    1851    7            �           1259    31070    wwwsqldesigner    TABLE     �   CREATE TABLE wwwsqldesigner (
    keyword character varying(30) NOT NULL,
    xmldata text,
    dt timestamp without time zone
);
 &   DROP TABLE saib_model.wwwsqldesigner;
    
   saib_model         postgres    false    6            �           2604    31076    id_ani    DEFAULT     _   ALTER TABLE animales ALTER COLUMN id_ani SET DEFAULT nextval('animales_id_ani_seq'::regclass);
 >   ALTER TABLE public.animales ALTER COLUMN id_ani DROP DEFAULT;
       public       desarrollo_g    false    1670    1669            �           2604    31077 
   id_ant_pac    DEFAULT     �   ALTER TABLE antecedentes_pacientes ALTER COLUMN id_ant_pac SET DEFAULT nextval('antecedentes_pacientes_id_ant_pac_seq'::regclass);
 P   ALTER TABLE public.antecedentes_pacientes ALTER COLUMN id_ant_pac DROP DEFAULT;
       public       desarrollo_g    false    1672    1671            �           2604    31078 
   id_ant_per    DEFAULT     �   ALTER TABLE antecedentes_personales ALTER COLUMN id_ant_per SET DEFAULT nextval('antecedentes_personales_id_ant_per_seq'::regclass);
 Q   ALTER TABLE public.antecedentes_personales ALTER COLUMN id_ant_per DROP DEFAULT;
       public       desarrollo_g    false    1674    1673            �           2604    31079 
   id_aud_tra    DEFAULT     �   ALTER TABLE auditoria_transacciones ALTER COLUMN id_aud_tra SET DEFAULT nextval('auditoria_transacciones_id_aud_tra_seq'::regclass);
 Q   ALTER TABLE public.auditoria_transacciones ALTER COLUMN id_aud_tra DROP DEFAULT;
       public       desarrollo_g    false    1676    1675            �           2604    31080    id_cat_cue_mic    DEFAULT     �   ALTER TABLE categorias__cuerpos_micosis ALTER COLUMN id_cat_cue_mic SET DEFAULT nextval('categorias__cuerpos_micosis_id_cat_cue_mic_seq'::regclass);
 Y   ALTER TABLE public.categorias__cuerpos_micosis ALTER COLUMN id_cat_cue_mic DROP DEFAULT;
       public       desarrollo_g    false    1678    1677                        2604    31081 
   id_cat_cue    DEFAULT     {   ALTER TABLE categorias_cuerpos ALTER COLUMN id_cat_cue SET DEFAULT nextval('categorias_cuerpos_id_cat_cue_seq'::regclass);
 L   ALTER TABLE public.categorias_cuerpos ALTER COLUMN id_cat_cue DROP DEFAULT;
       public       desarrollo_g    false    1681    1679                       2604    31082    id_cat_cue_les    DEFAULT     �   ALTER TABLE categorias_cuerpos__lesiones ALTER COLUMN id_cat_cue_les SET DEFAULT nextval('lesiones__partes_cuerpos_id_les_par_cue_seq'::regclass);
 Z   ALTER TABLE public.categorias_cuerpos__lesiones ALTER COLUMN id_cat_cue_les DROP DEFAULT;
       public       desarrollo_g    false    1707    1680                       2604    31083    id_cen_sal_doc    DEFAULT     �   ALTER TABLE centro_salud_doctores ALTER COLUMN id_cen_sal_doc SET DEFAULT nextval('centro_salud_doctores_id_cen_sal_doc_seq'::regclass);
 S   ALTER TABLE public.centro_salud_doctores ALTER COLUMN id_cen_sal_doc DROP DEFAULT;
       public       desarrollo_g    false    1683    1682                       2604    31084    id_cen_sal_pac    DEFAULT     �   ALTER TABLE centro_salud_pacientes ALTER COLUMN id_cen_sal_pac SET DEFAULT nextval('centro_salud_pacientes_id_cen_sal_pac_seq'::regclass);
 T   ALTER TABLE public.centro_salud_pacientes ALTER COLUMN id_cen_sal_pac DROP DEFAULT;
       public       desarrollo_g    false    1687    1686                       2604    31085 
   id_cen_sal    DEFAULT     p   ALTER TABLE centro_saluds ALTER COLUMN id_cen_sal SET DEFAULT nextval('centro_salud_id_cen_sal_seq'::regclass);
 G   ALTER TABLE public.centro_saluds ALTER COLUMN id_cen_sal DROP DEFAULT;
       public       desarrollo_g    false    1685    1684                       2604    31086 
   id_con_ani    DEFAULT     {   ALTER TABLE contactos_animales ALTER COLUMN id_con_ani SET DEFAULT nextval('contactos_animales_id_con_ani_seq'::regclass);
 L   ALTER TABLE public.contactos_animales ALTER COLUMN id_con_ani DROP DEFAULT;
       public       desarrollo_g    false    1689    1688                       2604    31087    id_doc    DEFAULT     _   ALTER TABLE doctores ALTER COLUMN id_doc SET DEFAULT nextval('doctores_id_doc_seq'::regclass);
 >   ALTER TABLE public.doctores ALTER COLUMN id_doc DROP DEFAULT;
       public       desarrollo_g    false    1691    1690                       2604    31088 
   id_enf_mic    DEFAULT     �   ALTER TABLE enfermedades_micologicas ALTER COLUMN id_enf_mic SET DEFAULT nextval('enfermedades_micologicas_id_enf_mic_seq'::regclass);
 R   ALTER TABLE public.enfermedades_micologicas ALTER COLUMN id_enf_mic DROP DEFAULT;
       public       desarrollo_g    false    1693    1692            	           2604    31089 
   id_enf_pac    DEFAULT     �   ALTER TABLE enfermedades_pacientes ALTER COLUMN id_enf_pac SET DEFAULT nextval('enfermedades_pacientes_id_enf_pac_seq'::regclass);
 P   ALTER TABLE public.enfermedades_pacientes ALTER COLUMN id_enf_pac DROP DEFAULT;
       public       desarrollo_g    false    1695    1694            
           2604    31090    id_est    DEFAULT     ]   ALTER TABLE estados ALTER COLUMN id_est SET DEFAULT nextval('estados_id_est_seq'::regclass);
 =   ALTER TABLE public.estados ALTER COLUMN id_est DROP DEFAULT;
       public       desarrollo_g    false    1697    1696                       2604    31091 
   id_for_inf    DEFAULT     y   ALTER TABLE forma_infecciones ALTER COLUMN id_for_inf SET DEFAULT nextval('forma_infecciones_id_for_inf_seq'::regclass);
 K   ALTER TABLE public.forma_infecciones ALTER COLUMN id_for_inf DROP DEFAULT;
       public       desarrollo_g    false    1703    1698                       2604    31092 
   id_for_pac    DEFAULT     �   ALTER TABLE forma_infecciones__pacientes ALTER COLUMN id_for_pac SET DEFAULT nextval('forma_infecciones__pacientes_id_for_pac_seq'::regclass);
 V   ALTER TABLE public.forma_infecciones__pacientes ALTER COLUMN id_for_pac DROP DEFAULT;
       public       desarrollo_g    false    1700    1699                       2604    31093    id_for_inf_tip_mic    DEFAULT     �   ALTER TABLE forma_infecciones__tipos_micosis ALTER COLUMN id_for_inf_tip_mic SET DEFAULT nextval('forma_infecciones__tipos_micosis_id_for_inf_tip_mic_seq'::regclass);
 b   ALTER TABLE public.forma_infecciones__tipos_micosis ALTER COLUMN id_for_inf_tip_mic DROP DEFAULT;
       public       desarrollo_g    false    1702    1701                       2604    31094    id_his    DEFAULT     y   ALTER TABLE historiales_pacientes ALTER COLUMN id_his SET DEFAULT nextval('historiales_pacientes_id_his_seq'::regclass);
 K   ALTER TABLE public.historiales_pacientes ALTER COLUMN id_his DROP DEFAULT;
       public       desarrollo_g    false    1705    1704                       2604    31095    id_les    DEFAULT     _   ALTER TABLE lesiones ALTER COLUMN id_les SET DEFAULT nextval('lesiones_id_les_seq'::regclass);
 >   ALTER TABLE public.lesiones ALTER COLUMN id_les DROP DEFAULT;
       public       desarrollo_g    false    1708    1706                       2604    31096    id_les_par_cue_pac    DEFAULT     �   ALTER TABLE lesiones_partes_cuerpos__pacientes ALTER COLUMN id_les_par_cue_pac SET DEFAULT nextval('lesiones_partes_cuerpos__pacientes_id_les_par_cue_pac_seq'::regclass);
 d   ALTER TABLE public.lesiones_partes_cuerpos__pacientes ALTER COLUMN id_les_par_cue_pac DROP DEFAULT;
       public       desarrollo_g    false    1710    1709                       2604    31097 
   id_loc_cue    DEFAULT     �   ALTER TABLE localizaciones_cuerpos ALTER COLUMN id_loc_cue SET DEFAULT nextval('localizaciones_cuerpos_id_loc_cue_seq'::regclass);
 P   ALTER TABLE public.localizaciones_cuerpos ALTER COLUMN id_loc_cue DROP DEFAULT;
       public       desarrollo_g    false    1712    1711                       2604    31098    id_mod    DEFAULT     ]   ALTER TABLE modulos ALTER COLUMN id_mod SET DEFAULT nextval('modulos_id_mod_seq'::regclass);
 =   ALTER TABLE public.modulos ALTER COLUMN id_mod DROP DEFAULT;
       public       desarrollo_g    false    1714    1713                       2604    31099 
   id_mue_cli    DEFAULT     y   ALTER TABLE muestras_clinicas ALTER COLUMN id_mue_cli SET DEFAULT nextval('muestras_clinicas_id_mue_cli_seq'::regclass);
 K   ALTER TABLE public.muestras_clinicas ALTER COLUMN id_mue_cli DROP DEFAULT;
       public       desarrollo_g    false    1716    1715                       2604    31100 
   id_mue_pac    DEFAULT     {   ALTER TABLE muestras_pacientes ALTER COLUMN id_mue_pac SET DEFAULT nextval('muestras_pacientes_id_mue_pac_seq'::regclass);
 L   ALTER TABLE public.muestras_pacientes ALTER COLUMN id_mue_pac DROP DEFAULT;
       public       desarrollo_g    false    1718    1717                       2604    31101    id_mun    DEFAULT     c   ALTER TABLE municipios ALTER COLUMN id_mun SET DEFAULT nextval('municipios_id_mun_seq'::regclass);
 @   ALTER TABLE public.municipios ALTER COLUMN id_mun DROP DEFAULT;
       public       desarrollo_g    false    1720    1719                       2604    31102    id_pac    DEFAULT     a   ALTER TABLE pacientes ALTER COLUMN id_pac SET DEFAULT nextval('pacientes_id_pac_seq'::regclass);
 ?   ALTER TABLE public.pacientes ALTER COLUMN id_pac DROP DEFAULT;
       public       desarrollo_g    false    1722    1721                       2604    31103    id_pai    DEFAULT     [   ALTER TABLE paises ALTER COLUMN id_pai SET DEFAULT nextval('paises_id_pai_seq'::regclass);
 <   ALTER TABLE public.paises ALTER COLUMN id_pai DROP DEFAULT;
       public       desarrollo_g    false    1724    1723                       2604    31104    id_par    DEFAULT     c   ALTER TABLE parroquias ALTER COLUMN id_par SET DEFAULT nextval('parroquias_id_par_seq'::regclass);
 @   ALTER TABLE public.parroquias ALTER COLUMN id_par DROP DEFAULT;
       public       desarrollo_g    false    1726    1725                       2604    31105 
   id_par_cue    DEFAULT     s   ALTER TABLE partes_cuerpos ALTER COLUMN id_par_cue SET DEFAULT nextval('partes_cuerpos_id_par_cue_seq'::regclass);
 H   ALTER TABLE public.partes_cuerpos ALTER COLUMN id_par_cue DROP DEFAULT;
       public       desarrollo_g    false    1730    1727                       2604    31106    id_par_cue_cat_cue    DEFAULT     �   ALTER TABLE partes_cuerpos__categorias_cuerpos ALTER COLUMN id_par_cue_cat_cue SET DEFAULT nextval('partes_cuerpos__categorias_cuerpos_id_par_cue_cat_cue_seq'::regclass);
 d   ALTER TABLE public.partes_cuerpos__categorias_cuerpos ALTER COLUMN id_par_cue_cat_cue DROP DEFAULT;
       public       desarrollo_g    false    1729    1728                       2604    31107 
   id_tie_evo    DEFAULT     {   ALTER TABLE tiempo_evoluciones ALTER COLUMN id_tie_evo SET DEFAULT nextval('tiempo_evoluciones_id_tie_evo_seq'::regclass);
 L   ALTER TABLE public.tiempo_evoluciones ALTER COLUMN id_tie_evo DROP DEFAULT;
       public       desarrollo_g    false    1732    1731                       2604    31108 
   id_tip_con    DEFAULT     u   ALTER TABLE tipos_consultas ALTER COLUMN id_tip_con SET DEFAULT nextval('tipos_consultas_id_tip_con_seq'::regclass);
 I   ALTER TABLE public.tipos_consultas ALTER COLUMN id_tip_con DROP DEFAULT;
       public       desarrollo_g    false    1734    1733                        2604    31109    id_tip_con_pac    DEFAULT     �   ALTER TABLE tipos_consultas_pacientes ALTER COLUMN id_tip_con_pac SET DEFAULT nextval('tipos_consultas_pacientes_id_tip_con_pac_seq'::regclass);
 W   ALTER TABLE public.tipos_consultas_pacientes ALTER COLUMN id_tip_con_pac DROP DEFAULT;
       public       desarrollo_g    false    1736    1735            !           2604    31110    id_tip_est_mic    DEFAULT     �   ALTER TABLE tipos_estudios_micologicos ALTER COLUMN id_tip_est_mic SET DEFAULT nextval('tipos_estudios_micologicos_id_tip_est_mic_seq'::regclass);
 X   ALTER TABLE public.tipos_estudios_micologicos ALTER COLUMN id_tip_est_mic DROP DEFAULT;
       public       desarrollo_g    false    1738    1737            "           2604    31111 
   id_tip_exa    DEFAULT     s   ALTER TABLE tipos_examenes ALTER COLUMN id_tip_exa SET DEFAULT nextval('tipos_examenes_id_tip_exa_seq'::regclass);
 H   ALTER TABLE public.tipos_examenes ALTER COLUMN id_tip_exa DROP DEFAULT;
       public       desarrollo_g    false    1740    1739            #           2604    31112 
   id_tip_mic    DEFAULT     q   ALTER TABLE tipos_micosis ALTER COLUMN id_tip_mic SET DEFAULT nextval('tipos_micosis_id_tip_mic_seq'::regclass);
 G   ALTER TABLE public.tipos_micosis ALTER COLUMN id_tip_mic DROP DEFAULT;
       public       desarrollo_g    false    1742    1741            $           2604    31113    id_tip_mic_pac    DEFAULT     �   ALTER TABLE tipos_micosis_pacientes ALTER COLUMN id_tip_mic_pac SET DEFAULT nextval('tipos_micosis_pacientes_id_tip_mic_pac_seq'::regclass);
 U   ALTER TABLE public.tipos_micosis_pacientes ALTER COLUMN id_tip_mic_pac DROP DEFAULT;
       public       desarrollo_g    false    1746    1743            %           2604    31114    id_tip_mic_pac_tip_est_mic    DEFAULT     �   ALTER TABLE tipos_micosis_pacientes__tipos_estudios_micologicos ALTER COLUMN id_tip_mic_pac_tip_est_mic SET DEFAULT nextval('tipos_micosis_pacientes__tipos_e_id_tip_mic_pac_tip_est_mic_seq'::regclass);
 }   ALTER TABLE public.tipos_micosis_pacientes__tipos_estudios_micologicos ALTER COLUMN id_tip_mic_pac_tip_est_mic DROP DEFAULT;
       public       desarrollo_g    false    1745    1744            &           2604    31115 
   id_tip_usu    DEFAULT     s   ALTER TABLE tipos_usuarios ALTER COLUMN id_tip_usu SET DEFAULT nextval('tipos_usuarios_id_tip_usu_seq'::regclass);
 H   ALTER TABLE public.tipos_usuarios ALTER COLUMN id_tip_usu DROP DEFAULT;
       public       desarrollo_g    false    1750    1747            '           2604    31116    id_tip_usu_usu    DEFAULT     �   ALTER TABLE tipos_usuarios__usuarios ALTER COLUMN id_tip_usu_usu SET DEFAULT nextval('tipos_usuarios__usuarios_id_tip_usu_usu_seq'::regclass);
 V   ALTER TABLE public.tipos_usuarios__usuarios ALTER COLUMN id_tip_usu_usu DROP DEFAULT;
       public       desarrollo_g    false    1749    1748            (           2604    31117 
   id_tip_tra    DEFAULT     q   ALTER TABLE transacciones ALTER COLUMN id_tip_tra SET DEFAULT nextval('transacciones_id_tip_tra_seq'::regclass);
 G   ALTER TABLE public.transacciones ALTER COLUMN id_tip_tra DROP DEFAULT;
       public       desarrollo_g    false    1752    1751            )           2604    31118 
   id_tra_usu    DEFAULT     �   ALTER TABLE transacciones_usuarios ALTER COLUMN id_tra_usu SET DEFAULT nextval('transacciones_usuarios_id_tra_usu_seq'::regclass);
 P   ALTER TABLE public.transacciones_usuarios ALTER COLUMN id_tra_usu DROP DEFAULT;
       public       desarrollo_g    false    1754    1753            *           2604    31119    id_tra    DEFAULT     g   ALTER TABLE tratamientos ALTER COLUMN id_tra SET DEFAULT nextval('tratamientos_id_tra_seq'::regclass);
 B   ALTER TABLE public.tratamientos ALTER COLUMN id_tra DROP DEFAULT;
       public       desarrollo_g    false    1756    1755            +           2604    31120 
   id_tra_pac    DEFAULT     �   ALTER TABLE tratamientos_pacientes ALTER COLUMN id_tra_pac SET DEFAULT nextval('tratamientos_pacientes_id_tra_pac_seq'::regclass);
 P   ALTER TABLE public.tratamientos_pacientes ALTER COLUMN id_tra_pac DROP DEFAULT;
       public       desarrollo_g    false    1758    1757            -           2604    31121 
   id_usu_adm    DEFAULT     �   ALTER TABLE usuarios_administrativos ALTER COLUMN id_usu_adm SET DEFAULT nextval('usuarios_administrativos_id_usu_adm_seq'::regclass);
 R   ALTER TABLE public.usuarios_administrativos ALTER COLUMN id_usu_adm DROP DEFAULT;
       public       desarrollo_g    false    1760    1759            	          0    30817    animales 
   TABLE DATA               ,   COPY animales (id_ani, nom_ani) FROM stdin;
    public       desarrollo_g    false    1669   ��      	          0    30822    antecedentes_pacientes 
   TABLE DATA               I   COPY antecedentes_pacientes (id_ant_pac, id_ant_per, id_pac) FROM stdin;
    public       desarrollo_g    false    1671   ��      	          0    30827    antecedentes_personales 
   TABLE DATA               C   COPY antecedentes_personales (id_ant_per, nom_ant_per) FROM stdin;
    public       desarrollo_g    false    1673   1�      		          0    30832    auditoria_transacciones 
   TABLE DATA               i   COPY auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) FROM stdin;
    public       desarrollo_g    false    1675   ��      
	          0    30840    categorias__cuerpos_micosis 
   TABLE DATA               V   COPY categorias__cuerpos_micosis (id_cat_cue_mic, id_cat_cue, id_tip_mic) FROM stdin;
    public       desarrollo_g    false    1677   ��      	          0    30845    categorias_cuerpos 
   TABLE DATA               >   COPY categorias_cuerpos (id_cat_cue, nom_cat_cue) FROM stdin;
    public       desarrollo_g    false    1679   �      	          0    30848    categorias_cuerpos__lesiones 
   TABLE DATA               S   COPY categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) FROM stdin;
    public       desarrollo_g    false    1680   A�      	          0    30853    centro_salud_doctores 
   TABLE DATA               Y   COPY centro_salud_doctores (id_cen_sal_doc, id_cen_sal, id_doc, otr_cen_sal) FROM stdin;
    public       desarrollo_g    false    1682   Z�      	          0    30863    centro_salud_pacientes 
   TABLE DATA               Z   COPY centro_salud_pacientes (id_cen_sal_pac, id_his, id_cen_sal, otr_cen_sal) FROM stdin;
    public       desarrollo_g    false    1686   ��      	          0    30858    centro_saluds 
   TABLE DATA               F   COPY centro_saluds (id_cen_sal, nom_cen_sal, des_cen_sal) FROM stdin;
    public       desarrollo_g    false    1684   �      	          0    30868    contactos_animales 
   TABLE DATA               J   COPY contactos_animales (id_con_ani, id_his, id_ani, otr_ani) FROM stdin;
    public       desarrollo_g    false    1688   ��      	          0    30873    doctores 
   TABLE DATA               o   COPY doctores (id_doc, nom_doc, ape_doc, ced_doc, pas_doc, tel_doc, cor_doc, log_doc, fec_reg_doc) FROM stdin;
    public       desarrollo_g    false    1690   �      	          0    30882    enfermedades_micologicas 
   TABLE DATA               P   COPY enfermedades_micologicas (id_enf_mic, nom_enf_mic, id_tip_mic) FROM stdin;
    public       desarrollo_g    false    1692   p�      	          0    30887    enfermedades_pacientes 
   TABLE DATA               k   COPY enfermedades_pacientes (id_enf_pac, id_enf_mic, otr_enf_mic, esp_enf_mic, id_tip_mic_pac) FROM stdin;
    public       desarrollo_g    false    1694   ��      	          0    30892    estados 
   TABLE DATA               3   COPY estados (id_est, des_est, id_pai) FROM stdin;
    public       desarrollo_g    false    1696   �      	          0    30897    forma_infecciones 
   TABLE DATA               =   COPY forma_infecciones (id_for_inf, des_for_inf) FROM stdin;
    public       desarrollo_g    false    1698   '�      	          0    30900    forma_infecciones__pacientes 
   TABLE DATA               d   COPY forma_infecciones__pacientes (id_for_pac, id_for_inf, otr_for_inf, id_tip_mic_pac) FROM stdin;
    public       desarrollo_g    false    1699   ��      	          0    30905     forma_infecciones__tipos_micosis 
   TABLE DATA               _   COPY forma_infecciones__tipos_micosis (id_for_inf_tip_mic, id_tip_mic, id_for_inf) FROM stdin;
    public       desarrollo_g    false    1701   3�      	          0    30912    historiales_pacientes 
   TABLE DATA               c   COPY historiales_pacientes (id_his, id_pac, des_his, id_doc, des_adi_pac_his, fec_his) FROM stdin;
    public       desarrollo_g    false    1704   ��      	          0    30921    lesiones 
   TABLE DATA               ,   COPY lesiones (id_les, nom_les) FROM stdin;
    public       desarrollo_g    false    1706   |�      	          0    30928 "   lesiones_partes_cuerpos__pacientes 
   TABLE DATA               �   COPY lesiones_partes_cuerpos__pacientes (id_les_par_cue_pac, otr_les_par_cue, id_cat_cue_les, id_par_cue_cat_cue, id_tip_mic_pac) FROM stdin;
    public       desarrollo_g    false    1709   f      	          0    30933    localizaciones_cuerpos 
   TABLE DATA               N   COPY localizaciones_cuerpos (id_loc_cue, nom_loc_cue, id_par_cue) FROM stdin;
    public       desarrollo_g    false    1711         	          0    30938    modulos 
   TABLE DATA               @   COPY modulos (id_mod, cod_mod, des_mod, id_tip_usu) FROM stdin;
    public       desarrollo_g    false    1713   4      	          0    30943    muestras_clinicas 
   TABLE DATA               =   COPY muestras_clinicas (id_mue_cli, nom_mue_cli) FROM stdin;
    public       desarrollo_g    false    1715   t      	          0    30948    muestras_pacientes 
   TABLE DATA               R   COPY muestras_pacientes (id_mue_pac, id_his, id_mue_cli, otr_mue_cli) FROM stdin;
    public       desarrollo_g    false    1717   )      	          0    30953 
   municipios 
   TABLE DATA               6   COPY municipios (id_mun, des_mun, id_est) FROM stdin;
    public       desarrollo_g    false    1719   �       	          0    30958 	   pacientes 
   TABLE DATA               �   COPY pacientes (id_pac, ape_pac, nom_pac, ced_pac, fec_nac_pac, nac_pac, tel_hab_pac, tel_cel_pac, ocu_pac, ciu_pac, id_pai, id_est, id_mun, id_par, num_pac, id_doc, fec_reg_pac, sex_pac) FROM stdin;
    public       desarrollo_g    false    1721   z      !	          0    30964    paises 
   TABLE DATA               3   COPY paises (id_pai, des_pai, cod_pai) FROM stdin;
    public       desarrollo_g    false    1723          "	          0    30969 
   parroquias 
   TABLE DATA               6   COPY parroquias (id_par, des_par, id_mun) FROM stdin;
    public       desarrollo_g    false    1725   M      #	          0    30974    partes_cuerpos 
   TABLE DATA               :   COPY partes_cuerpos (id_par_cue, nom_par_cue) FROM stdin;
    public       desarrollo_g    false    1727   j      $	          0    30977 "   partes_cuerpos__categorias_cuerpos 
   TABLE DATA               a   COPY partes_cuerpos__categorias_cuerpos (id_par_cue_cat_cue, id_cat_cue, id_par_cue) FROM stdin;
    public       desarrollo_g    false    1728         %	          0    30984    tiempo_evoluciones 
   TABLE DATA               B   COPY tiempo_evoluciones (id_tie_evo, id_his, tie_evo) FROM stdin;
    public       desarrollo_g    false    1731   U      &	          0    30990    tipos_consultas 
   TABLE DATA               ;   COPY tipos_consultas (id_tip_con, nom_tip_con) FROM stdin;
    public       desarrollo_g    false    1733   �      '	          0    30995    tipos_consultas_pacientes 
   TABLE DATA               ]   COPY tipos_consultas_pacientes (id_tip_con_pac, id_tip_con, id_his, otr_tip_con) FROM stdin;
    public       desarrollo_g    false    1735         (	          0    31000    tipos_estudios_micologicos 
   TABLE DATA               f   COPY tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) FROM stdin;
    public       desarrollo_g    false    1737   q      )	          0    31005    tipos_examenes 
   TABLE DATA               :   COPY tipos_examenes (id_tip_exa, nom_tip_exa) FROM stdin;
    public       desarrollo_g    false    1739   �      *	          0    31010    tipos_micosis 
   TABLE DATA               9   COPY tipos_micosis (id_tip_mic, nom_tip_mic) FROM stdin;
    public       desarrollo_g    false    1741   �      +	          0    31015    tipos_micosis_pacientes 
   TABLE DATA               N   COPY tipos_micosis_pacientes (id_tip_mic_pac, id_tip_mic, id_his) FROM stdin;
    public       desarrollo_g    false    1743         ,	          0    31018 3   tipos_micosis_pacientes__tipos_estudios_micologicos 
   TABLE DATA               �   COPY tipos_micosis_pacientes__tipos_estudios_micologicos (id_tip_mic_pac_tip_est_mic, id_tip_mic_pac, id_tip_est_mic) FROM stdin;
    public       desarrollo_g    false    1744   <      -	          0    31025    tipos_usuarios 
   TABLE DATA               G   COPY tipos_usuarios (id_tip_usu, cod_tip_usu, des_tip_usu) FROM stdin;
    public       desarrollo_g    false    1747   �      .	          0    31028    tipos_usuarios__usuarios 
   TABLE DATA               [   COPY tipos_usuarios__usuarios (id_tip_usu_usu, id_doc, id_usu_adm, id_tip_usu) FROM stdin;
    public       desarrollo_g    false    1748   �      /	          0    31035    transacciones 
   TABLE DATA               N   COPY transacciones (id_tip_tra, cod_tip_tra, des_tip_tra, id_mod) FROM stdin;
    public       desarrollo_g    false    1751   "      0	          0    31040    transacciones_usuarios 
   TABLE DATA               Q   COPY transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) FROM stdin;
    public       desarrollo_g    false    1753         1	          0    31045    tratamientos 
   TABLE DATA               0   COPY tratamientos (id_tra, nom_tra) FROM stdin;
    public       desarrollo_g    false    1755   �      2	          0    31050    tratamientos_pacientes 
   TABLE DATA               N   COPY tratamientos_pacientes (id_tra_pac, id_his, id_tra, otr_tra) FROM stdin;
    public       desarrollo_g    false    1757   "      3	          0    31055    usuarios_administrativos 
   TABLE DATA               �   COPY usuarios_administrativos (id_usu_adm, nom_usu_adm, ape_usu_adm, pas_usu_adm, log_usu_adm, tel_usu_adm, fec_reg_usu_adm, adm_usu) FROM stdin;
    public       desarrollo_g    false    1759   �      4	          0    31070    wwwsqldesigner 
   TABLE DATA               7   COPY wwwsqldesigner (keyword, xmldata, dt) FROM stdin;
 
   saib_model       postgres    false    1763   ~      0           2606    31124    animales_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY animales
    ADD CONSTRAINT animales_pkey PRIMARY KEY (id_ani);
 @   ALTER TABLE ONLY public.animales DROP CONSTRAINT animales_pkey;
       public         desarrollo_g    false    1669    1669            2           2606    31126    antecedentes_pacientes_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY antecedentes_pacientes
    ADD CONSTRAINT antecedentes_pacientes_pkey PRIMARY KEY (id_ant_pac);
 \   ALTER TABLE ONLY public.antecedentes_pacientes DROP CONSTRAINT antecedentes_pacientes_pkey;
       public         desarrollo_g    false    1671    1671            5           2606    31128    antecedentes_personales_pkey 
   CONSTRAINT     s   ALTER TABLE ONLY antecedentes_personales
    ADD CONSTRAINT antecedentes_personales_pkey PRIMARY KEY (id_ant_per);
 ^   ALTER TABLE ONLY public.antecedentes_personales DROP CONSTRAINT antecedentes_personales_pkey;
       public         desarrollo_g    false    1673    1673            7           2606    31130    auditoria_transacciones_pkey 
   CONSTRAINT     s   ALTER TABLE ONLY auditoria_transacciones
    ADD CONSTRAINT auditoria_transacciones_pkey PRIMARY KEY (id_aud_tra);
 ^   ALTER TABLE ONLY public.auditoria_transacciones DROP CONSTRAINT auditoria_transacciones_pkey;
       public    saib    desarrollo_g    false    1675    1675            :           2606    31132     categorias__cuerpos_micosis_pkey 
   CONSTRAINT        ALTER TABLE ONLY categorias__cuerpos_micosis
    ADD CONSTRAINT categorias__cuerpos_micosis_pkey PRIMARY KEY (id_cat_cue_mic);
 f   ALTER TABLE ONLY public.categorias__cuerpos_micosis DROP CONSTRAINT categorias__cuerpos_micosis_pkey;
       public         desarrollo_g    false    1677    1677            <           2606    31134 "   categorias__cuerpos_micosis_unique 
   CONSTRAINT     �   ALTER TABLE ONLY categorias__cuerpos_micosis
    ADD CONSTRAINT categorias__cuerpos_micosis_unique UNIQUE (id_cat_cue, id_tip_mic);
 h   ALTER TABLE ONLY public.categorias__cuerpos_micosis DROP CONSTRAINT categorias__cuerpos_micosis_unique;
       public         desarrollo_g    false    1677    1677    1677            A           2606    31576 #   categorias_cuerpos__lesiones_unique 
   CONSTRAINT     �   ALTER TABLE ONLY categorias_cuerpos__lesiones
    ADD CONSTRAINT categorias_cuerpos__lesiones_unique UNIQUE (id_les, id_cat_cue);
 j   ALTER TABLE ONLY public.categorias_cuerpos__lesiones DROP CONSTRAINT categorias_cuerpos__lesiones_unique;
       public         desarrollo_g    false    1680    1680    1680            ?           2606    31136    categorias_cuerpos_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY categorias_cuerpos
    ADD CONSTRAINT categorias_cuerpos_pkey PRIMARY KEY (id_cat_cue);
 T   ALTER TABLE ONLY public.categorias_cuerpos DROP CONSTRAINT categorias_cuerpos_pkey;
       public         desarrollo_g    false    1679    1679            G           2606    31138    centro_salud_doctores_pkey 
   CONSTRAINT     s   ALTER TABLE ONLY centro_salud_doctores
    ADD CONSTRAINT centro_salud_doctores_pkey PRIMARY KEY (id_cen_sal_doc);
 Z   ALTER TABLE ONLY public.centro_salud_doctores DROP CONSTRAINT centro_salud_doctores_pkey;
       public         desarrollo_g    false    1682    1682            I           2606    31140    centro_salud_doctores_unique 
   CONSTRAINT     t   ALTER TABLE ONLY centro_salud_doctores
    ADD CONSTRAINT centro_salud_doctores_unique UNIQUE (id_doc, id_cen_sal);
 \   ALTER TABLE ONLY public.centro_salud_doctores DROP CONSTRAINT centro_salud_doctores_unique;
       public         desarrollo_g    false    1682    1682    1682            O           2606    31142    centro_salud_pacientes_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY centro_salud_pacientes
    ADD CONSTRAINT centro_salud_pacientes_pkey PRIMARY KEY (id_cen_sal_pac);
 \   ALTER TABLE ONLY public.centro_salud_pacientes DROP CONSTRAINT centro_salud_pacientes_pkey;
       public         desarrollo_g    false    1686    1686            Q           2606    31144    centro_salud_pacientes_unique 
   CONSTRAINT     v   ALTER TABLE ONLY centro_salud_pacientes
    ADD CONSTRAINT centro_salud_pacientes_unique UNIQUE (id_his, id_cen_sal);
 ^   ALTER TABLE ONLY public.centro_salud_pacientes DROP CONSTRAINT centro_salud_pacientes_unique;
       public         desarrollo_g    false    1686    1686    1686            L           2606    31146    centro_salud_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY centro_saluds
    ADD CONSTRAINT centro_salud_pkey PRIMARY KEY (id_cen_sal);
 I   ALTER TABLE ONLY public.centro_saluds DROP CONSTRAINT centro_salud_pkey;
       public         desarrollo_g    false    1684    1684            T           2606    31148    contactos_animales_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY contactos_animales
    ADD CONSTRAINT contactos_animales_pkey PRIMARY KEY (id_con_ani);
 T   ALTER TABLE ONLY public.contactos_animales DROP CONSTRAINT contactos_animales_pkey;
       public         desarrollo_g    false    1688    1688            V           2606    31150    contactos_animales_unique 
   CONSTRAINT     j   ALTER TABLE ONLY contactos_animales
    ADD CONSTRAINT contactos_animales_unique UNIQUE (id_his, id_ani);
 V   ALTER TABLE ONLY public.contactos_animales DROP CONSTRAINT contactos_animales_unique;
       public         desarrollo_g    false    1688    1688    1688            X           2606    31152    doctores_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY doctores
    ADD CONSTRAINT doctores_pkey PRIMARY KEY (id_doc);
 @   ALTER TABLE ONLY public.doctores DROP CONSTRAINT doctores_pkey;
       public         desarrollo_g    false    1690    1690            [           2606    31154    enfermedades_micologicas_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY enfermedades_micologicas
    ADD CONSTRAINT enfermedades_micologicas_pkey PRIMARY KEY (id_enf_mic);
 `   ALTER TABLE ONLY public.enfermedades_micologicas DROP CONSTRAINT enfermedades_micologicas_pkey;
       public         desarrollo_g    false    1692    1692            ]           2606    31156    enfermedades_pacientes_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY enfermedades_pacientes
    ADD CONSTRAINT enfermedades_pacientes_pkey PRIMARY KEY (id_enf_pac);
 \   ALTER TABLE ONLY public.enfermedades_pacientes DROP CONSTRAINT enfermedades_pacientes_pkey;
       public         desarrollo_g    false    1694    1694            _           2606    31572    enfermedades_pacientes_unique 
   CONSTRAINT     ~   ALTER TABLE ONLY enfermedades_pacientes
    ADD CONSTRAINT enfermedades_pacientes_unique UNIQUE (id_enf_mic, id_tip_mic_pac);
 ^   ALTER TABLE ONLY public.enfermedades_pacientes DROP CONSTRAINT enfermedades_pacientes_unique;
       public         desarrollo_g    false    1694    1694    1694            a           2606    31158    estados_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY estados
    ADD CONSTRAINT estados_pkey PRIMARY KEY (id_est);
 >   ALTER TABLE ONLY public.estados DROP CONSTRAINT estados_pkey;
       public         desarrollo_g    false    1696    1696            g           2606    31160 !   forma_infecciones__pacientes_pkey 
   CONSTRAINT     }   ALTER TABLE ONLY forma_infecciones__pacientes
    ADD CONSTRAINT forma_infecciones__pacientes_pkey PRIMARY KEY (id_for_pac);
 h   ALTER TABLE ONLY public.forma_infecciones__pacientes DROP CONSTRAINT forma_infecciones__pacientes_pkey;
       public         desarrollo_g    false    1699    1699            i           2606    31162 #   forma_infecciones__pacientes_unique 
   CONSTRAINT     �   ALTER TABLE ONLY forma_infecciones__pacientes
    ADD CONSTRAINT forma_infecciones__pacientes_unique UNIQUE (id_for_inf, id_tip_mic_pac);
 j   ALTER TABLE ONLY public.forma_infecciones__pacientes DROP CONSTRAINT forma_infecciones__pacientes_unique;
       public         desarrollo_g    false    1699    1699    1699            l           2606    31164 %   forma_infecciones__tipos_micosis_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY forma_infecciones__tipos_micosis
    ADD CONSTRAINT forma_infecciones__tipos_micosis_pkey PRIMARY KEY (id_for_inf_tip_mic);
 p   ALTER TABLE ONLY public.forma_infecciones__tipos_micosis DROP CONSTRAINT forma_infecciones__tipos_micosis_pkey;
       public         desarrollo_g    false    1701    1701            n           2606    31166 '   forma_infecciones__tipos_micosis_unique 
   CONSTRAINT     �   ALTER TABLE ONLY forma_infecciones__tipos_micosis
    ADD CONSTRAINT forma_infecciones__tipos_micosis_unique UNIQUE (id_tip_mic, id_for_inf);
 r   ALTER TABLE ONLY public.forma_infecciones__tipos_micosis DROP CONSTRAINT forma_infecciones__tipos_micosis_unique;
       public         desarrollo_g    false    1701    1701    1701            d           2606    31168    forma_infecciones_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY forma_infecciones
    ADD CONSTRAINT forma_infecciones_pkey PRIMARY KEY (id_for_inf);
 R   ALTER TABLE ONLY public.forma_infecciones DROP CONSTRAINT forma_infecciones_pkey;
       public         desarrollo_g    false    1698    1698            q           2606    31170    historiales_pacientes_pkey 
   CONSTRAINT     k   ALTER TABLE ONLY historiales_pacientes
    ADD CONSTRAINT historiales_pacientes_pkey PRIMARY KEY (id_his);
 Z   ALTER TABLE ONLY public.historiales_pacientes DROP CONSTRAINT historiales_pacientes_pkey;
       public         desarrollo_g    false    1704    1704            D           2606    31172    lesiones__partes_cuerpos_pkey 
   CONSTRAINT     }   ALTER TABLE ONLY categorias_cuerpos__lesiones
    ADD CONSTRAINT lesiones__partes_cuerpos_pkey PRIMARY KEY (id_cat_cue_les);
 d   ALTER TABLE ONLY public.categorias_cuerpos__lesiones DROP CONSTRAINT lesiones__partes_cuerpos_pkey;
       public         desarrollo_g    false    1680    1680            s           2606    31174    lesiones_id_les_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY lesiones
    ADD CONSTRAINT lesiones_id_les_pkey PRIMARY KEY (id_les);
 G   ALTER TABLE ONLY public.lesiones DROP CONSTRAINT lesiones_id_les_pkey;
       public         desarrollo_g    false    1706    1706            v           2606    31176 '   lesiones_partes_cuerpos__pacientes_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY lesiones_partes_cuerpos__pacientes
    ADD CONSTRAINT lesiones_partes_cuerpos__pacientes_pkey PRIMARY KEY (id_les_par_cue_pac);
 t   ALTER TABLE ONLY public.lesiones_partes_cuerpos__pacientes DROP CONSTRAINT lesiones_partes_cuerpos__pacientes_pkey;
       public         desarrollo_g    false    1709    1709            x           2606    31178 )   lesiones_partes_cuerpos__pacientes_unique 
   CONSTRAINT     �   ALTER TABLE ONLY lesiones_partes_cuerpos__pacientes
    ADD CONSTRAINT lesiones_partes_cuerpos__pacientes_unique UNIQUE (id_cat_cue_les, id_par_cue_cat_cue, id_tip_mic_pac);
 v   ALTER TABLE ONLY public.lesiones_partes_cuerpos__pacientes DROP CONSTRAINT lesiones_partes_cuerpos__pacientes_unique;
       public         desarrollo_g    false    1709    1709    1709    1709            {           2606    31180    localizaciones_cuerpos_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY localizaciones_cuerpos
    ADD CONSTRAINT localizaciones_cuerpos_pkey PRIMARY KEY (id_loc_cue);
 \   ALTER TABLE ONLY public.localizaciones_cuerpos DROP CONSTRAINT localizaciones_cuerpos_pkey;
       public         desarrollo_g    false    1711    1711            }           2606    31182    modulos_cod_mod_unique 
   CONSTRAINT     a   ALTER TABLE ONLY modulos
    ADD CONSTRAINT modulos_cod_mod_unique UNIQUE (cod_mod, id_tip_usu);
 H   ALTER TABLE ONLY public.modulos DROP CONSTRAINT modulos_cod_mod_unique;
       public         desarrollo_g    false    1713    1713    1713                       2606    31184    modulos_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY modulos
    ADD CONSTRAINT modulos_pkey PRIMARY KEY (id_mod);
 >   ALTER TABLE ONLY public.modulos DROP CONSTRAINT modulos_pkey;
       public         desarrollo_g    false    1713    1713            �           2606    31186    muestras_clinicas_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY muestras_clinicas
    ADD CONSTRAINT muestras_clinicas_pkey PRIMARY KEY (id_mue_cli);
 R   ALTER TABLE ONLY public.muestras_clinicas DROP CONSTRAINT muestras_clinicas_pkey;
       public         desarrollo_g    false    1715    1715            �           2606    31188    muestras_pacientes_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY muestras_pacientes
    ADD CONSTRAINT muestras_pacientes_pkey PRIMARY KEY (id_mue_pac);
 T   ALTER TABLE ONLY public.muestras_pacientes DROP CONSTRAINT muestras_pacientes_pkey;
       public         desarrollo_g    false    1717    1717            �           2606    31190    muestras_pacientes_unique 
   CONSTRAINT     n   ALTER TABLE ONLY muestras_pacientes
    ADD CONSTRAINT muestras_pacientes_unique UNIQUE (id_his, id_mue_cli);
 V   ALTER TABLE ONLY public.muestras_pacientes DROP CONSTRAINT muestras_pacientes_unique;
       public         desarrollo_g    false    1717    1717    1717            �           2606    31192    municipios_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY municipios
    ADD CONSTRAINT municipios_pkey PRIMARY KEY (id_mun);
 D   ALTER TABLE ONLY public.municipios DROP CONSTRAINT municipios_pkey;
       public         desarrollo_g    false    1719    1719            �           2606    31194    pacientes_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY pacientes
    ADD CONSTRAINT pacientes_pkey PRIMARY KEY (id_pac);
 B   ALTER TABLE ONLY public.pacientes DROP CONSTRAINT pacientes_pkey;
       public         desarrollo_g    false    1721    1721            �           2606    31196    paises_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY paises
    ADD CONSTRAINT paises_pkey PRIMARY KEY (id_pai);
 <   ALTER TABLE ONLY public.paises DROP CONSTRAINT paises_pkey;
       public         desarrollo_g    false    1723    1723            �           2606    31198    parroquias_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY parroquias
    ADD CONSTRAINT parroquias_pkey PRIMARY KEY (id_par);
 D   ALTER TABLE ONLY public.parroquias DROP CONSTRAINT parroquias_pkey;
       public         desarrollo_g    false    1725    1725            �           2606    31200 '   partes_cuerpos__categorias_cuerpos_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY partes_cuerpos__categorias_cuerpos
    ADD CONSTRAINT partes_cuerpos__categorias_cuerpos_pkey PRIMARY KEY (id_par_cue_cat_cue);
 t   ALTER TABLE ONLY public.partes_cuerpos__categorias_cuerpos DROP CONSTRAINT partes_cuerpos__categorias_cuerpos_pkey;
       public         desarrollo_g    false    1728    1728            �           2606    31202 )   partes_cuerpos__categorias_cuerpos_unique 
   CONSTRAINT     �   ALTER TABLE ONLY partes_cuerpos__categorias_cuerpos
    ADD CONSTRAINT partes_cuerpos__categorias_cuerpos_unique UNIQUE (id_cat_cue, id_par_cue);
 v   ALTER TABLE ONLY public.partes_cuerpos__categorias_cuerpos DROP CONSTRAINT partes_cuerpos__categorias_cuerpos_unique;
       public         desarrollo_g    false    1728    1728    1728            �           2606    31204    partes_cuerpos_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY partes_cuerpos
    ADD CONSTRAINT partes_cuerpos_pkey PRIMARY KEY (id_par_cue);
 L   ALTER TABLE ONLY public.partes_cuerpos DROP CONSTRAINT partes_cuerpos_pkey;
       public         desarrollo_g    false    1727    1727            �           2606    31206    tiempo_evoluciones_pkey 
   CONSTRAINT     i   ALTER TABLE ONLY tiempo_evoluciones
    ADD CONSTRAINT tiempo_evoluciones_pkey PRIMARY KEY (id_tie_evo);
 T   ALTER TABLE ONLY public.tiempo_evoluciones DROP CONSTRAINT tiempo_evoluciones_pkey;
       public         desarrollo_g    false    1731    1731            �           2606    31208    tipos_consultas_pacientes_pkey 
   CONSTRAINT     {   ALTER TABLE ONLY tipos_consultas_pacientes
    ADD CONSTRAINT tipos_consultas_pacientes_pkey PRIMARY KEY (id_tip_con_pac);
 b   ALTER TABLE ONLY public.tipos_consultas_pacientes DROP CONSTRAINT tipos_consultas_pacientes_pkey;
       public         desarrollo_g    false    1735    1735            �           2606    31210     tipos_consultas_pacientes_unique 
   CONSTRAINT     |   ALTER TABLE ONLY tipos_consultas_pacientes
    ADD CONSTRAINT tipos_consultas_pacientes_unique UNIQUE (id_tip_con, id_his);
 d   ALTER TABLE ONLY public.tipos_consultas_pacientes DROP CONSTRAINT tipos_consultas_pacientes_unique;
       public         desarrollo_g    false    1735    1735    1735            �           2606    31212    tipos_consultas_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY tipos_consultas
    ADD CONSTRAINT tipos_consultas_pkey PRIMARY KEY (id_tip_con);
 N   ALTER TABLE ONLY public.tipos_consultas DROP CONSTRAINT tipos_consultas_pkey;
       public         desarrollo_g    false    1733    1733            �           2606    31214    tipos_estudios_micologicos_pkey 
   CONSTRAINT     }   ALTER TABLE ONLY tipos_estudios_micologicos
    ADD CONSTRAINT tipos_estudios_micologicos_pkey PRIMARY KEY (id_tip_est_mic);
 d   ALTER TABLE ONLY public.tipos_estudios_micologicos DROP CONSTRAINT tipos_estudios_micologicos_pkey;
       public         desarrollo_g    false    1737    1737            �           2606    31216    tipos_examenes_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY tipos_examenes
    ADD CONSTRAINT tipos_examenes_pkey PRIMARY KEY (id_tip_exa);
 L   ALTER TABLE ONLY public.tipos_examenes DROP CONSTRAINT tipos_examenes_pkey;
       public         desarrollo_g    false    1739    1739            �           2606    31218 8   tipos_micosis_pacientes__tipos_estudios_micologicos_pkey 
   CONSTRAINT     �   ALTER TABLE ONLY tipos_micosis_pacientes__tipos_estudios_micologicos
    ADD CONSTRAINT tipos_micosis_pacientes__tipos_estudios_micologicos_pkey PRIMARY KEY (id_tip_mic_pac_tip_est_mic);
 �   ALTER TABLE ONLY public.tipos_micosis_pacientes__tipos_estudios_micologicos DROP CONSTRAINT tipos_micosis_pacientes__tipos_estudios_micologicos_pkey;
       public         desarrollo_g    false    1744    1744            �           2606    31574 :   tipos_micosis_pacientes__tipos_estudios_micologicos_unique 
   CONSTRAINT     �   ALTER TABLE ONLY tipos_micosis_pacientes__tipos_estudios_micologicos
    ADD CONSTRAINT tipos_micosis_pacientes__tipos_estudios_micologicos_unique UNIQUE (id_tip_mic_pac, id_tip_est_mic);
 �   ALTER TABLE ONLY public.tipos_micosis_pacientes__tipos_estudios_micologicos DROP CONSTRAINT tipos_micosis_pacientes__tipos_estudios_micologicos_unique;
       public         desarrollo_g    false    1744    1744    1744            �           2606    31220    tipos_micosis_pacientes_pkey 
   CONSTRAINT     w   ALTER TABLE ONLY tipos_micosis_pacientes
    ADD CONSTRAINT tipos_micosis_pacientes_pkey PRIMARY KEY (id_tip_mic_pac);
 ^   ALTER TABLE ONLY public.tipos_micosis_pacientes DROP CONSTRAINT tipos_micosis_pacientes_pkey;
       public         desarrollo_g    false    1743    1743            �           2606    31222    tipos_micosis_pacientes_unique 
   CONSTRAINT     x   ALTER TABLE ONLY tipos_micosis_pacientes
    ADD CONSTRAINT tipos_micosis_pacientes_unique UNIQUE (id_tip_mic, id_his);
 `   ALTER TABLE ONLY public.tipos_micosis_pacientes DROP CONSTRAINT tipos_micosis_pacientes_unique;
       public         desarrollo_g    false    1743    1743    1743            �           2606    31224    tipos_micosis_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY tipos_micosis
    ADD CONSTRAINT tipos_micosis_pkey PRIMARY KEY (id_tip_mic);
 J   ALTER TABLE ONLY public.tipos_micosis DROP CONSTRAINT tipos_micosis_pkey;
       public         desarrollo_g    false    1741    1741            �           2606    31226    tipos_usuarios__usuarios_pkey 
   CONSTRAINT     y   ALTER TABLE ONLY tipos_usuarios__usuarios
    ADD CONSTRAINT tipos_usuarios__usuarios_pkey PRIMARY KEY (id_tip_usu_usu);
 `   ALTER TABLE ONLY public.tipos_usuarios__usuarios DROP CONSTRAINT tipos_usuarios__usuarios_pkey;
       public         desarrollo_g    false    1748    1748            �           2606    31228    tipos_usuarios_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY tipos_usuarios
    ADD CONSTRAINT tipos_usuarios_pkey PRIMARY KEY (id_tip_usu);
 L   ALTER TABLE ONLY public.tipos_usuarios DROP CONSTRAINT tipos_usuarios_pkey;
       public         desarrollo_g    false    1747    1747            �           2606    31230    tipos_usuarios_unique 
   CONSTRAINT     _   ALTER TABLE ONLY tipos_usuarios
    ADD CONSTRAINT tipos_usuarios_unique UNIQUE (cod_tip_usu);
 N   ALTER TABLE ONLY public.tipos_usuarios DROP CONSTRAINT tipos_usuarios_unique;
       public    saib    desarrollo_g    false    1747    1747            �           2606    31232 !   transacciones_cod_tip_tra__id_mod 
   CONSTRAINT     r   ALTER TABLE ONLY transacciones
    ADD CONSTRAINT transacciones_cod_tip_tra__id_mod UNIQUE (id_mod, cod_tip_tra);
 Y   ALTER TABLE ONLY public.transacciones DROP CONSTRAINT transacciones_cod_tip_tra__id_mod;
       public         desarrollo_g    false    1751    1751    1751            �           2606    31234    transacciones_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY transacciones
    ADD CONSTRAINT transacciones_pkey PRIMARY KEY (id_tip_tra);
 J   ALTER TABLE ONLY public.transacciones DROP CONSTRAINT transacciones_pkey;
       public         desarrollo_g    false    1751    1751            �           2606    31236    transacciones_usuarios_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY transacciones_usuarios
    ADD CONSTRAINT transacciones_usuarios_pkey PRIMARY KEY (id_tra_usu);
 \   ALTER TABLE ONLY public.transacciones_usuarios DROP CONSTRAINT transacciones_usuarios_pkey;
       public         desarrollo_g    false    1753    1753            �           2606    31238    tratamientos_pacientes_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY tratamientos_pacientes
    ADD CONSTRAINT tratamientos_pacientes_pkey PRIMARY KEY (id_tra_pac);
 \   ALTER TABLE ONLY public.tratamientos_pacientes DROP CONSTRAINT tratamientos_pacientes_pkey;
       public         desarrollo_g    false    1757    1757            �           2606    31240    tratamientos_pacientes_unique 
   CONSTRAINT     r   ALTER TABLE ONLY tratamientos_pacientes
    ADD CONSTRAINT tratamientos_pacientes_unique UNIQUE (id_his, id_tra);
 ^   ALTER TABLE ONLY public.tratamientos_pacientes DROP CONSTRAINT tratamientos_pacientes_unique;
       public         desarrollo_g    false    1757    1757    1757            �           2606    31242    tratamientos_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY tratamientos
    ADD CONSTRAINT tratamientos_pkey PRIMARY KEY (id_tra);
 H   ALTER TABLE ONLY public.tratamientos DROP CONSTRAINT tratamientos_pkey;
       public         desarrollo_g    false    1755    1755            �           2606    31244    unique_tipos_usuarios__usuarios 
   CONSTRAINT     �   ALTER TABLE ONLY tipos_usuarios__usuarios
    ADD CONSTRAINT unique_tipos_usuarios__usuarios UNIQUE (id_doc, id_usu_adm, id_tip_usu);
 b   ALTER TABLE ONLY public.tipos_usuarios__usuarios DROP CONSTRAINT unique_tipos_usuarios__usuarios;
       public         desarrollo_g    false    1748    1748    1748    1748            �           2606    31246 +   usuarios_administrativos_log_usu_adm_unique 
   CONSTRAINT        ALTER TABLE ONLY usuarios_administrativos
    ADD CONSTRAINT usuarios_administrativos_log_usu_adm_unique UNIQUE (log_usu_adm);
 n   ALTER TABLE ONLY public.usuarios_administrativos DROP CONSTRAINT usuarios_administrativos_log_usu_adm_unique;
       public         desarrollo_g    false    1759    1759            �           2606    31248    usuarios_administrativos_pkey 
   CONSTRAINT     u   ALTER TABLE ONLY usuarios_administrativos
    ADD CONSTRAINT usuarios_administrativos_pkey PRIMARY KEY (id_usu_adm);
 `   ALTER TABLE ONLY public.usuarios_administrativos DROP CONSTRAINT usuarios_administrativos_pkey;
       public    saib    desarrollo_g    false    1759    1759            �           2606    31250    wwwsqldesigner_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY wwwsqldesigner
    ADD CONSTRAINT wwwsqldesigner_pkey PRIMARY KEY (keyword);
 P   ALTER TABLE ONLY saib_model.wwwsqldesigner DROP CONSTRAINT wwwsqldesigner_pkey;
    
   saib_model         postgres    false    1763    1763            .           1259    31251    animales_index    INDEX     >   CREATE INDEX animales_index ON animales USING btree (id_ani);
 "   DROP INDEX public.animales_index;
       public    saib    desarrollo_g    false    1669            3           1259    31252    antecedentes_personales_index    INDEX     `   CREATE INDEX antecedentes_personales_index ON antecedentes_personales USING btree (id_ant_per);
 1   DROP INDEX public.antecedentes_personales_index;
       public    saib    desarrollo_g    false    1673            8           1259    31253 !   categorias__cuerpos_micosis_index    INDEX     l   CREATE INDEX categorias__cuerpos_micosis_index ON categorias__cuerpos_micosis USING btree (id_cat_cue_mic);
 5   DROP INDEX public.categorias__cuerpos_micosis_index;
       public    saib    desarrollo_g    false    1677            =           1259    31254    categorias_cuerpos_index    INDEX     V   CREATE INDEX categorias_cuerpos_index ON categorias_cuerpos USING btree (id_cat_cue);
 ,   DROP INDEX public.categorias_cuerpos_index;
       public    saib    desarrollo_g    false    1679            E           1259    31255    centro_salud_doctores_index    INDEX     t   CREATE INDEX centro_salud_doctores_index ON centro_salud_doctores USING btree (id_cen_sal_doc, id_doc, id_cen_sal);
 /   DROP INDEX public.centro_salud_doctores_index;
       public         desarrollo_g    false    1682    1682    1682            J           1259    31256    centro_salud_index    INDEX     K   CREATE INDEX centro_salud_index ON centro_saluds USING btree (id_cen_sal);
 &   DROP INDEX public.centro_salud_index;
       public    saib    desarrollo_g    false    1684            M           1259    31257    centro_salud_pacientes_index    INDEX     v   CREATE INDEX centro_salud_pacientes_index ON centro_salud_pacientes USING btree (id_cen_sal_pac, id_his, id_cen_sal);
 0   DROP INDEX public.centro_salud_pacientes_index;
       public    saib    desarrollo_g    false    1686    1686    1686            R           1259    31258    contactos_animales_index    INDEX     f   CREATE INDEX contactos_animales_index ON contactos_animales USING btree (id_con_ani, id_his, id_ani);
 ,   DROP INDEX public.contactos_animales_index;
       public    saib    desarrollo_g    false    1688    1688    1688            Y           1259    31259    enfermedades_micologicas_index    INDEX     b   CREATE INDEX enfermedades_micologicas_index ON enfermedades_micologicas USING btree (id_enf_mic);
 2   DROP INDEX public.enfermedades_micologicas_index;
       public    saib    desarrollo_g    false    1692            e           1259    31260 "   forma_infecciones__pacientes_index    INDEX     j   CREATE INDEX forma_infecciones__pacientes_index ON forma_infecciones__pacientes USING btree (id_for_pac);
 6   DROP INDEX public.forma_infecciones__pacientes_index;
       public    saib    desarrollo_g    false    1699            j           1259    31261 &   forma_infecciones__tipos_micosis_index    INDEX     z   CREATE INDEX forma_infecciones__tipos_micosis_index ON forma_infecciones__tipos_micosis USING btree (id_for_inf_tip_mic);
 :   DROP INDEX public.forma_infecciones__tipos_micosis_index;
       public    saib    desarrollo_g    false    1701            b           1259    31262    forma_infecciones_index    INDEX     T   CREATE INDEX forma_infecciones_index ON forma_infecciones USING btree (id_for_inf);
 +   DROP INDEX public.forma_infecciones_index;
       public    saib    desarrollo_g    false    1698            o           1259    31263    historiales_pacientes_index    INDEX     X   CREATE INDEX historiales_pacientes_index ON historiales_pacientes USING btree (id_his);
 /   DROP INDEX public.historiales_pacientes_index;
       public    saib    desarrollo_g    false    1704            B           1259    31264    lesiones__partes_cuerpos_index    INDEX     j   CREATE INDEX lesiones__partes_cuerpos_index ON categorias_cuerpos__lesiones USING btree (id_cat_cue_les);
 2   DROP INDEX public.lesiones__partes_cuerpos_index;
       public    saib    desarrollo_g    false    1680            t           1259    31265 (   lesiones_partes_cuerpos__pacientes_index    INDEX     ~   CREATE INDEX lesiones_partes_cuerpos__pacientes_index ON lesiones_partes_cuerpos__pacientes USING btree (id_les_par_cue_pac);
 <   DROP INDEX public.lesiones_partes_cuerpos__pacientes_index;
       public    saib    desarrollo_g    false    1709            y           1259    31266    localizaciones_cuerpos_index    INDEX     ^   CREATE INDEX localizaciones_cuerpos_index ON localizaciones_cuerpos USING btree (id_loc_cue);
 0   DROP INDEX public.localizaciones_cuerpos_index;
       public    saib    desarrollo_g    false    1711            �           1259    31267    muestras_clinicas_index    INDEX     T   CREATE INDEX muestras_clinicas_index ON muestras_clinicas USING btree (id_mue_cli);
 +   DROP INDEX public.muestras_clinicas_index;
       public    saib    desarrollo_g    false    1715            �           1259    31268    pacientes_index    INDEX     @   CREATE INDEX pacientes_index ON pacientes USING btree (id_pac);
 #   DROP INDEX public.pacientes_index;
       public    saib    desarrollo_g    false    1721            �           1259    31269    partes_cuerpos_index    INDEX     N   CREATE INDEX partes_cuerpos_index ON partes_cuerpos USING btree (id_par_cue);
 (   DROP INDEX public.partes_cuerpos_index;
       public    saib    desarrollo_g    false    1727            �           1259    31270    tipos_consultas_index    INDEX     P   CREATE INDEX tipos_consultas_index ON tipos_consultas USING btree (id_tip_con);
 )   DROP INDEX public.tipos_consultas_index;
       public    saib    desarrollo_g    false    1733            �           1259    31271    tipos_consultas_pacientes_index    INDEX     |   CREATE INDEX tipos_consultas_pacientes_index ON tipos_consultas_pacientes USING btree (id_tip_con_pac, id_tip_con, id_his);
 3   DROP INDEX public.tipos_consultas_pacientes_index;
       public    saib    desarrollo_g    false    1735    1735    1735            �           1259    31272     tipos_estudios_micologicos_index    INDEX     j   CREATE INDEX tipos_estudios_micologicos_index ON tipos_estudios_micologicos USING btree (id_tip_est_mic);
 4   DROP INDEX public.tipos_estudios_micologicos_index;
       public    saib    desarrollo_g    false    1737            �           1259    31273    tipos_micosis_index    INDEX     L   CREATE INDEX tipos_micosis_index ON tipos_micosis USING btree (id_tip_mic);
 '   DROP INDEX public.tipos_micosis_index;
       public    saib    desarrollo_g    false    1741            �           1259    31274    tratamientos_index    INDEX     F   CREATE INDEX tratamientos_index ON tratamientos USING btree (id_tra);
 &   DROP INDEX public.tratamientos_index;
       public    saib    desarrollo_g    false    1755            �           1259    31275    tratamientos_pacientes_index    INDEX     n   CREATE INDEX tratamientos_pacientes_index ON tratamientos_pacientes USING btree (id_tra_pac, id_his, id_tra);
 0   DROP INDEX public.tratamientos_pacientes_index;
       public    saib    desarrollo_g    false    1757    1757    1757            �           2606    31276 &   antecedentes_pacientes_id_ant_per_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY antecedentes_pacientes
    ADD CONSTRAINT antecedentes_pacientes_id_ant_per_fkey FOREIGN KEY (id_ant_per) REFERENCES antecedentes_personales(id_ant_per) ON UPDATE CASCADE ON DELETE CASCADE;
 g   ALTER TABLE ONLY public.antecedentes_pacientes DROP CONSTRAINT antecedentes_pacientes_id_ant_per_fkey;
       public       desarrollo_g    false    1673    1671    2100            �           2606    31281 "   antecedentes_pacientes_id_pac_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY antecedentes_pacientes
    ADD CONSTRAINT antecedentes_pacientes_id_pac_fkey FOREIGN KEY (id_pac) REFERENCES pacientes(id_pac) ON UPDATE CASCADE ON DELETE CASCADE;
 c   ALTER TABLE ONLY public.antecedentes_pacientes DROP CONSTRAINT antecedentes_pacientes_id_pac_fkey;
       public       desarrollo_g    false    1721    1671    2186            �           2606    31286 '   auditoria_transacciones_id_tip_tra_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY auditoria_transacciones
    ADD CONSTRAINT auditoria_transacciones_id_tip_tra_fkey FOREIGN KEY (id_tip_tra) REFERENCES transacciones(id_tip_tra) ON UPDATE CASCADE;
 i   ALTER TABLE ONLY public.auditoria_transacciones DROP CONSTRAINT auditoria_transacciones_id_tip_tra_fkey;
       public       desarrollo_g    false    2235    1675    1751            �           2606    31291 +   auditoria_transacciones_id_tip_usu_usu_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY auditoria_transacciones
    ADD CONSTRAINT auditoria_transacciones_id_tip_usu_usu_fkey FOREIGN KEY (id_tip_usu_usu) REFERENCES tipos_usuarios__usuarios(id_tip_usu_usu) ON UPDATE CASCADE;
 m   ALTER TABLE ONLY public.auditoria_transacciones DROP CONSTRAINT auditoria_transacciones_id_tip_usu_usu_fkey;
       public       desarrollo_g    false    2229    1675    1748            �           2606    31296 1   categoria_cuerpos__partes_cuerpos_id_cat_cue_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY categorias_cuerpos__lesiones
    ADD CONSTRAINT categoria_cuerpos__partes_cuerpos_id_cat_cue_fkey FOREIGN KEY (id_cat_cue) REFERENCES categorias_cuerpos(id_cat_cue) ON UPDATE CASCADE ON DELETE CASCADE;
 x   ALTER TABLE ONLY public.categorias_cuerpos__lesiones DROP CONSTRAINT categoria_cuerpos__partes_cuerpos_id_cat_cue_fkey;
       public       desarrollo_g    false    2110    1679    1680            �           2606    31301 +   categorias__cuerpos_micosis_id_cat_cue_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY categorias__cuerpos_micosis
    ADD CONSTRAINT categorias__cuerpos_micosis_id_cat_cue_fkey FOREIGN KEY (id_cat_cue) REFERENCES categorias_cuerpos(id_cat_cue) ON UPDATE CASCADE ON DELETE CASCADE;
 q   ALTER TABLE ONLY public.categorias__cuerpos_micosis DROP CONSTRAINT categorias__cuerpos_micosis_id_cat_cue_fkey;
       public       desarrollo_g    false    1677    1679    2110            �           2606    31306 +   categorias__cuerpos_micosis_id_tip_mic_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY categorias__cuerpos_micosis
    ADD CONSTRAINT categorias__cuerpos_micosis_id_tip_mic_fkey FOREIGN KEY (id_tip_mic) REFERENCES tipos_micosis(id_tip_mic) ON UPDATE CASCADE ON DELETE CASCADE;
 q   ALTER TABLE ONLY public.categorias__cuerpos_micosis DROP CONSTRAINT categorias__cuerpos_micosis_id_tip_mic_fkey;
       public       desarrollo_g    false    2215    1741    1677            �           2606    31311 %   centro_salud_doctores_id_cen_sal_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY centro_salud_doctores
    ADD CONSTRAINT centro_salud_doctores_id_cen_sal_fkey FOREIGN KEY (id_cen_sal) REFERENCES centro_saluds(id_cen_sal) ON UPDATE CASCADE ON DELETE CASCADE;
 e   ALTER TABLE ONLY public.centro_salud_doctores DROP CONSTRAINT centro_salud_doctores_id_cen_sal_fkey;
       public       desarrollo_g    false    2123    1684    1682            �           2606    31316 !   centro_salud_doctores_id_doc_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY centro_salud_doctores
    ADD CONSTRAINT centro_salud_doctores_id_doc_fkey FOREIGN KEY (id_doc) REFERENCES doctores(id_doc) ON UPDATE CASCADE ON DELETE CASCADE;
 a   ALTER TABLE ONLY public.centro_salud_doctores DROP CONSTRAINT centro_salud_doctores_id_doc_fkey;
       public       desarrollo_g    false    1682    2135    1690            �           2606    31321 &   centro_salud_pacientes_id_cen_sal_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY centro_salud_pacientes
    ADD CONSTRAINT centro_salud_pacientes_id_cen_sal_fkey FOREIGN KEY (id_cen_sal) REFERENCES centro_saluds(id_cen_sal) ON UPDATE CASCADE ON DELETE CASCADE;
 g   ALTER TABLE ONLY public.centro_salud_pacientes DROP CONSTRAINT centro_salud_pacientes_id_cen_sal_fkey;
       public       desarrollo_g    false    1686    2123    1684            �           2606    31326 "   centro_salud_pacientes_id_his_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY centro_salud_pacientes
    ADD CONSTRAINT centro_salud_pacientes_id_his_fkey FOREIGN KEY (id_his) REFERENCES historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;
 c   ALTER TABLE ONLY public.centro_salud_pacientes DROP CONSTRAINT centro_salud_pacientes_id_his_fkey;
       public       desarrollo_g    false    1686    2160    1704            �           2606    31331    contactos_animales_id_ani_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY contactos_animales
    ADD CONSTRAINT contactos_animales_id_ani_fkey FOREIGN KEY (id_ani) REFERENCES animales(id_ani) ON UPDATE CASCADE ON DELETE CASCADE;
 [   ALTER TABLE ONLY public.contactos_animales DROP CONSTRAINT contactos_animales_id_ani_fkey;
       public       desarrollo_g    false    1688    2095    1669            �           2606    31336    contactos_animales_id_his_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY contactos_animales
    ADD CONSTRAINT contactos_animales_id_his_fkey FOREIGN KEY (id_his) REFERENCES historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;
 [   ALTER TABLE ONLY public.contactos_animales DROP CONSTRAINT contactos_animales_id_his_fkey;
       public       desarrollo_g    false    1688    2160    1704            �           2606    31341 (   enfermedades_micologicas_id_tip_mic_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY enfermedades_micologicas
    ADD CONSTRAINT enfermedades_micologicas_id_tip_mic_fkey FOREIGN KEY (id_tip_mic) REFERENCES tipos_micosis(id_tip_mic) ON UPDATE CASCADE ON DELETE CASCADE;
 k   ALTER TABLE ONLY public.enfermedades_micologicas DROP CONSTRAINT enfermedades_micologicas_id_tip_mic_fkey;
       public       desarrollo_g    false    1692    2215    1741            �           2606    31346 &   enfermedades_pacientes_id_enf_mic_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY enfermedades_pacientes
    ADD CONSTRAINT enfermedades_pacientes_id_enf_mic_fkey FOREIGN KEY (id_enf_mic) REFERENCES enfermedades_micologicas(id_enf_mic) ON UPDATE CASCADE ON DELETE CASCADE;
 g   ALTER TABLE ONLY public.enfermedades_pacientes DROP CONSTRAINT enfermedades_pacientes_id_enf_mic_fkey;
       public       desarrollo_g    false    2138    1692    1694            �           2606    31351 *   enfermedades_pacientes_id_tip_enf_pac_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY enfermedades_pacientes
    ADD CONSTRAINT enfermedades_pacientes_id_tip_enf_pac_fkey FOREIGN KEY (id_tip_mic_pac) REFERENCES tipos_micosis_pacientes(id_tip_mic_pac) ON UPDATE CASCADE ON DELETE CASCADE;
 k   ALTER TABLE ONLY public.enfermedades_pacientes DROP CONSTRAINT enfermedades_pacientes_id_tip_enf_pac_fkey;
       public       desarrollo_g    false    1694    2217    1743            �           2606    31356    estados_id_pai_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY estados
    ADD CONSTRAINT estados_id_pai_fkey FOREIGN KEY (id_pai) REFERENCES paises(id_pai) ON UPDATE CASCADE ON DELETE CASCADE;
 E   ALTER TABLE ONLY public.estados DROP CONSTRAINT estados_id_pai_fkey;
       public       desarrollo_g    false    1723    2188    1696            �           2606    31361 ,   forma_infecciones__pacientes_id_for_inf_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY forma_infecciones__pacientes
    ADD CONSTRAINT forma_infecciones__pacientes_id_for_inf_fkey FOREIGN KEY (id_for_inf) REFERENCES forma_infecciones(id_for_inf) ON UPDATE CASCADE ON DELETE CASCADE;
 s   ALTER TABLE ONLY public.forma_infecciones__pacientes DROP CONSTRAINT forma_infecciones__pacientes_id_for_inf_fkey;
       public       desarrollo_g    false    1698    2147    1699            �           2606    31366 0   forma_infecciones__pacientes_id_tip_mic_pac_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY forma_infecciones__pacientes
    ADD CONSTRAINT forma_infecciones__pacientes_id_tip_mic_pac_fkey FOREIGN KEY (id_tip_mic_pac) REFERENCES tipos_micosis_pacientes(id_tip_mic_pac) ON UPDATE CASCADE ON DELETE CASCADE;
 w   ALTER TABLE ONLY public.forma_infecciones__pacientes DROP CONSTRAINT forma_infecciones__pacientes_id_tip_mic_pac_fkey;
       public       desarrollo_g    false    1743    2217    1699            �           2606    31371 0   forma_infecciones__tipos_micosis_id_for_inf_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY forma_infecciones__tipos_micosis
    ADD CONSTRAINT forma_infecciones__tipos_micosis_id_for_inf_fkey FOREIGN KEY (id_for_inf) REFERENCES forma_infecciones(id_for_inf) ON UPDATE CASCADE ON DELETE CASCADE;
 {   ALTER TABLE ONLY public.forma_infecciones__tipos_micosis DROP CONSTRAINT forma_infecciones__tipos_micosis_id_for_inf_fkey;
       public       desarrollo_g    false    1701    2147    1698            �           2606    31376 0   forma_infecciones__tipos_micosis_id_tip_mic_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY forma_infecciones__tipos_micosis
    ADD CONSTRAINT forma_infecciones__tipos_micosis_id_tip_mic_fkey FOREIGN KEY (id_tip_mic) REFERENCES tipos_micosis(id_tip_mic) ON UPDATE CASCADE ON DELETE CASCADE;
 {   ALTER TABLE ONLY public.forma_infecciones__tipos_micosis DROP CONSTRAINT forma_infecciones__tipos_micosis_id_tip_mic_fkey;
       public       desarrollo_g    false    1741    2215    1701            �           2606    31381 !   historiales_pacientes_id_doc_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY historiales_pacientes
    ADD CONSTRAINT historiales_pacientes_id_doc_fkey FOREIGN KEY (id_doc) REFERENCES doctores(id_doc) ON UPDATE CASCADE ON DELETE RESTRICT;
 a   ALTER TABLE ONLY public.historiales_pacientes DROP CONSTRAINT historiales_pacientes_id_doc_fkey;
       public       desarrollo_g    false    1704    2135    1690            �           2606    31386 !   historiales_pacientes_id_pac_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY historiales_pacientes
    ADD CONSTRAINT historiales_pacientes_id_pac_fkey FOREIGN KEY (id_pac) REFERENCES pacientes(id_pac) ON UPDATE CASCADE ON DELETE CASCADE;
 a   ALTER TABLE ONLY public.historiales_pacientes DROP CONSTRAINT historiales_pacientes_id_pac_fkey;
       public       desarrollo_g    false    1721    1704    2186            �           2606    31391 $   lesiones__partes_cuerpos_id_les_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY categorias_cuerpos__lesiones
    ADD CONSTRAINT lesiones__partes_cuerpos_id_les_fkey FOREIGN KEY (id_les) REFERENCES lesiones(id_les) ON UPDATE CASCADE ON DELETE CASCADE;
 k   ALTER TABLE ONLY public.categorias_cuerpos__lesiones DROP CONSTRAINT lesiones__partes_cuerpos_id_les_fkey;
       public       desarrollo_g    false    1680    1706    2162            �           2606    31396 6   lesiones_partes_cuerpos__pacientes_id_cat_cue_les_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY lesiones_partes_cuerpos__pacientes
    ADD CONSTRAINT lesiones_partes_cuerpos__pacientes_id_cat_cue_les_fkey FOREIGN KEY (id_cat_cue_les) REFERENCES categorias_cuerpos__lesiones(id_cat_cue_les) ON UPDATE CASCADE ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.lesiones_partes_cuerpos__pacientes DROP CONSTRAINT lesiones_partes_cuerpos__pacientes_id_cat_cue_les_fkey;
       public       desarrollo_g    false    1680    1709    2115            �           2606    31401 :   lesiones_partes_cuerpos__pacientes_id_par_cue_cat_cue_fkey    FK CONSTRAINT     
  ALTER TABLE ONLY lesiones_partes_cuerpos__pacientes
    ADD CONSTRAINT lesiones_partes_cuerpos__pacientes_id_par_cue_cat_cue_fkey FOREIGN KEY (id_par_cue_cat_cue) REFERENCES partes_cuerpos__categorias_cuerpos(id_par_cue_cat_cue) ON UPDATE CASCADE ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.lesiones_partes_cuerpos__pacientes DROP CONSTRAINT lesiones_partes_cuerpos__pacientes_id_par_cue_cat_cue_fkey;
       public       desarrollo_g    false    2195    1728    1709            �           2606    31406 6   lesiones_partes_cuerpos__pacientes_id_tip_mic_pac_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY lesiones_partes_cuerpos__pacientes
    ADD CONSTRAINT lesiones_partes_cuerpos__pacientes_id_tip_mic_pac_fkey FOREIGN KEY (id_tip_mic_pac) REFERENCES tipos_micosis_pacientes(id_tip_mic_pac) ON UPDATE CASCADE ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.lesiones_partes_cuerpos__pacientes DROP CONSTRAINT lesiones_partes_cuerpos__pacientes_id_tip_mic_pac_fkey;
       public       desarrollo_g    false    1709    2217    1743            �           2606    31411 &   localizaciones_cuerpos_id_par_cue_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY localizaciones_cuerpos
    ADD CONSTRAINT localizaciones_cuerpos_id_par_cue_fkey FOREIGN KEY (id_par_cue) REFERENCES partes_cuerpos(id_par_cue) ON UPDATE CASCADE ON DELETE CASCADE;
 g   ALTER TABLE ONLY public.localizaciones_cuerpos DROP CONSTRAINT localizaciones_cuerpos_id_par_cue_fkey;
       public       desarrollo_g    false    1727    1711    2193            �           2606    31416    modulos_id_tip_usu_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY modulos
    ADD CONSTRAINT modulos_id_tip_usu_fkey FOREIGN KEY (id_tip_usu) REFERENCES tipos_usuarios(id_tip_usu) ON UPDATE CASCADE ON DELETE RESTRICT;
 I   ALTER TABLE ONLY public.modulos DROP CONSTRAINT modulos_id_tip_usu_fkey;
       public       desarrollo_g    false    1747    2225    1713            �           2606    31421    muestras_pacientes_id_his_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY muestras_pacientes
    ADD CONSTRAINT muestras_pacientes_id_his_fkey FOREIGN KEY (id_his) REFERENCES historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;
 [   ALTER TABLE ONLY public.muestras_pacientes DROP CONSTRAINT muestras_pacientes_id_his_fkey;
       public       desarrollo_g    false    1717    2160    1704            �           2606    31426 "   muestras_pacientes_id_mue_cli_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY muestras_pacientes
    ADD CONSTRAINT muestras_pacientes_id_mue_cli_fkey FOREIGN KEY (id_mue_cli) REFERENCES muestras_clinicas(id_mue_cli) ON UPDATE CASCADE ON DELETE CASCADE;
 _   ALTER TABLE ONLY public.muestras_pacientes DROP CONSTRAINT muestras_pacientes_id_mue_cli_fkey;
       public       desarrollo_g    false    2177    1717    1715            �           2606    31431    municipios_id_est_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY municipios
    ADD CONSTRAINT municipios_id_est_fkey FOREIGN KEY (id_est) REFERENCES estados(id_est) ON UPDATE CASCADE ON DELETE CASCADE;
 K   ALTER TABLE ONLY public.municipios DROP CONSTRAINT municipios_id_est_fkey;
       public       desarrollo_g    false    2144    1696    1719            �           2606    31436    pacientes_id_doc_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY pacientes
    ADD CONSTRAINT pacientes_id_doc_fkey FOREIGN KEY (id_doc) REFERENCES doctores(id_doc) ON UPDATE CASCADE ON DELETE RESTRICT;
 I   ALTER TABLE ONLY public.pacientes DROP CONSTRAINT pacientes_id_doc_fkey;
       public       desarrollo_g    false    1721    1690    2135            �           2606    31441    pacientes_id_est_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY pacientes
    ADD CONSTRAINT pacientes_id_est_fkey FOREIGN KEY (id_est) REFERENCES estados(id_est) ON UPDATE CASCADE ON DELETE RESTRICT;
 I   ALTER TABLE ONLY public.pacientes DROP CONSTRAINT pacientes_id_est_fkey;
       public       desarrollo_g    false    1696    2144    1721            �           2606    31446    pacientes_id_mun_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY pacientes
    ADD CONSTRAINT pacientes_id_mun_fkey FOREIGN KEY (id_mun) REFERENCES municipios(id_mun) ON UPDATE CASCADE ON DELETE RESTRICT;
 I   ALTER TABLE ONLY public.pacientes DROP CONSTRAINT pacientes_id_mun_fkey;
       public       desarrollo_g    false    1719    1721    2183            �           2606    31451    pacientes_id_pai_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY pacientes
    ADD CONSTRAINT pacientes_id_pai_fkey FOREIGN KEY (id_pai) REFERENCES paises(id_pai) ON UPDATE CASCADE ON DELETE RESTRICT;
 I   ALTER TABLE ONLY public.pacientes DROP CONSTRAINT pacientes_id_pai_fkey;
       public       desarrollo_g    false    2188    1723    1721            �           2606    31456    pacientes_id_par_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY pacientes
    ADD CONSTRAINT pacientes_id_par_fkey FOREIGN KEY (id_par) REFERENCES parroquias(id_par) ON UPDATE CASCADE ON DELETE RESTRICT;
 I   ALTER TABLE ONLY public.pacientes DROP CONSTRAINT pacientes_id_par_fkey;
       public       desarrollo_g    false    2190    1721    1725            �           2606    31461    parroquias_id_mun_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY parroquias
    ADD CONSTRAINT parroquias_id_mun_fkey FOREIGN KEY (id_mun) REFERENCES municipios(id_mun) ON UPDATE CASCADE ON DELETE CASCADE;
 K   ALTER TABLE ONLY public.parroquias DROP CONSTRAINT parroquias_id_mun_fkey;
       public       desarrollo_g    false    2183    1725    1719            �           2606    31466 2   partes_cuerpos__categorias_cuerpos_id_cat_cue_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY partes_cuerpos__categorias_cuerpos
    ADD CONSTRAINT partes_cuerpos__categorias_cuerpos_id_cat_cue_fkey FOREIGN KEY (id_cat_cue) REFERENCES categorias_cuerpos(id_cat_cue) ON UPDATE CASCADE ON DELETE CASCADE;
    ALTER TABLE ONLY public.partes_cuerpos__categorias_cuerpos DROP CONSTRAINT partes_cuerpos__categorias_cuerpos_id_cat_cue_fkey;
       public       desarrollo_g    false    1679    1728    2110            �           2606    31471 2   partes_cuerpos__categorias_cuerpos_id_par_cue_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY partes_cuerpos__categorias_cuerpos
    ADD CONSTRAINT partes_cuerpos__categorias_cuerpos_id_par_cue_fkey FOREIGN KEY (id_par_cue) REFERENCES partes_cuerpos(id_par_cue) ON UPDATE CASCADE ON DELETE CASCADE;
    ALTER TABLE ONLY public.partes_cuerpos__categorias_cuerpos DROP CONSTRAINT partes_cuerpos__categorias_cuerpos_id_par_cue_fkey;
       public       desarrollo_g    false    2193    1728    1727            �           2606    31476    tiempo_evoluciones_id_his_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY tiempo_evoluciones
    ADD CONSTRAINT tiempo_evoluciones_id_his_fkey FOREIGN KEY (id_his) REFERENCES historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;
 [   ALTER TABLE ONLY public.tiempo_evoluciones DROP CONSTRAINT tiempo_evoluciones_id_his_fkey;
       public       desarrollo_g    false    1704    1731    2160            �           2606    31481 %   tipos_consultas_pacientes_id_his_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY tipos_consultas_pacientes
    ADD CONSTRAINT tipos_consultas_pacientes_id_his_fkey FOREIGN KEY (id_his) REFERENCES historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;
 i   ALTER TABLE ONLY public.tipos_consultas_pacientes DROP CONSTRAINT tipos_consultas_pacientes_id_his_fkey;
       public       desarrollo_g    false    1704    2160    1735            �           2606    31486 )   tipos_consultas_pacientes_id_tip_con_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY tipos_consultas_pacientes
    ADD CONSTRAINT tipos_consultas_pacientes_id_tip_con_fkey FOREIGN KEY (id_tip_con) REFERENCES tipos_consultas(id_tip_con) ON UPDATE CASCADE ON DELETE CASCADE;
 m   ALTER TABLE ONLY public.tipos_consultas_pacientes DROP CONSTRAINT tipos_consultas_pacientes_id_tip_con_fkey;
       public       desarrollo_g    false    1733    1735    2202            �           2606    31491 *   tipos_estudios_micologicos_id_tip_exa_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY tipos_estudios_micologicos
    ADD CONSTRAINT tipos_estudios_micologicos_id_tip_exa_fkey FOREIGN KEY (id_tip_exa) REFERENCES tipos_examenes(id_tip_exa) ON UPDATE CASCADE ON DELETE CASCADE;
 o   ALTER TABLE ONLY public.tipos_estudios_micologicos DROP CONSTRAINT tipos_estudios_micologicos_id_tip_exa_fkey;
       public       desarrollo_g    false    1739    2212    1737            �           2606    31496 *   tipos_estudios_micologicos_id_tip_mic_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY tipos_estudios_micologicos
    ADD CONSTRAINT tipos_estudios_micologicos_id_tip_mic_fkey FOREIGN KEY (id_tip_mic) REFERENCES tipos_micosis(id_tip_mic) ON UPDATE CASCADE ON DELETE CASCADE;
 o   ALTER TABLE ONLY public.tipos_estudios_micologicos DROP CONSTRAINT tipos_estudios_micologicos_id_tip_mic_fkey;
       public       desarrollo_g    false    2215    1737    1741            �           2606    31501 ?   tipos_micosis_pacientes__tipos_estudios_mic_id_tip_est_mic_fkey    FK CONSTRAINT       ALTER TABLE ONLY tipos_micosis_pacientes__tipos_estudios_micologicos
    ADD CONSTRAINT tipos_micosis_pacientes__tipos_estudios_mic_id_tip_est_mic_fkey FOREIGN KEY (id_tip_est_mic) REFERENCES tipos_estudios_micologicos(id_tip_est_mic) ON UPDATE CASCADE ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.tipos_micosis_pacientes__tipos_estudios_micologicos DROP CONSTRAINT tipos_micosis_pacientes__tipos_estudios_mic_id_tip_est_mic_fkey;
       public       desarrollo_g    false    1744    2210    1737            �           2606    31506 ?   tipos_micosis_pacientes__tipos_estudios_mic_id_tip_mic_pac_fkey    FK CONSTRAINT       ALTER TABLE ONLY tipos_micosis_pacientes__tipos_estudios_micologicos
    ADD CONSTRAINT tipos_micosis_pacientes__tipos_estudios_mic_id_tip_mic_pac_fkey FOREIGN KEY (id_tip_mic_pac) REFERENCES tipos_micosis_pacientes(id_tip_mic_pac) ON UPDATE CASCADE ON DELETE CASCADE;
 �   ALTER TABLE ONLY public.tipos_micosis_pacientes__tipos_estudios_micologicos DROP CONSTRAINT tipos_micosis_pacientes__tipos_estudios_mic_id_tip_mic_pac_fkey;
       public       desarrollo_g    false    1744    2217    1743            �           2606    31511 #   tipos_micosis_pacientes_id_his_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY tipos_micosis_pacientes
    ADD CONSTRAINT tipos_micosis_pacientes_id_his_fkey FOREIGN KEY (id_his) REFERENCES historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;
 e   ALTER TABLE ONLY public.tipos_micosis_pacientes DROP CONSTRAINT tipos_micosis_pacientes_id_his_fkey;
       public       desarrollo_g    false    1743    2160    1704            �           2606    31516 '   tipos_micosis_pacientes_id_tip_mic_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY tipos_micosis_pacientes
    ADD CONSTRAINT tipos_micosis_pacientes_id_tip_mic_fkey FOREIGN KEY (id_tip_mic) REFERENCES tipos_micosis(id_tip_mic) ON UPDATE CASCADE ON DELETE CASCADE;
 i   ALTER TABLE ONLY public.tipos_micosis_pacientes DROP CONSTRAINT tipos_micosis_pacientes_id_tip_mic_fkey;
       public       desarrollo_g    false    1743    2215    1741            �           2606    31521 $   tipos_usuarios__usuarios_id_doc_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY tipos_usuarios__usuarios
    ADD CONSTRAINT tipos_usuarios__usuarios_id_doc_fkey FOREIGN KEY (id_doc) REFERENCES doctores(id_doc) ON UPDATE CASCADE ON DELETE CASCADE;
 g   ALTER TABLE ONLY public.tipos_usuarios__usuarios DROP CONSTRAINT tipos_usuarios__usuarios_id_doc_fkey;
       public       desarrollo_g    false    1748    2135    1690            �           2606    31526 (   tipos_usuarios__usuarios_id_tip_usu_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY tipos_usuarios__usuarios
    ADD CONSTRAINT tipos_usuarios__usuarios_id_tip_usu_fkey FOREIGN KEY (id_tip_usu) REFERENCES tipos_usuarios(id_tip_usu) ON UPDATE CASCADE ON DELETE RESTRICT;
 k   ALTER TABLE ONLY public.tipos_usuarios__usuarios DROP CONSTRAINT tipos_usuarios__usuarios_id_tip_usu_fkey;
       public       desarrollo_g    false    2225    1747    1748             	           2606    31531 (   tipos_usuarios__usuarios_id_usu_adm_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY tipos_usuarios__usuarios
    ADD CONSTRAINT tipos_usuarios__usuarios_id_usu_adm_fkey FOREIGN KEY (id_usu_adm) REFERENCES usuarios_administrativos(id_usu_adm) ON UPDATE CASCADE ON DELETE CASCADE;
 k   ALTER TABLE ONLY public.tipos_usuarios__usuarios DROP CONSTRAINT tipos_usuarios__usuarios_id_usu_adm_fkey;
       public       desarrollo_g    false    1759    2249    1748            	           2606    31536    transacciones_id_mod_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY transacciones
    ADD CONSTRAINT transacciones_id_mod_fkey FOREIGN KEY (id_mod) REFERENCES modulos(id_mod) ON UPDATE CASCADE ON DELETE RESTRICT;
 Q   ALTER TABLE ONLY public.transacciones DROP CONSTRAINT transacciones_id_mod_fkey;
       public       desarrollo_g    false    1713    2174    1751            	           2606    31541 &   transacciones_usuarios_id_tip_tra_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY transacciones_usuarios
    ADD CONSTRAINT transacciones_usuarios_id_tip_tra_fkey FOREIGN KEY (id_tip_tra) REFERENCES transacciones(id_tip_tra) ON UPDATE CASCADE ON DELETE RESTRICT;
 g   ALTER TABLE ONLY public.transacciones_usuarios DROP CONSTRAINT transacciones_usuarios_id_tip_tra_fkey;
       public       desarrollo_g    false    1751    2235    1753            	           2606    31546 *   transacciones_usuarios_id_tip_usu_usu_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY transacciones_usuarios
    ADD CONSTRAINT transacciones_usuarios_id_tip_usu_usu_fkey FOREIGN KEY (id_tip_usu_usu) REFERENCES tipos_usuarios__usuarios(id_tip_usu_usu) ON UPDATE CASCADE ON DELETE CASCADE;
 k   ALTER TABLE ONLY public.transacciones_usuarios DROP CONSTRAINT transacciones_usuarios_id_tip_usu_usu_fkey;
       public       desarrollo_g    false    1748    2229    1753            	           2606    31551 "   tratamientos_pacientes_id_his_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY tratamientos_pacientes
    ADD CONSTRAINT tratamientos_pacientes_id_his_fkey FOREIGN KEY (id_his) REFERENCES historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;
 c   ALTER TABLE ONLY public.tratamientos_pacientes DROP CONSTRAINT tratamientos_pacientes_id_his_fkey;
       public       desarrollo_g    false    1704    2160    1757            	           2606    31556 "   tratamientos_pacientes_id_tra_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY tratamientos_pacientes
    ADD CONSTRAINT tratamientos_pacientes_id_tra_fkey FOREIGN KEY (id_tra) REFERENCES tratamientos(id_tra) ON UPDATE CASCADE ON DELETE CASCADE;
 c   ALTER TABLE ONLY public.tratamientos_pacientes DROP CONSTRAINT tratamientos_pacientes_id_tra_fkey;
       public       desarrollo_g    false    2240    1757    1755            	   @   x�3�H-*��2�tO,��2�t,K-�2�t���M�I-VHIUp�/*J��2��/)�/����� ���      	   ;   x���  ��]1�����^�lV*�mr���S���"��T�	���y
      	   �   x��;�@ �z��@]�[ �
?�� 2�;K��x`���k����a�f�v��@�P2u:h��:��{cq�8������R�'�C1����b�X'���+�F��줅	�p�vQ����!�j����ˢR�h;=�3%ɠ��	�ڴx|,�/C;�      		   �  x��]ݎ۶���B���"���-�l�$@�,�� ��k+� Yr%;H�F��Ua_�Cɿ�dɶ�K���פ��p�}�!�"O�Aȹ�SG#�G,�8����	1�\��mj_�$�藧D7�j�XDƑ����~���ˋa<>}чZ��v��h짗����_�b,�B�E��.����<����(�����_��x"�˫A�H\<��}!�gI'K%�o.�e��"�F~�x!���o1(�9/�y}�c0	�B"�-�P�Jd.�H����[��Pjg���8��U��JaMo�a�1X����ǡ���+�5�?����Oqk��]0���F�v�E�CyI#���-��0�B��)��rʛX-�i�]2*�����~��t�TT#�F���4?��2c\.����岁?�q�AIb��H/�R�ț	<b0
���8�=���x��i>���T�n��{}9�������5��2�,`����ݎ ���(A���z��r�i'�Lc�O�` U����(i ���HH�=����/+��Y5��9Dp��!�eX��@KѬ���XP�ۚ#~��U��k�_��VXh6
�ϓRpښ���%l%�9-<��~�r�4�j��&m��� �)��9�A���rn�6x&�`��\9��9���Y��F{l>ш�C�=�0��`5���Oq2�I�V̴V9��xߦ"�6́�Z*5�^V]�w`c�ib�I"B�l��?�;�h��?"�^2A�k��:�� D�!O�����"��7�q0���~��p,6�YS��zV�M5̄�W�O��#D��s�t�������M�*Wk��V�׼��z�5��h���U�K��������vY�kj��܁�h�K��kp��?��s+K�I?N��G�K����I&��!�z:%~'�? c���Ї����?����?G�'��pJh�>���_c��N�}���VV0�(sD63j��x΢�H�F�g���T���MY4�?˅�Hn�_~��O�ޫ���ޥ<�p\=�l�4�%��d�zf�<\��:u���e�Z7n�:hh�={�<LCwL���q�#� �fd;��m�~w︳���q"��I��z�(^ѵu�C��̊/`K}㪫5�Ե�+2��9̝�c΂2-���G��a'$bT���l��*S�6�0¹Ψ�
�R�mn�֑.2�QwE����\���ںJ�g��٭�	))w�����x��M�s�s���Վ���˦�,���p���2p'��
{+�h�B�̣f�5�"E#E#E����Ŷ�F�F�VG9"l�Nؔ�..�����U�{$�5242�.���d��R4R4R��H��`���Z�)�b��LC��i�^�u�\��$��i���;����\ޱ5.�r�ֻ;?��
/w��v^��/H�@h�^�E�"��"��-��"���Eud���Y�\5�ʋ���w(A�X�I˄��9M 8¤�#�O>�T�dw	��lQ�3���š���q��p��Z�K�>�>�>�Q�Fd%w�(nn�斺[%ʌnnngzV��Nb���"7S�pubp�f�f�fe�^�1@nFn�r��i�M�)�X�A<n�.Ǜ�1�"�+��>\�3���������t���>N�>̢}P�0�f���iֺ}P:?��q��a��su����0��!$uʌ��T��t�>�,�T�]�ŕv!9E�v=b��b&��xl�Ʉ�L
e2�_&
M��m)��:4LŴ��ӖZ]M-�[`��$���3lGv)}u{�3E��W��#�ʹO����Dt+T��O�I0�m <,h��T���n��'�8����*�+4�8|J�����R_M����y䦚}
�N+NCʶ�(����6���3y�6�K�{�L_vaE��#�3��Ws2�������߀`��ɴ&��!`��:"�.9+Q��ƣR�ؠΫ��O�Fd?2w-k_D�S�*	�^P����!8�s��H�l ?k��y�����A�}�ѡ���>|�ѿ���ӾȰ�L���eKp���]H�k���/�q>��--+��%�+��@���X7��#��)���e�Gݰ��=VvN��~c,��3�X�J,4�)^t�`i|P|#�2`C��1�ϗ����jtl�R��Gx#|1��0!$��b	L��X��Y����� l����CVE��i"����)�c�0W�[Lw��b�t��!,⢖ů�7	�S��ҭ����&Qx��u��t�i��u�<�dxi�Z�U�U���u5\-�ťpu#r)��ޠz��1h�l\-w�%�N[Z���-�,Y�� ������Ҷ�jW��}*Y�nD�J 홳3p���1�k󨭛.{�ݣ�c�Ƥkb�;�_6&q5����e�!y����ͷ����ˎ<�J�T*j;��aY�wR�aɊg�)���3z��/�\G�y���ٲi����e��4��&�U��-��`.s�3��^�W]���:v|ș�������E,���A��4#A��	?�;kN�����o[����p;�dN��4��d �&�)=�L�C��Vm"����� �a�p݁:���OjK@'�Ձ�L�Sq�I���9�$�9<�9������aȹ��<S�Ѱ�Vl��Il*f�RW�3o��ڗAꇥ�C@z��Iir@ӗq�2܇�£$~�>����M�4��S=�	Z��c�#\w,�oT������S�ٌ\.k6'Mť���z���W�<�`�i�9ٙ'U�䔲8�>X1�
@�q��m�hF[0ڢH����ң�.0ԭ /��pGg�گ^AO�/&:1�C'=��S@O=����1��x̚q�ݦx�+�����!(�5�sǳǷ��՞x���F���xjX����*:���|/q]̓oCv��[�t�V��6�C��១쏩����:f�P��1�2(��J0��a�ۇi�6��>�>.{�#���lݴ��b�bD#������ �
X����f���8��ɑ������e����AkA���o�@����_�2�o�o�o��_��@��5u�Z�����.�oS'������:�+3H�ݠ�Z�w5};�������������e����AkA���ow���{#:����H�H�Hߏ�H�H�
�;�mE�v=�u�b���[E�G��(o#a#a�O�d�����Ho�D�F��8aws����mu����G�����;[      
	   *   x�3�4�4�2�4��Ɯ� ʄӄӈ�МӔӘ+F��� \��      	   )   x�3�=�1�ˈӹ4�� �˘3 35��B�c���� %�!      	   	  x��ˑ1�r0[��\^�ql�b\��aij��E<�īC]�SS�XJ��T�c��������V�Ǌ�Z!�FXK<��>�N-�"��� ,Ok��u��ŀ�}Za���ԧ�M�J��J�i������=���ʼ��y�2�%˘�,c^Rl^RlC-�ML�&&s������dnQlnQln]s��[�w���W�k^�.%��O7:�������l���(�N�bv��	ݝ��tR�&s�h2�&s�h2'�&s��d��L���1���Qq      	   *   x�3�4�46���2�A �$dbr�s��1z\\\ �e*      	   b   x�-̻� �ڞ�	"���%2M� �0Pݓ�t��CڐتݰS�Z�X�m꽸��R#�� ^=$��&���&��������<��eL"�� �      	   �   x�u�M�0���)8��_�eeb��� ]LR[���Sx1�&�)l�����LGmv$��P ��
�7a�φ�㬿��FTL��T��9�ײ���$�xn�a�%��:v��}�l�󡸢o�5����{�����t_��P��( �i`a���z����g�9�2A�TA��      	   A   x�37�44�4���24��44�4��@l���!�ma�ئ��ى��@c��!H2F��� L��      	   F  x����n1Eי����{Vm7U%�[6&$�jh�,��FBj$�Y�=�5����v	�Of�DT\�}�6��7X2�[�gB#Z���sr�9�s�3וr��9%+�!ؒ�#[t�pb�(D瘋rͥ�@^������8����y�5�X��m(ե�k�-[�>��w��\ Fp��1�&@��4��@D�E���m�s6�I�>S��!����h�1mt4֦��J�]���n�rl������o�}��=5���?��o���@U�V
K���G�H�~vy�'�P�!;�y�O��@q����pB<��m��H޷`UE�[ܸ/      	     x�u��N�0���S�	������I��G.n&KMR�	��3�b8k:��C$��'���e�1�Q#��U'O&89��V'�Rn~�}�e,�l�$L��w�������3َ�j{�Wy/�������N&�s{[8Żt'��X�L����E�����C�ɪgƩ��r��c~^/t�Sr��
l7�[��%��l`����3��G�g��4��pL����(��˰�ꩯlk�^���C{���PG��oT��'���4p3[�͟��?r��ܖ�Qz�z}PJ}�i��      	   s   x�M�A
�0����@�i��%<��/�B���|�4����P'���"�:�ѹF0u�{_Ԝz�5{�u�]��-`��|�g8���Z�V4�S!���^�l��^m��u!� 2.�      	   �   x�%�MN�0�דS��q��.���D�b��Z������M�,Xq�\��ͧy?3�zp��Mk�#�,����F�Z��z�*�S�)�;b���;k��q�[��t�G`�ڞ�I�S[�q�V_$=�n��=9�u3dx���ZFK�1��U�f�a}�P��L�%�Q3dk<yu��n�]�7x��|��y�/c��a姎/D���6f~-^���"�[�!��޽�q�D�q�K���$I�<f^�      	   �   x�U�;�0Dk�)|�ÿD�(�4��R,�^�v��&g��0P�h�F]�E�ڑ�)�-kufq�z�kar,�a�N)�#��:R���-�V�8���#��۫K�`�M���X�VՔl�����>a��:Z�]%��`�����a��Y����}��e���� ��}KY      	   H   x�36�4���41�26�4�1-8�aLKN(�Ā��45��55�25��,.MJ.UH�/R�I-���qqq ��      	   >   x�̱� ���&�g�]��9��N�
Q�v��dۗ��c7J�Qǈ���������ĵ
�      	   �  x�mRAn�0<+��C�;��m�셕�T�,��U�����:I��`Q3Cr4��ԯ��0b\PϨ}�΃��A��y!���Y�(�s��5ü0��7E�ߐG`ȕ d�A��)����D�?�� �?R�(W:\5���U�R��vg���ښ����T�xܙ}ߘ�=(ۨG�nW�m�����:�͊me�N�
�3\7efYfu�����9S���f<��e��naAǄ��S����|=��b,�}1�fv+P��S�f`OY�1^l*�鑆􍜄��gD �[q�y=d���L��e0<�{y*֐�
�g*����$b�8N�ճ�A_\�G�Z�����l��g�� ���9��m��W�%�QK+����;�0x�N���{mN}s�kS��^��)�WO��N%9��ԊR�Zm�ޞ����Uݕ� �os�R���� ]w���l׮�'ek%~,�|M9�/��橷�2�����l6+uC�      	   �  x�uTMo1=��� �~'Ǵ��B����l��v��Q���7���x^�n@Ⲳ���̛7�>Z-�F�����lp��{���G�,�t�|�׳� �d@z�kN7>z�i���9�Q!c	�"/�ݚ��<�����M�5]G3�Q�k�&�!ƹ��q;%����<�h�<<�E!��|E��h�A����f�Ie�ENAƂ��VXHvl6,��h-���Y���f���t�P���(;��O��:d!�F�E�&�yw�{���+�ƽ��������Y��x�����ID\эa�!�A�楞�%}=�gl�D؋��˩jP�Jށy��dT(H-�y>�8-�����d��Ģ\<!O^��=�)��:G)K�P�����T�H?����(k��f��a�]�}֧��>+����B���ϒֱ�J.�;�N�\Ma��Z�z��p�.*LH��yƟVq�W��.��*ft�=�3�*gLA㤎�*�0>n0��Ba����ǥ��b
���U;���4*�0�n�v�Ð�W�f���z1�?�2No��>� � =&E�'�:7�R}B*�<����AQ��4��0��}>gF�p9���^� wH����{�n�՝�1��X'�ҳ�t���M1���&=������>�c�/ES�Ze�TfS�W<e]�{lp�ҵ���@�Y�[��R*�����c���Yѕ��G}Hi���6:h����O�ɷ�B����      	   �   x�=�K� �5�#�X/�d�i;�53ir��,?D~�� ԚpUqQΪBU��CE�C�gVW�.��΢�w"w��K�S�E��~�;]|�)��"����#�W��<�Qvr�/`p��|����D�Ҙ%���º� ���GrZZ�AK��\n)�?��@:      	      x������ � �      	   0   x�3�t�t��K�L/-JL�<�9�ӈˈ3�3(� ��$�ȍ���� ��      	   �  x�MR�n�0��_�2i�#u_+b��|I�4is����|���.\��XV
�Q�����Ҩ�<�Uw��B��1�\��.vu�Ou������͑���=N�R������uC�e�n.��>:����_�9F|*�kG�nS?�3���D�6xC�6r�ڈ����YˇC�1��އ����\}L�����8l�f���y?�M�L���TM	�ނn�?p�fu�ݨ/�KW<J������{�c��F9���3���V��LY"J	~�v:|$��4���fOm�(����NZ��8Ү��b�P(��&��Zٝ]�Y5���;
���L�8N۩�%�m+7�PY���)�FyF���zx�R�2��iRȝ��u����K.]��j��8�I_'������a�G�� ���}      	   f   x�%̱�0D�:��	PL��kzX MD��(��wt���Y�z�P�8�	L���N��Ff"]h����?���y���A5F���j�|�羵��ڋ�7��      	   �  x�}Y�r�:������.ԥ��ر'����"����I����.2����ηXJJ����]��[p��k��,���ʺ�D9���k��J�#H��M��)lf=>JcTj���0V;](%��T�4t	`k���1�lԛ�i^m�I�]�dA+*e0<"ĩu�4tl���I� �-Ǯ~�U02�D=���&��'�(@2��k���2e��{�T�~���e�N�*8`0$��jU�mԛ�X!��X�Ɵ"3A2:�@��2;s8O�oD�]��U�5�wi�V�H#��Z7?U�������ՙ�t����MV�����!84�*p��"nKޚM�Hn�ʙu����l�����̘�0{�Kl:�����c#��}ИO��#�-\9�o����c�צ�mr�����u֞jW���W��h��s����b�]p(�`���)�e�6Ϛ���	|��r+[���e��\�<���� �i�#7�On�R��A|��)��F?�b���2=���<��v&C\���d��t�5WY��5�JN,� ���rjm0���!���[�W��E@[&t��G�Жɥ�t��`OJ޺���� !�YqK)9�ޭ��U�!9���x)ש�|c���I#>����e��Z6�ҳr͏2y����q���A>cye����#N�9�*Sn��&��c�^t׉*y�t �����7��Q�,����.^���jiʭ��]�����a�8#lUf�4ڢy��t0�D�a½#��爃<W�q�;
��"��Uth@Ȝk��l�Q�o䄆>�3�����\{�٢N���L�V+t[)�.���:֏�x����=G,��$��Ηʹ����L	���꩏�K+d�
��b���Nw�=�����6$`2��"V+�d�u�A��:6�i��]�8��U���k�`A�~V�h] �<϶y���n/m>X���
5�W��^=��?6��h��|w�ӫkO][Jd��T�*�� �����;xxDVߙ�9�\׼���, q��P7]�<�)G�%�"�p����ꭩ�6����G �{5�a�Ou�`�����=*3��:!�Uw���6��`c6��	Չ�M$��!o뮮3Lƾ���6��wɌ����h�%d���j'����p�|�Ok'�e^�KF>%J*P.9?u�Y(0úV9Z��%>��L%��.Kbt�1���ل�Q�$WN�Ո�)�.�k����`�}g1��w�N��;}�@fV�S�u(�!pn%L�\d,��}���QH�f�.��4컝�'a+���;�������ƴ+�g�mp�DVz֘�FN�"�D�R+)%/}T��e�[��\E���Mr^|��Q��̷�/*�H�߮\e�6j���=����5�%z]�r �z/T&�O�������8�����i��2O��V��sl��u:��M �?��B3���Ũ�)����3S��=���	�H2O�\h��33�'��arP]��!���~Ų������7�R���ӯ,vA�=+{�L����Z$��r�{_��ԧ�=��r�o�J���6��k�����b��|䉂�2'�q�8,V�,���IV�U��B�`,���IBg�&b�ؠ�"�>�ZB*���>Y�t=��s�%��1"����(�h8�����|׼<�\�5	گHm!���Iؤ��K����N��ư��~gZ�Ew�O�p�d����:�Cܑ�%�u%�aJ�+�aD ϳ�Y��d�[R.౯Ι;1<��P5�PW��Y����A�њS]{��ݛ$\��X�'p'�Eې)������7P�L��Α��{VKÙ��<��,&�����6S¦�Ņ��n�$p�˴R���D��{@GG�3�mv�� _��%��i,=4�����.�s3�<����cM]dq�bx��q�▪��ރ���`�v�>�!�6��L�0z�7�2N���s~�2�%[�@ѵTmuxT`�}4�b�!t�����(�'���(���%ҫPB���]���w��l�ķ �Gm����I��ۨl�@2�}Y�x��"8��Y���4���������Q��OȢ�X�I�qUnc�&p����ƾ�ou���@kp�4����m^���i���M��=�q�>08���&�d'	��V��/�4fB预����\�),���L ��u�^����e�}�Ȍr��T�SäWhH�`ʓ ݋bB9�c� �mT��yҥ���;�Ɣ�{��tx�ፎ 	����'�,����q.{�?�칏a��u��Q)p���/p��\��GZPS��]nAv�y4a�E�;��A?!fJw�i���aw荞d��Ӽ ��C��Q���[K[
W��Π�n��G���ז�
��E~(2�u �ib%�,N?���}.L�|���,K}A�Ԑ��h�|�ak%w醡�h����F%�3��42��м�$�y�cl���-����И����p�tQ�T���(eRw()�������h?�	�_�E9\	���&�@�ؕY�F�!�Nu�\"��B|��I|2�����ۺ~����M4��y_r��Rm�;4ʴ�K=�m�t	ӿK[�*��3���}tܢ��*��$F�!X��5���v���qH�����p1�c�/|��i5��|��L��j"*AwW�7����������O��r4�+�AJp��:D�a���5f�z�)p���x�TP��J�rKr�'��'V�:��D,�u�����v���q�0L�w����h\Zxn��l(m�B����	��6���+��K��Ϣ�z���1�FD s��O.ԓ�.���u�@�j_��gb�x���7Ҭp���I���8���Vo���-1is��_3���))q�P� �{G�<���J?�F�l^�Jˤ�r-�I6�K��B �)$�;��xh�@&w�HY�����F���ɏ�;̑��'++��"&����� ��Zb       	   �  x�u��n�0��7O�Ht���J-Bb�Ħ��b�!�tA��k���p�Ȗs��s���S�s������ yb���w��	���,�2��.���嚟�
��y�
�#рn �J�M�CGw�|����ḖS��t��44���ml__���^~=��]c��L}��yc�w$��5ϭ�Ӳ�W��l��������C��)���{��$~ϻ7?�z.����-s�bw���7�E�d��JSq��k�/�Fi\���	C3zq�?��ӱ��O�r��v@+q́;K�b]|u�vY�)$2�y4&\�j]y�`*?�Ka��Gǅc�[��s7��)'������������0�c��'�Yʦ��̍���%ڜo����iT�R�wM�Ǳ�?Y���      !	      x�3�K�K�*M�I�s������ Fv�      "	      x������ � �      #	   �   x�M�A�@E��)8��([I�.LX�tS��I�L,���Q<sƀ��y�?%(�`G�(�"=c
�����>D�S���a[�����0����wF�v��V��Z�������G���L�g����7��$4H)������ҫ�E�a�I��?�VG      $	   /   x�3�4�4�2�F\ƜƜ��\& ʌ˔��3�4�4������� ���      %	   .   x���  ���&&���Du�����o�x�!W���$}~��      &	   c   x�3�t��+.�)I�2�tI-�M,���O�L�2�HM�L,)�M8�RKs��p-
�y%�Ey�\f��EP�朥EP���yi��0-9�K��b���� ��'      '	   [   x��0�4�?.Ns��ЀӐ���6�4���8�`l#�3���6���M9��l3NK;��(_�$� _!9?��4�$�+F��� ^{�      (	      x�m�;r�0�k�,�&#>%��ǎ�8�$)Ӭ@�� �X���\ �.�AS�h�X���b?�.�ŭڑOj���h�?-�evč�����&��F�*�j�r ,%,�.�S��XX�OW��)i�E5���u�y���HS���#̛S��] �)�,�K��2]�@��Qkǈ��hm��5	>~pdb`9�ҹAX?W�����s�͑�ְ�K�$�`Ѣ���f\��ZJH���Y:�kJ�M���4��fȌ�g��ܰu#������x�1m~�j��i���:�8�A^�Q���?�9�I�{�B!�"+��� �E��,�x�^u��Q��+�e�3wi��Zb��:<�A(��Ƣ�u4�����FA�8f���>�U�M!y
������Ъ�ċV�K)ԟ�AS�0,E��OT�B�ѥ���%�"k��έߟM
#����V+8����=��x��Ɏ�9
*���;�B���$S�/&l��<�����џÆ�v_�
����qF��F�1�N��+�� n��km��֡�a`�`�XXTtQͣ�N5��������y�\1D�4~Q|�\��~N��v{!d;z��*+`�]TT2~�ʳ���J���	��$�%�vkU��VA�=�ms�K��=?j��o�+���/�3���&V�]����E���d��v�%��Y�2�J~'���t]^�p���A}���[�V�c[��cQ��B�|���f�����m����r����      )	   /   x�3�t�H�M�SH�,JM.��2�tLO�+IUp�,�IL������ ���      *	   4   x�3�.-H-J�L�L�I-�2�(�O+�KI,�2�%%��$�y1z\\\ {��      +	   (   x�31�4�44�21�4�4��25�f\f q3�=... d�!      ,	   ?   x����0���� :c����d���A��s4�F'T�Ċ�;���~���NR:~���-.      -	   0   x�3�LL��tL����,.)JL�/�2��MM��=�2%39��+F��� ]�      .	   G   x�-���0���0�SK0A����%�-&.�n*2A�ĥ��"�w�(�
��:NH���u���y��;��      /	   �   x���1n!E��� ��H)-�h] ��Ӡe�	��X�|_̳n<."��t0�O�H�_4��	�Xu�o9�#M�B�z�L�h�W��&҉�Kx�"_,rΥ�s}�X���@�#Q����	w�'�ԐۺX'Deԁq+��0�p�5�q�9pv���0��`���2Y���7�������C�3�D�Kһ@�t���9�oJ��ɞ\      0	   e   x����0��P�M�۽��:n�K; ذz촿��kx<,�ݥ9L�ay[�����撰�L�G.�#^�{	0�_��d-��@O�u���!6��������      1	   �   x�=�;�0D��S���D@�D��1���bo�]K�u���,A1��Ӽ��!(y�yT�,������y�K]AC����ZÙ��`�jܐL�7p���U������y����i��Eӓ�=\�O�%��	O�zW���9C�Z;~      2	   h   x�-̱�0D�ڙ�	P��IX�	h)�� 1?�����d�L\�ж�gw�9���â���X瘋F��Y��l�/n����\m:��=�ݳ!W�dX�N�6�>��!:      3	   �   x����N�@���S�l�̭�~:�LEKs�ga)	���'�!5l1էoF��������1�R�P^���h�3Cd-�O��(�&��b����Y���ݹ!���|,o�W�rF2�Xǀ��[�m��ꎧ+'J�a1Ronȁ���$lj����#������C+� ː�ԩps�˺��޿�T�`?��=��p+�������j]�z)x��[)      4	      x��]s�6��8=\ڙ����(���u�&�d�C���)E*$;�G}���{���I $@��}s�I�v����b����w�?�nl�{��:O{�Ѡ��c��嬟�v���Y���s��Ǐћ_����%2<��DW_лw��_����v��}��~��Gk�]���p7�m�����d��}��q2�X�1z{�|����?�m��޺4��z4I�ï�_����-��y���u�`�axփ��_p����������w�YF��zO{���{u8{D�(���(G&M��9^c��l쬃�O{�Z ����=���=�i��s�Ϟ��F�mĝ����Rd��֚?��W"s����d�x���� }��,Yݗ�[���OZ\�%sE?�z���ܢ
|*or�Rz�Y4a�j`\b��B4��1�z��D��^./N���yq���r}k�sy��~��ѿ"p�Q�t# ������:�?<! i^9���2E�!��~�=�9�ד�h�I䧓�����;;U?�
��:��W�c�[��}�qz��jq"0�um�3����b�89g�PG��]�����hemp�B�:�x"�Ls�Z,d����ׂc�M�~g�f@��V?���/�&$b�}f�&�p/%�.���Z���������T}_8��G�vE�x������^[��m[w���i֊؋�Z`��uY/eC�΄�3@�8��ze*�p�7�q�q�� �~:1M�I_��rz��3yT?�+�np��A��W��׋��o5t>��ϳ�@'���H{����h>�!G������Ĉb_�ꆅA�|B�cϽ�߱L^�;�Q�w�k9��m�u���,v~2§�Z���33H��������O�<��ڰu������-
;�v�� L+
�
��t% �`��f� ~h~��:b��^���e���!��%`�u 8@��2��+�A7-�T�-l��˃��<kkX_��  l 溍L�|a%T�Ll`�"�E;G��5�6��M�Cn���|=��|^���X�y������2������S�8�g"��T�5e�F��9n��B�0Dp�Z7��K��������ou/x	�q?�Gn�~�a�T=�f�P;��,�P����yJ#��a�Jx��L���a�-�B�)	��-l�t��mQw�G��<w7W����f�X�bsg�2X�v�dF�i6�^b���SZ_�p��Trιi8��>	$lk���hņ~�!�Ʈs^�0vېRBbu�ة��d�PIZqC �_��,��a�t��6�tsx���xmv�A�8��l�<j!l>j[�9%=�����5=.j�N�j��v�<kb���Z�}]N�|��yR��Ƿ�{j��僧�;p~�#������H���9<����x:�ә�LX[��6쟬� �H^��m砠�ʆ���/�B�_m�lA���%J1�苋�\��E���<:S���:����o��~y���L���gK@�i6�D������ө��NFX��RVZ�8�uJq:ݗ�8�$FS%��P-ν�w�����Ħ-<%:�/��V�*�憐�ɷ��� ȥk	 -�8F��s��N��#���u��E{���Su6n�T��Q#�d0,S6c�W�2�*E����1Y���B�b>���$��)�W�ZKJ!��E�D9-�o][�v=��?��ta���v}��'�Q{�#���]�T��
aEb�]cu���4(*��V��G�u@����$#q®[a��_׮#CD�;�zyv����P*���u��-ݵ� ,`��4�zG4�(�I�C�%۔�D��L�/eИ�#Y��,����׼����[�4qC��J� e٠�t����RV(�l�
eдh~)'�d�e��{'��PH��+g#u&͕9bP|	τ��Y������P�-U��7Š�hriV���ެtw�&��$�IA�<b��|9��(�J�a@%c�=�k��𚄣�߱�<�K�n�T�#��Av��
�e�`�]�!)��<Q�8W��b�SZTnXÑ�� ���$ ��e!F���P�_`�@g���r�'N����Xq��7+<��nJ
m1�䐺,؇��>L�O���̣\�2PRFD/t����D��6��㷈�*CEZ��p0�s�>� �)�Y��C�19�
�$�q�ի	LM+�@��$^��C�S� ]�T׆��z_�%�AN�D��6Υ��K`K�c��t�8����+R�y>k?�Z�Q���J&���T�����5n���v[�ER�Np6��J�j���,O9�Y��:E��.����>��/�(I8\���F/ $��������7��J�.�
 �����P�z�� X��8���I�QF$���δb���P���%�����,,�"�=�\�L?JW�$e�%�>��� �\��)���MS�0R��G2��1�\"e����(�=Ow|�08�=���-jy�ZFJ�W=&���������k�n�5wv�h� ��yc���D�d��+9�kZ�{*�����7�,iYP��W�Re�s5
����s5_�waN�S� ��w:(O`"�A
��Jj���E?�&N�2�x�4��r06��yW<��������3���L�V�B�Nvz���j��
�eM�d:6S?��F��p�l�-ctd#�8qW�=7û/�Z)��&Q�h>H]����Ƶ�$P-I���eN��o���飺��P��"GV�D���Ӑ���8�5L�2��j�������$�Vޏ��3�5�:�P�<�=��e��%�I�NQ�vD����h����J�Q>��3���Cd�.�s�p �I���'�D�p �<cS�Ε�o�#5
©�Q��hx�H��	���8���|��������O��Z9wR} A�E`Gh?�CaW�J!,^s�R�݈oD޿^JmB�`DJcM��k�;�\�|��� =�+ �#�������&��(,E�A׮�	��I�j��*P���p,){x�'������_���"+�ş�	����H���5+�8���&i�����8��O��{$y�е�����=wZe�-b�=�t0��n
�*oy�.�9�����#e���&�13>�e��q�깴m� �xMR{���hhE����>�W��v�ܑͺ6���1�
���1�^n�#~F�NnRc�'q�2H5k��s�>+�ov �<�ZQ��RS�|ܽ��iӾ(ddC	����%;}� "��)����d�U�u@�{]l�ZO��"��Q$���&%`9懤oJ�u������W��Vj
e�#���
�3
�E�q?��^�HU{��j_��hE��B�wK潛�ܑ���Ƣ�4j�ڎ����-�=��`��O��}�d���&�ܮ�u�H��\k|�!Oۖz
�����Ҿ�j�1��8����'�
�D�'��4� w��p�\HvēBMO**�L8�r�I䷏�9K��x��;��O�Ib'Qz'l]cq��,�F�c���l8S�H�TM�	��4I!h5��`y��6}u�h4��$@�5��C-c�R
Oj�4�8����HYP�>� ��I�.Ԃ��c�X��T�eC%��%��w�����f��뾥����c9��e�i��*)r�1I)f��>�V�Ȱܱ'E��a&`�=%NF�F�
���l?TR���A��owà70%����1�M��("�|�hE�$�н�fe��y������Q�d:�q��:��~��-�>�h�1�L���<�L�
cM���r�0�U\���t�Q���e��.ۊ��6xG&�l���"h��Q:�g�8��r�-���3z)�2���l���3G�	�4�nT�Ms^dd�[C���2��0z5J�e`L�0819ic#z��2���\�+iV�ǿ+E���nj�)���.�`RQ��	��:ii-!#e/��|}�!�<�Nfѱ2e6H�pDW�u|X�jsLLB�]ݝ�@B+����l�F'JX�X���"B+�9��_�1\�\Z��NT�Ŭ]�:�4��� �  ��D>�ʗ$���X�d�'b���!«��X��I�)�n��Զ�ְu�v38���.�ŉ2�ɱ�����r�֪�j\�;�ݰ@�n��6B`�:0@L�ZO��dF���E5����F���~�8�pq��WELLG퉊��a�Z2��e!#�-[D���IaO,|�`��y|�;8���z�W�u���.Ak��K?��^2{�.�Ԭq�Y��r�7}ɺJ鄬,wNfs�At��l�M~��[MG�K�=2mf�g��`&/c��Y�H�h��g�y3������Ϯ��7����O���ڣ �n]��aYZ����w����qQڈ�C#��%�cSc�{2T��i�rI��"C�28�n{��ځVQEN��;�&��Zz+��(�O���K��R��������)x-(M���$������D;k�N���h�A�(h�4A�������߶\~Є���u�"��4rݔ�t1sf�߽Cѵ��\ P��82���mU�;*7)�!��[�I�-C.�	�
��1��b�a�s������I$���d�[�I�%��=7K^d�oc�N�V^,j��MO����\F���p/dƫn�S�ی��0���]#�ߔ������b�l�ZO~�)��x���}{���w�TUח(�%�3���:"����]�̆���܀l1!��287�-�e����2�Ҽ[´�r\r��a!����1}X��2��BL�*�ё��:��/��1����n��7��Y��HE��_\,'�R	�·`u�v��������'�7������ ��XA���4����.F��*&��Tl9�L�0���s3��;e��+�g��O��d9&K�Yj������ڜ�|Ҿ�Zcd�D;N+q�i�ހyss��M�[k{%�\7�'~�M������q�x�jz@M�&�r�N��d2�_��E"�8 &R�a4��݇��<x�_�i�     