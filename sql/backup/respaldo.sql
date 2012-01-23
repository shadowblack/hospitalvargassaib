--
-- PostgreSQL database dump
--

-- Dumped from database version 9.0.3
-- Dumped by pg_dump version 9.0.3
-- Started on 2012-01-22 11:42:21

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 6 (class 2615 OID 32405)
-- Name: saib_model; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA saib_model;


ALTER SCHEMA saib_model OWNER TO postgres;

--
-- TOC entry 479 (class 2612 OID 11574)
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: postgres
--

CREATE OR REPLACE PROCEDURAL LANGUAGE plpgsql;


ALTER PROCEDURAL LANGUAGE plpgsql OWNER TO postgres;

SET search_path = public, pg_catalog;

--
-- TOC entry 326 (class 1247 OID 32408)
-- Dependencies: 7 1671
-- Name: t_validar_usuarios; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE t_validar_usuarios AS (
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


ALTER TYPE public.t_validar_usuarios OWNER TO postgres;

--
-- TOC entry 2376 (class 0 OID 0)
-- Dependencies: 326
-- Name: TYPE t_validar_usuarios; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TYPE t_validar_usuarios IS '
NOMBRE: t_validar_usuarios
TIPO: TIPO
	
CREADOR: Luis Raul Marin	
MODIFICADO: 
FECHA: 20/03/2011
';


--
-- TOC entry 19 (class 1255 OID 32409)
-- Dependencies: 479 7
-- Name: adm_eliminar_medico(character varying[]); Type: FUNCTION; Schema: public; Owner: desarrollo_g
--

CREATE FUNCTION adm_eliminar_medico(character varying[]) RETURNS smallint
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


ALTER FUNCTION public.adm_eliminar_medico(character varying[]) OWNER TO desarrollo_g;

--
-- TOC entry 2377 (class 0 OID 0)
-- Dependencies: 19
-- Name: FUNCTION adm_eliminar_medico(character varying[]); Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON FUNCTION adm_eliminar_medico(character varying[]) IS '
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


--
-- TOC entry 20 (class 1255 OID 32410)
-- Dependencies: 479 7
-- Name: adm_eliminar_usuario_admin(character varying); Type: FUNCTION; Schema: public; Owner: desarrollo_g
--

CREATE FUNCTION adm_eliminar_usuario_admin(character varying) RETURNS smallint
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


ALTER FUNCTION public.adm_eliminar_usuario_admin(character varying) OWNER TO desarrollo_g;

--
-- TOC entry 2378 (class 0 OID 0)
-- Dependencies: 20
-- Name: FUNCTION adm_eliminar_usuario_admin(character varying); Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON FUNCTION adm_eliminar_usuario_admin(character varying) IS '
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


--
-- TOC entry 21 (class 1255 OID 32411)
-- Dependencies: 7 479
-- Name: adm_modificar_medico(character varying[]); Type: FUNCTION; Schema: public; Owner: desarrollo_g
--

CREATE FUNCTION adm_modificar_medico(character varying[]) RETURNS smallint
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


ALTER FUNCTION public.adm_modificar_medico(character varying[]) OWNER TO desarrollo_g;

--
-- TOC entry 2379 (class 0 OID 0)
-- Dependencies: 21
-- Name: FUNCTION adm_modificar_medico(character varying[]); Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON FUNCTION adm_modificar_medico(character varying[]) IS '
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


--
-- TOC entry 22 (class 1255 OID 32412)
-- Dependencies: 479 7
-- Name: adm_modificar_usuario_admin(character varying[]); Type: FUNCTION; Schema: public; Owner: desarrollo_g
--

CREATE FUNCTION adm_modificar_usuario_admin(character varying[]) RETURNS smallint
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


ALTER FUNCTION public.adm_modificar_usuario_admin(character varying[]) OWNER TO desarrollo_g;

--
-- TOC entry 2380 (class 0 OID 0)
-- Dependencies: 22
-- Name: FUNCTION adm_modificar_usuario_admin(character varying[]); Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON FUNCTION adm_modificar_usuario_admin(character varying[]) IS '
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


--
-- TOC entry 23 (class 1255 OID 32413)
-- Dependencies: 7 479
-- Name: adm_registrar_medico(character varying[]); Type: FUNCTION; Schema: public; Owner: desarrollo_g
--

CREATE FUNCTION adm_registrar_medico(character varying[]) RETURNS smallint
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


ALTER FUNCTION public.adm_registrar_medico(character varying[]) OWNER TO desarrollo_g;

--
-- TOC entry 2381 (class 0 OID 0)
-- Dependencies: 23
-- Name: FUNCTION adm_registrar_medico(character varying[]); Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON FUNCTION adm_registrar_medico(character varying[]) IS '
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


--
-- TOC entry 25 (class 1255 OID 32414)
-- Dependencies: 479 7
-- Name: adm_registrar_usuario_admin(character varying[]); Type: FUNCTION; Schema: public; Owner: desarrollo_g
--

CREATE FUNCTION adm_registrar_usuario_admin(character varying[]) RETURNS smallint
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


ALTER FUNCTION public.adm_registrar_usuario_admin(character varying[]) OWNER TO desarrollo_g;

--
-- TOC entry 2382 (class 0 OID 0)
-- Dependencies: 25
-- Name: FUNCTION adm_registrar_usuario_admin(character varying[]); Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON FUNCTION adm_registrar_usuario_admin(character varying[]) IS '
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


--
-- TOC entry 26 (class 1255 OID 32415)
-- Dependencies: 7 479
-- Name: formato_campo_xml(character varying, character varying, character varying); Type: FUNCTION; Schema: public; Owner: desarrollo_g
--

CREATE FUNCTION formato_campo_xml(character varying, character varying, character varying) RETURNS text
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


ALTER FUNCTION public.formato_campo_xml(character varying, character varying, character varying) OWNER TO desarrollo_g;

--
-- TOC entry 2383 (class 0 OID 0)
-- Dependencies: 26
-- Name: FUNCTION formato_campo_xml(character varying, character varying, character varying); Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON FUNCTION formato_campo_xml(character varying, character varying, character varying) IS '
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


--
-- TOC entry 27 (class 1255 OID 32416)
-- Dependencies: 479 7
-- Name: med_eliminar_historial(character varying[]); Type: FUNCTION; Schema: public; Owner: desarrollo_g
--

CREATE FUNCTION med_eliminar_historial(character varying[]) RETURNS smallint
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


ALTER FUNCTION public.med_eliminar_historial(character varying[]) OWNER TO desarrollo_g;

--
-- TOC entry 2384 (class 0 OID 0)
-- Dependencies: 27
-- Name: FUNCTION med_eliminar_historial(character varying[]); Type: COMMENT; Schema: public; Owner: desarrollo_g
--

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


--
-- TOC entry 24 (class 1255 OID 32417)
-- Dependencies: 479 7
-- Name: med_eliminar_micosis_paciente(character varying[]); Type: FUNCTION; Schema: public; Owner: desarrollo_g
--

CREATE FUNCTION med_eliminar_micosis_paciente(character varying[]) RETURNS smallint
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


ALTER FUNCTION public.med_eliminar_micosis_paciente(character varying[]) OWNER TO desarrollo_g;

--
-- TOC entry 2385 (class 0 OID 0)
-- Dependencies: 24
-- Name: FUNCTION med_eliminar_micosis_paciente(character varying[]); Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON FUNCTION med_eliminar_micosis_paciente(character varying[]) IS '
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


--
-- TOC entry 28 (class 1255 OID 32418)
-- Dependencies: 7 479
-- Name: med_eliminar_paciente(character varying[]); Type: FUNCTION; Schema: public; Owner: desarrollo_g
--

CREATE FUNCTION med_eliminar_paciente(character varying[]) RETURNS smallint
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


ALTER FUNCTION public.med_eliminar_paciente(character varying[]) OWNER TO desarrollo_g;

--
-- TOC entry 2386 (class 0 OID 0)
-- Dependencies: 28
-- Name: FUNCTION med_eliminar_paciente(character varying[]); Type: COMMENT; Schema: public; Owner: desarrollo_g
--

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


--
-- TOC entry 38 (class 1255 OID 32420)
-- Dependencies: 479 7
-- Name: med_insertar_micosis_pacientes(character varying[]); Type: FUNCTION; Schema: public; Owner: desarrollo_g
--

CREATE FUNCTION med_insertar_micosis_pacientes(character varying[]) RETURNS smallint
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

	_str_pos		TEXT;

	-- variables para trabajar con otros
	_str_data_otr			TEXT; --partes del cuerpo y categorias
	_str_data_otr_est		TEXT; --estudios
	_arr_str_data_otr		TEXT[];
	_arr_str_data_otr_est		TEXT[];
	_arr_str_data_otr_elm		TEXT[];
	_arr_str_data_otr_elm_est	TEXT[];
	_bol_otr			BOOLEAN DEFAULT FALSE;

	-- cadena para manipular el array	
	_str		TEXT;	
		
	_id_doc		doctores.id_doc%TYPE;
	
	_arr_1	INTEGER[];	
	_arr_2	INTEGER[];
	_arr_3	TEXT[];	
	_arr_4	TEXT[];

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
	_str_data_otr_est	:= _datos[12];	
	_str_pos		:= _datos[13];
	_id_doc			:= _datos[14];
	
	
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

		_arr_str_data_otr = STRING_TO_ARRAY(_str_data_otr,'~@~');			
		FOR i IN 1..(ARRAY_UPPER(_arr_3,1)) LOOP
			_bol_otr := FALSE;
			_arr_2 := STRING_TO_ARRAY(replace(replace(_arr_3[i],'(',''),')',''),'~@@~');
			
			IF (_arr_str_data_otr IS NOT NULL)THEN
				<<mifor>>
				FOR j IN 1..(ARRAY_UPPER(_arr_str_data_otr,1))LOOP			
					_arr_str_data_otr_elm := STRING_TO_ARRAY(_arr_str_data_otr[j],'~@@~');
					
					IF(_arr_str_data_otr_elm[1]::INTEGER = _arr_2[1] AND _arr_str_data_otr_elm[2]::INTEGER = _arr_2[2])THEN
						_str_data_otr := _arr_str_data_otr_elm[3];					
						_bol_otr := TRUE;
						EXIT mifor;
					END IF;
				END LOOP mifor;
			END IF;

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
			_bol_otr := TRUE;
			_arr_str_data_otr_est := STRING_TO_ARRAY(_str_data_otr_est,'~@~');
			IF (_arr_str_data_otr_est IS NOT NULL)THEN
				<<for_estudios>>
				FOR j IN 1..(ARRAY_UPPER(_arr_str_data_otr_est,1))LOOP
					_arr_str_data_otr_elm_est := STRING_TO_ARRAY(_arr_str_data_otr_est[j],'~@@~');				
					IF(_arr_str_data_otr_elm_est[1]::INTEGER = _arr_1[i])THEN
						_bol_otr := FALSE;
						INSERT INTO tipos_micosis_pacientes__tipos_estudios_micologicos (
							id_tip_mic_pac,
							id_tip_est_mic,
							otr_tip_est_mic
						) VALUES (
							_id_tip_mic_pac,
							_arr_1[i],
							_arr_str_data_otr_elm_est[2]
						);
						EXIT for_estudios;
					END IF;
				END LOOP;
			END IF;
			IF (_bol_otr)THEN
				INSERT INTO tipos_micosis_pacientes__tipos_estudios_micologicos (
					id_tip_mic_pac,
					id_tip_est_mic					
				) VALUES (
					_id_tip_mic_pac,
					_arr_1[i]
				);
			END IF;
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
	
	/*Examenes del paciente */
	_arr_3 := STRING_TO_ARRAY(_str_pos,'~@~');
	IF (ARRAY_UPPER(_arr_3,1) > 0)THEN
		FOR i IN 1..(ARRAY_UPPER(_arr_3,1)) LOOP
			_arr_4 := STRING_TO_ARRAY(_arr_3[i],'~@@~');
			INSERT INTO examenes_pacientes (id_tip_mic_pac,id_tip_exa, exa_pac_est) VALUES (_id_tip_mic_pac,_arr_4[1]::integer,_arr_4[2]::integer);
		END LOOP;
	END IF;		

	RETURN 1;

END;$_$;


ALTER FUNCTION public.med_insertar_micosis_pacientes(character varying[]) OWNER TO desarrollo_g;

--
-- TOC entry 2387 (class 0 OID 0)
-- Dependencies: 38
-- Name: FUNCTION med_insertar_micosis_pacientes(character varying[]); Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON FUNCTION med_insertar_micosis_pacientes(character varying[]) IS '
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
		''32'',
		''63,demo''
	] ) AS result

AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 15/08/2011

AUTOR DE MODIFICACIÓN: Lisseth Lozada
FECHA DE MODIFICACIÓN: 29/12/2011

AUTOR DE MODIFICACIÓN: Luis Raul
FECHA DE MODIFICACIÓN: 29/12/2011
DESCRIPCIÓN: Estableciendo campo otros para los estudios micológicos
';


--
-- TOC entry 29 (class 1255 OID 32421)
-- Dependencies: 7 479
-- Name: med_modificar_hitorial_paciente(character varying[]); Type: FUNCTION; Schema: public; Owner: desarrollo_g
--

CREATE FUNCTION med_modificar_hitorial_paciente(character varying[]) RETURNS smallint
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


ALTER FUNCTION public.med_modificar_hitorial_paciente(character varying[]) OWNER TO desarrollo_g;

--
-- TOC entry 2388 (class 0 OID 0)
-- Dependencies: 29
-- Name: FUNCTION med_modificar_hitorial_paciente(character varying[]); Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON FUNCTION med_modificar_hitorial_paciente(character varying[]) IS '
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


--
-- TOC entry 32 (class 1255 OID 32422)
-- Dependencies: 7 479
-- Name: med_modificar_micosis_pacientes(character varying[]); Type: FUNCTION; Schema: public; Owner: desarrollo_g
--

CREATE FUNCTION med_modificar_micosis_pacientes(character varying[]) RETURNS smallint
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

	_str_pos		TEXT;

	-- variables para trabajar con otros
	_str_data_otr			TEXT;
	_str_data_otr_est		TEXT; --estudios
	_arr_str_data_otr		TEXT[];
	_arr_str_data_otr_est		TEXT[];
	_arr_str_data_otr_elm		TEXT[];
	_arr_str_data_otr_elm_est	TEXT[];
	_bol_otr			BOOLEAN DEFAULT FALSE;
	
	-- cadena para manipular el array
	_str		TEXT;
		
	_id_doc		doctores.id_doc%TYPE;
	
	_arr_1	INTEGER[];	
	_arr_2	INTEGER[];
	_arr_3	TEXT[];	
	_arr_4	TEXT[];
	
	
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
	
	_str_data_otr_est	:= _datos[11];

	_str_pos		:= _datos[12];
	
	_id_doc			:= _datos[13];	
		
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
	
		_arr_str_data_otr = STRING_TO_ARRAY(_str_data_otr,'~@~');		
		
		
		FOR i IN 1..(ARRAY_UPPER(_arr_3,1)) LOOP
			_bol_otr := FALSE;
			_arr_2 := STRING_TO_ARRAY(replace(replace(_arr_3[i] ,'(',''),')',''),'~@@~');
			IF (_arr_str_data_otr IS NOT NULL)THEN
				<<mifor>>
				FOR i IN 1..(ARRAY_UPPER(_arr_str_data_otr,1))LOOP			
					_arr_str_data_otr_elm := STRING_TO_ARRAY(_arr_str_data_otr[i],'~@@~');
					IF(_arr_str_data_otr_elm[1]::INTEGER = _arr_2[1] AND _arr_str_data_otr_elm[2]::INTEGER = _arr_2[2])THEN
						_str_data_otr := _arr_str_data_otr_elm[3];					
						_bol_otr := TRUE;
						EXIT mifor;
					END IF;
				END LOOP mifor;
			END IF;
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

	-- estudios micologicos
	DELETE FROM tipos_micosis_pacientes__tipos_estudios_micologicos WHERE id_tip_mic_pac = _id_tip_mic_pac;

	_arr_1 := STRING_TO_ARRAY(_str_tip_est_mic,',');
	IF (ARRAY_UPPER(_arr_1,1) > 0)THEN
		FOR i IN 1..(ARRAY_UPPER(_arr_1,1)) LOOP
			_bol_otr := TRUE;
			_arr_str_data_otr_est := STRING_TO_ARRAY(_str_data_otr_est,'~@~');
			IF (_arr_str_data_otr_est IS NOT NULL)THEN
				<<for_estudios>>
				FOR j IN 1..(ARRAY_UPPER(_arr_str_data_otr_est,1))LOOP
					_arr_str_data_otr_elm_est := STRING_TO_ARRAY(_arr_str_data_otr_est[j],'~@@~');				
					IF(_arr_str_data_otr_elm_est[1]::INTEGER = _arr_1[i])THEN
						_bol_otr := FALSE;
						INSERT INTO tipos_micosis_pacientes__tipos_estudios_micologicos (
							id_tip_mic_pac,
							id_tip_est_mic,
							otr_tip_est_mic
						) VALUES (
							_id_tip_mic_pac,
							_arr_1[i],
							_arr_str_data_otr_elm_est[2]
						);
						EXIT for_estudios;
					END IF;
				END LOOP;
			END IF;
			IF (_bol_otr)THEN
				INSERT INTO tipos_micosis_pacientes__tipos_estudios_micologicos (
					id_tip_mic_pac,
					id_tip_est_mic					
				) VALUES (
					_id_tip_mic_pac,
					_arr_1[i]
				);
			END IF;
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

	/*Examenes del paciente */
	DELETE FROM examenes_pacientes WHERE id_tip_mic_pac = _id_tip_mic_pac;
	_arr_3 := STRING_TO_ARRAY(_str_pos,'~@~');
	IF (ARRAY_UPPER(_arr_3,1) > 0)THEN
		FOR i IN 1..(ARRAY_UPPER(_arr_3,1)) LOOP
			_arr_4 := STRING_TO_ARRAY(_arr_3[i],'~@@~');
			INSERT INTO examenes_pacientes (id_tip_mic_pac,id_tip_exa, exa_pac_est) VALUES (_id_tip_mic_pac,_arr_4[1]::integer,_arr_4[2]::integer);
		END LOOP;
	END IF;		

	RETURN 1;

END;$_$;


ALTER FUNCTION public.med_modificar_micosis_pacientes(character varying[]) OWNER TO desarrollo_g;

--
-- TOC entry 2389 (class 0 OID 0)
-- Dependencies: 32
-- Name: FUNCTION med_modificar_micosis_pacientes(character varying[]); Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON FUNCTION med_modificar_micosis_pacientes(character varying[]) IS '
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
		''63,demostracion'',
		''32''
	] ) AS result
AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 15/08/2011

AUTOR DE MODIFICACION: Luis Marin
FECHA DE MODIFICACION: 27/12/2011

AUTOR DE MODIFICACION: Lisseth Lozada
FECHA DE MODIFICACION: 29/12/2011
';


--
-- TOC entry 30 (class 1255 OID 32423)
-- Dependencies: 479 7
-- Name: med_modificar_paciente(character varying[]); Type: FUNCTION; Schema: public; Owner: desarrollo_g
--

CREATE FUNCTION med_modificar_paciente(character varying[]) RETURNS smallint
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


ALTER FUNCTION public.med_modificar_paciente(character varying[]) OWNER TO desarrollo_g;

--
-- TOC entry 2390 (class 0 OID 0)
-- Dependencies: 30
-- Name: FUNCTION med_modificar_paciente(character varying[]); Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON FUNCTION med_modificar_paciente(character varying[]) IS '
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


--
-- TOC entry 31 (class 1255 OID 32425)
-- Dependencies: 7 479
-- Name: med_muestra_clinica_paciente(character varying[]); Type: FUNCTION; Schema: public; Owner: desarrollo_g
--

CREATE FUNCTION med_muestra_clinica_paciente(character varying[]) RETURNS smallint
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


ALTER FUNCTION public.med_muestra_clinica_paciente(character varying[]) OWNER TO desarrollo_g;

--
-- TOC entry 2391 (class 0 OID 0)
-- Dependencies: 31
-- Name: FUNCTION med_muestra_clinica_paciente(character varying[]); Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON FUNCTION med_muestra_clinica_paciente(character varying[]) IS '
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


--
-- TOC entry 33 (class 1255 OID 32426)
-- Dependencies: 479 7
-- Name: med_registrar_hitorial_paciente(character varying[]); Type: FUNCTION; Schema: public; Owner: desarrollo_g
--

CREATE FUNCTION med_registrar_hitorial_paciente(character varying[]) RETURNS smallint
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
		pag_his,
		id_doc	
	)
	VALUES 
	(
		_id_pac,	
		_des_his, 	
		_des_adi_pac_his,		
		(SELECT COUNT(id_his) FROM historiales_pacientes WHERE id_pac = _id_pac)+1,
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


ALTER FUNCTION public.med_registrar_hitorial_paciente(character varying[]) OWNER TO desarrollo_g;

--
-- TOC entry 2392 (class 0 OID 0)
-- Dependencies: 33
-- Name: FUNCTION med_registrar_hitorial_paciente(character varying[]); Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON FUNCTION med_registrar_hitorial_paciente(character varying[]) IS '
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
	SELECT med_registrar_hitorial_paciente(ARRAY[ ''7'', ''lkhlkjh'', ''jhgfjgf'', ''6'',''RHP'' ]) AS result

AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 26/06/2011

AUTOR DE MODIFICACIÓN: Lisseth Lozada
FECHA DE MODIFICACIÓN: 17/08/2011
DESCRIPCIÓN: Se agregó en la función el armado del xml para la inserción de la auditoría de las transacciones.
';


--
-- TOC entry 34 (class 1255 OID 32427)
-- Dependencies: 479 7
-- Name: med_registrar_informacion_adicional(character varying[]); Type: FUNCTION; Schema: public; Owner: desarrollo_g
--

CREATE FUNCTION med_registrar_informacion_adicional(character varying[]) RETURNS smallint
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


ALTER FUNCTION public.med_registrar_informacion_adicional(character varying[]) OWNER TO desarrollo_g;

--
-- TOC entry 2393 (class 0 OID 0)
-- Dependencies: 34
-- Name: FUNCTION med_registrar_informacion_adicional(character varying[]); Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON FUNCTION med_registrar_informacion_adicional(character varying[]) IS '
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


--
-- TOC entry 35 (class 1255 OID 32429)
-- Dependencies: 479 7
-- Name: med_registrar_paciente(character varying[]); Type: FUNCTION; Schema: public; Owner: desarrollo_g
--

CREATE FUNCTION med_registrar_paciente(character varying[]) RETURNS smallint
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


ALTER FUNCTION public.med_registrar_paciente(character varying[]) OWNER TO desarrollo_g;

--
-- TOC entry 2394 (class 0 OID 0)
-- Dependencies: 35
-- Name: FUNCTION med_registrar_paciente(character varying[]); Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON FUNCTION med_registrar_paciente(character varying[]) IS '
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


--
-- TOC entry 36 (class 1255 OID 32431)
-- Dependencies: 7 479
-- Name: reg_transacciones(character varying[]); Type: FUNCTION; Schema: public; Owner: desarrollo_g
--

CREATE FUNCTION reg_transacciones(character varying[]) RETURNS void
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


ALTER FUNCTION public.reg_transacciones(character varying[]) OWNER TO desarrollo_g;

--
-- TOC entry 2395 (class 0 OID 0)
-- Dependencies: 36
-- Name: FUNCTION reg_transacciones(character varying[]); Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON FUNCTION reg_transacciones(character varying[]) IS '
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


--
-- TOC entry 37 (class 1255 OID 32432)
-- Dependencies: 326 479 7
-- Name: validar_usuarios(text, text, text); Type: FUNCTION; Schema: public; Owner: desarrollo_g
--

CREATE FUNCTION validar_usuarios(_log_usu text, _pas_usu text, _tip_usu text) RETURNS SETOF t_validar_usuarios
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


ALTER FUNCTION public.validar_usuarios(_log_usu text, _pas_usu text, _tip_usu text) OWNER TO desarrollo_g;

--
-- TOC entry 2396 (class 0 OID 0)
-- Dependencies: 37
-- Name: FUNCTION validar_usuarios(_log_usu text, _pas_usu text, _tip_usu text); Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON FUNCTION validar_usuarios(_log_usu text, _pas_usu text, _tip_usu text) IS '
NOMBRE: validar_usuarios
TIPO: Function (store procedure)
PARAMETROS: 
	1:  Nombre de la empresa 
	2:  Login de la empresa
	3:  Password de seguridad

EJEMPLO: SELECT str_mods FROM validar_usuarios(''hitokiri83'',''123'',''adm'');

';


SET default_tablespace = saib;

SET default_with_oids = false;

--
-- TOC entry 1672 (class 1259 OID 32433)
-- Dependencies: 7
-- Name: animales; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE animales (
    id_ani integer NOT NULL,
    nom_ani character varying(20)
);


ALTER TABLE public.animales OWNER TO desarrollo_g;

--
-- TOC entry 1673 (class 1259 OID 32436)
-- Dependencies: 7 1672
-- Name: animales_id_ani_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE animales_id_ani_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.animales_id_ani_seq OWNER TO desarrollo_g;

--
-- TOC entry 2397 (class 0 OID 0)
-- Dependencies: 1673
-- Name: animales_id_ani_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE animales_id_ani_seq OWNED BY animales.id_ani;


--
-- TOC entry 2398 (class 0 OID 0)
-- Dependencies: 1673
-- Name: animales_id_ani_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('animales_id_ani_seq', 1, false);


--
-- TOC entry 1674 (class 1259 OID 32438)
-- Dependencies: 7
-- Name: antecedentes_pacientes; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE antecedentes_pacientes (
    id_ant_pac integer NOT NULL,
    id_ant_per integer NOT NULL,
    id_pac integer
);


ALTER TABLE public.antecedentes_pacientes OWNER TO desarrollo_g;

--
-- TOC entry 1675 (class 1259 OID 32441)
-- Dependencies: 7 1674
-- Name: antecedentes_pacientes_id_ant_pac_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE antecedentes_pacientes_id_ant_pac_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.antecedentes_pacientes_id_ant_pac_seq OWNER TO desarrollo_g;

--
-- TOC entry 2399 (class 0 OID 0)
-- Dependencies: 1675
-- Name: antecedentes_pacientes_id_ant_pac_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE antecedentes_pacientes_id_ant_pac_seq OWNED BY antecedentes_pacientes.id_ant_pac;


--
-- TOC entry 2400 (class 0 OID 0)
-- Dependencies: 1675
-- Name: antecedentes_pacientes_id_ant_pac_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('antecedentes_pacientes_id_ant_pac_seq', 101, true);


--
-- TOC entry 1676 (class 1259 OID 32443)
-- Dependencies: 7
-- Name: antecedentes_personales; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE antecedentes_personales (
    id_ant_per integer NOT NULL,
    nom_ant_per character varying(100)
);


ALTER TABLE public.antecedentes_personales OWNER TO desarrollo_g;

--
-- TOC entry 1677 (class 1259 OID 32446)
-- Dependencies: 1676 7
-- Name: antecedentes_personales_id_ant_per_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE antecedentes_personales_id_ant_per_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.antecedentes_personales_id_ant_per_seq OWNER TO desarrollo_g;

--
-- TOC entry 2401 (class 0 OID 0)
-- Dependencies: 1677
-- Name: antecedentes_personales_id_ant_per_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE antecedentes_personales_id_ant_per_seq OWNED BY antecedentes_personales.id_ant_per;


--
-- TOC entry 2402 (class 0 OID 0)
-- Dependencies: 1677
-- Name: antecedentes_personales_id_ant_per_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('antecedentes_personales_id_ant_per_seq', 1, false);


--
-- TOC entry 1678 (class 1259 OID 32448)
-- Dependencies: 7
-- Name: auditoria_transacciones; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE auditoria_transacciones (
    id_aud_tra integer NOT NULL,
    fec_aud_tra timestamp without time zone,
    id_tip_usu_usu integer NOT NULL,
    id_tip_tra integer NOT NULL,
    data_xml xml
);


ALTER TABLE public.auditoria_transacciones OWNER TO desarrollo_g;

--
-- TOC entry 2403 (class 0 OID 0)
-- Dependencies: 1678
-- Name: TABLE auditoria_transacciones; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON TABLE auditoria_transacciones IS 'Se guarda todos los eventos generados por los usuarios';


--
-- TOC entry 2404 (class 0 OID 0)
-- Dependencies: 1678
-- Name: COLUMN auditoria_transacciones.data_xml; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN auditoria_transacciones.data_xml IS 'Se guarda las modificaciones de la tabla y atributos realizada por los usuarios, todo en forma de XML';


--
-- TOC entry 1679 (class 1259 OID 32454)
-- Dependencies: 1678 7
-- Name: auditoria_transacciones_id_aud_tra_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE auditoria_transacciones_id_aud_tra_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auditoria_transacciones_id_aud_tra_seq OWNER TO desarrollo_g;

--
-- TOC entry 2405 (class 0 OID 0)
-- Dependencies: 1679
-- Name: auditoria_transacciones_id_aud_tra_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE auditoria_transacciones_id_aud_tra_seq OWNED BY auditoria_transacciones.id_aud_tra;


--
-- TOC entry 2406 (class 0 OID 0)
-- Dependencies: 1679
-- Name: auditoria_transacciones_id_aud_tra_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('auditoria_transacciones_id_aud_tra_seq', 169, true);


--
-- TOC entry 1680 (class 1259 OID 32456)
-- Dependencies: 7
-- Name: categorias__cuerpos_micosis; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE categorias__cuerpos_micosis (
    id_cat_cue_mic integer NOT NULL,
    id_cat_cue integer NOT NULL,
    id_tip_mic integer NOT NULL
);


ALTER TABLE public.categorias__cuerpos_micosis OWNER TO desarrollo_g;

--
-- TOC entry 1681 (class 1259 OID 32459)
-- Dependencies: 1680 7
-- Name: categorias__cuerpos_micosis_id_cat_cue_mic_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE categorias__cuerpos_micosis_id_cat_cue_mic_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categorias__cuerpos_micosis_id_cat_cue_mic_seq OWNER TO desarrollo_g;

--
-- TOC entry 2407 (class 0 OID 0)
-- Dependencies: 1681
-- Name: categorias__cuerpos_micosis_id_cat_cue_mic_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE categorias__cuerpos_micosis_id_cat_cue_mic_seq OWNED BY categorias__cuerpos_micosis.id_cat_cue_mic;


--
-- TOC entry 2408 (class 0 OID 0)
-- Dependencies: 1681
-- Name: categorias__cuerpos_micosis_id_cat_cue_mic_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('categorias__cuerpos_micosis_id_cat_cue_mic_seq', 17, true);


--
-- TOC entry 1682 (class 1259 OID 32461)
-- Dependencies: 7
-- Name: categorias_cuerpos; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE categorias_cuerpos (
    id_cat_cue integer NOT NULL,
    nom_cat_cue character varying(20)
);


ALTER TABLE public.categorias_cuerpos OWNER TO desarrollo_g;

--
-- TOC entry 1683 (class 1259 OID 32464)
-- Dependencies: 7
-- Name: categorias_cuerpos__lesiones; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE categorias_cuerpos__lesiones (
    id_cat_cue_les integer NOT NULL,
    id_les integer,
    id_cat_cue integer
);


ALTER TABLE public.categorias_cuerpos__lesiones OWNER TO desarrollo_g;

--
-- TOC entry 1684 (class 1259 OID 32467)
-- Dependencies: 1682 7
-- Name: categorias_cuerpos_id_cat_cue_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE categorias_cuerpos_id_cat_cue_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categorias_cuerpos_id_cat_cue_seq OWNER TO desarrollo_g;

--
-- TOC entry 2409 (class 0 OID 0)
-- Dependencies: 1684
-- Name: categorias_cuerpos_id_cat_cue_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE categorias_cuerpos_id_cat_cue_seq OWNED BY categorias_cuerpos.id_cat_cue;


--
-- TOC entry 2410 (class 0 OID 0)
-- Dependencies: 1684
-- Name: categorias_cuerpos_id_cat_cue_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('categorias_cuerpos_id_cat_cue_seq', 4, true);


SET default_tablespace = '';

--
-- TOC entry 1685 (class 1259 OID 32469)
-- Dependencies: 7
-- Name: centro_salud_doctores; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: 
--

CREATE TABLE centro_salud_doctores (
    id_cen_sal_doc integer NOT NULL,
    id_cen_sal integer NOT NULL,
    id_doc integer NOT NULL,
    otr_cen_sal character varying(100)
);


ALTER TABLE public.centro_salud_doctores OWNER TO desarrollo_g;

--
-- TOC entry 2411 (class 0 OID 0)
-- Dependencies: 1685
-- Name: COLUMN centro_salud_doctores.id_cen_sal_doc; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN centro_salud_doctores.id_cen_sal_doc IS 'Identificación del Centro de Salud del doctor';


--
-- TOC entry 2412 (class 0 OID 0)
-- Dependencies: 1685
-- Name: COLUMN centro_salud_doctores.id_cen_sal; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN centro_salud_doctores.id_cen_sal IS 'Identificación del Centro de Salud';


--
-- TOC entry 2413 (class 0 OID 0)
-- Dependencies: 1685
-- Name: COLUMN centro_salud_doctores.id_doc; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN centro_salud_doctores.id_doc IS 'Identificación del doctor';


--
-- TOC entry 2414 (class 0 OID 0)
-- Dependencies: 1685
-- Name: COLUMN centro_salud_doctores.otr_cen_sal; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN centro_salud_doctores.otr_cen_sal IS 'Otro Centro de Salud';


--
-- TOC entry 1686 (class 1259 OID 32472)
-- Dependencies: 1685 7
-- Name: centro_salud_doctores_id_cen_sal_doc_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE centro_salud_doctores_id_cen_sal_doc_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.centro_salud_doctores_id_cen_sal_doc_seq OWNER TO desarrollo_g;

--
-- TOC entry 2415 (class 0 OID 0)
-- Dependencies: 1686
-- Name: centro_salud_doctores_id_cen_sal_doc_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE centro_salud_doctores_id_cen_sal_doc_seq OWNED BY centro_salud_doctores.id_cen_sal_doc;


--
-- TOC entry 2416 (class 0 OID 0)
-- Dependencies: 1686
-- Name: centro_salud_doctores_id_cen_sal_doc_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('centro_salud_doctores_id_cen_sal_doc_seq', 15, true);


SET default_tablespace = saib;

--
-- TOC entry 1687 (class 1259 OID 32474)
-- Dependencies: 7
-- Name: centro_saluds; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE centro_saluds (
    id_cen_sal integer NOT NULL,
    nom_cen_sal character varying(100) NOT NULL,
    des_cen_sal character varying(100)
);


ALTER TABLE public.centro_saluds OWNER TO desarrollo_g;

--
-- TOC entry 1688 (class 1259 OID 32477)
-- Dependencies: 7 1687
-- Name: centro_salud_id_cen_sal_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE centro_salud_id_cen_sal_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.centro_salud_id_cen_sal_seq OWNER TO desarrollo_g;

--
-- TOC entry 2417 (class 0 OID 0)
-- Dependencies: 1688
-- Name: centro_salud_id_cen_sal_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE centro_salud_id_cen_sal_seq OWNED BY centro_saluds.id_cen_sal;


--
-- TOC entry 2418 (class 0 OID 0)
-- Dependencies: 1688
-- Name: centro_salud_id_cen_sal_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('centro_salud_id_cen_sal_seq', 35, true);


--
-- TOC entry 1689 (class 1259 OID 32479)
-- Dependencies: 7
-- Name: centro_salud_pacientes; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE centro_salud_pacientes (
    id_cen_sal_pac integer NOT NULL,
    id_his integer NOT NULL,
    id_cen_sal integer NOT NULL,
    otr_cen_sal character varying(100)
);


ALTER TABLE public.centro_salud_pacientes OWNER TO desarrollo_g;

--
-- TOC entry 1690 (class 1259 OID 32482)
-- Dependencies: 7 1689
-- Name: centro_salud_pacientes_id_cen_sal_pac_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE centro_salud_pacientes_id_cen_sal_pac_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.centro_salud_pacientes_id_cen_sal_pac_seq OWNER TO desarrollo_g;

--
-- TOC entry 2419 (class 0 OID 0)
-- Dependencies: 1690
-- Name: centro_salud_pacientes_id_cen_sal_pac_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE centro_salud_pacientes_id_cen_sal_pac_seq OWNED BY centro_salud_pacientes.id_cen_sal_pac;


--
-- TOC entry 2420 (class 0 OID 0)
-- Dependencies: 1690
-- Name: centro_salud_pacientes_id_cen_sal_pac_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('centro_salud_pacientes_id_cen_sal_pac_seq', 228, true);


--
-- TOC entry 1691 (class 1259 OID 32484)
-- Dependencies: 7
-- Name: contactos_animales; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE contactos_animales (
    id_con_ani integer NOT NULL,
    id_his integer NOT NULL,
    id_ani integer NOT NULL,
    otr_ani character varying(100)
);


ALTER TABLE public.contactos_animales OWNER TO desarrollo_g;

--
-- TOC entry 1692 (class 1259 OID 32487)
-- Dependencies: 1691 7
-- Name: contactos_animales_id_con_ani_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE contactos_animales_id_con_ani_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contactos_animales_id_con_ani_seq OWNER TO desarrollo_g;

--
-- TOC entry 2421 (class 0 OID 0)
-- Dependencies: 1692
-- Name: contactos_animales_id_con_ani_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE contactos_animales_id_con_ani_seq OWNED BY contactos_animales.id_con_ani;


--
-- TOC entry 2422 (class 0 OID 0)
-- Dependencies: 1692
-- Name: contactos_animales_id_con_ani_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('contactos_animales_id_con_ani_seq', 181, true);


--
-- TOC entry 1693 (class 1259 OID 32489)
-- Dependencies: 2059 7
-- Name: doctores; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE doctores (
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


ALTER TABLE public.doctores OWNER TO desarrollo_g;

--
-- TOC entry 2423 (class 0 OID 0)
-- Dependencies: 1693
-- Name: TABLE doctores; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON TABLE doctores IS 'Registro de todos los doctores que del aplicativo';


--
-- TOC entry 2424 (class 0 OID 0)
-- Dependencies: 1693
-- Name: COLUMN doctores.id_doc; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN doctores.id_doc IS 'identificador único para los doctores';


--
-- TOC entry 2425 (class 0 OID 0)
-- Dependencies: 1693
-- Name: COLUMN doctores.nom_doc; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN doctores.nom_doc IS 'Nombre del doctor';


--
-- TOC entry 2426 (class 0 OID 0)
-- Dependencies: 1693
-- Name: COLUMN doctores.ape_doc; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN doctores.ape_doc IS 'Apellido del doctor';


--
-- TOC entry 2427 (class 0 OID 0)
-- Dependencies: 1693
-- Name: COLUMN doctores.ced_doc; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN doctores.ced_doc IS 'Cédula del doctor';


--
-- TOC entry 2428 (class 0 OID 0)
-- Dependencies: 1693
-- Name: COLUMN doctores.pas_doc; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN doctores.pas_doc IS 'Contraseña del doctor';


--
-- TOC entry 2429 (class 0 OID 0)
-- Dependencies: 1693
-- Name: COLUMN doctores.tel_doc; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN doctores.tel_doc IS 'Teléfono del doctor';


--
-- TOC entry 2430 (class 0 OID 0)
-- Dependencies: 1693
-- Name: COLUMN doctores.cor_doc; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN doctores.cor_doc IS 'Correo electronico del doctor';


--
-- TOC entry 2431 (class 0 OID 0)
-- Dependencies: 1693
-- Name: COLUMN doctores.log_doc; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN doctores.log_doc IS 'Login con el que se loguara el doctor';


--
-- TOC entry 1694 (class 1259 OID 32496)
-- Dependencies: 7 1693
-- Name: doctores_id_doc_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE doctores_id_doc_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.doctores_id_doc_seq OWNER TO desarrollo_g;

--
-- TOC entry 2432 (class 0 OID 0)
-- Dependencies: 1694
-- Name: doctores_id_doc_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE doctores_id_doc_seq OWNED BY doctores.id_doc;


--
-- TOC entry 2433 (class 0 OID 0)
-- Dependencies: 1694
-- Name: doctores_id_doc_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('doctores_id_doc_seq', 35, true);


--
-- TOC entry 1695 (class 1259 OID 32498)
-- Dependencies: 7
-- Name: enfermedades_micologicas; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE enfermedades_micologicas (
    id_enf_mic integer NOT NULL,
    nom_enf_mic character varying(100) NOT NULL,
    id_tip_mic integer NOT NULL
);


ALTER TABLE public.enfermedades_micologicas OWNER TO desarrollo_g;

--
-- TOC entry 1696 (class 1259 OID 32501)
-- Dependencies: 1695 7
-- Name: enfermedades_micologicas_id_enf_mic_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE enfermedades_micologicas_id_enf_mic_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.enfermedades_micologicas_id_enf_mic_seq OWNER TO desarrollo_g;

--
-- TOC entry 2434 (class 0 OID 0)
-- Dependencies: 1696
-- Name: enfermedades_micologicas_id_enf_mic_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE enfermedades_micologicas_id_enf_mic_seq OWNED BY enfermedades_micologicas.id_enf_mic;


--
-- TOC entry 2435 (class 0 OID 0)
-- Dependencies: 1696
-- Name: enfermedades_micologicas_id_enf_mic_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('enfermedades_micologicas_id_enf_mic_seq', 28, true);


--
-- TOC entry 1697 (class 1259 OID 32503)
-- Dependencies: 7
-- Name: enfermedades_pacientes; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE enfermedades_pacientes (
    id_enf_pac integer NOT NULL,
    id_enf_mic integer NOT NULL,
    otr_enf_mic character varying(100),
    esp_enf_mic character varying(20),
    id_tip_mic_pac integer
);


ALTER TABLE public.enfermedades_pacientes OWNER TO desarrollo_g;

--
-- TOC entry 1698 (class 1259 OID 32506)
-- Dependencies: 7 1697
-- Name: enfermedades_pacientes_id_enf_pac_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE enfermedades_pacientes_id_enf_pac_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.enfermedades_pacientes_id_enf_pac_seq OWNER TO desarrollo_g;

--
-- TOC entry 2436 (class 0 OID 0)
-- Dependencies: 1698
-- Name: enfermedades_pacientes_id_enf_pac_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE enfermedades_pacientes_id_enf_pac_seq OWNED BY enfermedades_pacientes.id_enf_pac;


--
-- TOC entry 2437 (class 0 OID 0)
-- Dependencies: 1698
-- Name: enfermedades_pacientes_id_enf_pac_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('enfermedades_pacientes_id_enf_pac_seq', 454, true);


SET default_tablespace = '';

--
-- TOC entry 1699 (class 1259 OID 32508)
-- Dependencies: 7
-- Name: estados; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: 
--

CREATE TABLE estados (
    id_est integer NOT NULL,
    des_est character varying(100),
    id_pai integer
);


ALTER TABLE public.estados OWNER TO desarrollo_g;

--
-- TOC entry 1700 (class 1259 OID 32511)
-- Dependencies: 1699 7
-- Name: estados_id_est_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE estados_id_est_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.estados_id_est_seq OWNER TO desarrollo_g;

--
-- TOC entry 2438 (class 0 OID 0)
-- Dependencies: 1700
-- Name: estados_id_est_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE estados_id_est_seq OWNED BY estados.id_est;


--
-- TOC entry 2439 (class 0 OID 0)
-- Dependencies: 1700
-- Name: estados_id_est_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('estados_id_est_seq', 6, true);


SET default_tablespace = saib;

--
-- TOC entry 1701 (class 1259 OID 32513)
-- Dependencies: 7
-- Name: examenes_pacientes; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE examenes_pacientes (
    id_exa_pac integer NOT NULL,
    id_tip_mic_pac integer,
    exa_pac_est integer,
    id_tip_exa integer
);


ALTER TABLE public.examenes_pacientes OWNER TO desarrollo_g;

--
-- TOC entry 2440 (class 0 OID 0)
-- Dependencies: 1701
-- Name: TABLE examenes_pacientes; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON TABLE examenes_pacientes IS 'Muestra el estado de una enfermedad del paciente';


--
-- TOC entry 2441 (class 0 OID 0)
-- Dependencies: 1701
-- Name: COLUMN examenes_pacientes.exa_pac_est; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN examenes_pacientes.exa_pac_est IS 'Muestra el estado de una enfermedad del paciente 0 si es negativo 1 si es positivo';


--
-- TOC entry 1702 (class 1259 OID 32516)
-- Dependencies: 1701 7
-- Name: examenes_pacientes_id_exa_pac_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE examenes_pacientes_id_exa_pac_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.examenes_pacientes_id_exa_pac_seq OWNER TO desarrollo_g;

--
-- TOC entry 2442 (class 0 OID 0)
-- Dependencies: 1702
-- Name: examenes_pacientes_id_exa_pac_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE examenes_pacientes_id_exa_pac_seq OWNED BY examenes_pacientes.id_exa_pac;


--
-- TOC entry 2443 (class 0 OID 0)
-- Dependencies: 1702
-- Name: examenes_pacientes_id_exa_pac_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('examenes_pacientes_id_exa_pac_seq', 64, true);


--
-- TOC entry 1703 (class 1259 OID 32518)
-- Dependencies: 7
-- Name: forma_infecciones; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE forma_infecciones (
    id_for_inf integer NOT NULL,
    des_for_inf character varying(255)
);


ALTER TABLE public.forma_infecciones OWNER TO desarrollo_g;

--
-- TOC entry 1704 (class 1259 OID 32521)
-- Dependencies: 7
-- Name: forma_infecciones__pacientes; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE forma_infecciones__pacientes (
    id_for_pac integer NOT NULL,
    id_for_inf integer NOT NULL,
    otr_for_inf character varying(100),
    id_tip_mic_pac integer
);


ALTER TABLE public.forma_infecciones__pacientes OWNER TO desarrollo_g;

--
-- TOC entry 1705 (class 1259 OID 32524)
-- Dependencies: 7 1704
-- Name: forma_infecciones__pacientes_id_for_pac_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE forma_infecciones__pacientes_id_for_pac_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.forma_infecciones__pacientes_id_for_pac_seq OWNER TO desarrollo_g;

--
-- TOC entry 2444 (class 0 OID 0)
-- Dependencies: 1705
-- Name: forma_infecciones__pacientes_id_for_pac_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE forma_infecciones__pacientes_id_for_pac_seq OWNED BY forma_infecciones__pacientes.id_for_pac;


--
-- TOC entry 2445 (class 0 OID 0)
-- Dependencies: 1705
-- Name: forma_infecciones__pacientes_id_for_pac_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('forma_infecciones__pacientes_id_for_pac_seq', 77, true);


--
-- TOC entry 1706 (class 1259 OID 32526)
-- Dependencies: 7
-- Name: forma_infecciones__tipos_micosis; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE forma_infecciones__tipos_micosis (
    id_for_inf_tip_mic integer NOT NULL,
    id_tip_mic integer NOT NULL,
    id_for_inf integer NOT NULL
);


ALTER TABLE public.forma_infecciones__tipos_micosis OWNER TO desarrollo_g;

--
-- TOC entry 1707 (class 1259 OID 32529)
-- Dependencies: 1706 7
-- Name: forma_infecciones__tipos_micosis_id_for_inf_tip_mic_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE forma_infecciones__tipos_micosis_id_for_inf_tip_mic_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.forma_infecciones__tipos_micosis_id_for_inf_tip_mic_seq OWNER TO desarrollo_g;

--
-- TOC entry 2446 (class 0 OID 0)
-- Dependencies: 1707
-- Name: forma_infecciones__tipos_micosis_id_for_inf_tip_mic_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE forma_infecciones__tipos_micosis_id_for_inf_tip_mic_seq OWNED BY forma_infecciones__tipos_micosis.id_for_inf_tip_mic;


--
-- TOC entry 2447 (class 0 OID 0)
-- Dependencies: 1707
-- Name: forma_infecciones__tipos_micosis_id_for_inf_tip_mic_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('forma_infecciones__tipos_micosis_id_for_inf_tip_mic_seq', 21, true);


--
-- TOC entry 1708 (class 1259 OID 32531)
-- Dependencies: 7 1703
-- Name: forma_infecciones_id_for_inf_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE forma_infecciones_id_for_inf_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.forma_infecciones_id_for_inf_seq OWNER TO desarrollo_g;

--
-- TOC entry 2448 (class 0 OID 0)
-- Dependencies: 1708
-- Name: forma_infecciones_id_for_inf_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE forma_infecciones_id_for_inf_seq OWNED BY forma_infecciones.id_for_inf;


--
-- TOC entry 2449 (class 0 OID 0)
-- Dependencies: 1708
-- Name: forma_infecciones_id_for_inf_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('forma_infecciones_id_for_inf_seq', 12, true);


--
-- TOC entry 1709 (class 1259 OID 32533)
-- Dependencies: 2068 2069 7
-- Name: historiales_pacientes; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE historiales_pacientes (
    id_his integer NOT NULL,
    id_pac integer NOT NULL,
    des_his character varying(255),
    id_doc integer,
    des_adi_pac_his character varying(255),
    fec_his timestamp with time zone DEFAULT now(),
    pag_his numeric DEFAULT 0
);


ALTER TABLE public.historiales_pacientes OWNER TO desarrollo_g;

--
-- TOC entry 2450 (class 0 OID 0)
-- Dependencies: 1709
-- Name: COLUMN historiales_pacientes.des_adi_pac_his; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN historiales_pacientes.des_adi_pac_his IS '
	Discripción adicional de si el paciente padece o no una enfermedad u otra cosa adicional.
';


--
-- TOC entry 2451 (class 0 OID 0)
-- Dependencies: 1709
-- Name: COLUMN historiales_pacientes.pag_his; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN historiales_pacientes.pag_his IS 'Muestra al cantidad de paginas asociadas al historial del paciente.';


--
-- TOC entry 1710 (class 1259 OID 32541)
-- Dependencies: 7 1709
-- Name: historiales_pacientes_id_his_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE historiales_pacientes_id_his_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.historiales_pacientes_id_his_seq OWNER TO desarrollo_g;

--
-- TOC entry 2452 (class 0 OID 0)
-- Dependencies: 1710
-- Name: historiales_pacientes_id_his_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE historiales_pacientes_id_his_seq OWNED BY historiales_pacientes.id_his;


--
-- TOC entry 2453 (class 0 OID 0)
-- Dependencies: 1710
-- Name: historiales_pacientes_id_his_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('historiales_pacientes_id_his_seq', 27, true);


SET default_tablespace = '';

--
-- TOC entry 1711 (class 1259 OID 32543)
-- Dependencies: 7
-- Name: lesiones; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: 
--

CREATE TABLE lesiones (
    id_les integer NOT NULL,
    nom_les character varying(100)
);


ALTER TABLE public.lesiones OWNER TO desarrollo_g;

--
-- TOC entry 1712 (class 1259 OID 32546)
-- Dependencies: 7 1683
-- Name: lesiones__partes_cuerpos_id_les_par_cue_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE lesiones__partes_cuerpos_id_les_par_cue_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lesiones__partes_cuerpos_id_les_par_cue_seq OWNER TO desarrollo_g;

--
-- TOC entry 2454 (class 0 OID 0)
-- Dependencies: 1712
-- Name: lesiones__partes_cuerpos_id_les_par_cue_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE lesiones__partes_cuerpos_id_les_par_cue_seq OWNED BY categorias_cuerpos__lesiones.id_cat_cue_les;


--
-- TOC entry 2455 (class 0 OID 0)
-- Dependencies: 1712
-- Name: lesiones__partes_cuerpos_id_les_par_cue_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('lesiones__partes_cuerpos_id_les_par_cue_seq', 115, true);


--
-- TOC entry 1713 (class 1259 OID 32548)
-- Dependencies: 7 1711
-- Name: lesiones_id_les_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE lesiones_id_les_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lesiones_id_les_seq OWNER TO desarrollo_g;

--
-- TOC entry 2456 (class 0 OID 0)
-- Dependencies: 1713
-- Name: lesiones_id_les_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE lesiones_id_les_seq OWNED BY lesiones.id_les;


--
-- TOC entry 2457 (class 0 OID 0)
-- Dependencies: 1713
-- Name: lesiones_id_les_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('lesiones_id_les_seq', 71, true);


SET default_tablespace = saib;

--
-- TOC entry 1714 (class 1259 OID 32550)
-- Dependencies: 7
-- Name: lesiones_partes_cuerpos__pacientes; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE lesiones_partes_cuerpos__pacientes (
    id_les_par_cue_pac integer NOT NULL,
    otr_les_par_cue character varying(100),
    id_cat_cue_les integer,
    id_par_cue_cat_cue integer,
    id_tip_mic_pac integer
);


ALTER TABLE public.lesiones_partes_cuerpos__pacientes OWNER TO desarrollo_g;

--
-- TOC entry 2458 (class 0 OID 0)
-- Dependencies: 1714
-- Name: COLUMN lesiones_partes_cuerpos__pacientes.id_les_par_cue_pac; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN lesiones_partes_cuerpos__pacientes.id_les_par_cue_pac IS 'Leciones parted del cuerpo paciente';


--
-- TOC entry 2459 (class 0 OID 0)
-- Dependencies: 1714
-- Name: COLUMN lesiones_partes_cuerpos__pacientes.otr_les_par_cue; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN lesiones_partes_cuerpos__pacientes.otr_les_par_cue IS 'Otras leciones de la parte del cuerpo del paciente';


--
-- TOC entry 1715 (class 1259 OID 32553)
-- Dependencies: 1714 7
-- Name: lesiones_partes_cuerpos__pacientes_id_les_par_cue_pac_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE lesiones_partes_cuerpos__pacientes_id_les_par_cue_pac_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lesiones_partes_cuerpos__pacientes_id_les_par_cue_pac_seq OWNER TO desarrollo_g;

--
-- TOC entry 2460 (class 0 OID 0)
-- Dependencies: 1715
-- Name: lesiones_partes_cuerpos__pacientes_id_les_par_cue_pac_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE lesiones_partes_cuerpos__pacientes_id_les_par_cue_pac_seq OWNED BY lesiones_partes_cuerpos__pacientes.id_les_par_cue_pac;


--
-- TOC entry 2461 (class 0 OID 0)
-- Dependencies: 1715
-- Name: lesiones_partes_cuerpos__pacientes_id_les_par_cue_pac_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('lesiones_partes_cuerpos__pacientes_id_les_par_cue_pac_seq', 374, true);


--
-- TOC entry 1716 (class 1259 OID 32555)
-- Dependencies: 7
-- Name: localizaciones_cuerpos; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE localizaciones_cuerpos (
    id_loc_cue integer NOT NULL,
    nom_loc_cue character varying(20) NOT NULL,
    id_par_cue integer
);


ALTER TABLE public.localizaciones_cuerpos OWNER TO desarrollo_g;

--
-- TOC entry 1717 (class 1259 OID 32558)
-- Dependencies: 7 1716
-- Name: localizaciones_cuerpos_id_loc_cue_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE localizaciones_cuerpos_id_loc_cue_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.localizaciones_cuerpos_id_loc_cue_seq OWNER TO desarrollo_g;

--
-- TOC entry 2462 (class 0 OID 0)
-- Dependencies: 1717
-- Name: localizaciones_cuerpos_id_loc_cue_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE localizaciones_cuerpos_id_loc_cue_seq OWNED BY localizaciones_cuerpos.id_loc_cue;


--
-- TOC entry 2463 (class 0 OID 0)
-- Dependencies: 1717
-- Name: localizaciones_cuerpos_id_loc_cue_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('localizaciones_cuerpos_id_loc_cue_seq', 1, false);


--
-- TOC entry 1718 (class 1259 OID 32560)
-- Dependencies: 7
-- Name: modulos; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE modulos (
    id_mod integer NOT NULL,
    cod_mod character varying(3),
    des_mod character varying(100),
    id_tip_usu integer
);


ALTER TABLE public.modulos OWNER TO desarrollo_g;

--
-- TOC entry 1719 (class 1259 OID 32563)
-- Dependencies: 7 1718
-- Name: modulos_id_mod_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE modulos_id_mod_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.modulos_id_mod_seq OWNER TO desarrollo_g;

--
-- TOC entry 2464 (class 0 OID 0)
-- Dependencies: 1719
-- Name: modulos_id_mod_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE modulos_id_mod_seq OWNED BY modulos.id_mod;


--
-- TOC entry 2465 (class 0 OID 0)
-- Dependencies: 1719
-- Name: modulos_id_mod_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('modulos_id_mod_seq', 2, true);


--
-- TOC entry 1720 (class 1259 OID 32565)
-- Dependencies: 7
-- Name: muestras_clinicas; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE muestras_clinicas (
    id_mue_cli integer NOT NULL,
    nom_mue_cli character varying(100) NOT NULL
);


ALTER TABLE public.muestras_clinicas OWNER TO desarrollo_g;

--
-- TOC entry 2466 (class 0 OID 0)
-- Dependencies: 1720
-- Name: COLUMN muestras_clinicas.id_mue_cli; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN muestras_clinicas.id_mue_cli IS 'Identificacion de la muestra clinica';


--
-- TOC entry 2467 (class 0 OID 0)
-- Dependencies: 1720
-- Name: COLUMN muestras_clinicas.nom_mue_cli; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN muestras_clinicas.nom_mue_cli IS 'Nombre muestra clinica';


--
-- TOC entry 1721 (class 1259 OID 32568)
-- Dependencies: 7 1720
-- Name: muestras_clinicas_id_mue_cli_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE muestras_clinicas_id_mue_cli_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.muestras_clinicas_id_mue_cli_seq OWNER TO desarrollo_g;

--
-- TOC entry 2468 (class 0 OID 0)
-- Dependencies: 1721
-- Name: muestras_clinicas_id_mue_cli_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE muestras_clinicas_id_mue_cli_seq OWNED BY muestras_clinicas.id_mue_cli;


--
-- TOC entry 2469 (class 0 OID 0)
-- Dependencies: 1721
-- Name: muestras_clinicas_id_mue_cli_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('muestras_clinicas_id_mue_cli_seq', 1, false);


--
-- TOC entry 1722 (class 1259 OID 32570)
-- Dependencies: 7
-- Name: muestras_pacientes; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE muestras_pacientes (
    id_mue_pac integer NOT NULL,
    id_his integer NOT NULL,
    id_mue_cli integer NOT NULL,
    otr_mue_cli character varying(100)
);


ALTER TABLE public.muestras_pacientes OWNER TO desarrollo_g;

--
-- TOC entry 2470 (class 0 OID 0)
-- Dependencies: 1722
-- Name: COLUMN muestras_pacientes.id_mue_pac; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN muestras_pacientes.id_mue_pac IS 'Id de la meustra del paciente';


--
-- TOC entry 2471 (class 0 OID 0)
-- Dependencies: 1722
-- Name: COLUMN muestras_pacientes.id_his; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN muestras_pacientes.id_his IS 'Id del historial';


--
-- TOC entry 2472 (class 0 OID 0)
-- Dependencies: 1722
-- Name: COLUMN muestras_pacientes.id_mue_cli; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN muestras_pacientes.id_mue_cli IS 'Id muestra cli';


--
-- TOC entry 2473 (class 0 OID 0)
-- Dependencies: 1722
-- Name: COLUMN muestras_pacientes.otr_mue_cli; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN muestras_pacientes.otr_mue_cli IS 'Otra meustra clinica';


--
-- TOC entry 1723 (class 1259 OID 32573)
-- Dependencies: 7 1722
-- Name: muestras_pacientes_id_mue_pac_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE muestras_pacientes_id_mue_pac_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.muestras_pacientes_id_mue_pac_seq OWNER TO desarrollo_g;

--
-- TOC entry 2474 (class 0 OID 0)
-- Dependencies: 1723
-- Name: muestras_pacientes_id_mue_pac_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE muestras_pacientes_id_mue_pac_seq OWNED BY muestras_pacientes.id_mue_pac;


--
-- TOC entry 2475 (class 0 OID 0)
-- Dependencies: 1723
-- Name: muestras_pacientes_id_mue_pac_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('muestras_pacientes_id_mue_pac_seq', 119, true);


SET default_tablespace = '';

--
-- TOC entry 1724 (class 1259 OID 32575)
-- Dependencies: 7
-- Name: municipios; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: 
--

CREATE TABLE municipios (
    id_mun integer NOT NULL,
    des_mun character varying(100),
    id_est integer
);


ALTER TABLE public.municipios OWNER TO desarrollo_g;

--
-- TOC entry 1725 (class 1259 OID 32578)
-- Dependencies: 7 1724
-- Name: municipios_id_mun_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE municipios_id_mun_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.municipios_id_mun_seq OWNER TO desarrollo_g;

--
-- TOC entry 2476 (class 0 OID 0)
-- Dependencies: 1725
-- Name: municipios_id_mun_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE municipios_id_mun_seq OWNED BY municipios.id_mun;


--
-- TOC entry 2477 (class 0 OID 0)
-- Dependencies: 1725
-- Name: municipios_id_mun_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('municipios_id_mun_seq', 335, true);


SET default_tablespace = saib;

--
-- TOC entry 1726 (class 1259 OID 32580)
-- Dependencies: 2078 7
-- Name: pacientes; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE pacientes (
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


ALTER TABLE public.pacientes OWNER TO desarrollo_g;

--
-- TOC entry 2478 (class 0 OID 0)
-- Dependencies: 1726
-- Name: COLUMN pacientes.id_pac; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN pacientes.id_pac IS 'Id paciente';


--
-- TOC entry 2479 (class 0 OID 0)
-- Dependencies: 1726
-- Name: COLUMN pacientes.ape_pac; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN pacientes.ape_pac IS 'Apellido del paciente';


--
-- TOC entry 2480 (class 0 OID 0)
-- Dependencies: 1726
-- Name: COLUMN pacientes.nom_pac; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN pacientes.nom_pac IS 'Nombre del paciente';


--
-- TOC entry 2481 (class 0 OID 0)
-- Dependencies: 1726
-- Name: COLUMN pacientes.ced_pac; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN pacientes.ced_pac IS 'Cedula del paciente';


--
-- TOC entry 2482 (class 0 OID 0)
-- Dependencies: 1726
-- Name: COLUMN pacientes.fec_nac_pac; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN pacientes.fec_nac_pac IS 'Fecha de nacimiento del paciente';


--
-- TOC entry 2483 (class 0 OID 0)
-- Dependencies: 1726
-- Name: COLUMN pacientes.nac_pac; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN pacientes.nac_pac IS 'Nacionalidad del paciente';


--
-- TOC entry 2484 (class 0 OID 0)
-- Dependencies: 1726
-- Name: COLUMN pacientes.ocu_pac; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN pacientes.ocu_pac IS 'Ocupacion del paciente';


--
-- TOC entry 2485 (class 0 OID 0)
-- Dependencies: 1726
-- Name: COLUMN pacientes.ciu_pac; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN pacientes.ciu_pac IS 'Ciudad del paciente';


--
-- TOC entry 2486 (class 0 OID 0)
-- Dependencies: 1726
-- Name: COLUMN pacientes.fec_reg_pac; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN pacientes.fec_reg_pac IS 'Fecha de registro del paciente';


--
-- TOC entry 1727 (class 1259 OID 32584)
-- Dependencies: 1726 7
-- Name: pacientes_id_pac_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE pacientes_id_pac_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pacientes_id_pac_seq OWNER TO desarrollo_g;

--
-- TOC entry 2487 (class 0 OID 0)
-- Dependencies: 1727
-- Name: pacientes_id_pac_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE pacientes_id_pac_seq OWNED BY pacientes.id_pac;


--
-- TOC entry 2488 (class 0 OID 0)
-- Dependencies: 1727
-- Name: pacientes_id_pac_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('pacientes_id_pac_seq', 63, true);


SET default_tablespace = '';

--
-- TOC entry 1728 (class 1259 OID 32586)
-- Dependencies: 7
-- Name: paises; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: 
--

CREATE TABLE paises (
    id_pai integer NOT NULL,
    des_pai character varying(100),
    cod_pai character varying(3)
);


ALTER TABLE public.paises OWNER TO desarrollo_g;

--
-- TOC entry 1729 (class 1259 OID 32589)
-- Dependencies: 7 1728
-- Name: paises_id_pai_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE paises_id_pai_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.paises_id_pai_seq OWNER TO desarrollo_g;

--
-- TOC entry 2489 (class 0 OID 0)
-- Dependencies: 1729
-- Name: paises_id_pai_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE paises_id_pai_seq OWNED BY paises.id_pai;


--
-- TOC entry 2490 (class 0 OID 0)
-- Dependencies: 1729
-- Name: paises_id_pai_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('paises_id_pai_seq', 1, false);


--
-- TOC entry 1730 (class 1259 OID 32591)
-- Dependencies: 7
-- Name: parroquias; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: 
--

CREATE TABLE parroquias (
    id_par integer NOT NULL,
    des_par character varying(100),
    id_mun integer
);


ALTER TABLE public.parroquias OWNER TO desarrollo_g;

--
-- TOC entry 1731 (class 1259 OID 32594)
-- Dependencies: 1730 7
-- Name: parroquias_id_par_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE parroquias_id_par_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.parroquias_id_par_seq OWNER TO desarrollo_g;

--
-- TOC entry 2491 (class 0 OID 0)
-- Dependencies: 1731
-- Name: parroquias_id_par_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE parroquias_id_par_seq OWNED BY parroquias.id_par;


--
-- TOC entry 2492 (class 0 OID 0)
-- Dependencies: 1731
-- Name: parroquias_id_par_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('parroquias_id_par_seq', 1, false);


SET default_tablespace = saib;

--
-- TOC entry 1732 (class 1259 OID 32596)
-- Dependencies: 7
-- Name: partes_cuerpos; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE partes_cuerpos (
    id_par_cue integer NOT NULL,
    nom_par_cue character varying(20)
);


ALTER TABLE public.partes_cuerpos OWNER TO desarrollo_g;

SET default_tablespace = '';

--
-- TOC entry 1733 (class 1259 OID 32599)
-- Dependencies: 7
-- Name: partes_cuerpos__categorias_cuerpos; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: 
--

CREATE TABLE partes_cuerpos__categorias_cuerpos (
    id_par_cue_cat_cue integer NOT NULL,
    id_cat_cue integer NOT NULL,
    id_par_cue integer NOT NULL
);


ALTER TABLE public.partes_cuerpos__categorias_cuerpos OWNER TO desarrollo_g;

--
-- TOC entry 2493 (class 0 OID 0)
-- Dependencies: 1733
-- Name: TABLE partes_cuerpos__categorias_cuerpos; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON TABLE partes_cuerpos__categorias_cuerpos IS 'Permite seleccionar a que categoria pertenece la parte del cuerpo';


--
-- TOC entry 1734 (class 1259 OID 32602)
-- Dependencies: 7 1733
-- Name: partes_cuerpos__categorias_cuerpos_id_par_cue_cat_cue_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE partes_cuerpos__categorias_cuerpos_id_par_cue_cat_cue_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.partes_cuerpos__categorias_cuerpos_id_par_cue_cat_cue_seq OWNER TO desarrollo_g;

--
-- TOC entry 2494 (class 0 OID 0)
-- Dependencies: 1734
-- Name: partes_cuerpos__categorias_cuerpos_id_par_cue_cat_cue_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE partes_cuerpos__categorias_cuerpos_id_par_cue_cat_cue_seq OWNED BY partes_cuerpos__categorias_cuerpos.id_par_cue_cat_cue;


--
-- TOC entry 2495 (class 0 OID 0)
-- Dependencies: 1734
-- Name: partes_cuerpos__categorias_cuerpos_id_par_cue_cat_cue_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('partes_cuerpos__categorias_cuerpos_id_par_cue_cat_cue_seq', 9, true);


--
-- TOC entry 1735 (class 1259 OID 32604)
-- Dependencies: 1732 7
-- Name: partes_cuerpos_id_par_cue_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE partes_cuerpos_id_par_cue_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.partes_cuerpos_id_par_cue_seq OWNER TO desarrollo_g;

--
-- TOC entry 2496 (class 0 OID 0)
-- Dependencies: 1735
-- Name: partes_cuerpos_id_par_cue_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE partes_cuerpos_id_par_cue_seq OWNED BY partes_cuerpos.id_par_cue;


--
-- TOC entry 2497 (class 0 OID 0)
-- Dependencies: 1735
-- Name: partes_cuerpos_id_par_cue_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('partes_cuerpos_id_par_cue_seq', 19, true);


--
-- TOC entry 1736 (class 1259 OID 32606)
-- Dependencies: 2084 7
-- Name: tiempo_evoluciones; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: 
--

CREATE TABLE tiempo_evoluciones (
    id_tie_evo integer NOT NULL,
    id_his integer,
    tie_evo integer DEFAULT 0
);


ALTER TABLE public.tiempo_evoluciones OWNER TO desarrollo_g;

--
-- TOC entry 1737 (class 1259 OID 32610)
-- Dependencies: 1736 7
-- Name: tiempo_evoluciones_id_tie_evo_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE tiempo_evoluciones_id_tie_evo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tiempo_evoluciones_id_tie_evo_seq OWNER TO desarrollo_g;

--
-- TOC entry 2498 (class 0 OID 0)
-- Dependencies: 1737
-- Name: tiempo_evoluciones_id_tie_evo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE tiempo_evoluciones_id_tie_evo_seq OWNED BY tiempo_evoluciones.id_tie_evo;


--
-- TOC entry 2499 (class 0 OID 0)
-- Dependencies: 1737
-- Name: tiempo_evoluciones_id_tie_evo_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('tiempo_evoluciones_id_tie_evo_seq', 13, true);


SET default_tablespace = saib;

--
-- TOC entry 1738 (class 1259 OID 32612)
-- Dependencies: 7
-- Name: tipos_consultas; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE tipos_consultas (
    id_tip_con integer NOT NULL,
    nom_tip_con character varying(50) NOT NULL
);


ALTER TABLE public.tipos_consultas OWNER TO desarrollo_g;

--
-- TOC entry 2500 (class 0 OID 0)
-- Dependencies: 1738
-- Name: COLUMN tipos_consultas.id_tip_con; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN tipos_consultas.id_tip_con IS 'id tipos consultas';


--
-- TOC entry 1739 (class 1259 OID 32615)
-- Dependencies: 7 1738
-- Name: tipos_consultas_id_tip_con_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE tipos_consultas_id_tip_con_seq
    START WITH 9
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipos_consultas_id_tip_con_seq OWNER TO desarrollo_g;

--
-- TOC entry 2501 (class 0 OID 0)
-- Dependencies: 1739
-- Name: tipos_consultas_id_tip_con_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE tipos_consultas_id_tip_con_seq OWNED BY tipos_consultas.id_tip_con;


--
-- TOC entry 2502 (class 0 OID 0)
-- Dependencies: 1739
-- Name: tipos_consultas_id_tip_con_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('tipos_consultas_id_tip_con_seq', 9, true);


--
-- TOC entry 1740 (class 1259 OID 32617)
-- Dependencies: 7
-- Name: tipos_consultas_pacientes; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE tipos_consultas_pacientes (
    id_tip_con_pac integer NOT NULL,
    id_tip_con integer NOT NULL,
    id_his integer NOT NULL,
    otr_tip_con character varying(100)
);


ALTER TABLE public.tipos_consultas_pacientes OWNER TO desarrollo_g;

--
-- TOC entry 2503 (class 0 OID 0)
-- Dependencies: 1740
-- Name: COLUMN tipos_consultas_pacientes.id_tip_con_pac; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN tipos_consultas_pacientes.id_tip_con_pac IS 'Id tipos de consulta paciente';


--
-- TOC entry 2504 (class 0 OID 0)
-- Dependencies: 1740
-- Name: COLUMN tipos_consultas_pacientes.id_tip_con; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN tipos_consultas_pacientes.id_tip_con IS 'Id tipos de consulta';


--
-- TOC entry 2505 (class 0 OID 0)
-- Dependencies: 1740
-- Name: COLUMN tipos_consultas_pacientes.id_his; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN tipos_consultas_pacientes.id_his IS 'Id historico';


--
-- TOC entry 2506 (class 0 OID 0)
-- Dependencies: 1740
-- Name: COLUMN tipos_consultas_pacientes.otr_tip_con; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN tipos_consultas_pacientes.otr_tip_con IS 'Otro tipo de consulta';


--
-- TOC entry 1741 (class 1259 OID 32620)
-- Dependencies: 7 1740
-- Name: tipos_consultas_pacientes_id_tip_con_pac_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE tipos_consultas_pacientes_id_tip_con_pac_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipos_consultas_pacientes_id_tip_con_pac_seq OWNER TO desarrollo_g;

--
-- TOC entry 2507 (class 0 OID 0)
-- Dependencies: 1741
-- Name: tipos_consultas_pacientes_id_tip_con_pac_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE tipos_consultas_pacientes_id_tip_con_pac_seq OWNED BY tipos_consultas_pacientes.id_tip_con_pac;


--
-- TOC entry 2508 (class 0 OID 0)
-- Dependencies: 1741
-- Name: tipos_consultas_pacientes_id_tip_con_pac_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('tipos_consultas_pacientes_id_tip_con_pac_seq', 199, true);


--
-- TOC entry 1742 (class 1259 OID 32622)
-- Dependencies: 7
-- Name: tipos_estudios_micologicos; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE tipos_estudios_micologicos (
    id_tip_est_mic integer NOT NULL,
    id_tip_mic integer NOT NULL,
    nom_tip_est_mic character varying(255),
    id_tip_exa integer
);


ALTER TABLE public.tipos_estudios_micologicos OWNER TO desarrollo_g;

--
-- TOC entry 1743 (class 1259 OID 32625)
-- Dependencies: 7 1742
-- Name: tipos_estudios_micologicos_id_tip_est_mic_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE tipos_estudios_micologicos_id_tip_est_mic_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipos_estudios_micologicos_id_tip_est_mic_seq OWNER TO desarrollo_g;

--
-- TOC entry 2509 (class 0 OID 0)
-- Dependencies: 1743
-- Name: tipos_estudios_micologicos_id_tip_est_mic_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE tipos_estudios_micologicos_id_tip_est_mic_seq OWNED BY tipos_estudios_micologicos.id_tip_est_mic;


--
-- TOC entry 2510 (class 0 OID 0)
-- Dependencies: 1743
-- Name: tipos_estudios_micologicos_id_tip_est_mic_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('tipos_estudios_micologicos_id_tip_est_mic_seq', 64, true);


SET default_tablespace = '';

--
-- TOC entry 1744 (class 1259 OID 32627)
-- Dependencies: 7
-- Name: tipos_examenes; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: 
--

CREATE TABLE tipos_examenes (
    id_tip_exa integer NOT NULL,
    nom_tip_exa character varying(255)
);


ALTER TABLE public.tipos_examenes OWNER TO desarrollo_g;

--
-- TOC entry 1745 (class 1259 OID 32630)
-- Dependencies: 1744 7
-- Name: tipos_examenes_id_tip_exa_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE tipos_examenes_id_tip_exa_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipos_examenes_id_tip_exa_seq OWNER TO desarrollo_g;

--
-- TOC entry 2511 (class 0 OID 0)
-- Dependencies: 1745
-- Name: tipos_examenes_id_tip_exa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE tipos_examenes_id_tip_exa_seq OWNED BY tipos_examenes.id_tip_exa;


--
-- TOC entry 2512 (class 0 OID 0)
-- Dependencies: 1745
-- Name: tipos_examenes_id_tip_exa_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('tipos_examenes_id_tip_exa_seq', 3, false);


SET default_tablespace = saib;

--
-- TOC entry 1746 (class 1259 OID 32632)
-- Dependencies: 7
-- Name: tipos_micosis; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE tipos_micosis (
    id_tip_mic integer NOT NULL,
    nom_tip_mic character varying(20)
);


ALTER TABLE public.tipos_micosis OWNER TO desarrollo_g;

--
-- TOC entry 1747 (class 1259 OID 32635)
-- Dependencies: 7 1746
-- Name: tipos_micosis_id_tip_mic_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE tipos_micosis_id_tip_mic_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipos_micosis_id_tip_mic_seq OWNER TO desarrollo_g;

--
-- TOC entry 2513 (class 0 OID 0)
-- Dependencies: 1747
-- Name: tipos_micosis_id_tip_mic_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE tipos_micosis_id_tip_mic_seq OWNED BY tipos_micosis.id_tip_mic;


--
-- TOC entry 2514 (class 0 OID 0)
-- Dependencies: 1747
-- Name: tipos_micosis_id_tip_mic_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('tipos_micosis_id_tip_mic_seq', 4, false);


SET default_tablespace = '';

--
-- TOC entry 1748 (class 1259 OID 32637)
-- Dependencies: 7
-- Name: tipos_micosis_pacientes; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: 
--

CREATE TABLE tipos_micosis_pacientes (
    id_tip_mic_pac integer NOT NULL,
    id_tip_mic integer,
    id_his integer
);


ALTER TABLE public.tipos_micosis_pacientes OWNER TO desarrollo_g;

--
-- TOC entry 1749 (class 1259 OID 32640)
-- Dependencies: 7
-- Name: tipos_micosis_pacientes__tipos_estudios_micologicos; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: 
--

CREATE TABLE tipos_micosis_pacientes__tipos_estudios_micologicos (
    id_tip_mic_pac_tip_est_mic integer NOT NULL,
    id_tip_mic_pac integer,
    id_tip_est_mic integer,
    otr_tip_est_mic character varying(100)
);


ALTER TABLE public.tipos_micosis_pacientes__tipos_estudios_micologicos OWNER TO desarrollo_g;

--
-- TOC entry 2515 (class 0 OID 0)
-- Dependencies: 1749
-- Name: COLUMN tipos_micosis_pacientes__tipos_estudios_micologicos.otr_tip_est_mic; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN tipos_micosis_pacientes__tipos_estudios_micologicos.otr_tip_est_mic IS 'Otros tipos de estudio micologico asociado a muestras pacientes.';


--
-- TOC entry 1750 (class 1259 OID 32643)
-- Dependencies: 1749 7
-- Name: tipos_micosis_pacientes__tipos_e_id_tip_mic_pac_tip_est_mic_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE tipos_micosis_pacientes__tipos_e_id_tip_mic_pac_tip_est_mic_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipos_micosis_pacientes__tipos_e_id_tip_mic_pac_tip_est_mic_seq OWNER TO desarrollo_g;

--
-- TOC entry 2516 (class 0 OID 0)
-- Dependencies: 1750
-- Name: tipos_micosis_pacientes__tipos_e_id_tip_mic_pac_tip_est_mic_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE tipos_micosis_pacientes__tipos_e_id_tip_mic_pac_tip_est_mic_seq OWNED BY tipos_micosis_pacientes__tipos_estudios_micologicos.id_tip_mic_pac_tip_est_mic;


--
-- TOC entry 2517 (class 0 OID 0)
-- Dependencies: 1750
-- Name: tipos_micosis_pacientes__tipos_e_id_tip_mic_pac_tip_est_mic_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('tipos_micosis_pacientes__tipos_e_id_tip_mic_pac_tip_est_mic_seq', 150, true);


--
-- TOC entry 1751 (class 1259 OID 32645)
-- Dependencies: 7 1748
-- Name: tipos_micosis_pacientes_id_tip_mic_pac_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE tipos_micosis_pacientes_id_tip_mic_pac_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipos_micosis_pacientes_id_tip_mic_pac_seq OWNER TO desarrollo_g;

--
-- TOC entry 2518 (class 0 OID 0)
-- Dependencies: 1751
-- Name: tipos_micosis_pacientes_id_tip_mic_pac_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE tipos_micosis_pacientes_id_tip_mic_pac_seq OWNED BY tipos_micosis_pacientes.id_tip_mic_pac;


--
-- TOC entry 2519 (class 0 OID 0)
-- Dependencies: 1751
-- Name: tipos_micosis_pacientes_id_tip_mic_pac_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('tipos_micosis_pacientes_id_tip_mic_pac_seq', 181, true);


SET default_tablespace = saib;

--
-- TOC entry 1752 (class 1259 OID 32647)
-- Dependencies: 7
-- Name: tipos_usuarios; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE tipos_usuarios (
    id_tip_usu integer NOT NULL,
    cod_tip_usu character varying(3) NOT NULL,
    des_tip_usu character varying(100)
);


ALTER TABLE public.tipos_usuarios OWNER TO desarrollo_g;

--
-- TOC entry 1753 (class 1259 OID 32650)
-- Dependencies: 7
-- Name: tipos_usuarios__usuarios; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE tipos_usuarios__usuarios (
    id_tip_usu_usu integer NOT NULL,
    id_doc integer,
    id_usu_adm integer,
    id_tip_usu integer NOT NULL
);


ALTER TABLE public.tipos_usuarios__usuarios OWNER TO desarrollo_g;

--
-- TOC entry 1754 (class 1259 OID 32653)
-- Dependencies: 1753 7
-- Name: tipos_usuarios__usuarios_id_tip_usu_usu_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE tipos_usuarios__usuarios_id_tip_usu_usu_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipos_usuarios__usuarios_id_tip_usu_usu_seq OWNER TO desarrollo_g;

--
-- TOC entry 2520 (class 0 OID 0)
-- Dependencies: 1754
-- Name: tipos_usuarios__usuarios_id_tip_usu_usu_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE tipos_usuarios__usuarios_id_tip_usu_usu_seq OWNED BY tipos_usuarios__usuarios.id_tip_usu_usu;


--
-- TOC entry 2521 (class 0 OID 0)
-- Dependencies: 1754
-- Name: tipos_usuarios__usuarios_id_tip_usu_usu_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('tipos_usuarios__usuarios_id_tip_usu_usu_seq', 54, true);


--
-- TOC entry 1755 (class 1259 OID 32655)
-- Dependencies: 7 1752
-- Name: tipos_usuarios_id_tip_usu_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE tipos_usuarios_id_tip_usu_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipos_usuarios_id_tip_usu_seq OWNER TO desarrollo_g;

--
-- TOC entry 2522 (class 0 OID 0)
-- Dependencies: 1755
-- Name: tipos_usuarios_id_tip_usu_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE tipos_usuarios_id_tip_usu_seq OWNED BY tipos_usuarios.id_tip_usu;


--
-- TOC entry 2523 (class 0 OID 0)
-- Dependencies: 1755
-- Name: tipos_usuarios_id_tip_usu_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('tipos_usuarios_id_tip_usu_seq', 2, true);


--
-- TOC entry 1756 (class 1259 OID 32657)
-- Dependencies: 7
-- Name: transacciones; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE transacciones (
    id_tip_tra integer NOT NULL,
    cod_tip_tra character varying(3) NOT NULL,
    des_tip_tra character varying(100),
    id_mod integer
);


ALTER TABLE public.transacciones OWNER TO desarrollo_g;

--
-- TOC entry 1757 (class 1259 OID 32660)
-- Dependencies: 1756 7
-- Name: transacciones_id_tip_tra_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE transacciones_id_tip_tra_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transacciones_id_tip_tra_seq OWNER TO desarrollo_g;

--
-- TOC entry 2524 (class 0 OID 0)
-- Dependencies: 1757
-- Name: transacciones_id_tip_tra_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE transacciones_id_tip_tra_seq OWNED BY transacciones.id_tip_tra;


--
-- TOC entry 2525 (class 0 OID 0)
-- Dependencies: 1757
-- Name: transacciones_id_tip_tra_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('transacciones_id_tip_tra_seq', 16, true);


--
-- TOC entry 1758 (class 1259 OID 32662)
-- Dependencies: 7
-- Name: transacciones_usuarios; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE transacciones_usuarios (
    id_tip_tra integer NOT NULL,
    id_tip_usu_usu integer,
    id_tra_usu integer NOT NULL
);


ALTER TABLE public.transacciones_usuarios OWNER TO desarrollo_g;

--
-- TOC entry 1759 (class 1259 OID 32665)
-- Dependencies: 7 1758
-- Name: transacciones_usuarios_id_tra_usu_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE transacciones_usuarios_id_tra_usu_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transacciones_usuarios_id_tra_usu_seq OWNER TO desarrollo_g;

--
-- TOC entry 2526 (class 0 OID 0)
-- Dependencies: 1759
-- Name: transacciones_usuarios_id_tra_usu_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE transacciones_usuarios_id_tra_usu_seq OWNED BY transacciones_usuarios.id_tra_usu;


--
-- TOC entry 2527 (class 0 OID 0)
-- Dependencies: 1759
-- Name: transacciones_usuarios_id_tra_usu_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('transacciones_usuarios_id_tra_usu_seq', 161, true);


--
-- TOC entry 1760 (class 1259 OID 32667)
-- Dependencies: 7
-- Name: tratamientos; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE tratamientos (
    id_tra integer NOT NULL,
    nom_tra character varying(100)
);


ALTER TABLE public.tratamientos OWNER TO desarrollo_g;

--
-- TOC entry 1761 (class 1259 OID 32670)
-- Dependencies: 7 1760
-- Name: tratamientos_id_tra_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE tratamientos_id_tra_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tratamientos_id_tra_seq OWNER TO desarrollo_g;

--
-- TOC entry 2528 (class 0 OID 0)
-- Dependencies: 1761
-- Name: tratamientos_id_tra_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE tratamientos_id_tra_seq OWNED BY tratamientos.id_tra;


--
-- TOC entry 2529 (class 0 OID 0)
-- Dependencies: 1761
-- Name: tratamientos_id_tra_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('tratamientos_id_tra_seq', 1, false);


--
-- TOC entry 1762 (class 1259 OID 32672)
-- Dependencies: 7
-- Name: tratamientos_pacientes; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE tratamientos_pacientes (
    id_tra_pac integer NOT NULL,
    id_his integer NOT NULL,
    id_tra integer NOT NULL,
    otr_tra character varying(100)
);


ALTER TABLE public.tratamientos_pacientes OWNER TO desarrollo_g;

--
-- TOC entry 2530 (class 0 OID 0)
-- Dependencies: 1762
-- Name: COLUMN tratamientos_pacientes.id_tra_pac; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN tratamientos_pacientes.id_tra_pac IS 'Id transaccion paciente';


--
-- TOC entry 2531 (class 0 OID 0)
-- Dependencies: 1762
-- Name: COLUMN tratamientos_pacientes.id_his; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN tratamientos_pacientes.id_his IS 'Id historico';


--
-- TOC entry 2532 (class 0 OID 0)
-- Dependencies: 1762
-- Name: COLUMN tratamientos_pacientes.id_tra; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN tratamientos_pacientes.id_tra IS 'Id tratamiento';


--
-- TOC entry 2533 (class 0 OID 0)
-- Dependencies: 1762
-- Name: COLUMN tratamientos_pacientes.otr_tra; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN tratamientos_pacientes.otr_tra IS 'Otro tratamiento';


--
-- TOC entry 1763 (class 1259 OID 32675)
-- Dependencies: 7 1762
-- Name: tratamientos_pacientes_id_tra_pac_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE tratamientos_pacientes_id_tra_pac_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tratamientos_pacientes_id_tra_pac_seq OWNER TO desarrollo_g;

--
-- TOC entry 2534 (class 0 OID 0)
-- Dependencies: 1763
-- Name: tratamientos_pacientes_id_tra_pac_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE tratamientos_pacientes_id_tra_pac_seq OWNED BY tratamientos_pacientes.id_tra_pac;


--
-- TOC entry 2535 (class 0 OID 0)
-- Dependencies: 1763
-- Name: tratamientos_pacientes_id_tra_pac_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('tratamientos_pacientes_id_tra_pac_seq', 260, true);


--
-- TOC entry 1764 (class 1259 OID 32677)
-- Dependencies: 2099 7
-- Name: usuarios_administrativos; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE usuarios_administrativos (
    id_usu_adm integer NOT NULL,
    nom_usu_adm character varying(100),
    ape_usu_adm character varying(100),
    pas_usu_adm character varying(100),
    log_usu_adm character varying(100),
    tel_usu_adm character varying(20),
    fec_reg_usu_adm timestamp without time zone DEFAULT now(),
    adm_usu boolean
);


ALTER TABLE public.usuarios_administrativos OWNER TO desarrollo_g;

--
-- TOC entry 2536 (class 0 OID 0)
-- Dependencies: 1764
-- Name: COLUMN usuarios_administrativos.fec_reg_usu_adm; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN usuarios_administrativos.fec_reg_usu_adm IS 'Fecha de registro de los usuarios';


--
-- TOC entry 2537 (class 0 OID 0)
-- Dependencies: 1764
-- Name: COLUMN usuarios_administrativos.adm_usu; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN usuarios_administrativos.adm_usu IS '
	TRUE: si es un super usuario
	FALSE: si es usuario com limitaciones
';


--
-- TOC entry 1765 (class 1259 OID 32681)
-- Dependencies: 1764 7
-- Name: usuarios_administrativos_id_usu_adm_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE usuarios_administrativos_id_usu_adm_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usuarios_administrativos_id_usu_adm_seq OWNER TO desarrollo_g;

--
-- TOC entry 2538 (class 0 OID 0)
-- Dependencies: 1765
-- Name: usuarios_administrativos_id_usu_adm_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE usuarios_administrativos_id_usu_adm_seq OWNED BY usuarios_administrativos.id_usu_adm;


--
-- TOC entry 2539 (class 0 OID 0)
-- Dependencies: 1765
-- Name: usuarios_administrativos_id_usu_adm_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('usuarios_administrativos_id_usu_adm_seq', 24, true);


--
-- TOC entry 1766 (class 1259 OID 32683)
-- Dependencies: 1855 7
-- Name: view_auditoria_transacciones; Type: VIEW; Schema: public; Owner: desarrollo_g
--

CREATE VIEW view_auditoria_transacciones AS
    SELECT to_char(at.fec_aud_tra, 'DD/MM/YYYY HH12:MI:SS AM'::text) AS fecha_tran, (((d.nom_doc)::text || ' '::text) || (d.ape_doc)::text) AS nom_ape_usu, d.log_doc AS log_usu, CASE WHEN (at.data_xml IS NOT NULL) THEN 'Si'::text ELSE 'No'::text END AS detalle, at.id_tip_usu_usu, at.data_xml, at.id_tip_tra, t.cod_tip_tra, t.id_mod FROM (((auditoria_transacciones at LEFT JOIN transacciones t USING (id_tip_tra)) LEFT JOIN tipos_usuarios__usuarios tuu USING (id_tip_usu_usu)) LEFT JOIN doctores d ON ((tuu.id_doc = d.id_doc))) ORDER BY to_char(at.fec_aud_tra, 'DD/MM/YYYY HH12:MI:SS AM'::text) DESC;


ALTER TABLE public.view_auditoria_transacciones OWNER TO desarrollo_g;

--
-- TOC entry 1767 (class 1259 OID 32688)
-- Dependencies: 1856 7
-- Name: view_tipo_enfermedades_mic_pac; Type: VIEW; Schema: public; Owner: desarrollo_g
--

CREATE VIEW view_tipo_enfermedades_mic_pac AS
    SELECT hp.id_his, to_char(hp.fec_his, 'DD/MM/YYYY HH12:MI:SS AM'::text) AS fec_his, tm.id_tip_mic, tm.nom_tip_mic, hp.id_pac, (hp.id_his)::text AS num_his FROM ((tipos_micosis tm LEFT JOIN tipos_micosis_pacientes tmp USING (id_tip_mic)) LEFT JOIN historiales_pacientes hp ON ((tmp.id_his = hp.id_his))) WHERE (hp.id_his IS NOT NULL) ORDER BY tm.nom_tip_mic;


ALTER TABLE public.view_tipo_enfermedades_mic_pac OWNER TO desarrollo_g;

SET search_path = saib_model, pg_catalog;

SET default_tablespace = '';

--
-- TOC entry 1768 (class 1259 OID 32692)
-- Dependencies: 6
-- Name: wwwsqldesigner; Type: TABLE; Schema: saib_model; Owner: postgres; Tablespace: 
--

CREATE TABLE wwwsqldesigner (
    keyword character varying(30) NOT NULL,
    xmldata text,
    dt timestamp without time zone
);


ALTER TABLE saib_model.wwwsqldesigner OWNER TO postgres;

SET search_path = public, pg_catalog;

--
-- TOC entry 2048 (class 2604 OID 32698)
-- Dependencies: 1673 1672
-- Name: id_ani; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE animales ALTER COLUMN id_ani SET DEFAULT nextval('animales_id_ani_seq'::regclass);


--
-- TOC entry 2049 (class 2604 OID 32699)
-- Dependencies: 1675 1674
-- Name: id_ant_pac; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE antecedentes_pacientes ALTER COLUMN id_ant_pac SET DEFAULT nextval('antecedentes_pacientes_id_ant_pac_seq'::regclass);


--
-- TOC entry 2050 (class 2604 OID 32700)
-- Dependencies: 1677 1676
-- Name: id_ant_per; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE antecedentes_personales ALTER COLUMN id_ant_per SET DEFAULT nextval('antecedentes_personales_id_ant_per_seq'::regclass);


--
-- TOC entry 2051 (class 2604 OID 32701)
-- Dependencies: 1679 1678
-- Name: id_aud_tra; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE auditoria_transacciones ALTER COLUMN id_aud_tra SET DEFAULT nextval('auditoria_transacciones_id_aud_tra_seq'::regclass);


--
-- TOC entry 2052 (class 2604 OID 32702)
-- Dependencies: 1681 1680
-- Name: id_cat_cue_mic; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE categorias__cuerpos_micosis ALTER COLUMN id_cat_cue_mic SET DEFAULT nextval('categorias__cuerpos_micosis_id_cat_cue_mic_seq'::regclass);


--
-- TOC entry 2053 (class 2604 OID 32703)
-- Dependencies: 1684 1682
-- Name: id_cat_cue; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE categorias_cuerpos ALTER COLUMN id_cat_cue SET DEFAULT nextval('categorias_cuerpos_id_cat_cue_seq'::regclass);


--
-- TOC entry 2054 (class 2604 OID 32704)
-- Dependencies: 1712 1683
-- Name: id_cat_cue_les; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE categorias_cuerpos__lesiones ALTER COLUMN id_cat_cue_les SET DEFAULT nextval('lesiones__partes_cuerpos_id_les_par_cue_seq'::regclass);


--
-- TOC entry 2055 (class 2604 OID 32705)
-- Dependencies: 1686 1685
-- Name: id_cen_sal_doc; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE centro_salud_doctores ALTER COLUMN id_cen_sal_doc SET DEFAULT nextval('centro_salud_doctores_id_cen_sal_doc_seq'::regclass);


--
-- TOC entry 2057 (class 2604 OID 32706)
-- Dependencies: 1690 1689
-- Name: id_cen_sal_pac; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE centro_salud_pacientes ALTER COLUMN id_cen_sal_pac SET DEFAULT nextval('centro_salud_pacientes_id_cen_sal_pac_seq'::regclass);


--
-- TOC entry 2056 (class 2604 OID 32707)
-- Dependencies: 1688 1687
-- Name: id_cen_sal; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE centro_saluds ALTER COLUMN id_cen_sal SET DEFAULT nextval('centro_salud_id_cen_sal_seq'::regclass);


--
-- TOC entry 2058 (class 2604 OID 32708)
-- Dependencies: 1692 1691
-- Name: id_con_ani; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE contactos_animales ALTER COLUMN id_con_ani SET DEFAULT nextval('contactos_animales_id_con_ani_seq'::regclass);


--
-- TOC entry 2060 (class 2604 OID 32709)
-- Dependencies: 1694 1693
-- Name: id_doc; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE doctores ALTER COLUMN id_doc SET DEFAULT nextval('doctores_id_doc_seq'::regclass);


--
-- TOC entry 2061 (class 2604 OID 32710)
-- Dependencies: 1696 1695
-- Name: id_enf_mic; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE enfermedades_micologicas ALTER COLUMN id_enf_mic SET DEFAULT nextval('enfermedades_micologicas_id_enf_mic_seq'::regclass);


--
-- TOC entry 2062 (class 2604 OID 32711)
-- Dependencies: 1698 1697
-- Name: id_enf_pac; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE enfermedades_pacientes ALTER COLUMN id_enf_pac SET DEFAULT nextval('enfermedades_pacientes_id_enf_pac_seq'::regclass);


--
-- TOC entry 2063 (class 2604 OID 32712)
-- Dependencies: 1700 1699
-- Name: id_est; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE estados ALTER COLUMN id_est SET DEFAULT nextval('estados_id_est_seq'::regclass);


--
-- TOC entry 2064 (class 2604 OID 32713)
-- Dependencies: 1702 1701
-- Name: id_exa_pac; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE examenes_pacientes ALTER COLUMN id_exa_pac SET DEFAULT nextval('examenes_pacientes_id_exa_pac_seq'::regclass);


--
-- TOC entry 2065 (class 2604 OID 32714)
-- Dependencies: 1708 1703
-- Name: id_for_inf; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE forma_infecciones ALTER COLUMN id_for_inf SET DEFAULT nextval('forma_infecciones_id_for_inf_seq'::regclass);


--
-- TOC entry 2066 (class 2604 OID 32715)
-- Dependencies: 1705 1704
-- Name: id_for_pac; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE forma_infecciones__pacientes ALTER COLUMN id_for_pac SET DEFAULT nextval('forma_infecciones__pacientes_id_for_pac_seq'::regclass);


--
-- TOC entry 2067 (class 2604 OID 32716)
-- Dependencies: 1707 1706
-- Name: id_for_inf_tip_mic; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE forma_infecciones__tipos_micosis ALTER COLUMN id_for_inf_tip_mic SET DEFAULT nextval('forma_infecciones__tipos_micosis_id_for_inf_tip_mic_seq'::regclass);


--
-- TOC entry 2070 (class 2604 OID 32717)
-- Dependencies: 1710 1709
-- Name: id_his; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE historiales_pacientes ALTER COLUMN id_his SET DEFAULT nextval('historiales_pacientes_id_his_seq'::regclass);


--
-- TOC entry 2071 (class 2604 OID 32718)
-- Dependencies: 1713 1711
-- Name: id_les; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE lesiones ALTER COLUMN id_les SET DEFAULT nextval('lesiones_id_les_seq'::regclass);


--
-- TOC entry 2072 (class 2604 OID 32719)
-- Dependencies: 1715 1714
-- Name: id_les_par_cue_pac; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE lesiones_partes_cuerpos__pacientes ALTER COLUMN id_les_par_cue_pac SET DEFAULT nextval('lesiones_partes_cuerpos__pacientes_id_les_par_cue_pac_seq'::regclass);


--
-- TOC entry 2073 (class 2604 OID 32720)
-- Dependencies: 1717 1716
-- Name: id_loc_cue; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE localizaciones_cuerpos ALTER COLUMN id_loc_cue SET DEFAULT nextval('localizaciones_cuerpos_id_loc_cue_seq'::regclass);


--
-- TOC entry 2074 (class 2604 OID 32721)
-- Dependencies: 1719 1718
-- Name: id_mod; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE modulos ALTER COLUMN id_mod SET DEFAULT nextval('modulos_id_mod_seq'::regclass);


--
-- TOC entry 2075 (class 2604 OID 32722)
-- Dependencies: 1721 1720
-- Name: id_mue_cli; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE muestras_clinicas ALTER COLUMN id_mue_cli SET DEFAULT nextval('muestras_clinicas_id_mue_cli_seq'::regclass);


--
-- TOC entry 2076 (class 2604 OID 32723)
-- Dependencies: 1723 1722
-- Name: id_mue_pac; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE muestras_pacientes ALTER COLUMN id_mue_pac SET DEFAULT nextval('muestras_pacientes_id_mue_pac_seq'::regclass);


--
-- TOC entry 2077 (class 2604 OID 32724)
-- Dependencies: 1725 1724
-- Name: id_mun; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE municipios ALTER COLUMN id_mun SET DEFAULT nextval('municipios_id_mun_seq'::regclass);


--
-- TOC entry 2079 (class 2604 OID 32725)
-- Dependencies: 1727 1726
-- Name: id_pac; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE pacientes ALTER COLUMN id_pac SET DEFAULT nextval('pacientes_id_pac_seq'::regclass);


--
-- TOC entry 2080 (class 2604 OID 32726)
-- Dependencies: 1729 1728
-- Name: id_pai; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE paises ALTER COLUMN id_pai SET DEFAULT nextval('paises_id_pai_seq'::regclass);


--
-- TOC entry 2081 (class 2604 OID 32727)
-- Dependencies: 1731 1730
-- Name: id_par; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE parroquias ALTER COLUMN id_par SET DEFAULT nextval('parroquias_id_par_seq'::regclass);


--
-- TOC entry 2082 (class 2604 OID 32728)
-- Dependencies: 1735 1732
-- Name: id_par_cue; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE partes_cuerpos ALTER COLUMN id_par_cue SET DEFAULT nextval('partes_cuerpos_id_par_cue_seq'::regclass);


--
-- TOC entry 2083 (class 2604 OID 32729)
-- Dependencies: 1734 1733
-- Name: id_par_cue_cat_cue; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE partes_cuerpos__categorias_cuerpos ALTER COLUMN id_par_cue_cat_cue SET DEFAULT nextval('partes_cuerpos__categorias_cuerpos_id_par_cue_cat_cue_seq'::regclass);


--
-- TOC entry 2085 (class 2604 OID 32730)
-- Dependencies: 1737 1736
-- Name: id_tie_evo; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE tiempo_evoluciones ALTER COLUMN id_tie_evo SET DEFAULT nextval('tiempo_evoluciones_id_tie_evo_seq'::regclass);


--
-- TOC entry 2086 (class 2604 OID 32731)
-- Dependencies: 1739 1738
-- Name: id_tip_con; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE tipos_consultas ALTER COLUMN id_tip_con SET DEFAULT nextval('tipos_consultas_id_tip_con_seq'::regclass);


--
-- TOC entry 2087 (class 2604 OID 32732)
-- Dependencies: 1741 1740
-- Name: id_tip_con_pac; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE tipos_consultas_pacientes ALTER COLUMN id_tip_con_pac SET DEFAULT nextval('tipos_consultas_pacientes_id_tip_con_pac_seq'::regclass);


--
-- TOC entry 2088 (class 2604 OID 32733)
-- Dependencies: 1743 1742
-- Name: id_tip_est_mic; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE tipos_estudios_micologicos ALTER COLUMN id_tip_est_mic SET DEFAULT nextval('tipos_estudios_micologicos_id_tip_est_mic_seq'::regclass);


--
-- TOC entry 2089 (class 2604 OID 32734)
-- Dependencies: 1745 1744
-- Name: id_tip_exa; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE tipos_examenes ALTER COLUMN id_tip_exa SET DEFAULT nextval('tipos_examenes_id_tip_exa_seq'::regclass);


--
-- TOC entry 2090 (class 2604 OID 32735)
-- Dependencies: 1747 1746
-- Name: id_tip_mic; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE tipos_micosis ALTER COLUMN id_tip_mic SET DEFAULT nextval('tipos_micosis_id_tip_mic_seq'::regclass);


--
-- TOC entry 2091 (class 2604 OID 32736)
-- Dependencies: 1751 1748
-- Name: id_tip_mic_pac; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE tipos_micosis_pacientes ALTER COLUMN id_tip_mic_pac SET DEFAULT nextval('tipos_micosis_pacientes_id_tip_mic_pac_seq'::regclass);


--
-- TOC entry 2092 (class 2604 OID 32737)
-- Dependencies: 1750 1749
-- Name: id_tip_mic_pac_tip_est_mic; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE tipos_micosis_pacientes__tipos_estudios_micologicos ALTER COLUMN id_tip_mic_pac_tip_est_mic SET DEFAULT nextval('tipos_micosis_pacientes__tipos_e_id_tip_mic_pac_tip_est_mic_seq'::regclass);


--
-- TOC entry 2093 (class 2604 OID 32738)
-- Dependencies: 1755 1752
-- Name: id_tip_usu; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE tipos_usuarios ALTER COLUMN id_tip_usu SET DEFAULT nextval('tipos_usuarios_id_tip_usu_seq'::regclass);


--
-- TOC entry 2094 (class 2604 OID 32739)
-- Dependencies: 1754 1753
-- Name: id_tip_usu_usu; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE tipos_usuarios__usuarios ALTER COLUMN id_tip_usu_usu SET DEFAULT nextval('tipos_usuarios__usuarios_id_tip_usu_usu_seq'::regclass);


--
-- TOC entry 2095 (class 2604 OID 32740)
-- Dependencies: 1757 1756
-- Name: id_tip_tra; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE transacciones ALTER COLUMN id_tip_tra SET DEFAULT nextval('transacciones_id_tip_tra_seq'::regclass);


--
-- TOC entry 2096 (class 2604 OID 32741)
-- Dependencies: 1759 1758
-- Name: id_tra_usu; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE transacciones_usuarios ALTER COLUMN id_tra_usu SET DEFAULT nextval('transacciones_usuarios_id_tra_usu_seq'::regclass);


--
-- TOC entry 2097 (class 2604 OID 32742)
-- Dependencies: 1761 1760
-- Name: id_tra; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE tratamientos ALTER COLUMN id_tra SET DEFAULT nextval('tratamientos_id_tra_seq'::regclass);


--
-- TOC entry 2098 (class 2604 OID 32743)
-- Dependencies: 1763 1762
-- Name: id_tra_pac; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE tratamientos_pacientes ALTER COLUMN id_tra_pac SET DEFAULT nextval('tratamientos_pacientes_id_tra_pac_seq'::regclass);


--
-- TOC entry 2100 (class 2604 OID 32744)
-- Dependencies: 1765 1764
-- Name: id_usu_adm; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE usuarios_administrativos ALTER COLUMN id_usu_adm SET DEFAULT nextval('usuarios_administrativos_id_usu_adm_seq'::regclass);


--
-- TOC entry 2323 (class 0 OID 32433)
-- Dependencies: 1672
-- Data for Name: animales; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO animales (id_ani, nom_ani) VALUES (1, 'Perro');
INSERT INTO animales (id_ani, nom_ani) VALUES (2, 'Gato');
INSERT INTO animales (id_ani, nom_ani) VALUES (3, 'Aves');
INSERT INTO animales (id_ani, nom_ani) VALUES (4, 'Animales de Corral');
INSERT INTO animales (id_ani, nom_ani) VALUES (5, 'Otros');


--
-- TOC entry 2324 (class 0 OID 32438)
-- Dependencies: 1674
-- Data for Name: antecedentes_pacientes; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO antecedentes_pacientes (id_ant_pac, id_ant_per, id_pac) VALUES (90, 1, 56);
INSERT INTO antecedentes_pacientes (id_ant_pac, id_ant_per, id_pac) VALUES (91, 1, 57);
INSERT INTO antecedentes_pacientes (id_ant_pac, id_ant_per, id_pac) VALUES (93, 2, 58);
INSERT INTO antecedentes_pacientes (id_ant_pac, id_ant_per, id_pac) VALUES (98, 2, 63);
INSERT INTO antecedentes_pacientes (id_ant_pac, id_ant_per, id_pac) VALUES (99, 1, 59);
INSERT INTO antecedentes_pacientes (id_ant_pac, id_ant_per, id_pac) VALUES (100, 2, 54);
INSERT INTO antecedentes_pacientes (id_ant_pac, id_ant_per, id_pac) VALUES (101, 3, 54);


--
-- TOC entry 2325 (class 0 OID 32443)
-- Dependencies: 1676
-- Data for Name: antecedentes_personales; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO antecedentes_personales (id_ant_per, nom_ant_per) VALUES (1, 'Ninguna');
INSERT INTO antecedentes_personales (id_ant_per, nom_ant_per) VALUES (2, 'Obesidad');
INSERT INTO antecedentes_personales (id_ant_per, nom_ant_per) VALUES (3, 'Diabetes');
INSERT INTO antecedentes_personales (id_ant_per, nom_ant_per) VALUES (4, 'Traumatismo');
INSERT INTO antecedentes_personales (id_ant_per, nom_ant_per) VALUES (5, 'Cirugía');
INSERT INTO antecedentes_personales (id_ant_per, nom_ant_per) VALUES (6, 'HIV/SIDA');
INSERT INTO antecedentes_personales (id_ant_per, nom_ant_per) VALUES (7, 'Cáncer');
INSERT INTO antecedentes_personales (id_ant_per, nom_ant_per) VALUES (8, 'inmunosupresión/Neutropenia');
INSERT INTO antecedentes_personales (id_ant_per, nom_ant_per) VALUES (9, 'Uso Esteroides');
INSERT INTO antecedentes_personales (id_ant_per, nom_ant_per) VALUES (10, 'Embarazo');
INSERT INTO antecedentes_personales (id_ant_per, nom_ant_per) VALUES (11, 'Neoplasias');
INSERT INTO antecedentes_personales (id_ant_per, nom_ant_per) VALUES (12, 'Inanición');
INSERT INTO antecedentes_personales (id_ant_per, nom_ant_per) VALUES (13, 'Otros');


--
-- TOC entry 2326 (class 0 OID 32448)
-- Dependencies: 1678
-- Data for Name: auditoria_transacciones; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (1, '2011-08-28 18:16:18.03', 17, 10, '<?xml version="1.0" standalone="yes"?><modificacion_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="Nombre"><actual>Adriana</actual><anterior>Adriana</anterior></campo><campo nombre="Apellido"><actual>Lozada</actual><anterior>Lozada</anterior></campo><campo nombre="Cédula"><actual>17651233</actual><anterior>17651233</anterior></campo><campo nombre="Fecha Nacimiento"><actual>2011-09-06</actual><anterior>2011-09-06</anterior></campo><campo nombre="Nacionalidad"><actual>Venezolano</actual><anterior>Venezolano</anterior></campo><campo nombre="Teléfono Habitación"><actual>3622824</actual><anterior>3622824</anterior></campo><campo nombre="Teléfono Célular"><actual>04265168824</actual><anterior>04265168824</anterior></campo><campo nombre="Ocupación"><actual>Técnico</actual><anterior>Técnico</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>Venezuela</anterior></campo><campo nombre="Estado"><actual>Distrito Capital</actual><anterior>Distrito Capital</anterior></campo><campo nombre="Municipio"><actual>	Libertador Caracas		 </actual><anterior>	Libertador Caracas		 </anterior></campo><campo nombre="Ciudad"><actual>Guarenas</actual><anterior>Guarenas</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Uso Esteroides ,Neoplasias ,Inanición </actual><anterior>Uso Esteroides ,Neoplasias ,Inanición </anterior></campo></tabla></modificacion_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (2, '2011-09-04 11:30:11.606', 17, 14, '<?xml version="1.0" standalone="yes"?><eliminacion_del_historial_paciente>
			 <tabla nombre="historiales_pacientes"><campo nombre="Nombre Paciente"><actual>ninguno</actual><anterior>Adriana</anterior></campo><campo nombre="Apellido Paciente"><actual>ninguno</actual><anterior>Lozada</anterior></campo><campo nombre="Cédula Paciente"><actual>ninguno</actual><anterior>17651233</anterior></campo><campo nombre="Descripción de la Historia"><actual>ninguno</actual><anterior></anterior></campo><campo nombre="Descripción Adicional"><actual>ninguno</actual><anterior></anterior></campo><campo nombre="Fecha de Historia"><actual>ninguno</actual><anterior>2011-07-08 12:11:11.417-04:30</anterior></campo></tabla></eliminacion_del_historial_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (3, '2011-09-11 17:10:18.105', 17, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia </anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia Animales de Corral ,Aves ,Gato ,Perro </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia Animales de Corral ,Gato ,Perro </anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia Animales de Corral ,Aves ,Gato ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Radioterapia ,Sistémicos ,Tópicos </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia Animales de Corral ,Gato ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Radioterapia ,Sistémicos ,Tópicos </anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>10</actual><anterior>10</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (4, '2011-11-02 22:57:44.609', 17, 15, '<?xml version="1.0" standalone="yes"?><registrar_muestra_clínica_paciente>
			 <tabla nombre="muestras_pacientes"><campo nombre="Nombre"><actual>Adriana</actual><anterior>Adriana</anterior></campo><campo nombre="Apellido"><actual>Lozada</actual><anterior>Lozada</anterior></campo><campo nombre="Cédula"><actual>17651233</actual><anterior>17651233</anterior></campo><campo nombre="Muestra Clínica"><actual>ninguno</actual><anterior>ninguno</anterior></campo></tabla></registrar_muestra_clínica_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (5, '2011-11-02 22:59:25.293', 17, 15, '<?xml version="1.0" standalone="yes"?><registrar_muestra_clínica_paciente>
			 <tabla nombre="muestras_pacientes"><campo nombre="Nombre"><actual>Adriana</actual><anterior>Adriana</anterior></campo><campo nombre="Apellido"><actual>Lozada</actual><anterior>Lozada</anterior></campo><campo nombre="Cédula"><actual>17651233</actual><anterior>17651233</anterior></campo><campo nombre="Muestra Clínica"><actual>ninguno</actual><anterior>ninguno</anterior></campo></tabla></registrar_muestra_clínica_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (6, '2011-11-02 22:59:46.128', 17, 15, '<?xml version="1.0" standalone="yes"?><registrar_muestra_clínica_paciente>
			 <tabla nombre="muestras_pacientes"><campo nombre="Nombre"><actual>Adriana</actual><anterior>Adriana</anterior></campo><campo nombre="Apellido"><actual>Lozada</actual><anterior>Lozada</anterior></campo><campo nombre="Cédula"><actual>17651233</actual><anterior>17651233</anterior></campo><campo nombre="Muestra Clínica"><actual>ninguno</actual><anterior>ninguno</anterior></campo></tabla></registrar_muestra_clínica_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (7, '2011-11-02 22:59:50.854', 17, 15, '<?xml version="1.0" standalone="yes"?><registrar_muestra_clínica_paciente>
			 <tabla nombre="muestras_pacientes"><campo nombre="Nombre"><actual>Adriana</actual><anterior>Adriana</anterior></campo><campo nombre="Apellido"><actual>Lozada</actual><anterior>Lozada</anterior></campo><campo nombre="Cédula"><actual>17651233</actual><anterior>17651233</anterior></campo><campo nombre="Muestra Clínica"><actual>ninguno</actual><anterior>ninguno</anterior></campo></tabla></registrar_muestra_clínica_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (17, '2011-11-16 08:16:22.776', 17, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Barrio Adentro I </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I Pediatria ,urologia </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Barrio Adentro I</anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I Pediatria ,urologia</actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Barrio Adentro </anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I Pediatria ,urologiaCitotóxicos ,Glucorticoides </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Barrio Adentro Citotóxicos ,Glucorticoides </anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>5</actual><anterior>5</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (8, '2011-11-06 21:49:49.907', 17, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia </anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia Animales de Corral ,Aves ,Gato ,Perro </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia Animales de Corral ,Aves ,Gato ,Perro </anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia Animales de Corral ,Aves ,Gato ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Radioterapia ,Sistémicos ,Tópicos </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia Animales de Corral ,Aves ,Gato ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Radioterapia ,Sistémicos ,Tópicos </anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>10</actual><anterior>10</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (9, '2011-11-06 22:30:55.296', 17, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia </anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Perro </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia Animales de Corral ,Aves ,Gato ,Perro </anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Radioterapia ,Sistémicos ,Tópicos </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia Animales de Corral ,Aves ,Gato ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Radioterapia ,Sistémicos ,Tópicos </anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>10</actual><anterior>10</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (10, '2011-11-06 22:41:12.072', 17, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria </anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Perro </anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Radioterapia ,Sistémicos ,Tópicos </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Radioterapia ,Sistémicos ,Tópicos </anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>10</actual><anterior>10</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (11, '2011-11-06 23:25:18.039', 17, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria </anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro </anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Radioterapia ,Sistémicos ,Tópicos </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Radioterapia ,Sistémicos ,Tópicos </anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>10</actual><anterior>10</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (12, '2011-11-06 23:25:21.92', 17, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria </anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Perro </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro </anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Radioterapia ,Sistémicos ,Tópicos </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Radioterapia ,Sistémicos ,Tópicos </anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>10</actual><anterior>10</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (13, '2011-11-06 23:25:53.843', 17, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria </anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Perro </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Perro </anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Radioterapia ,Sistémicos ,Tópicos </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Radioterapia ,Sistémicos ,Tópicos </anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>10</actual><anterior>10</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (14, '2011-11-16 08:12:59.528', 17, 10, '<?xml version="1.0" standalone="yes"?><modificacion_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="Nombre"><actual>Adriana</actual><anterior>Adriana</anterior></campo><campo nombre="Apellido"><actual>Lozada</actual><anterior>Lozada</anterior></campo><campo nombre="Cédula"><actual>17651233</actual><anterior>17651233</anterior></campo><campo nombre="Fecha Nacimiento"><actual>2011-09-06</actual><anterior>2011-09-06</anterior></campo><campo nombre="Sexo"><actual>F</actual><anterior>F</anterior></campo><campo nombre="Nacionalidad"><actual>Venezolano</actual><anterior>Venezolano</anterior></campo><campo nombre="Teléfono Habitación"><actual>3622824</actual><anterior>3622824</anterior></campo><campo nombre="Teléfono Célular"><actual>04265168824</actual><anterior>04265168824</anterior></campo><campo nombre="Ocupación"><actual>Técnico</actual><anterior>Técnico</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>Venezuela</anterior></campo><campo nombre="Estado"><actual>Distrito Capital</actual><anterior>Distrito Capital</anterior></campo><campo nombre="Municipio"><actual>	Libertador Caracas		 </actual><anterior>	Libertador Caracas		 </anterior></campo><campo nombre="Ciudad"><actual>Guarenas</actual><anterior>Guarenas</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Obesidad ,Diabetes ,Traumatismo ,Uso Esteroides ,Neoplasias ,Inanición </actual><anterior>Uso Esteroides ,Neoplasias ,Inanición </anterior></campo></tabla></modificacion_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (15, '2011-11-16 08:15:57.618', 17, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I </actual><anterior>Ambulatorio Rural </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I</actual><anterior>Ambulatorio Rural</anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro </actual><anterior>Ambulatorio Rura</anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro</actual><anterior>Ambulatorio Rur</anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>5</actual><anterior>5</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (16, '2011-11-16 08:16:11.188', 17, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Barrio Adentro I </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I</actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Barrio Adentro I</anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Barrio Adentro </anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro Citotóxicos ,Glucorticoides </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Barrio Adentro</anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>5</actual><anterior>5</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (18, '2011-11-16 08:28:01.434', 17, 15, '<?xml version="1.0" standalone="yes"?><registrar_muestra_clínica_paciente>
			 <tabla nombre="muestras_pacientes"><campo nombre="Nombre"><actual>Adriana</actual><anterior>Adriana</anterior></campo><campo nombre="Apellido"><actual>Lozada</actual><anterior>Lozada</anterior></campo><campo nombre="Cédula"><actual>17651233</actual><anterior>17651233</anterior></campo><campo nombre="Muestra Clínica"><actual>ninguno</actual><anterior>ninguno</anterior></campo></tabla></registrar_muestra_clínica_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (19, '2011-11-16 08:28:26.924', 17, 15, '<?xml version="1.0" standalone="yes"?><registrar_muestra_clínica_paciente>
			 <tabla nombre="muestras_pacientes"><campo nombre="Nombre"><actual>Adriana</actual><anterior>Adriana</anterior></campo><campo nombre="Apellido"><actual>Lozada</actual><anterior>Lozada</anterior></campo><campo nombre="Cédula"><actual>17651233</actual><anterior>17651233</anterior></campo><campo nombre="Muestra Clínica"><actual>ninguno</actual><anterior>ninguno</anterior></campo></tabla></registrar_muestra_clínica_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (20, '2011-11-16 08:31:55.499', 17, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria </anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Perro </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Perro </anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Otros ,Radioterapia ,Sistémicos ,Tópicos </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Radioterapia ,Sistémicos ,Tópicos </anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>10</actual><anterior>10</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (21, '2011-11-16 08:32:09.104', 17, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria </anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Perro </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Perro </anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Otros ,Radioterapia ,Sistémicos ,Tópicos </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Otros ,Radioterapia ,Sistémicos ,Tópicos </anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>12</actual><anterior>10</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (22, '2011-11-16 16:01:40.948', 17, 15, '<?xml version="1.0" standalone="yes"?><registrar_muestra_clínica_paciente>
			 <tabla nombre="muestras_pacientes"><campo nombre="Nombre"><actual>Adriana</actual><anterior>Adriana</anterior></campo><campo nombre="Apellido"><actual>Lozada</actual><anterior>Lozada</anterior></campo><campo nombre="Cédula"><actual>17651233</actual><anterior>17651233</anterior></campo><campo nombre="Muestra Clínica"><actual>ninguno</actual><anterior>ninguno</anterior></campo></tabla></registrar_muestra_clínica_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (23, '2011-11-16 16:01:49.432', 17, 15, '<?xml version="1.0" standalone="yes"?><registrar_muestra_clínica_paciente>
			 <tabla nombre="muestras_pacientes"><campo nombre="Nombre"><actual>Adriana</actual><anterior>Adriana</anterior></campo><campo nombre="Apellido"><actual>Lozada</actual><anterior>Lozada</anterior></campo><campo nombre="Cédula"><actual>17651233</actual><anterior>17651233</anterior></campo><campo nombre="Muestra Clínica"><actual>ninguno</actual><anterior>ninguno</anterior></campo></tabla></registrar_muestra_clínica_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (24, '2011-11-16 16:01:58.618', 17, 15, '<?xml version="1.0" standalone="yes"?><registrar_muestra_clínica_paciente>
			 <tabla nombre="muestras_pacientes"><campo nombre="Nombre"><actual>Adriana</actual><anterior>Adriana</anterior></campo><campo nombre="Apellido"><actual>Lozada</actual><anterior>Lozada</anterior></campo><campo nombre="Cédula"><actual>17651233</actual><anterior>17651233</anterior></campo><campo nombre="Muestra Clínica"><actual>ninguno</actual><anterior>ninguno</anterior></campo></tabla></registrar_muestra_clínica_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (25, '2011-11-16 16:02:13.733', 17, 15, '<?xml version="1.0" standalone="yes"?><registrar_muestra_clínica_paciente>
			 <tabla nombre="muestras_pacientes"><campo nombre="Nombre"><actual>Adriana</actual><anterior>Adriana</anterior></campo><campo nombre="Apellido"><actual>Lozada</actual><anterior>Lozada</anterior></campo><campo nombre="Cédula"><actual>17651233</actual><anterior>17651233</anterior></campo><campo nombre="Muestra Clínica"><actual>ninguno</actual><anterior>ninguno</anterior></campo></tabla></registrar_muestra_clínica_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (26, '2011-11-16 16:02:22.528', 17, 15, '<?xml version="1.0" standalone="yes"?><registrar_muestra_clínica_paciente>
			 <tabla nombre="muestras_pacientes"><campo nombre="Nombre"><actual>Adriana</actual><anterior>Adriana</anterior></campo><campo nombre="Apellido"><actual>Lozada</actual><anterior>Lozada</anterior></campo><campo nombre="Cédula"><actual>17651233</actual><anterior>17651233</anterior></campo><campo nombre="Muestra Clínica"><actual>ninguno</actual><anterior>ninguno</anterior></campo></tabla></registrar_muestra_clínica_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (27, '2011-11-16 16:02:39.045', 17, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria </anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Perro </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Perro </anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Otros ,Radioterapia ,Sistémicos ,Tópicos </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Otros ,Radioterapia ,Sistémicos ,Tópicos </anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>24</actual><anterior>12</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (28, '2011-11-16 16:09:17.079', 17, 10, '<?xml version="1.0" standalone="yes"?><modificacion_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="Nombre"><actual>Adriana</actual><anterior>Adriana</anterior></campo><campo nombre="Apellido"><actual>Lozada</actual><anterior>Lozada</anterior></campo><campo nombre="Cédula"><actual>17651233</actual><anterior>17651233</anterior></campo><campo nombre="Fecha Nacimiento"><actual>2011-09-06</actual><anterior>2011-09-06</anterior></campo><campo nombre="Sexo"><actual>F</actual><anterior>F</anterior></campo><campo nombre="Nacionalidad"><actual>Venezolano</actual><anterior>Venezolano</anterior></campo><campo nombre="Teléfono Habitación"><actual>3622824</actual><anterior>3622824</anterior></campo><campo nombre="Teléfono Célular"><actual>04265168824</actual><anterior>04265168824</anterior></campo><campo nombre="Ocupación"><actual>Técnico</actual><anterior>Técnico</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>Venezuela</anterior></campo><campo nombre="Estado"><actual>Yaracuy</actual><anterior>Distrito Capital</anterior></campo><campo nombre="Municipio"><actual>	Cocorote		 </actual><anterior>	Libertador Caracas		 </anterior></campo><campo nombre="Ciudad"><actual>Guarenas</actual><anterior>Guarenas</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Obesidad ,Diabetes ,Traumatismo ,Uso Esteroides ,Neoplasias ,Inanición </actual><anterior>Obesidad ,Diabetes ,Traumatismo ,Uso Esteroides ,Neoplasias ,Inanición </anterior></campo></tabla></modificacion_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (29, '2011-11-16 16:16:51.944', 17, 13, '<?xml version="1.0" standalone="yes"?><modificacion_del_historial_paciente>
		 <tabla nombre="historiales_pacientes"><campo nombre="Nombre Paciente"><actual>Adriana</actual><anterior>Adriana</anterior></campo><campo nombre="Apellido Paciente"><actual>Lozada</actual><anterior>Lozada</anterior></campo><campo nombre="Cédula Paciente"><actual>17651233</actual><anterior>17651233</anterior></campo><campo nombre="Descripción de la Historia"><actual>Prueba del historial de los pacientes para que se puedan registrar las enfermedades que se muestran en la aplicacion, un paciente puede tener una serie de enfermedades por lo que es necesario la creacion de un modulo que permita gestionar,</actual><anterior>demops</anterior></campo><campo nombre="Descripción Adicional"><actual>Gestionar de forma permanente las enfermedades que el paciente puede padecer a lo largo del periodo de tiempo, si el paciente se cura encontes ese historial queda descartado, y se procede a abrir un nuevo historico para el paciente que permita dicho.</actual><anterior>demos</anterior></campo><campo nombre="Fecha de Historia"><actual>2011-07-24 09:39:20.062-04:30</actual><anterior>2011-07-24 09:39:20.062-04:30</anterior></campo></tabla></modificacion_del_historial_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (30, '2011-11-16 16:19:51.588', 17, 12, '<?xml version="1.0" standalone="yes"?><registro_del_historial_paciente>
		 <tabla nombre="historiales_pacientes"><campo nombre="Nombre Paciente"><actual>Mary</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido Paciente"><actual>Wester</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula Paciente"><actual>8752299</actual><anterior>ninguno</anterior></campo><campo nombre="Descripción de la Historia"><actual>Enfermedad prueba</actual><anterior>ninguno</anterior></campo><campo nombre="Descripción Adicional"><actual>Enfermedad prueba</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha de Historia"><actual>2011-11-16 16:19:51.588-04:30</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Tiempo de Evolución"><actual>5</actual><anterior>ninguno</anterior></campo></tabla></registro_del_historial_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (31, '2011-11-16 16:23:23.979', 17, 11, '<?xml version="1.0" standalone="yes"?><eliminacion_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>ninguno</actual><anterior>28</anterior></campo><campo nombre="Nombre"><actual>ninguno</actual><anterior>demo</anterior></campo><campo nombre="Apellido"><actual>ninguno</actual><anterior>sdf</anterior></campo><campo nombre="Cédula"><actual>ninguno</actual><anterior>12345</anterior></campo><campo nombre="Fecha Nacimiento"><actual>ninguno</actual><anterior>2011-07-27</anterior></campo><campo nombre="Nacionalidad"><actual>ninguno</actual><anterior>Venezolano</anterior></campo><campo nombre="Teléfono Habitación"><actual>ninguno</actual><anterior>3622222</anterior></campo><campo nombre="Teléfono Célular"><actual>ninguno</actual><anterior>17302857</anterior></campo><campo nombre="Ocupación"><actual>ninguno</actual><anterior>Técnico</anterior></campo><campo nombre="País"><actual>ninguno</actual><anterior>ninguno</anterior></campo><campo nombre="Estado"><actual>ninguno</actual><anterior>ninguno</anterior></campo><campo nombre="Municipio"><actual>ninguno</actual><anterior>ninguno</anterior></campo><campo nombre="Ciudad"><actual>ninguno</actual><anterior>Guarenas</anterior></campo></tabla><tabla nombre="antecedentes_pacientes"><campo nombre="Antecedentes Personales"><actual>ninguno</actual><anterior>Obesidad ,Diabetes </anterior></campo></tabla></eliminacion_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (52, '2011-12-25 10:20:27.593', 49, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica ,Otros </actual><anterior>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica ,Otros Consulta ,Consulta Interna ,Dermatologia ,Geriatria ,Otros </actual><anterior>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria </anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica ,Otros Consulta ,Consulta Interna ,Dermatologia ,Geriatria ,Otros Animales de Corral ,Aves ,Gato ,Otros ,Perro </actual><anterior>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro </anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica ,Otros Consulta ,Consulta Interna ,Dermatologia ,Geriatria ,Otros Animales de Corral ,Aves ,Gato ,Otros ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Otros ,Radioterapia ,Sistémicos ,Tópicos </actual><anterior>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Otros ,Radioterapia ,Sistémicos ,Tópicos </anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>24</actual><anterior>24</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (32, '2011-11-16 16:24:29.327', 17, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I </actual><anterior></anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I</actual><anterior></anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro IAves </actual><anterior></anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro IAves</actual><anterior></anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>60</actual><anterior>0</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (33, '2011-11-16 16:24:41.348', 17, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Barrio Adentro I </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I</actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Barrio Adentro I</anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro IAves </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Barrio Adentro IAves </anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro IAves</actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Barrio Adentro IAves</anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>1600</actual><anterior>60</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (34, '2011-11-16 16:24:49.149', 17, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Barrio Adentro I </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Barrio Adentro I</anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia Aves </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Barrio Adentro IAves </anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia Aves</actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Barrio Adentro IAves</anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>1600</actual><anterior>1600</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (35, '2011-11-16 16:24:53.225', 17, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Barrio Adentro I </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia </anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia Aves </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia Aves </anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia Aves Citotóxicos ,Glucorticoides </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia Aves</anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>1600</actual><anterior>1600</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (36, '2011-11-16 16:27:53.176', 17, 12, '<?xml version="1.0" standalone="yes"?><registro_del_historial_paciente>
		 <tabla nombre="historiales_pacientes"><campo nombre="Nombre Paciente"><actual>demo</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido Paciente"><actual>asd</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula Paciente"><actual>1234</actual><anterior>ninguno</anterior></campo><campo nombre="Descripción de la Historia"><actual>demostracion de historial</actual><anterior>ninguno</anterior></campo><campo nombre="Descripción Adicional"><actual>demostracion del historial</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha de Historia"><actual>2011-11-16 16:27:53.176-04:30</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Tiempo de Evolución"><actual>5</actual><anterior>ninguno</anterior></campo></tabla></registro_del_historial_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (37, '2011-11-16 16:29:11.01', 17, 12, '<?xml version="1.0" standalone="yes"?><registro_del_historial_paciente>
		 <tabla nombre="historiales_pacientes"><campo nombre="Nombre Paciente"><actual>Gisela </actual><anterior>ninguno</anterior></campo><campo nombre="Apellido Paciente"><actual>Contreras</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula Paciente"><actual>13456094</actual><anterior>ninguno</anterior></campo><campo nombre="Descripción de la Historia"><actual>prototypo</actual><anterior>ninguno</anterior></campo><campo nombre="Descripción Adicional"><actual>Prototypo</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha de Historia"><actual>2011-11-16 16:29:11.01-04:30</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Tiempo de Evolución"><actual>5</actual><anterior>ninguno</anterior></campo></tabla></registro_del_historial_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (38, '2011-11-16 16:31:14.86', 17, 15, '<?xml version="1.0" standalone="yes"?><registrar_muestra_clínica_paciente>
			 <tabla nombre="muestras_pacientes"><campo nombre="Nombre"><actual>Gisela </actual><anterior>Gisela </anterior></campo><campo nombre="Apellido"><actual>Contreras</actual><anterior>Contreras</anterior></campo><campo nombre="Cédula"><actual>13456094</actual><anterior>13456094</anterior></campo><campo nombre="Muestra Clínica"><actual>ninguno</actual><anterior>ninguno</anterior></campo></tabla></registrar_muestra_clínica_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (54, '2011-12-25 11:03:56.178', 49, 15, '<?xml version="1.0" standalone="yes"?><registrar_muestra_clínica_paciente>
			 <tabla nombre="muestras_pacientes"><campo nombre="Nombre"><actual>Adriana</actual><anterior>Adriana</anterior></campo><campo nombre="Apellido"><actual>Lozada</actual><anterior>Lozada</anterior></campo><campo nombre="Cédula"><actual>17651233</actual><anterior>17651233</anterior></campo><campo nombre="Muestra Clínica"><actual>ninguno</actual><anterior>ninguno</anterior></campo></tabla></registrar_muestra_clínica_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (39, '2011-11-16 16:31:34.395', 17, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Barrio Adentro I </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia </anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia Aves </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia Aves </anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia Aves Citotóxicos ,Glucorticoides ,Otros ,Radioterapia </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia Aves Citotóxicos ,Glucorticoides </anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>1600</actual><anterior>1600</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (40, '2011-11-16 16:31:48.354', 17, 15, '<?xml version="1.0" standalone="yes"?><registrar_muestra_clínica_paciente>
			 <tabla nombre="muestras_pacientes"><campo nombre="Nombre"><actual>Gisela </actual><anterior>Gisela </anterior></campo><campo nombre="Apellido"><actual>Contreras</actual><anterior>Contreras</anterior></campo><campo nombre="Cédula"><actual>13456094</actual><anterior>13456094</anterior></campo><campo nombre="Muestra Clínica"><actual>ninguno</actual><anterior>ninguno</anterior></campo></tabla></registrar_muestra_clínica_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (41, '2011-11-16 16:33:10.135', 17, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Barrio Adentro I </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia </anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia Aves </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia Aves </anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia Aves Citotóxicos ,Glucorticoides ,Otros ,Radioterapia </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia Aves Citotóxicos ,Glucorticoides ,Otros ,Radioterapia </anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>1600</actual><anterior>1600</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (42, '2011-11-16 16:34:33.723', 17, 15, '<?xml version="1.0" standalone="yes"?><registrar_muestra_clínica_paciente>
			 <tabla nombre="muestras_pacientes"><campo nombre="Nombre"><actual>Adriana</actual><anterior>Adriana</anterior></campo><campo nombre="Apellido"><actual>Lozada</actual><anterior>Lozada</anterior></campo><campo nombre="Cédula"><actual>17651233</actual><anterior>17651233</anterior></campo><campo nombre="Muestra Clínica"><actual>ninguno</actual><anterior>ninguno</anterior></campo></tabla></registrar_muestra_clínica_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (43, '2011-12-14 20:24:34.344', 17, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria </anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Perro </anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Otros ,Radioterapia ,Sistémicos ,Tópicos </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Otros ,Radioterapia ,Sistémicos ,Tópicos </anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>24</actual><anterior>24</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (53, '2011-12-25 10:21:26.199', 49, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica ,Otros </actual><anterior>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica ,Otros </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica ,Otros Consulta ,Consulta Interna ,Dermatologia ,Geriatria ,Otros </actual><anterior>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica ,Otros Consulta ,Consulta Interna ,Dermatologia ,Geriatria ,Otros </anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica ,Otros Consulta ,Consulta Interna ,Dermatologia ,Geriatria ,Otros Animales de Corral ,Aves ,Gato ,Otros ,Perro </actual><anterior>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica ,Otros Consulta ,Consulta Interna ,Dermatologia ,Geriatria ,Otros Animales de Corral ,Aves ,Gato ,Otros ,Perro </anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica ,Otros Consulta ,Consulta Interna ,Dermatologia ,Geriatria ,Otros Animales de Corral ,Aves ,Gato ,Otros ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Otros ,Radioterapia ,Sistémicos ,Tópicos </actual><anterior>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica ,Otros Consulta ,Consulta Interna ,Dermatologia ,Geriatria ,Otros Animales de Corral ,Aves ,Gato ,Otros ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Otros ,Radioterapia ,Sistémicos ,Tópicos </anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>24</actual><anterior>24</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (55, '2011-12-25 11:06:38.612', 49, 15, '<?xml version="1.0" standalone="yes"?><registrar_muestra_clínica_paciente>
			 <tabla nombre="muestras_pacientes"><campo nombre="Nombre"><actual>Adriana</actual><anterior>Adriana</anterior></campo><campo nombre="Apellido"><actual>Lozada</actual><anterior>Lozada</anterior></campo><campo nombre="Cédula"><actual>17651233</actual><anterior>17651233</anterior></campo><campo nombre="Muestra Clínica"><actual>ninguno</actual><anterior>ninguno</anterior></campo></tabla></registrar_muestra_clínica_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (56, '2011-12-25 11:06:56.736', 49, 15, '<?xml version="1.0" standalone="yes"?><registrar_muestra_clínica_paciente>
			 <tabla nombre="muestras_pacientes"><campo nombre="Nombre"><actual>Adriana</actual><anterior>Adriana</anterior></campo><campo nombre="Apellido"><actual>Lozada</actual><anterior>Lozada</anterior></campo><campo nombre="Cédula"><actual>17651233</actual><anterior>17651233</anterior></campo><campo nombre="Muestra Clínica"><actual>ninguno</actual><anterior>ninguno</anterior></campo></tabla></registrar_muestra_clínica_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (44, '2011-12-14 20:27:37.567', 17, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria </anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro </anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Otros ,Radioterapia ,Sistémicos ,Tópicos </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Otros ,Radioterapia ,Sistémicos ,Tópicos </anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>24</actual><anterior>24</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (45, '2011-12-14 20:28:18.588', 17, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria </anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro </anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Otros ,Radioterapia ,Sistémicos ,Tópicos </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Otros ,Radioterapia ,Sistémicos ,Tópicos </anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>24</actual><anterior>24</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (46, '2011-12-14 20:30:20.093', 17, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria </anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro </anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Otros ,Radioterapia ,Sistémicos ,Tópicos </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Otros ,Radioterapia ,Sistémicos ,Tópicos </anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>24</actual><anterior>24</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (47, '2011-12-14 20:30:25.196', 17, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria </anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro </anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Otros ,Radioterapia ,Sistémicos ,Tópicos </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Otros ,Radioterapia ,Sistémicos ,Tópicos </anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>24</actual><anterior>24</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (48, '2011-12-14 20:41:45.433', 17, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria </anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro </anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Otros ,Radioterapia ,Sistémicos ,Tópicos </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Otros ,Radioterapia ,Sistémicos ,Tópicos </anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>24</actual><anterior>24</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (49, '2011-12-14 21:14:31.169', 17, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria </anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro </anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Otros ,Radioterapia ,Sistémicos ,Tópicos </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Otros ,Radioterapia ,Sistémicos ,Tópicos </anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>24</actual><anterior>24</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (50, '2011-12-14 21:19:24.826', 17, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria </anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Perro </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro </anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Otros ,Radioterapia ,Sistémicos ,Tópicos </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Otros ,Radioterapia ,Sistémicos ,Tópicos </anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>24</actual><anterior>24</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (51, '2011-12-14 21:19:37.045', 17, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria </anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Perro </anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Clínica Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Otros ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Otros ,Radioterapia ,Sistémicos ,Tópicos </actual><anterior>Ambulatorio Urbano ,Ambulatorio Rural ,Clínica ,Barrio Adentro I Consulta ,Consulta Interna ,Dermatologia ,Geriatria Animales de Corral ,Aves ,Gato ,Perro Citotóxicos ,Glucorticoides ,Hormonas Sexuales ,Inmunosupresores ,Otros ,Radioterapia ,Sistémicos ,Tópicos </anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>24</actual><anterior>24</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (57, '2012-01-12 11:07:02.903', 49, 14, '<?xml version="1.0" standalone="yes"?><eliminacion_del_historial_paciente>
			 <tabla nombre="historiales_pacientes"><campo nombre="Nombre Paciente"><actual>ninguno</actual><anterior>demo</anterior></campo><campo nombre="Apellido Paciente"><actual>ninguno</actual><anterior>asd</anterior></campo><campo nombre="Cédula Paciente"><actual>ninguno</actual><anterior>1234</anterior></campo><campo nombre="Descripción de la Historia"><actual>ninguno</actual><anterior>demostracion de historial</anterior></campo><campo nombre="Descripción Adicional"><actual>ninguno</actual><anterior>demostracion del historial</anterior></campo><campo nombre="Fecha de Historia"><actual>ninguno</actual><anterior>2011-11-16 16:27:53.176-04:30</anterior></campo></tabla></eliminacion_del_historial_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (58, '2012-01-12 11:09:26.45', 49, 9, '<?xml version="1.0" standalone="yes"?><registro_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>32</actual><anterior>ninguno</anterior></campo><campo nombre="Nombre"><actual>pruebaliss</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido"><actual>pruebaliss</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula"><actual>17651243</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha Nacimiento"><actual>1987-01-10</actual><anterior>ninguno</anterior></campo><campo nombre="Sexo"><actual>F</actual><anterior>ninguno</anterior></campo><campo nombre="Nacionalidad"><actual>Venezolano</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Habitación"><actual>02123617323</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Célular"><actual>04269150722</actual><anterior>ninguno</anterior></campo><campo nombre="Ocupación"><actual>Profesional</actual><anterior>ninguno</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>ninguno</anterior></campo><campo nombre="Estado"><actual>Miranda</actual><anterior>ninguno</anterior></campo><campo nombre="Municipio"><actual>	Plaza		 </actual><anterior>ninguno</anterior></campo><campo nombre="Ciudad"><actual>guarenas</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Cirugía ,Embarazo ,Neoplasias ,Otros </actual><anterior>ninguno</anterior></campo></tabla></registro_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (59, '2012-01-12 11:09:50.576', 49, 12, '<?xml version="1.0" standalone="yes"?><registro_del_historial_paciente>
		 <tabla nombre="historiales_pacientes"><campo nombre="Nombre Paciente"><actual>pruebaliss</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido Paciente"><actual>pruebaliss</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula Paciente"><actual>17651243</actual><anterior>ninguno</anterior></campo><campo nombre="Descripción de la Historia"><actual>hdjsfhjhdfjh</actual><anterior>ninguno</anterior></campo><campo nombre="Descripción Adicional"><actual>dhfksdhfjkhsdjkfhjk</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha de Historia"><actual>2012-01-12 11:09:50.576-04:30</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Tiempo de Evolución"><actual>5</actual><anterior>ninguno</anterior></campo></tabla></registro_del_historial_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (60, '2012-01-15 21:53:39.276', 17, 14, '<?xml version="1.0" standalone="yes"?><eliminacion_del_historial_paciente>
			 <tabla nombre="historiales_pacientes"><campo nombre="Nombre Paciente"><actual>ninguno</actual><anterior>Adriana</anterior></campo><campo nombre="Apellido Paciente"><actual>ninguno</actual><anterior>Lozada</anterior></campo><campo nombre="Cédula Paciente"><actual>ninguno</actual><anterior>17651233</anterior></campo><campo nombre="Descripción de la Historia"><actual>ninguno</actual><anterior>Prueba del historial de los pacientes para que se puedan registrar las enfermedades que se muestran en la aplicacion, un paciente puede tener una serie de enfermedades por lo que es necesario la creacion de un modulo que permita gestionar,</anterior></campo><campo nombre="Descripción Adicional"><actual>ninguno</actual><anterior>Gestionar de forma permanente las enfermedades que el paciente puede padecer a lo largo del periodo de tiempo, si el paciente se cura encontes ese historial queda descartado, y se procede a abrir un nuevo historico para el paciente que permita dicho.</anterior></campo><campo nombre="Fecha de Historia"><actual>ninguno</actual><anterior>2011-07-24 09:39:20.062-04:30</anterior></campo></tabla></eliminacion_del_historial_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (61, '2012-01-15 22:29:07.781', 17, 14, '<?xml version="1.0" standalone="yes"?><eliminacion_del_historial_paciente>
			 <tabla nombre="historiales_pacientes"><campo nombre="Nombre Paciente"><actual>ninguno</actual><anterior>Adriana</anterior></campo><campo nombre="Apellido Paciente"><actual>ninguno</actual><anterior>Lozada</anterior></campo><campo nombre="Cédula Paciente"><actual>ninguno</actual><anterior>17651233</anterior></campo><campo nombre="Descripción de la Historia"><actual>ninguno</actual><anterior>Nuevamente se inicia otra historia para hacer un seguimiento de rastros de una enfermedad de la piel</anterior></campo><campo nombre="Descripción Adicional"><actual>ninguno</actual><anterior>El paciente por visualizacion padece de una coloracion en la piel.</anterior></campo><campo nombre="Fecha de Historia"><actual>ninguno</actual><anterior>2011-07-01 10:24:00.188-04:30</anterior></campo></tabla></eliminacion_del_historial_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (62, '2012-01-15 22:29:29.013', 17, 12, '<?xml version="1.0" standalone="yes"?><registro_del_historial_paciente>
		 <tabla nombre="historiales_pacientes"><campo nombre="Nombre Paciente"><actual>Adriana</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido Paciente"><actual>Lozada</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula Paciente"><actual>17651233</actual><anterior>ninguno</anterior></campo><campo nombre="Descripción de la Historia"><actual>demostracion</actual><anterior>ninguno</anterior></campo><campo nombre="Descripción Adicional"><actual></actual><anterior>ninguno</anterior></campo><campo nombre="Fecha de Historia"><actual>2012-01-15 22:29:29.013-04:30</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Tiempo de Evolución"><actual>0</actual><anterior>ninguno</anterior></campo></tabla></registro_del_historial_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (110, '2012-01-17 08:03:08.986', 17, 15, '<?xml version="1.0" standalone="yes"?><registrar_muestra_clínica_paciente>
			 <tabla nombre="muestras_pacientes"><campo nombre="Nombre"><actual>A</actual><anterior>A</anterior></campo><campo nombre="Apellido"><actual>A</actual><anterior>A</anterior></campo><campo nombre="Cédula"><actual>17302803</actual><anterior>17302803</anterior></campo><campo nombre="Muestra Clínica"><actual>ninguno</actual><anterior>ninguno</anterior></campo></tabla></registrar_muestra_clínica_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (137, '2012-01-22 05:06:56.04', 49, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual></actual><anterior></anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual></actual><anterior></anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual></actual><anterior></anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual></actual><anterior></anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>-111111</actual><anterior>0</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (63, '2012-01-15 22:53:25.124', 17, 9, '<?xml version="1.0" standalone="yes"?><registro_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>6</actual><anterior>ninguno</anterior></campo><campo nombre="Nombre"><actual>''</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido"><actual>asdf</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula"><actual>17171717</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha Nacimiento"><actual>2012-01-15</actual><anterior>ninguno</anterior></campo><campo nombre="Sexo"><actual>F</actual><anterior>ninguno</anterior></campo><campo nombre="Nacionalidad"><actual>Venezolano</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Habitación"><actual>1010101010</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Célular"><actual>10101010</actual><anterior>ninguno</anterior></campo><campo nombre="Ocupación"><actual>Profesional</actual><anterior>ninguno</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>ninguno</anterior></campo><campo nombre="Estado"><actual>Nueva Esparta</actual><anterior>ninguno</anterior></campo><campo nombre="Municipio"><actual>	Díaz		 </actual><anterior>ninguno</anterior></campo><campo nombre="Ciudad"><actual>sdfsdf</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Ninguna ,Obesidad </actual><anterior>ninguno</anterior></campo></tabla></registro_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (64, '2012-01-15 23:23:57.077', 17, 9, '<?xml version="1.0" standalone="yes"?><registro_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>6</actual><anterior>ninguno</anterior></campo><campo nombre="Nombre"><actual>&#039;demostracion&#039;</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido"><actual>asdf</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula"><actual>17171711</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha Nacimiento"><actual>2012-01-15</actual><anterior>ninguno</anterior></campo><campo nombre="Sexo"><actual>F</actual><anterior>ninguno</anterior></campo><campo nombre="Nacionalidad"><actual>Venezolano</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Habitación"><actual>1010101010</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Célular"><actual>10101010</actual><anterior>ninguno</anterior></campo><campo nombre="Ocupación"><actual>Profesional</actual><anterior>ninguno</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>ninguno</anterior></campo><campo nombre="Estado"><actual>Nueva Esparta</actual><anterior>ninguno</anterior></campo><campo nombre="Municipio"><actual>	Díaz		 </actual><anterior>ninguno</anterior></campo><campo nombre="Ciudad"><actual>sdfsdf</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Ninguna ,Obesidad </actual><anterior>ninguno</anterior></campo></tabla></registro_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (65, '2012-01-15 23:29:04.689', 17, 9, '<?xml version="1.0" standalone="yes"?><registro_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>6</actual><anterior>ninguno</anterior></campo><campo nombre="Nombre"><actual>&#039;</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido"><actual>sdfg</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula"><actual>101010</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha Nacimiento"><actual>2012-01-03</actual><anterior>ninguno</anterior></campo><campo nombre="Sexo"><actual>F</actual><anterior>ninguno</anterior></campo><campo nombre="Nacionalidad"><actual>Venezolano</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Habitación"><actual>101010</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Célular"><actual>10101010</actual><anterior>ninguno</anterior></campo><campo nombre="Ocupación"><actual>Profesional</actual><anterior>ninguno</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>ninguno</anterior></campo><campo nombre="Estado"><actual>Nueva Esparta</actual><anterior>ninguno</anterior></campo><campo nombre="Municipio"><actual>	Díaz		 </actual><anterior>ninguno</anterior></campo><campo nombre="Ciudad"><actual>101</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Obesidad </actual><anterior>ninguno</anterior></campo></tabla></registro_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (66, '2012-01-16 00:07:35.121', 17, 9, '<?xml version="1.0" standalone="yes"?><registro_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>6</actual><anterior>ninguno</anterior></campo><campo nombre="Nombre"><actual>&#039;</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido"><actual>asdfgsdfg</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula"><actual>10101</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha Nacimiento"><actual>2012-01-11</actual><anterior>ninguno</anterior></campo><campo nombre="Sexo"><actual>F</actual><anterior>ninguno</anterior></campo><campo nombre="Nacionalidad"><actual>Extranjero</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Habitación"><actual>101010</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Célular"><actual>1010</actual><anterior>ninguno</anterior></campo><campo nombre="Ocupación"><actual>Profesional</actual><anterior>ninguno</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>ninguno</anterior></campo><campo nombre="Estado"><actual>Amazonas</actual><anterior>ninguno</anterior></campo><campo nombre="Municipio"><actual>	Alto Orinoco		 </actual><anterior>ninguno</anterior></campo><campo nombre="Ciudad"><actual>1010</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Obesidad </actual><anterior>ninguno</anterior></campo></tabla></registro_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (67, '2012-01-16 00:08:37.836', 17, 9, '<?xml version="1.0" standalone="yes"?><registro_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>6</actual><anterior>ninguno</anterior></campo><campo nombre="Nombre"><actual>&#039;</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido"><actual>sdfg</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula"><actual>1010</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha Nacimiento"><actual>2012-01-17</actual><anterior>ninguno</anterior></campo><campo nombre="Sexo"><actual>F</actual><anterior>ninguno</anterior></campo><campo nombre="Nacionalidad"><actual>Venezolano</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Habitación"><actual>1010</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Célular"><actual>17101010</actual><anterior>ninguno</anterior></campo><campo nombre="Ocupación"><actual>Obrero</actual><anterior>ninguno</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>ninguno</anterior></campo><campo nombre="Estado"><actual>Amazonas</actual><anterior>ninguno</anterior></campo><campo nombre="Municipio"><actual>	Atabapo		 </actual><anterior>ninguno</anterior></campo><campo nombre="Ciudad"><actual>fghfgh</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Traumatismo </actual><anterior>ninguno</anterior></campo></tabla></registro_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (68, '2012-01-16 00:12:13.936', 17, 9, '<?xml version="1.0" standalone="yes"?><registro_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>6</actual><anterior>ninguno</anterior></campo><campo nombre="Nombre"><actual>&#039;</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido"><actual>asdfaadf</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula"><actual>171010</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha Nacimiento"><actual>2012-01-05</actual><anterior>ninguno</anterior></campo><campo nombre="Sexo"><actual>F</actual><anterior>ninguno</anterior></campo><campo nombre="Nacionalidad"><actual>Venezolano</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Habitación"><actual>1010101</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Célular"><actual>0111</actual><anterior>ninguno</anterior></campo><campo nombre="Ocupación"><actual>Profesional</actual><anterior>ninguno</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>ninguno</anterior></campo><campo nombre="Estado"><actual>Anzoátegui</actual><anterior>ninguno</anterior></campo><campo nombre="Municipio"><actual>	Bolívar		 </actual><anterior>ninguno</anterior></campo><campo nombre="Ciudad"><actual>asdfadf</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Diabetes ,Traumatismo </actual><anterior>ninguno</anterior></campo></tabla></registro_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (69, '2012-01-16 00:16:25.649', 17, 9, '<?xml version="1.0" standalone="yes"?><registro_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>6</actual><anterior>ninguno</anterior></campo><campo nombre="Nombre"><actual>&#039;</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido"><actual>de</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula"><actual>171717</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha Nacimiento"><actual>2012-01-17</actual><anterior>ninguno</anterior></campo><campo nombre="Sexo"><actual>F</actual><anterior>ninguno</anterior></campo><campo nombre="Nacionalidad"><actual>Venezolano</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Habitación"><actual>1414141</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Célular"><actual>1433</actual><anterior>ninguno</anterior></campo><campo nombre="Ocupación"><actual>Profesional</actual><anterior>ninguno</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>ninguno</anterior></campo><campo nombre="Estado"><actual>Amazonas</actual><anterior>ninguno</anterior></campo><campo nombre="Municipio"><actual>	Atabapo		 </actual><anterior>ninguno</anterior></campo><campo nombre="Ciudad"><actual>101010</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Ninguna </actual><anterior>ninguno</anterior></campo></tabla></registro_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (70, '2012-01-16 00:27:34.182', 17, 11, '<?xml version="1.0" standalone="yes"?><eliminacion_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>ninguno</actual><anterior>32</anterior></campo><campo nombre="Nombre"><actual>ninguno</actual><anterior>&#039;</anterior></campo><campo nombre="Apellido"><actual>ninguno</actual><anterior>sdfg</anterior></campo><campo nombre="Cédula"><actual>ninguno</actual><anterior>101010</anterior></campo><campo nombre="Fecha Nacimiento"><actual>ninguno</actual><anterior>2012-01-03</anterior></campo><campo nombre="Nacionalidad"><actual>ninguno</actual><anterior>Venezolano</anterior></campo><campo nombre="Teléfono Habitación"><actual>ninguno</actual><anterior>101010</anterior></campo><campo nombre="Teléfono Célular"><actual>ninguno</actual><anterior>10101010</anterior></campo><campo nombre="Ocupación"><actual>ninguno</actual><anterior>Profesional</anterior></campo><campo nombre="País"><actual>ninguno</actual><anterior>Venezuela</anterior></campo><campo nombre="Estado"><actual>ninguno</actual><anterior>Nueva Esparta</anterior></campo><campo nombre="Municipio"><actual>ninguno</actual><anterior>	Díaz		 </anterior></campo><campo nombre="Ciudad"><actual>ninguno</actual><anterior>101</anterior></campo></tabla><tabla nombre="antecedentes_pacientes"><campo nombre="Antecedentes Personales"><actual>ninguno</actual><anterior>Obesidad </anterior></campo></tabla></eliminacion_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (71, '2012-01-16 00:27:43.61', 17, 11, '<?xml version="1.0" standalone="yes"?><eliminacion_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>ninguno</actual><anterior>33</anterior></campo><campo nombre="Nombre"><actual>ninguno</actual><anterior>&#039;</anterior></campo><campo nombre="Apellido"><actual>ninguno</actual><anterior>asdfgsdfg</anterior></campo><campo nombre="Cédula"><actual>ninguno</actual><anterior>10101</anterior></campo><campo nombre="Fecha Nacimiento"><actual>ninguno</actual><anterior>2012-01-11</anterior></campo><campo nombre="Nacionalidad"><actual>ninguno</actual><anterior>Extranjero</anterior></campo><campo nombre="Teléfono Habitación"><actual>ninguno</actual><anterior>101010</anterior></campo><campo nombre="Teléfono Célular"><actual>ninguno</actual><anterior>1010</anterior></campo><campo nombre="Ocupación"><actual>ninguno</actual><anterior>Profesional</anterior></campo><campo nombre="País"><actual>ninguno</actual><anterior>Venezuela</anterior></campo><campo nombre="Estado"><actual>ninguno</actual><anterior>Amazonas</anterior></campo><campo nombre="Municipio"><actual>ninguno</actual><anterior>	Alto Orinoco		 </anterior></campo><campo nombre="Ciudad"><actual>ninguno</actual><anterior>1010</anterior></campo></tabla><tabla nombre="antecedentes_pacientes"><campo nombre="Antecedentes Personales"><actual>ninguno</actual><anterior>Obesidad </anterior></campo></tabla></eliminacion_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (72, '2012-01-16 00:27:48.258', 17, 11, '<?xml version="1.0" standalone="yes"?><eliminacion_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>ninguno</actual><anterior>36</anterior></campo><campo nombre="Nombre"><actual>ninguno</actual><anterior>&#039;</anterior></campo><campo nombre="Apellido"><actual>ninguno</actual><anterior>de</anterior></campo><campo nombre="Cédula"><actual>ninguno</actual><anterior>171717</anterior></campo><campo nombre="Fecha Nacimiento"><actual>ninguno</actual><anterior>2012-01-17</anterior></campo><campo nombre="Nacionalidad"><actual>ninguno</actual><anterior>Venezolano</anterior></campo><campo nombre="Teléfono Habitación"><actual>ninguno</actual><anterior>1414141</anterior></campo><campo nombre="Teléfono Célular"><actual>ninguno</actual><anterior>1433</anterior></campo><campo nombre="Ocupación"><actual>ninguno</actual><anterior>Profesional</anterior></campo><campo nombre="País"><actual>ninguno</actual><anterior>Venezuela</anterior></campo><campo nombre="Estado"><actual>ninguno</actual><anterior>Amazonas</anterior></campo><campo nombre="Municipio"><actual>ninguno</actual><anterior>	Atabapo		 </anterior></campo><campo nombre="Ciudad"><actual>ninguno</actual><anterior>101010</anterior></campo></tabla><tabla nombre="antecedentes_pacientes"><campo nombre="Antecedentes Personales"><actual>ninguno</actual><anterior>Ninguna </anterior></campo></tabla></eliminacion_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (168, '2012-01-22 11:30:39.186', 49, 15, '<?xml version="1.0" standalone="yes"?><registrar_muestra_clínica_paciente>
			 <tabla nombre="muestras_pacientes"><campo nombre="Nombre"><actual>Bggh</actual><anterior>Bggh</anterior></campo><campo nombre="Apellido"><actual>Bggh</actual><anterior>Bggh</anterior></campo><campo nombre="Cédula"><actual>17302818</actual><anterior>17302818</anterior></campo><campo nombre="Muestra Clínica"><actual>ninguno</actual><anterior>ninguno</anterior></campo></tabla></registrar_muestra_clínica_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (73, '2012-01-16 00:27:53.238', 17, 11, '<?xml version="1.0" standalone="yes"?><eliminacion_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>ninguno</actual><anterior>35</anterior></campo><campo nombre="Nombre"><actual>ninguno</actual><anterior>&#039;</anterior></campo><campo nombre="Apellido"><actual>ninguno</actual><anterior>asdfaadf</anterior></campo><campo nombre="Cédula"><actual>ninguno</actual><anterior>171010</anterior></campo><campo nombre="Fecha Nacimiento"><actual>ninguno</actual><anterior>2012-01-05</anterior></campo><campo nombre="Nacionalidad"><actual>ninguno</actual><anterior>Venezolano</anterior></campo><campo nombre="Teléfono Habitación"><actual>ninguno</actual><anterior>1010101</anterior></campo><campo nombre="Teléfono Célular"><actual>ninguno</actual><anterior>0111</anterior></campo><campo nombre="Ocupación"><actual>ninguno</actual><anterior>Profesional</anterior></campo><campo nombre="País"><actual>ninguno</actual><anterior>Venezuela</anterior></campo><campo nombre="Estado"><actual>ninguno</actual><anterior>Anzoátegui</anterior></campo><campo nombre="Municipio"><actual>ninguno</actual><anterior>	Bolívar		 </anterior></campo><campo nombre="Ciudad"><actual>ninguno</actual><anterior>asdfadf</anterior></campo></tabla><tabla nombre="antecedentes_pacientes"><campo nombre="Antecedentes Personales"><actual>ninguno</actual><anterior>Diabetes ,Traumatismo </anterior></campo></tabla></eliminacion_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (74, '2012-01-16 00:27:56.784', 17, 11, '<?xml version="1.0" standalone="yes"?><eliminacion_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>ninguno</actual><anterior>34</anterior></campo><campo nombre="Nombre"><actual>ninguno</actual><anterior>&#039;</anterior></campo><campo nombre="Apellido"><actual>ninguno</actual><anterior>sdfg</anterior></campo><campo nombre="Cédula"><actual>ninguno</actual><anterior>1010</anterior></campo><campo nombre="Fecha Nacimiento"><actual>ninguno</actual><anterior>2012-01-17</anterior></campo><campo nombre="Nacionalidad"><actual>ninguno</actual><anterior>Venezolano</anterior></campo><campo nombre="Teléfono Habitación"><actual>ninguno</actual><anterior>1010</anterior></campo><campo nombre="Teléfono Célular"><actual>ninguno</actual><anterior>17101010</anterior></campo><campo nombre="Ocupación"><actual>ninguno</actual><anterior>Obrero</anterior></campo><campo nombre="País"><actual>ninguno</actual><anterior>Venezuela</anterior></campo><campo nombre="Estado"><actual>ninguno</actual><anterior>Amazonas</anterior></campo><campo nombre="Municipio"><actual>ninguno</actual><anterior>	Atabapo		 </anterior></campo><campo nombre="Ciudad"><actual>ninguno</actual><anterior>fghfgh</anterior></campo></tabla><tabla nombre="antecedentes_pacientes"><campo nombre="Antecedentes Personales"><actual>ninguno</actual><anterior>Traumatismo </anterior></campo></tabla></eliminacion_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (76, '2012-01-16 00:41:33.868', 17, 9, '<?xml version="1.0" standalone="yes"?><registro_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>6</actual><anterior>ninguno</anterior></campo><campo nombre="Nombre"><actual>&#039;</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido"><actual>asdfasdf</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula"><actual>101010</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha Nacimiento"><actual>2012-01-17</actual><anterior>ninguno</anterior></campo><campo nombre="Sexo"><actual>F</actual><anterior>ninguno</anterior></campo><campo nombre="Nacionalidad"><actual>Venezolano</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Habitación"><actual>101010</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Célular"><actual>101010</actual><anterior>ninguno</anterior></campo><campo nombre="Ocupación"><actual>Profesional</actual><anterior>ninguno</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>ninguno</anterior></campo><campo nombre="Estado"><actual>Monagas</actual><anterior>ninguno</anterior></campo><campo nombre="Municipio"><actual>	Acosta		 </actual><anterior>ninguno</anterior></campo><campo nombre="Ciudad"><actual>101010</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Obesidad </actual><anterior>ninguno</anterior></campo></tabla></registro_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (77, '2012-01-16 00:44:34.443', 17, 11, '<?xml version="1.0" standalone="yes"?><eliminacion_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>ninguno</actual><anterior>38</anterior></campo><campo nombre="Nombre"><actual>ninguno</actual><anterior>&#039;</anterior></campo><campo nombre="Apellido"><actual>ninguno</actual><anterior>asdfasdf</anterior></campo><campo nombre="Cédula"><actual>ninguno</actual><anterior>101010</anterior></campo><campo nombre="Fecha Nacimiento"><actual>ninguno</actual><anterior>2012-01-17</anterior></campo><campo nombre="Nacionalidad"><actual>ninguno</actual><anterior>Venezolano</anterior></campo><campo nombre="Teléfono Habitación"><actual>ninguno</actual><anterior>101010</anterior></campo><campo nombre="Teléfono Célular"><actual>ninguno</actual><anterior>101010</anterior></campo><campo nombre="Ocupación"><actual>ninguno</actual><anterior>Profesional</anterior></campo><campo nombre="País"><actual>ninguno</actual><anterior>Venezuela</anterior></campo><campo nombre="Estado"><actual>ninguno</actual><anterior>Monagas</anterior></campo><campo nombre="Municipio"><actual>ninguno</actual><anterior>	Acosta		 </anterior></campo><campo nombre="Ciudad"><actual>ninguno</actual><anterior>101010</anterior></campo></tabla><tabla nombre="antecedentes_pacientes"><campo nombre="Antecedentes Personales"><actual>ninguno</actual><anterior>Obesidad </anterior></campo></tabla></eliminacion_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (78, '2012-01-16 01:32:29.679', 17, 11, '<?xml version="1.0" standalone="yes"?><eliminacion_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>ninguno</actual><anterior>7</anterior></campo><campo nombre="Nombre"><actual>ninguno</actual><anterior>Adriana</anterior></campo><campo nombre="Apellido"><actual>ninguno</actual><anterior>Lozada</anterior></campo><campo nombre="Cédula"><actual>ninguno</actual><anterior>17651233</anterior></campo><campo nombre="Fecha Nacimiento"><actual>ninguno</actual><anterior>2011-09-06</anterior></campo><campo nombre="Nacionalidad"><actual>ninguno</actual><anterior>Venezolano</anterior></campo><campo nombre="Teléfono Habitación"><actual>ninguno</actual><anterior>3622824</anterior></campo><campo nombre="Teléfono Célular"><actual>ninguno</actual><anterior>04265168824</anterior></campo><campo nombre="Ocupación"><actual>ninguno</actual><anterior>Técnico</anterior></campo><campo nombre="País"><actual>ninguno</actual><anterior>Venezuela</anterior></campo><campo nombre="Estado"><actual>ninguno</actual><anterior>Yaracuy</anterior></campo><campo nombre="Municipio"><actual>ninguno</actual><anterior>	Cocorote		 </anterior></campo><campo nombre="Ciudad"><actual>ninguno</actual><anterior>Guarenas</anterior></campo></tabla><tabla nombre="antecedentes_pacientes"><campo nombre="Antecedentes Personales"><actual>ninguno</actual><anterior>Obesidad ,Diabetes ,Traumatismo ,Uso Esteroides ,Neoplasias ,Inanición </anterior></campo></tabla></eliminacion_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (169, '2012-01-22 11:31:22.25', 49, 15, '<?xml version="1.0" standalone="yes"?><registrar_muestra_clínica_paciente>
			 <tabla nombre="muestras_pacientes"><campo nombre="Nombre"><actual>Bggh</actual><anterior>Bggh</anterior></campo><campo nombre="Apellido"><actual>Bggh</actual><anterior>Bggh</anterior></campo><campo nombre="Cédula"><actual>17302818</actual><anterior>17302818</anterior></campo><campo nombre="Muestra Clínica"><actual>ninguno</actual><anterior>ninguno</anterior></campo></tabla></registrar_muestra_clínica_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (79, '2012-01-16 01:32:33.635', 17, 11, '<?xml version="1.0" standalone="yes"?><eliminacion_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>ninguno</actual><anterior>13</anterior></campo><campo nombre="Nombre"><actual>ninguno</actual><anterior>Carlos</anterior></campo><campo nombre="Apellido"><actual>ninguno</actual><anterior>Beltran</anterior></campo><campo nombre="Cédula"><actual>ninguno</actual><anterior>7098456</anterior></campo><campo nombre="Fecha Nacimiento"><actual>ninguno</actual><anterior>1961-05-02</anterior></campo><campo nombre="Nacionalidad"><actual>ninguno</actual><anterior>Venezolano</anterior></campo><campo nombre="Teléfono Habitación"><actual>ninguno</actual><anterior>0000</anterior></campo><campo nombre="Teléfono Célular"><actual>ninguno</actual><anterior>0000</anterior></campo><campo nombre="Ocupación"><actual>ninguno</actual><anterior>Agricultor</anterior></campo><campo nombre="País"><actual>ninguno</actual><anterior>Venezuela</anterior></campo><campo nombre="Estado"><actual>ninguno</actual><anterior>Distrito Capital</anterior></campo><campo nombre="Municipio"><actual>ninguno</actual><anterior>	Libertador Caracas		 </anterior></campo><campo nombre="Ciudad"><actual>ninguno</actual><anterior>Merida</anterior></campo></tabla><tabla nombre="antecedentes_pacientes"><campo nombre="Antecedentes Personales"><actual>ninguno</actual><anterior>Ninguna </anterior></campo></tabla></eliminacion_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (80, '2012-01-16 01:32:36.788', 17, 11, '<?xml version="1.0" standalone="yes"?><eliminacion_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>ninguno</actual><anterior>27</anterior></campo><campo nombre="Nombre"><actual>ninguno</actual><anterior>demo</anterior></campo><campo nombre="Apellido"><actual>ninguno</actual><anterior>asd</anterior></campo><campo nombre="Cédula"><actual>ninguno</actual><anterior>1234</anterior></campo><campo nombre="Fecha Nacimiento"><actual>ninguno</actual><anterior>2011-07-27</anterior></campo><campo nombre="Nacionalidad"><actual>ninguno</actual><anterior>Venezolano</anterior></campo><campo nombre="Teléfono Habitación"><actual>ninguno</actual><anterior>3622222</anterior></campo><campo nombre="Teléfono Célular"><actual>ninguno</actual><anterior>173028555</anterior></campo><campo nombre="Ocupación"><actual>ninguno</actual><anterior>Profesional</anterior></campo><campo nombre="País"><actual>ninguno</actual><anterior>Venezuela</anterior></campo><campo nombre="Estado"><actual>ninguno</actual><anterior>Distrito Capital</anterior></campo><campo nombre="Municipio"><actual>ninguno</actual><anterior>	Libertador Caracas		 </anterior></campo><campo nombre="Ciudad"><actual>ninguno</actual><anterior>Guarenas</anterior></campo></tabla><tabla nombre="antecedentes_pacientes"><campo nombre="Antecedentes Personales"><actual>ninguno</actual><anterior>Obesidad ,Diabetes </anterior></campo></tabla></eliminacion_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (81, '2012-01-16 01:32:39.095', 17, 11, '<?xml version="1.0" standalone="yes"?><eliminacion_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>ninguno</actual><anterior>12</anterior></campo><campo nombre="Nombre"><actual>ninguno</actual><anterior>Gisela </anterior></campo><campo nombre="Apellido"><actual>ninguno</actual><anterior>Contreras</anterior></campo><campo nombre="Cédula"><actual>ninguno</actual><anterior>13456094</anterior></campo><campo nombre="Fecha Nacimiento"><actual>ninguno</actual><anterior>1970-09-25</anterior></campo><campo nombre="Nacionalidad"><actual>ninguno</actual><anterior>Extranjero</anterior></campo><campo nombre="Teléfono Habitación"><actual>ninguno</actual><anterior>00000</anterior></campo><campo nombre="Teléfono Célular"><actual>ninguno</actual><anterior>00000</anterior></campo><campo nombre="Ocupación"><actual>ninguno</actual><anterior>Agricultor</anterior></campo><campo nombre="País"><actual>ninguno</actual><anterior>ninguno</anterior></campo><campo nombre="Estado"><actual>ninguno</actual><anterior>ninguno</anterior></campo><campo nombre="Municipio"><actual>ninguno</actual><anterior>ninguno</anterior></campo><campo nombre="Ciudad"><actual>ninguno</actual><anterior>Los Teques</anterior></campo></tabla><tabla nombre="antecedentes_pacientes"><campo nombre="Antecedentes Personales"><actual>ninguno</actual><anterior></anterior></campo></tabla></eliminacion_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (82, '2012-01-16 01:32:42.017', 17, 11, '<?xml version="1.0" standalone="yes"?><eliminacion_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>ninguno</actual><anterior>11</anterior></campo><campo nombre="Nombre"><actual>ninguno</actual><anterior>Jose</anterior></campo><campo nombre="Apellido"><actual>ninguno</actual><anterior>Hernandez</anterior></campo><campo nombre="Cédula"><actual>ninguno</actual><anterior>17123098</anterior></campo><campo nombre="Fecha Nacimiento"><actual>ninguno</actual><anterior>1976-08-21</anterior></campo><campo nombre="Nacionalidad"><actual>ninguno</actual><anterior>Venezolano</anterior></campo><campo nombre="Teléfono Habitación"><actual>ninguno</actual><anterior>02125682345</anterior></campo><campo nombre="Teléfono Célular"><actual>ninguno</actual><anterior>04141235687</anterior></campo><campo nombre="Ocupación"><actual>ninguno</actual><anterior>Profesional</anterior></campo><campo nombre="País"><actual>ninguno</actual><anterior>Venezuela</anterior></campo><campo nombre="Estado"><actual>ninguno</actual><anterior>Distrito Capital</anterior></campo><campo nombre="Municipio"><actual>ninguno</actual><anterior>	Libertador Caracas		 </anterior></campo><campo nombre="Ciudad"><actual>ninguno</actual><anterior>Caracas</anterior></campo></tabla><tabla nombre="antecedentes_pacientes"><campo nombre="Antecedentes Personales"><actual>ninguno</actual><anterior></anterior></campo></tabla></eliminacion_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (83, '2012-01-16 01:32:45.006', 17, 11, '<?xml version="1.0" standalone="yes"?><eliminacion_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>ninguno</actual><anterior>14</anterior></campo><campo nombre="Nombre"><actual>ninguno</actual><anterior>Mary</anterior></campo><campo nombre="Apellido"><actual>ninguno</actual><anterior>Wester</anterior></campo><campo nombre="Cédula"><actual>ninguno</actual><anterior>8752299</anterior></campo><campo nombre="Fecha Nacimiento"><actual>ninguno</actual><anterior>1965-05-02</anterior></campo><campo nombre="Nacionalidad"><actual>ninguno</actual><anterior>Venezolano</anterior></campo><campo nombre="Teléfono Habitación"><actual>ninguno</actual><anterior>02129874523</anterior></campo><campo nombre="Teléfono Célular"><actual>ninguno</actual><anterior>042691587412</anterior></campo><campo nombre="Ocupación"><actual>ninguno</actual><anterior>Otro</anterior></campo><campo nombre="País"><actual>ninguno</actual><anterior>ninguno</anterior></campo><campo nombre="Estado"><actual>ninguno</actual><anterior>ninguno</anterior></campo><campo nombre="Municipio"><actual>ninguno</actual><anterior>ninguno</anterior></campo><campo nombre="Ciudad"><actual>ninguno</actual><anterior>Guarenas</anterior></campo></tabla><tabla nombre="antecedentes_pacientes"><campo nombre="Antecedentes Personales"><actual>ninguno</actual><anterior></anterior></campo></tabla></eliminacion_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (84, '2012-01-16 01:32:51.624', 17, 11, '<?xml version="1.0" standalone="yes"?><eliminacion_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>ninguno</actual><anterior>29</anterior></campo><campo nombre="Nombre"><actual>ninguno</actual><anterior>pruebaliss</anterior></campo><campo nombre="Apellido"><actual>ninguno</actual><anterior>pruebaliss</anterior></campo><campo nombre="Cédula"><actual>ninguno</actual><anterior>17651243</anterior></campo><campo nombre="Fecha Nacimiento"><actual>ninguno</actual><anterior>1987-01-10</anterior></campo><campo nombre="Nacionalidad"><actual>ninguno</actual><anterior>Venezolano</anterior></campo><campo nombre="Teléfono Habitación"><actual>ninguno</actual><anterior>02123617323</anterior></campo><campo nombre="Teléfono Célular"><actual>ninguno</actual><anterior>04269150722</anterior></campo><campo nombre="Ocupación"><actual>ninguno</actual><anterior>Profesional</anterior></campo><campo nombre="País"><actual>ninguno</actual><anterior>Venezuela</anterior></campo><campo nombre="Estado"><actual>ninguno</actual><anterior>Miranda</anterior></campo><campo nombre="Municipio"><actual>ninguno</actual><anterior>	Plaza		 </anterior></campo><campo nombre="Ciudad"><actual>ninguno</actual><anterior>guarenas</anterior></campo></tabla><tabla nombre="antecedentes_pacientes"><campo nombre="Antecedentes Personales"><actual>ninguno</actual><anterior>Cirugía ,Embarazo ,Neoplasias ,Otros </anterior></campo></tabla></eliminacion_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (85, '2012-01-16 02:18:35.698', 44, 12, '<?xml version="1.0" standalone="yes"?><registro_del_historial_paciente>
		 <tabla nombre="historiales_pacientes"><campo nombre="Nombre Paciente"><actual>Paciente</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido Paciente"><actual>Paciente</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula Paciente"><actual>17302857</actual><anterior>ninguno</anterior></campo><campo nombre="Descripción de la Historia"><actual>prueba</actual><anterior>ninguno</anterior></campo><campo nombre="Descripción Adicional"><actual>prueba</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha de Historia"><actual>2012-01-16 02:18:35.698-04:30</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Tiempo de Evolución"><actual>0</actual><anterior>ninguno</anterior></campo></tabla></registro_del_historial_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (86, '2012-01-16 20:01:13.046', 17, 9, '<?xml version="1.0" standalone="yes"?><registro_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>6</actual><anterior>ninguno</anterior></campo><campo nombre="Nombre"><actual>A</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido"><actual>A</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula"><actual>17302801</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha Nacimiento"><actual>2012-01-16</actual><anterior>ninguno</anterior></campo><campo nombre="Sexo"><actual>F</actual><anterior>ninguno</anterior></campo><campo nombre="Nacionalidad"><actual>Venezolano</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Habitación"><actual>3622824</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Célular"><actual>10101010</actual><anterior>ninguno</anterior></campo><campo nombre="Ocupación"><actual>Profesional</actual><anterior>ninguno</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>ninguno</anterior></campo><campo nombre="Estado"><actual>Portuguesa</actual><anterior>ninguno</anterior></campo><campo nombre="Municipio"><actual>	Araure		 </actual><anterior>ninguno</anterior></campo><campo nombre="Ciudad"><actual>gUARENAS</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Obesidad </actual><anterior>ninguno</anterior></campo></tabla></registro_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (87, '2012-01-16 20:02:14.991', 17, 9, '<?xml version="1.0" standalone="yes"?><registro_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>6</actual><anterior>ninguno</anterior></campo><campo nombre="Nombre"><actual>A</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido"><actual>A</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula"><actual>17302802</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha Nacimiento"><actual>2012-01-16</actual><anterior>ninguno</anterior></campo><campo nombre="Sexo"><actual>F</actual><anterior>ninguno</anterior></campo><campo nombre="Nacionalidad"><actual>Venezolano</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Habitación"><actual>02123622222</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Célular"><actual>17302857</actual><anterior>ninguno</anterior></campo><campo nombre="Ocupación"><actual>Profesional</actual><anterior>ninguno</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>ninguno</anterior></campo><campo nombre="Estado"><actual>Amazonas</actual><anterior>ninguno</anterior></campo><campo nombre="Municipio"><actual>	Alto Orinoco		 </actual><anterior>ninguno</anterior></campo><campo nombre="Ciudad"><actual>Miranda</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Obesidad ,Diabetes </actual><anterior>ninguno</anterior></campo></tabla></registro_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (88, '2012-01-16 20:02:20.705', 17, 9, '<?xml version="1.0" standalone="yes"?><registro_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>6</actual><anterior>ninguno</anterior></campo><campo nombre="Nombre"><actual>A</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido"><actual>A</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula"><actual>17302803</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha Nacimiento"><actual>2012-01-16</actual><anterior>ninguno</anterior></campo><campo nombre="Sexo"><actual>F</actual><anterior>ninguno</anterior></campo><campo nombre="Nacionalidad"><actual>Venezolano</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Habitación"><actual>02123622222</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Célular"><actual>17302857</actual><anterior>ninguno</anterior></campo><campo nombre="Ocupación"><actual>Profesional</actual><anterior>ninguno</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>ninguno</anterior></campo><campo nombre="Estado"><actual>Amazonas</actual><anterior>ninguno</anterior></campo><campo nombre="Municipio"><actual>	Alto Orinoco		 </actual><anterior>ninguno</anterior></campo><campo nombre="Ciudad"><actual>Miranda</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Obesidad ,Diabetes </actual><anterior>ninguno</anterior></campo></tabla></registro_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (128, '2012-01-22 10:27:09.579', 17, 12, '<?xml version="1.0" standalone="yes"?><registro_del_historial_paciente>
		 <tabla nombre="historiales_pacientes"><campo nombre="Nombre Paciente"><actual>B</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido Paciente"><actual>B</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula Paciente"><actual>17302815</actual><anterior>ninguno</anterior></campo><campo nombre="Descripción de la Historia"><actual>demo</actual><anterior>ninguno</anterior></campo><campo nombre="Descripción Adicional"><actual>dem</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha de Historia"><actual>2012-01-22 10:27:09.579-04:30</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Tiempo de Evolución"><actual>0</actual><anterior>ninguno</anterior></campo></tabla></registro_del_historial_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (89, '2012-01-16 20:02:27.046', 17, 9, '<?xml version="1.0" standalone="yes"?><registro_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>6</actual><anterior>ninguno</anterior></campo><campo nombre="Nombre"><actual>A</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido"><actual>A</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula"><actual>17302804</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha Nacimiento"><actual>2012-01-16</actual><anterior>ninguno</anterior></campo><campo nombre="Sexo"><actual>F</actual><anterior>ninguno</anterior></campo><campo nombre="Nacionalidad"><actual>Venezolano</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Habitación"><actual>02123622222</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Célular"><actual>17302857</actual><anterior>ninguno</anterior></campo><campo nombre="Ocupación"><actual>Profesional</actual><anterior>ninguno</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>ninguno</anterior></campo><campo nombre="Estado"><actual>Amazonas</actual><anterior>ninguno</anterior></campo><campo nombre="Municipio"><actual>	Alto Orinoco		 </actual><anterior>ninguno</anterior></campo><campo nombre="Ciudad"><actual>Miranda</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Obesidad ,Diabetes </actual><anterior>ninguno</anterior></campo></tabla></registro_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (90, '2012-01-16 20:03:21.286', 17, 9, '<?xml version="1.0" standalone="yes"?><registro_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>6</actual><anterior>ninguno</anterior></campo><campo nombre="Nombre"><actual>B</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido"><actual>B</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula"><actual>17302854</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha Nacimiento"><actual>2012-01-16</actual><anterior>ninguno</anterior></campo><campo nombre="Sexo"><actual>F</actual><anterior>ninguno</anterior></campo><campo nombre="Nacionalidad"><actual>Venezolano</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Habitación"><actual>3622222</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Célular"><actual>15930135</actual><anterior>ninguno</anterior></campo><campo nombre="Ocupación"><actual>Profesional</actual><anterior>ninguno</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>ninguno</anterior></campo><campo nombre="Estado"><actual>Monagas</actual><anterior>ninguno</anterior></campo><campo nombre="Municipio"><actual>	Aguasay		 </actual><anterior>ninguno</anterior></campo><campo nombre="Ciudad"><actual>GUrenas</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Obesidad ,Diabetes </actual><anterior>ninguno</anterior></campo></tabla></registro_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (91, '2012-01-16 20:03:31.307', 17, 9, '<?xml version="1.0" standalone="yes"?><registro_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>6</actual><anterior>ninguno</anterior></campo><campo nombre="Nombre"><actual>B</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido"><actual>B</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula"><actual>17302805</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha Nacimiento"><actual>2012-01-16</actual><anterior>ninguno</anterior></campo><campo nombre="Sexo"><actual>F</actual><anterior>ninguno</anterior></campo><campo nombre="Nacionalidad"><actual>Venezolano</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Habitación"><actual>3622222</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Célular"><actual>15930135</actual><anterior>ninguno</anterior></campo><campo nombre="Ocupación"><actual>Profesional</actual><anterior>ninguno</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>ninguno</anterior></campo><campo nombre="Estado"><actual>Monagas</actual><anterior>ninguno</anterior></campo><campo nombre="Municipio"><actual>	Aguasay		 </actual><anterior>ninguno</anterior></campo><campo nombre="Ciudad"><actual>GUrenas</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Obesidad ,Diabetes </actual><anterior>ninguno</anterior></campo></tabla></registro_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (92, '2012-01-16 20:03:35.795', 17, 9, '<?xml version="1.0" standalone="yes"?><registro_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>6</actual><anterior>ninguno</anterior></campo><campo nombre="Nombre"><actual>B</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido"><actual>B</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula"><actual>17302806</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha Nacimiento"><actual>2012-01-16</actual><anterior>ninguno</anterior></campo><campo nombre="Sexo"><actual>F</actual><anterior>ninguno</anterior></campo><campo nombre="Nacionalidad"><actual>Venezolano</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Habitación"><actual>3622222</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Célular"><actual>15930135</actual><anterior>ninguno</anterior></campo><campo nombre="Ocupación"><actual>Profesional</actual><anterior>ninguno</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>ninguno</anterior></campo><campo nombre="Estado"><actual>Monagas</actual><anterior>ninguno</anterior></campo><campo nombre="Municipio"><actual>	Aguasay		 </actual><anterior>ninguno</anterior></campo><campo nombre="Ciudad"><actual>GUrenas</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Obesidad ,Diabetes </actual><anterior>ninguno</anterior></campo></tabla></registro_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (93, '2012-01-16 20:03:42.208', 17, 9, '<?xml version="1.0" standalone="yes"?><registro_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>6</actual><anterior>ninguno</anterior></campo><campo nombre="Nombre"><actual>B</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido"><actual>B</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula"><actual>17302807</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha Nacimiento"><actual>2012-01-16</actual><anterior>ninguno</anterior></campo><campo nombre="Sexo"><actual>F</actual><anterior>ninguno</anterior></campo><campo nombre="Nacionalidad"><actual>Venezolano</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Habitación"><actual>3622222</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Célular"><actual>15930135</actual><anterior>ninguno</anterior></campo><campo nombre="Ocupación"><actual>Profesional</actual><anterior>ninguno</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>ninguno</anterior></campo><campo nombre="Estado"><actual>Monagas</actual><anterior>ninguno</anterior></campo><campo nombre="Municipio"><actual>	Aguasay		 </actual><anterior>ninguno</anterior></campo><campo nombre="Ciudad"><actual>GUrenas</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Obesidad ,Diabetes </actual><anterior>ninguno</anterior></campo></tabla></registro_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (94, '2012-01-16 20:03:48.936', 17, 9, '<?xml version="1.0" standalone="yes"?><registro_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>6</actual><anterior>ninguno</anterior></campo><campo nombre="Nombre"><actual>B</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido"><actual>B</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula"><actual>17302808</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha Nacimiento"><actual>2012-01-16</actual><anterior>ninguno</anterior></campo><campo nombre="Sexo"><actual>F</actual><anterior>ninguno</anterior></campo><campo nombre="Nacionalidad"><actual>Venezolano</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Habitación"><actual>3622222</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Célular"><actual>15930135</actual><anterior>ninguno</anterior></campo><campo nombre="Ocupación"><actual>Profesional</actual><anterior>ninguno</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>ninguno</anterior></campo><campo nombre="Estado"><actual>Monagas</actual><anterior>ninguno</anterior></campo><campo nombre="Municipio"><actual>	Aguasay		 </actual><anterior>ninguno</anterior></campo><campo nombre="Ciudad"><actual>GUrenas</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Obesidad ,Diabetes </actual><anterior>ninguno</anterior></campo></tabla></registro_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (95, '2012-01-16 20:03:53.853', 17, 9, '<?xml version="1.0" standalone="yes"?><registro_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>6</actual><anterior>ninguno</anterior></campo><campo nombre="Nombre"><actual>B</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido"><actual>B</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula"><actual>17302809</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha Nacimiento"><actual>2012-01-16</actual><anterior>ninguno</anterior></campo><campo nombre="Sexo"><actual>F</actual><anterior>ninguno</anterior></campo><campo nombre="Nacionalidad"><actual>Venezolano</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Habitación"><actual>3622222</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Célular"><actual>15930135</actual><anterior>ninguno</anterior></campo><campo nombre="Ocupación"><actual>Profesional</actual><anterior>ninguno</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>ninguno</anterior></campo><campo nombre="Estado"><actual>Monagas</actual><anterior>ninguno</anterior></campo><campo nombre="Municipio"><actual>	Aguasay		 </actual><anterior>ninguno</anterior></campo><campo nombre="Ciudad"><actual>GUrenas</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Obesidad ,Diabetes </actual><anterior>ninguno</anterior></campo></tabla></registro_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (96, '2012-01-16 20:03:58.92', 17, 9, '<?xml version="1.0" standalone="yes"?><registro_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>6</actual><anterior>ninguno</anterior></campo><campo nombre="Nombre"><actual>B</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido"><actual>B</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula"><actual>17302810</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha Nacimiento"><actual>2012-01-16</actual><anterior>ninguno</anterior></campo><campo nombre="Sexo"><actual>F</actual><anterior>ninguno</anterior></campo><campo nombre="Nacionalidad"><actual>Venezolano</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Habitación"><actual>3622222</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Célular"><actual>15930135</actual><anterior>ninguno</anterior></campo><campo nombre="Ocupación"><actual>Profesional</actual><anterior>ninguno</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>ninguno</anterior></campo><campo nombre="Estado"><actual>Monagas</actual><anterior>ninguno</anterior></campo><campo nombre="Municipio"><actual>	Aguasay		 </actual><anterior>ninguno</anterior></campo><campo nombre="Ciudad"><actual>GUrenas</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Obesidad ,Diabetes </actual><anterior>ninguno</anterior></campo></tabla></registro_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (97, '2012-01-16 20:04:02.512', 17, 9, '<?xml version="1.0" standalone="yes"?><registro_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>6</actual><anterior>ninguno</anterior></campo><campo nombre="Nombre"><actual>B</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido"><actual>B</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula"><actual>17302811</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha Nacimiento"><actual>2012-01-16</actual><anterior>ninguno</anterior></campo><campo nombre="Sexo"><actual>F</actual><anterior>ninguno</anterior></campo><campo nombre="Nacionalidad"><actual>Venezolano</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Habitación"><actual>3622222</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Célular"><actual>15930135</actual><anterior>ninguno</anterior></campo><campo nombre="Ocupación"><actual>Profesional</actual><anterior>ninguno</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>ninguno</anterior></campo><campo nombre="Estado"><actual>Monagas</actual><anterior>ninguno</anterior></campo><campo nombre="Municipio"><actual>	Aguasay		 </actual><anterior>ninguno</anterior></campo><campo nombre="Ciudad"><actual>GUrenas</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Obesidad ,Diabetes </actual><anterior>ninguno</anterior></campo></tabla></registro_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (98, '2012-01-16 20:04:05.691', 17, 9, '<?xml version="1.0" standalone="yes"?><registro_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>6</actual><anterior>ninguno</anterior></campo><campo nombre="Nombre"><actual>B</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido"><actual>B</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula"><actual>17302812</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha Nacimiento"><actual>2012-01-16</actual><anterior>ninguno</anterior></campo><campo nombre="Sexo"><actual>F</actual><anterior>ninguno</anterior></campo><campo nombre="Nacionalidad"><actual>Venezolano</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Habitación"><actual>3622222</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Célular"><actual>15930135</actual><anterior>ninguno</anterior></campo><campo nombre="Ocupación"><actual>Profesional</actual><anterior>ninguno</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>ninguno</anterior></campo><campo nombre="Estado"><actual>Monagas</actual><anterior>ninguno</anterior></campo><campo nombre="Municipio"><actual>	Aguasay		 </actual><anterior>ninguno</anterior></campo><campo nombre="Ciudad"><actual>GUrenas</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Obesidad ,Diabetes </actual><anterior>ninguno</anterior></campo></tabla></registro_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (99, '2012-01-16 20:04:10.444', 17, 9, '<?xml version="1.0" standalone="yes"?><registro_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>6</actual><anterior>ninguno</anterior></campo><campo nombre="Nombre"><actual>B</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido"><actual>B</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula"><actual>17302813</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha Nacimiento"><actual>2012-01-16</actual><anterior>ninguno</anterior></campo><campo nombre="Sexo"><actual>F</actual><anterior>ninguno</anterior></campo><campo nombre="Nacionalidad"><actual>Venezolano</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Habitación"><actual>3622222</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Célular"><actual>15930135</actual><anterior>ninguno</anterior></campo><campo nombre="Ocupación"><actual>Profesional</actual><anterior>ninguno</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>ninguno</anterior></campo><campo nombre="Estado"><actual>Monagas</actual><anterior>ninguno</anterior></campo><campo nombre="Municipio"><actual>	Aguasay		 </actual><anterior>ninguno</anterior></campo><campo nombre="Ciudad"><actual>GUrenas</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Obesidad ,Diabetes </actual><anterior>ninguno</anterior></campo></tabla></registro_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (100, '2012-01-16 20:04:14.721', 17, 9, '<?xml version="1.0" standalone="yes"?><registro_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>6</actual><anterior>ninguno</anterior></campo><campo nombre="Nombre"><actual>B</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido"><actual>B</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula"><actual>17302814</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha Nacimiento"><actual>2012-01-16</actual><anterior>ninguno</anterior></campo><campo nombre="Sexo"><actual>F</actual><anterior>ninguno</anterior></campo><campo nombre="Nacionalidad"><actual>Venezolano</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Habitación"><actual>3622222</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Célular"><actual>15930135</actual><anterior>ninguno</anterior></campo><campo nombre="Ocupación"><actual>Profesional</actual><anterior>ninguno</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>ninguno</anterior></campo><campo nombre="Estado"><actual>Monagas</actual><anterior>ninguno</anterior></campo><campo nombre="Municipio"><actual>	Aguasay		 </actual><anterior>ninguno</anterior></campo><campo nombre="Ciudad"><actual>GUrenas</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Obesidad ,Diabetes </actual><anterior>ninguno</anterior></campo></tabla></registro_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (101, '2012-01-16 20:04:18.942', 17, 9, '<?xml version="1.0" standalone="yes"?><registro_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>6</actual><anterior>ninguno</anterior></campo><campo nombre="Nombre"><actual>B</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido"><actual>B</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula"><actual>17302815</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha Nacimiento"><actual>2012-01-16</actual><anterior>ninguno</anterior></campo><campo nombre="Sexo"><actual>F</actual><anterior>ninguno</anterior></campo><campo nombre="Nacionalidad"><actual>Venezolano</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Habitación"><actual>3622222</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Célular"><actual>15930135</actual><anterior>ninguno</anterior></campo><campo nombre="Ocupación"><actual>Profesional</actual><anterior>ninguno</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>ninguno</anterior></campo><campo nombre="Estado"><actual>Monagas</actual><anterior>ninguno</anterior></campo><campo nombre="Municipio"><actual>	Aguasay		 </actual><anterior>ninguno</anterior></campo><campo nombre="Ciudad"><actual>GUrenas</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Obesidad ,Diabetes </actual><anterior>ninguno</anterior></campo></tabla></registro_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (102, '2012-01-16 20:04:23.054', 17, 9, '<?xml version="1.0" standalone="yes"?><registro_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>6</actual><anterior>ninguno</anterior></campo><campo nombre="Nombre"><actual>B</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido"><actual>B</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula"><actual>17302816</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha Nacimiento"><actual>2012-01-16</actual><anterior>ninguno</anterior></campo><campo nombre="Sexo"><actual>F</actual><anterior>ninguno</anterior></campo><campo nombre="Nacionalidad"><actual>Venezolano</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Habitación"><actual>3622222</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Célular"><actual>15930135</actual><anterior>ninguno</anterior></campo><campo nombre="Ocupación"><actual>Profesional</actual><anterior>ninguno</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>ninguno</anterior></campo><campo nombre="Estado"><actual>Monagas</actual><anterior>ninguno</anterior></campo><campo nombre="Municipio"><actual>	Aguasay		 </actual><anterior>ninguno</anterior></campo><campo nombre="Ciudad"><actual>GUrenas</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Obesidad ,Diabetes </actual><anterior>ninguno</anterior></campo></tabla></registro_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (103, '2012-01-16 20:04:41.747', 17, 11, '<?xml version="1.0" standalone="yes"?><eliminacion_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>ninguno</actual><anterior>39</anterior></campo><campo nombre="Nombre"><actual>ninguno</actual><anterior>A</anterior></campo><campo nombre="Apellido"><actual>ninguno</actual><anterior>A</anterior></campo><campo nombre="Cédula"><actual>ninguno</actual><anterior>17302801</anterior></campo><campo nombre="Fecha Nacimiento"><actual>ninguno</actual><anterior>2012-01-16</anterior></campo><campo nombre="Nacionalidad"><actual>ninguno</actual><anterior>Venezolano</anterior></campo><campo nombre="Teléfono Habitación"><actual>ninguno</actual><anterior>3622824</anterior></campo><campo nombre="Teléfono Célular"><actual>ninguno</actual><anterior>10101010</anterior></campo><campo nombre="Ocupación"><actual>ninguno</actual><anterior>Profesional</anterior></campo><campo nombre="País"><actual>ninguno</actual><anterior>Venezuela</anterior></campo><campo nombre="Estado"><actual>ninguno</actual><anterior>Portuguesa</anterior></campo><campo nombre="Municipio"><actual>ninguno</actual><anterior>	Araure		 </anterior></campo><campo nombre="Ciudad"><actual>ninguno</actual><anterior>gUARENAS</anterior></campo></tabla><tabla nombre="antecedentes_pacientes"><campo nombre="Antecedentes Personales"><actual>ninguno</actual><anterior>Obesidad </anterior></campo></tabla></eliminacion_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (104, '2012-01-16 20:04:44.529', 17, 11, '<?xml version="1.0" standalone="yes"?><eliminacion_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>ninguno</actual><anterior>40</anterior></campo><campo nombre="Nombre"><actual>ninguno</actual><anterior>A</anterior></campo><campo nombre="Apellido"><actual>ninguno</actual><anterior>A</anterior></campo><campo nombre="Cédula"><actual>ninguno</actual><anterior>17302802</anterior></campo><campo nombre="Fecha Nacimiento"><actual>ninguno</actual><anterior>2012-01-16</anterior></campo><campo nombre="Nacionalidad"><actual>ninguno</actual><anterior>Venezolano</anterior></campo><campo nombre="Teléfono Habitación"><actual>ninguno</actual><anterior>02123622222</anterior></campo><campo nombre="Teléfono Célular"><actual>ninguno</actual><anterior>17302857</anterior></campo><campo nombre="Ocupación"><actual>ninguno</actual><anterior>Profesional</anterior></campo><campo nombre="País"><actual>ninguno</actual><anterior>Venezuela</anterior></campo><campo nombre="Estado"><actual>ninguno</actual><anterior>Amazonas</anterior></campo><campo nombre="Municipio"><actual>ninguno</actual><anterior>	Alto Orinoco		 </anterior></campo><campo nombre="Ciudad"><actual>ninguno</actual><anterior>Miranda</anterior></campo></tabla><tabla nombre="antecedentes_pacientes"><campo nombre="Antecedentes Personales"><actual>ninguno</actual><anterior>Obesidad ,Diabetes </anterior></campo></tabla></eliminacion_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (105, '2012-01-16 21:43:54.236', 17, 12, '<?xml version="1.0" standalone="yes"?><registro_del_historial_paciente>
		 <tabla nombre="historiales_pacientes"><campo nombre="Nombre Paciente"><actual>A</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido Paciente"><actual>A</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula Paciente"><actual>17302803</actual><anterior>ninguno</anterior></campo><campo nombre="Descripción de la Historia"><actual>dem</actual><anterior>ninguno</anterior></campo><campo nombre="Descripción Adicional"><actual>asd</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha de Historia"><actual>2012-01-16 21:43:54.236-04:30</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Tiempo de Evolución"><actual>0</actual><anterior>ninguno</anterior></campo></tabla></registro_del_historial_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (106, '2012-01-16 23:03:31.012', 44, 9, '<?xml version="1.0" standalone="yes"?><registro_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>28</actual><anterior>ninguno</anterior></campo><campo nombre="Nombre"><actual>Lisseth</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido"><actual>Lozada</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula"><actual>17234567</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha Nacimiento"><actual>2000-01-01</actual><anterior>ninguno</anterior></campo><campo nombre="Sexo"><actual>F</actual><anterior>ninguno</anterior></campo><campo nombre="Nacionalidad"><actual>Venezolano</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Habitación"><actual>12345678</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Célular"><actual>04261234567</actual><anterior>ninguno</anterior></campo><campo nombre="Ocupación"><actual>Técnico</actual><anterior>ninguno</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>ninguno</anterior></campo><campo nombre="Estado"><actual>Nueva Esparta</actual><anterior>ninguno</anterior></campo><campo nombre="Municipio"><actual>	García		 </actual><anterior>ninguno</anterior></campo><campo nombre="Ciudad"><actual>aa</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Ninguna </actual><anterior>ninguno</anterior></campo></tabla></registro_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (107, '2012-01-16 23:04:09.453', 44, 12, '<?xml version="1.0" standalone="yes"?><registro_del_historial_paciente>
		 <tabla nombre="historiales_pacientes"><campo nombre="Nombre Paciente"><actual>Lisseth</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido Paciente"><actual>Lozada</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula Paciente"><actual>17234567</actual><anterior>ninguno</anterior></campo><campo nombre="Descripción de la Historia"><actual></actual><anterior>ninguno</anterior></campo><campo nombre="Descripción Adicional"><actual></actual><anterior>ninguno</anterior></campo><campo nombre="Fecha de Historia"><actual>2012-01-16 23:04:09.453-04:30</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Tiempo de Evolución"><actual>0</actual><anterior>ninguno</anterior></campo></tabla></registro_del_historial_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (108, '2012-01-17 08:02:03.512', 17, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Barrio Adentro II ,Barrio Adentro III </actual><anterior></anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Barrio Adentro II ,Barrio Adentro III Consulta ,Consulta Interna ,Otros </actual><anterior></anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Barrio Adentro II ,Barrio Adentro III Consulta ,Consulta Interna ,Otros</actual><anterior></anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Barrio Adentro II ,Barrio Adentro III Consulta ,Consulta Interna ,OtrosCitotóxicos ,Glucorticoides ,Hormonas Sexuales </actual><anterior></anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>20</actual><anterior>0</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (109, '2012-01-17 08:02:18.246', 17, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Barrio Adentro II ,Barrio Adentro III </actual><anterior>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Barrio Adentro II ,Barrio Adentro III </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Barrio Adentro II ,Barrio Adentro III Consulta ,Consulta Interna ,Otros </actual><anterior>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Barrio Adentro II ,Barrio Adentro III Consulta ,Consulta Interna ,Otros </anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Barrio Adentro II ,Barrio Adentro III Consulta ,Consulta Interna ,Otros Animales de Corral ,Aves </actual><anterior>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Barrio Adentro II ,Barrio Adentro III Consulta ,Consulta Interna ,Otros</anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Barrio Adentro II ,Barrio Adentro III Consulta ,Consulta Interna ,Otros Animales de Corral ,Aves Citotóxicos ,Glucorticoides ,Hormonas Sexuales </actual><anterior>Ambulatorio Rural ,Ambulatorio Urbano ,Barrio Adentro I ,Barrio Adentro II ,Barrio Adentro III Consulta ,Consulta Interna ,OtrosCitotóxicos ,Glucorticoides ,Hormonas Sexuales </anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>20</actual><anterior>20</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (111, '2012-01-18 00:17:44.955', 17, 11, '<?xml version="1.0" standalone="yes"?><eliminacion_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>ninguno</actual><anterior>44</anterior></campo><campo nombre="Nombre"><actual>ninguno</actual><anterior>B</anterior></campo><campo nombre="Apellido"><actual>ninguno</actual><anterior>B</anterior></campo><campo nombre="Cédula"><actual>ninguno</actual><anterior>17302805</anterior></campo><campo nombre="Fecha Nacimiento"><actual>ninguno</actual><anterior>2012-01-16</anterior></campo><campo nombre="Nacionalidad"><actual>ninguno</actual><anterior>Venezolano</anterior></campo><campo nombre="Teléfono Habitación"><actual>ninguno</actual><anterior>3622222</anterior></campo><campo nombre="Teléfono Célular"><actual>ninguno</actual><anterior>15930135</anterior></campo><campo nombre="Ocupación"><actual>ninguno</actual><anterior>Profesional</anterior></campo><campo nombre="País"><actual>ninguno</actual><anterior>Venezuela</anterior></campo><campo nombre="Estado"><actual>ninguno</actual><anterior>Monagas</anterior></campo><campo nombre="Municipio"><actual>ninguno</actual><anterior>	Aguasay		 </anterior></campo><campo nombre="Ciudad"><actual>ninguno</actual><anterior>GUrenas</anterior></campo></tabla><tabla nombre="antecedentes_pacientes"><campo nombre="Antecedentes Personales"><actual>ninguno</actual><anterior>Obesidad ,Diabetes </anterior></campo></tabla></eliminacion_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (112, '2012-01-18 00:17:47.812', 17, 11, '<?xml version="1.0" standalone="yes"?><eliminacion_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>ninguno</actual><anterior>45</anterior></campo><campo nombre="Nombre"><actual>ninguno</actual><anterior>B</anterior></campo><campo nombre="Apellido"><actual>ninguno</actual><anterior>B</anterior></campo><campo nombre="Cédula"><actual>ninguno</actual><anterior>17302806</anterior></campo><campo nombre="Fecha Nacimiento"><actual>ninguno</actual><anterior>2012-01-16</anterior></campo><campo nombre="Nacionalidad"><actual>ninguno</actual><anterior>Venezolano</anterior></campo><campo nombre="Teléfono Habitación"><actual>ninguno</actual><anterior>3622222</anterior></campo><campo nombre="Teléfono Célular"><actual>ninguno</actual><anterior>15930135</anterior></campo><campo nombre="Ocupación"><actual>ninguno</actual><anterior>Profesional</anterior></campo><campo nombre="País"><actual>ninguno</actual><anterior>Venezuela</anterior></campo><campo nombre="Estado"><actual>ninguno</actual><anterior>Monagas</anterior></campo><campo nombre="Municipio"><actual>ninguno</actual><anterior>	Aguasay		 </anterior></campo><campo nombre="Ciudad"><actual>ninguno</actual><anterior>GUrenas</anterior></campo></tabla><tabla nombre="antecedentes_pacientes"><campo nombre="Antecedentes Personales"><actual>ninguno</actual><anterior>Obesidad ,Diabetes </anterior></campo></tabla></eliminacion_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (113, '2012-01-18 00:17:51.516', 17, 11, '<?xml version="1.0" standalone="yes"?><eliminacion_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>ninguno</actual><anterior>47</anterior></campo><campo nombre="Nombre"><actual>ninguno</actual><anterior>B</anterior></campo><campo nombre="Apellido"><actual>ninguno</actual><anterior>B</anterior></campo><campo nombre="Cédula"><actual>ninguno</actual><anterior>17302808</anterior></campo><campo nombre="Fecha Nacimiento"><actual>ninguno</actual><anterior>2012-01-16</anterior></campo><campo nombre="Nacionalidad"><actual>ninguno</actual><anterior>Venezolano</anterior></campo><campo nombre="Teléfono Habitación"><actual>ninguno</actual><anterior>3622222</anterior></campo><campo nombre="Teléfono Célular"><actual>ninguno</actual><anterior>15930135</anterior></campo><campo nombre="Ocupación"><actual>ninguno</actual><anterior>Profesional</anterior></campo><campo nombre="País"><actual>ninguno</actual><anterior>Venezuela</anterior></campo><campo nombre="Estado"><actual>ninguno</actual><anterior>Monagas</anterior></campo><campo nombre="Municipio"><actual>ninguno</actual><anterior>	Aguasay		 </anterior></campo><campo nombre="Ciudad"><actual>ninguno</actual><anterior>GUrenas</anterior></campo></tabla><tabla nombre="antecedentes_pacientes"><campo nombre="Antecedentes Personales"><actual>ninguno</actual><anterior>Obesidad ,Diabetes </anterior></campo></tabla></eliminacion_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (114, '2012-01-18 00:17:54.104', 17, 11, '<?xml version="1.0" standalone="yes"?><eliminacion_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>ninguno</actual><anterior>48</anterior></campo><campo nombre="Nombre"><actual>ninguno</actual><anterior>B</anterior></campo><campo nombre="Apellido"><actual>ninguno</actual><anterior>B</anterior></campo><campo nombre="Cédula"><actual>ninguno</actual><anterior>17302809</anterior></campo><campo nombre="Fecha Nacimiento"><actual>ninguno</actual><anterior>2012-01-16</anterior></campo><campo nombre="Nacionalidad"><actual>ninguno</actual><anterior>Venezolano</anterior></campo><campo nombre="Teléfono Habitación"><actual>ninguno</actual><anterior>3622222</anterior></campo><campo nombre="Teléfono Célular"><actual>ninguno</actual><anterior>15930135</anterior></campo><campo nombre="Ocupación"><actual>ninguno</actual><anterior>Profesional</anterior></campo><campo nombre="País"><actual>ninguno</actual><anterior>Venezuela</anterior></campo><campo nombre="Estado"><actual>ninguno</actual><anterior>Monagas</anterior></campo><campo nombre="Municipio"><actual>ninguno</actual><anterior>	Aguasay		 </anterior></campo><campo nombre="Ciudad"><actual>ninguno</actual><anterior>GUrenas</anterior></campo></tabla><tabla nombre="antecedentes_pacientes"><campo nombre="Antecedentes Personales"><actual>ninguno</actual><anterior>Obesidad ,Diabetes </anterior></campo></tabla></eliminacion_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (115, '2012-01-18 00:17:56.477', 17, 11, '<?xml version="1.0" standalone="yes"?><eliminacion_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>ninguno</actual><anterior>49</anterior></campo><campo nombre="Nombre"><actual>ninguno</actual><anterior>B</anterior></campo><campo nombre="Apellido"><actual>ninguno</actual><anterior>B</anterior></campo><campo nombre="Cédula"><actual>ninguno</actual><anterior>17302810</anterior></campo><campo nombre="Fecha Nacimiento"><actual>ninguno</actual><anterior>2012-01-16</anterior></campo><campo nombre="Nacionalidad"><actual>ninguno</actual><anterior>Venezolano</anterior></campo><campo nombre="Teléfono Habitación"><actual>ninguno</actual><anterior>3622222</anterior></campo><campo nombre="Teléfono Célular"><actual>ninguno</actual><anterior>15930135</anterior></campo><campo nombre="Ocupación"><actual>ninguno</actual><anterior>Profesional</anterior></campo><campo nombre="País"><actual>ninguno</actual><anterior>Venezuela</anterior></campo><campo nombre="Estado"><actual>ninguno</actual><anterior>Monagas</anterior></campo><campo nombre="Municipio"><actual>ninguno</actual><anterior>	Aguasay		 </anterior></campo><campo nombre="Ciudad"><actual>ninguno</actual><anterior>GUrenas</anterior></campo></tabla><tabla nombre="antecedentes_pacientes"><campo nombre="Antecedentes Personales"><actual>ninguno</actual><anterior>Obesidad ,Diabetes </anterior></campo></tabla></eliminacion_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (116, '2012-01-18 00:17:59.562', 17, 11, '<?xml version="1.0" standalone="yes"?><eliminacion_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>ninguno</actual><anterior>50</anterior></campo><campo nombre="Nombre"><actual>ninguno</actual><anterior>B</anterior></campo><campo nombre="Apellido"><actual>ninguno</actual><anterior>B</anterior></campo><campo nombre="Cédula"><actual>ninguno</actual><anterior>17302811</anterior></campo><campo nombre="Fecha Nacimiento"><actual>ninguno</actual><anterior>2012-01-16</anterior></campo><campo nombre="Nacionalidad"><actual>ninguno</actual><anterior>Venezolano</anterior></campo><campo nombre="Teléfono Habitación"><actual>ninguno</actual><anterior>3622222</anterior></campo><campo nombre="Teléfono Célular"><actual>ninguno</actual><anterior>15930135</anterior></campo><campo nombre="Ocupación"><actual>ninguno</actual><anterior>Profesional</anterior></campo><campo nombre="País"><actual>ninguno</actual><anterior>Venezuela</anterior></campo><campo nombre="Estado"><actual>ninguno</actual><anterior>Monagas</anterior></campo><campo nombre="Municipio"><actual>ninguno</actual><anterior>	Aguasay		 </anterior></campo><campo nombre="Ciudad"><actual>ninguno</actual><anterior>GUrenas</anterior></campo></tabla><tabla nombre="antecedentes_pacientes"><campo nombre="Antecedentes Personales"><actual>ninguno</actual><anterior>Obesidad ,Diabetes </anterior></campo></tabla></eliminacion_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (117, '2012-01-18 00:18:03.743', 17, 11, '<?xml version="1.0" standalone="yes"?><eliminacion_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>ninguno</actual><anterior>42</anterior></campo><campo nombre="Nombre"><actual>ninguno</actual><anterior>A</anterior></campo><campo nombre="Apellido"><actual>ninguno</actual><anterior>A</anterior></campo><campo nombre="Cédula"><actual>ninguno</actual><anterior>17302804</anterior></campo><campo nombre="Fecha Nacimiento"><actual>ninguno</actual><anterior>2012-01-16</anterior></campo><campo nombre="Nacionalidad"><actual>ninguno</actual><anterior>Venezolano</anterior></campo><campo nombre="Teléfono Habitación"><actual>ninguno</actual><anterior>02123622222</anterior></campo><campo nombre="Teléfono Célular"><actual>ninguno</actual><anterior>17302857</anterior></campo><campo nombre="Ocupación"><actual>ninguno</actual><anterior>Profesional</anterior></campo><campo nombre="País"><actual>ninguno</actual><anterior>Venezuela</anterior></campo><campo nombre="Estado"><actual>ninguno</actual><anterior>Amazonas</anterior></campo><campo nombre="Municipio"><actual>ninguno</actual><anterior>	Alto Orinoco		 </anterior></campo><campo nombre="Ciudad"><actual>ninguno</actual><anterior>Miranda</anterior></campo></tabla><tabla nombre="antecedentes_pacientes"><campo nombre="Antecedentes Personales"><actual>ninguno</actual><anterior>Obesidad ,Diabetes </anterior></campo></tabla></eliminacion_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (118, '2012-01-18 00:18:06.756', 17, 11, '<?xml version="1.0" standalone="yes"?><eliminacion_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>ninguno</actual><anterior>46</anterior></campo><campo nombre="Nombre"><actual>ninguno</actual><anterior>B</anterior></campo><campo nombre="Apellido"><actual>ninguno</actual><anterior>B</anterior></campo><campo nombre="Cédula"><actual>ninguno</actual><anterior>17302807</anterior></campo><campo nombre="Fecha Nacimiento"><actual>ninguno</actual><anterior>2012-01-16</anterior></campo><campo nombre="Nacionalidad"><actual>ninguno</actual><anterior>Venezolano</anterior></campo><campo nombre="Teléfono Habitación"><actual>ninguno</actual><anterior>3622222</anterior></campo><campo nombre="Teléfono Célular"><actual>ninguno</actual><anterior>15930135</anterior></campo><campo nombre="Ocupación"><actual>ninguno</actual><anterior>Profesional</anterior></campo><campo nombre="País"><actual>ninguno</actual><anterior>Venezuela</anterior></campo><campo nombre="Estado"><actual>ninguno</actual><anterior>Monagas</anterior></campo><campo nombre="Municipio"><actual>ninguno</actual><anterior>	Aguasay		 </anterior></campo><campo nombre="Ciudad"><actual>ninguno</actual><anterior>GUrenas</anterior></campo></tabla><tabla nombre="antecedentes_pacientes"><campo nombre="Antecedentes Personales"><actual>ninguno</actual><anterior>Obesidad ,Diabetes </anterior></campo></tabla></eliminacion_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (119, '2012-01-18 00:18:12.205', 17, 11, '<?xml version="1.0" standalone="yes"?><eliminacion_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>ninguno</actual><anterior>43</anterior></campo><campo nombre="Nombre"><actual>ninguno</actual><anterior>B</anterior></campo><campo nombre="Apellido"><actual>ninguno</actual><anterior>B</anterior></campo><campo nombre="Cédula"><actual>ninguno</actual><anterior>17302854</anterior></campo><campo nombre="Fecha Nacimiento"><actual>ninguno</actual><anterior>2012-01-16</anterior></campo><campo nombre="Nacionalidad"><actual>ninguno</actual><anterior>Venezolano</anterior></campo><campo nombre="Teléfono Habitación"><actual>ninguno</actual><anterior>3622222</anterior></campo><campo nombre="Teléfono Célular"><actual>ninguno</actual><anterior>15930135</anterior></campo><campo nombre="Ocupación"><actual>ninguno</actual><anterior>Profesional</anterior></campo><campo nombre="País"><actual>ninguno</actual><anterior>Venezuela</anterior></campo><campo nombre="Estado"><actual>ninguno</actual><anterior>Monagas</anterior></campo><campo nombre="Municipio"><actual>ninguno</actual><anterior>	Aguasay		 </anterior></campo><campo nombre="Ciudad"><actual>ninguno</actual><anterior>GUrenas</anterior></campo></tabla><tabla nombre="antecedentes_pacientes"><campo nombre="Antecedentes Personales"><actual>ninguno</actual><anterior>Obesidad ,Diabetes </anterior></campo></tabla></eliminacion_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (120, '2012-01-18 00:18:15.081', 17, 11, '<?xml version="1.0" standalone="yes"?><eliminacion_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>ninguno</actual><anterior>41</anterior></campo><campo nombre="Nombre"><actual>ninguno</actual><anterior>A</anterior></campo><campo nombre="Apellido"><actual>ninguno</actual><anterior>A</anterior></campo><campo nombre="Cédula"><actual>ninguno</actual><anterior>17302803</anterior></campo><campo nombre="Fecha Nacimiento"><actual>ninguno</actual><anterior>2012-01-16</anterior></campo><campo nombre="Nacionalidad"><actual>ninguno</actual><anterior>Venezolano</anterior></campo><campo nombre="Teléfono Habitación"><actual>ninguno</actual><anterior>02123622222</anterior></campo><campo nombre="Teléfono Célular"><actual>ninguno</actual><anterior>17302857</anterior></campo><campo nombre="Ocupación"><actual>ninguno</actual><anterior>Profesional</anterior></campo><campo nombre="País"><actual>ninguno</actual><anterior>Venezuela</anterior></campo><campo nombre="Estado"><actual>ninguno</actual><anterior>Amazonas</anterior></campo><campo nombre="Municipio"><actual>ninguno</actual><anterior>	Alto Orinoco		 </anterior></campo><campo nombre="Ciudad"><actual>ninguno</actual><anterior>Miranda</anterior></campo></tabla><tabla nombre="antecedentes_pacientes"><campo nombre="Antecedentes Personales"><actual>ninguno</actual><anterior>Obesidad ,Diabetes </anterior></campo></tabla></eliminacion_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (121, '2012-01-18 00:18:17.993', 17, 11, '<?xml version="1.0" standalone="yes"?><eliminacion_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>ninguno</actual><anterior>53</anterior></campo><campo nombre="Nombre"><actual>ninguno</actual><anterior>B</anterior></campo><campo nombre="Apellido"><actual>ninguno</actual><anterior>B</anterior></campo><campo nombre="Cédula"><actual>ninguno</actual><anterior>17302814</anterior></campo><campo nombre="Fecha Nacimiento"><actual>ninguno</actual><anterior>2012-01-16</anterior></campo><campo nombre="Nacionalidad"><actual>ninguno</actual><anterior>Venezolano</anterior></campo><campo nombre="Teléfono Habitación"><actual>ninguno</actual><anterior>3622222</anterior></campo><campo nombre="Teléfono Célular"><actual>ninguno</actual><anterior>15930135</anterior></campo><campo nombre="Ocupación"><actual>ninguno</actual><anterior>Profesional</anterior></campo><campo nombre="País"><actual>ninguno</actual><anterior>Venezuela</anterior></campo><campo nombre="Estado"><actual>ninguno</actual><anterior>Monagas</anterior></campo><campo nombre="Municipio"><actual>ninguno</actual><anterior>	Aguasay		 </anterior></campo><campo nombre="Ciudad"><actual>ninguno</actual><anterior>GUrenas</anterior></campo></tabla><tabla nombre="antecedentes_pacientes"><campo nombre="Antecedentes Personales"><actual>ninguno</actual><anterior>Obesidad ,Diabetes </anterior></campo></tabla></eliminacion_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (122, '2012-01-18 00:18:20.713', 17, 11, '<?xml version="1.0" standalone="yes"?><eliminacion_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>ninguno</actual><anterior>51</anterior></campo><campo nombre="Nombre"><actual>ninguno</actual><anterior>B</anterior></campo><campo nombre="Apellido"><actual>ninguno</actual><anterior>B</anterior></campo><campo nombre="Cédula"><actual>ninguno</actual><anterior>17302812</anterior></campo><campo nombre="Fecha Nacimiento"><actual>ninguno</actual><anterior>2012-01-16</anterior></campo><campo nombre="Nacionalidad"><actual>ninguno</actual><anterior>Venezolano</anterior></campo><campo nombre="Teléfono Habitación"><actual>ninguno</actual><anterior>3622222</anterior></campo><campo nombre="Teléfono Célular"><actual>ninguno</actual><anterior>15930135</anterior></campo><campo nombre="Ocupación"><actual>ninguno</actual><anterior>Profesional</anterior></campo><campo nombre="País"><actual>ninguno</actual><anterior>Venezuela</anterior></campo><campo nombre="Estado"><actual>ninguno</actual><anterior>Monagas</anterior></campo><campo nombre="Municipio"><actual>ninguno</actual><anterior>	Aguasay		 </anterior></campo><campo nombre="Ciudad"><actual>ninguno</actual><anterior>GUrenas</anterior></campo></tabla><tabla nombre="antecedentes_pacientes"><campo nombre="Antecedentes Personales"><actual>ninguno</actual><anterior>Obesidad ,Diabetes </anterior></campo></tabla></eliminacion_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (123, '2012-01-18 00:18:23.381', 17, 11, '<?xml version="1.0" standalone="yes"?><eliminacion_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>ninguno</actual><anterior>52</anterior></campo><campo nombre="Nombre"><actual>ninguno</actual><anterior>B</anterior></campo><campo nombre="Apellido"><actual>ninguno</actual><anterior>B</anterior></campo><campo nombre="Cédula"><actual>ninguno</actual><anterior>17302813</anterior></campo><campo nombre="Fecha Nacimiento"><actual>ninguno</actual><anterior>2012-01-16</anterior></campo><campo nombre="Nacionalidad"><actual>ninguno</actual><anterior>Venezolano</anterior></campo><campo nombre="Teléfono Habitación"><actual>ninguno</actual><anterior>3622222</anterior></campo><campo nombre="Teléfono Célular"><actual>ninguno</actual><anterior>15930135</anterior></campo><campo nombre="Ocupación"><actual>ninguno</actual><anterior>Profesional</anterior></campo><campo nombre="País"><actual>ninguno</actual><anterior>Venezuela</anterior></campo><campo nombre="Estado"><actual>ninguno</actual><anterior>Monagas</anterior></campo><campo nombre="Municipio"><actual>ninguno</actual><anterior>	Aguasay		 </anterior></campo><campo nombre="Ciudad"><actual>ninguno</actual><anterior>GUrenas</anterior></campo></tabla><tabla nombre="antecedentes_pacientes"><campo nombre="Antecedentes Personales"><actual>ninguno</actual><anterior>Obesidad ,Diabetes </anterior></campo></tabla></eliminacion_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (124, '2012-01-18 00:19:22.932', 17, 11, '<?xml version="1.0" standalone="yes"?><eliminacion_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>ninguno</actual><anterior>55</anterior></campo><campo nombre="Nombre"><actual>ninguno</actual><anterior>B</anterior></campo><campo nombre="Apellido"><actual>ninguno</actual><anterior>B</anterior></campo><campo nombre="Cédula"><actual>ninguno</actual><anterior>17302816</anterior></campo><campo nombre="Fecha Nacimiento"><actual>ninguno</actual><anterior>2012-01-16</anterior></campo><campo nombre="Nacionalidad"><actual>ninguno</actual><anterior>Venezolano</anterior></campo><campo nombre="Teléfono Habitación"><actual>ninguno</actual><anterior>3622222</anterior></campo><campo nombre="Teléfono Célular"><actual>ninguno</actual><anterior>15930135</anterior></campo><campo nombre="Ocupación"><actual>ninguno</actual><anterior>Profesional</anterior></campo><campo nombre="País"><actual>ninguno</actual><anterior>Venezuela</anterior></campo><campo nombre="Estado"><actual>ninguno</actual><anterior>Monagas</anterior></campo><campo nombre="Municipio"><actual>ninguno</actual><anterior>	Aguasay		 </anterior></campo><campo nombre="Ciudad"><actual>ninguno</actual><anterior>GUrenas</anterior></campo></tabla><tabla nombre="antecedentes_pacientes"><campo nombre="Antecedentes Personales"><actual>ninguno</actual><anterior>Obesidad ,Diabetes </anterior></campo></tabla></eliminacion_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (125, '2012-01-19 08:07:30.308', 17, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Ambulatorio Rural ,Clínica </actual><anterior></anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Ambulatorio Rural ,Clínica Neumologia </actual><anterior></anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Ambulatorio Rural ,Clínica Neumologia</actual><anterior></anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Ambulatorio Rural ,Clínica NeumologiaInmunosupresores </actual><anterior></anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>0</actual><anterior>0</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (126, '2012-01-19 08:09:02.472', 17, 15, '<?xml version="1.0" standalone="yes"?><registrar_muestra_clínica_paciente>
			 <tabla nombre="muestras_pacientes"><campo nombre="Nombre"><actual>Lisseth</actual><anterior>Lisseth</anterior></campo><campo nombre="Apellido"><actual>Lozada</actual><anterior>Lozada</anterior></campo><campo nombre="Cédula"><actual>17234567</actual><anterior>17234567</anterior></campo><campo nombre="Muestra Clínica"><actual>ninguno</actual><anterior>ninguno</anterior></campo></tabla></registrar_muestra_clínica_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (127, '2012-01-19 08:09:10.13', 17, 15, '<?xml version="1.0" standalone="yes"?><registrar_muestra_clínica_paciente>
			 <tabla nombre="muestras_pacientes"><campo nombre="Nombre"><actual>Lisseth</actual><anterior>Lisseth</anterior></campo><campo nombre="Apellido"><actual>Lozada</actual><anterior>Lozada</anterior></campo><campo nombre="Cédula"><actual>17234567</actual><anterior>17234567</anterior></campo><campo nombre="Muestra Clínica"><actual>ninguno</actual><anterior>ninguno</anterior></campo></tabla></registrar_muestra_clínica_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (129, '2012-01-22 02:51:35.348', 49, 9, '<?xml version="1.0" standalone="yes"?><registro_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>32</actual><anterior>ninguno</anterior></campo><campo nombre="Nombre"><actual>luis</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido"><actual>marin</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula"><actual>17568741</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha Nacimiento"><actual>1985-01-22</actual><anterior>ninguno</anterior></campo><campo nombre="Sexo"><actual>M</actual><anterior>ninguno</anterior></campo><campo nombre="Nacionalidad"><actual>Venezolano</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Habitación"><actual>04268741232</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Célular"><actual>02129358741</actual><anterior>ninguno</anterior></campo><campo nombre="Ocupación"><actual>Profesional</actual><anterior>ninguno</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>ninguno</anterior></campo><campo nombre="Estado"><actual>Anzoátegui</actual><anterior>ninguno</anterior></campo><campo nombre="Municipio"><actual>	Aragua		 </actual><anterior>ninguno</anterior></campo><campo nombre="Ciudad"><actual>dddd</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Ninguna </actual><anterior>ninguno</anterior></campo></tabla></registro_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (130, '2012-01-22 04:00:03.367', 49, 12, '<?xml version="1.0" standalone="yes"?><registro_del_historial_paciente>
		 <tabla nombre="historiales_pacientes"><campo nombre="Nombre Paciente"><actual>B</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido Paciente"><actual>B</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula Paciente"><actual>17302815</actual><anterior>ninguno</anterior></campo><campo nombre="Descripción de la Historia"><actual></actual><anterior>ninguno</anterior></campo><campo nombre="Descripción Adicional"><actual></actual><anterior>ninguno</anterior></campo><campo nombre="Fecha de Historia"><actual>2012-01-22 04:00:03.367-04:30</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Tiempo de Evolución"><actual>0</actual><anterior>ninguno</anterior></campo></tabla></registro_del_historial_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (131, '2012-01-22 04:05:33.173', 49, 13, '<?xml version="1.0" standalone="yes"?><modificacion_del_historial_paciente>
		 <tabla nombre="historiales_pacientes"><campo nombre="Nombre Paciente"><actual>B</actual><anterior>B</anterior></campo><campo nombre="Apellido Paciente"><actual>B</actual><anterior>B</anterior></campo><campo nombre="Cédula Paciente"><actual>17302815</actual><anterior>17302815</anterior></campo><campo nombre="Descripción de la Historia"><actual>demo</actual><anterior>demo</anterior></campo><campo nombre="Descripción Adicional"><actual>dem</actual><anterior>dem</anterior></campo><campo nombre="Fecha de Historia"><actual>2012-01-22 10:27:09.579-04:30</actual><anterior>2012-01-22 10:27:09.579-04:30</anterior></campo></tabla></modificacion_del_historial_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (132, '2012-01-22 04:05:48.16', 49, 12, '<?xml version="1.0" standalone="yes"?><registro_del_historial_paciente>
		 <tabla nombre="historiales_pacientes"><campo nombre="Nombre Paciente"><actual>B</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido Paciente"><actual>B</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula Paciente"><actual>17302815</actual><anterior>ninguno</anterior></campo><campo nombre="Descripción de la Historia"><actual>fdsfsdfdsfsdf</actual><anterior>ninguno</anterior></campo><campo nombre="Descripción Adicional"><actual>dsfsdf</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha de Historia"><actual>2012-01-22 04:05:48.16-04:30</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Tiempo de Evolución"><actual>0</actual><anterior>ninguno</anterior></campo></tabla></registro_del_historial_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (133, '2012-01-22 04:09:07.482', 49, 13, '<?xml version="1.0" standalone="yes"?><modificacion_del_historial_paciente>
		 <tabla nombre="historiales_pacientes"><campo nombre="Nombre Paciente"><actual>B</actual><anterior>B</anterior></campo><campo nombre="Apellido Paciente"><actual>B</actual><anterior>B</anterior></campo><campo nombre="Cédula Paciente"><actual>17302815</actual><anterior>17302815</anterior></campo><campo nombre="Descripción de la Historia"><actual>demo</actual><anterior>demo</anterior></campo><campo nombre="Descripción Adicional"><actual>dem</actual><anterior>dem</anterior></campo><campo nombre="Fecha de Historia"><actual>2012-01-22 10:27:09.579-04:30</actual><anterior>2012-01-22 10:27:09.579-04:30</anterior></campo></tabla></modificacion_del_historial_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (134, '2012-01-22 04:18:44.03', 49, 14, '<?xml version="1.0" standalone="yes"?><eliminacion_del_historial_paciente>
			 <tabla nombre="historiales_pacientes"><campo nombre="Nombre Paciente"><actual>ninguno</actual><anterior>B</anterior></campo><campo nombre="Apellido Paciente"><actual>ninguno</actual><anterior>B</anterior></campo><campo nombre="Cédula Paciente"><actual>ninguno</actual><anterior>17302815</anterior></campo><campo nombre="Descripción de la Historia"><actual>ninguno</actual><anterior></anterior></campo><campo nombre="Descripción Adicional"><actual>ninguno</actual><anterior></anterior></campo><campo nombre="Fecha de Historia"><actual>ninguno</actual><anterior>2012-01-22 04:00:03.367-04:30</anterior></campo></tabla></eliminacion_del_historial_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (135, '2012-01-22 04:20:35.205', 49, 14, '<?xml version="1.0" standalone="yes"?><eliminacion_del_historial_paciente>
			 <tabla nombre="historiales_pacientes"><campo nombre="Nombre Paciente"><actual>ninguno</actual><anterior>B</anterior></campo><campo nombre="Apellido Paciente"><actual>ninguno</actual><anterior>B</anterior></campo><campo nombre="Cédula Paciente"><actual>ninguno</actual><anterior>17302815</anterior></campo><campo nombre="Descripción de la Historia"><actual>ninguno</actual><anterior>fdsfsdfdsfsdf</anterior></campo><campo nombre="Descripción Adicional"><actual>ninguno</actual><anterior>dsfsdf</anterior></campo><campo nombre="Fecha de Historia"><actual>ninguno</actual><anterior>2012-01-22 04:05:48.16-04:30</anterior></campo></tabla></eliminacion_del_historial_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (136, '2012-01-22 05:05:58.561', 49, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual></actual><anterior></anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual></actual><anterior></anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual></actual><anterior></anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual></actual><anterior></anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>0</actual><anterior>0</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (138, '2012-01-22 05:16:05.98', 49, 9, '<?xml version="1.0" standalone="yes"?><registro_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>32</actual><anterior>ninguno</anterior></campo><campo nombre="Nombre"><actual>&#039;jhsdf</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido"><actual>$jhjh</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula"><actual>87897987</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha Nacimiento"><actual>1985-01-22</actual><anterior>ninguno</anterior></campo><campo nombre="Sexo"><actual>F</actual><anterior>ninguno</anterior></campo><campo nombre="Nacionalidad"><actual>Venezolano</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Habitación"><actual>04268741232</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Célular"><actual>02129358741</actual><anterior>ninguno</anterior></campo><campo nombre="Ocupación"><actual>Profesional</actual><anterior>ninguno</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>ninguno</anterior></campo><campo nombre="Estado"><actual>Anzoátegui</actual><anterior>ninguno</anterior></campo><campo nombre="Municipio"><actual>	Anaco		 </actual><anterior>ninguno</anterior></campo><campo nombre="Ciudad"><actual>dddd</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Obesidad </actual><anterior>ninguno</anterior></campo></tabla></registro_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (139, '2012-01-22 05:16:40.705', 49, 10, '<?xml version="1.0" standalone="yes"?><modificacion_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="Nombre"><actual>muñoz</actual><anterior>&#039;jhsdf</anterior></campo><campo nombre="Apellido"><actual>$jhjh</actual><anterior>$jhjh</anterior></campo><campo nombre="Cédula"><actual>87897987</actual><anterior>87897987</anterior></campo><campo nombre="Fecha Nacimiento"><actual>1985-01-22</actual><anterior>1985-01-22</anterior></campo><campo nombre="Sexo"><actual>F</actual><anterior>F</anterior></campo><campo nombre="Nacionalidad"><actual>Venezolano</actual><anterior>Venezolano</anterior></campo><campo nombre="Teléfono Habitación"><actual>04268741232</actual><anterior>04268741232</anterior></campo><campo nombre="Teléfono Célular"><actual>02129358741</actual><anterior>02129358741</anterior></campo><campo nombre="Ocupación"><actual>Profesional</actual><anterior>Profesional</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>Venezuela</anterior></campo><campo nombre="Estado"><actual>Anzoátegui</actual><anterior>Anzoátegui</anterior></campo><campo nombre="Municipio"><actual>	Anaco		 </actual><anterior>	Anaco		 </anterior></campo><campo nombre="Ciudad"><actual>dddd</actual><anterior>dddd</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Obesidad </actual><anterior>Obesidad </anterior></campo></tabla></modificacion_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (140, '2012-01-22 05:19:04.184', 49, 9, '<?xml version="1.0" standalone="yes"?><registro_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>32</actual><anterior>ninguno</anterior></campo><campo nombre="Nombre"><actual>&#039;jhsdf&#039;</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido"><actual>fggfg</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula"><actual>17651234</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha Nacimiento"><actual>1985-01-22</actual><anterior>ninguno</anterior></campo><campo nombre="Sexo"><actual>F</actual><anterior>ninguno</anterior></campo><campo nombre="Nacionalidad"><actual>Venezolano</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Habitación"><actual>04268741232</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Célular"><actual>02129358741</actual><anterior>ninguno</anterior></campo><campo nombre="Ocupación"><actual>Profesional</actual><anterior>ninguno</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>ninguno</anterior></campo><campo nombre="Estado"><actual>Apure</actual><anterior>ninguno</anterior></campo><campo nombre="Municipio"><actual>	Biruaca		 </actual><anterior>ninguno</anterior></campo><campo nombre="Ciudad"><actual>a</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Ninguna </actual><anterior>ninguno</anterior></campo></tabla></registro_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (144, '2012-01-22 05:25:42.791', 49, 9, '<?xml version="1.0" standalone="yes"?><registro_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="ID"><actual>32</actual><anterior>ninguno</anterior></campo><campo nombre="Nombre"><actual>muñoz</actual><anterior>ninguno</anterior></campo><campo nombre="Apellido"><actual>fdfadf</actual><anterior>ninguno</anterior></campo><campo nombre="Cédula"><actual>42325244</actual><anterior>ninguno</anterior></campo><campo nombre="Fecha Nacimiento"><actual>2000-01-08</actual><anterior>ninguno</anterior></campo><campo nombre="Sexo"><actual>F</actual><anterior>ninguno</anterior></campo><campo nombre="Nacionalidad"><actual>Venezolano</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Habitación"><actual>04268741232</actual><anterior>ninguno</anterior></campo><campo nombre="Teléfono Célular"><actual>02129358741</actual><anterior>ninguno</anterior></campo><campo nombre="Ocupación"><actual>Técnico</actual><anterior>ninguno</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>ninguno</anterior></campo><campo nombre="Estado"><actual>Anzoátegui</actual><anterior>ninguno</anterior></campo><campo nombre="Municipio"><actual>	Aragua		 </actual><anterior>ninguno</anterior></campo><campo nombre="Ciudad"><actual>dddd</actual><anterior>ninguno</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Obesidad </actual><anterior>ninguno</anterior></campo></tabla></registro_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (145, '2012-01-22 05:39:54.799', 49, 10, '<?xml version="1.0" standalone="yes"?><modificacion_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="Nombre"><actual>hsdf</actual><anterior>&#039;jhsdf&#039;</anterior></campo><campo nombre="Apellido"><actual>fggfg</actual><anterior>fggfg</anterior></campo><campo nombre="Cédula"><actual>17651234</actual><anterior>17651234</anterior></campo><campo nombre="Fecha Nacimiento"><actual>1985-01-22</actual><anterior>1985-01-22</anterior></campo><campo nombre="Sexo"><actual>F</actual><anterior>F</anterior></campo><campo nombre="Nacionalidad"><actual>Venezolano</actual><anterior>Venezolano</anterior></campo><campo nombre="Teléfono Habitación"><actual>04268741232</actual><anterior>04268741232</anterior></campo><campo nombre="Teléfono Célular"><actual>02129358741</actual><anterior>02129358741</anterior></campo><campo nombre="Ocupación"><actual>Profesional</actual><anterior>Profesional</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>Venezuela</anterior></campo><campo nombre="Estado"><actual>Apure</actual><anterior>Apure</anterior></campo><campo nombre="Municipio"><actual>	Biruaca		 </actual><anterior>	Biruaca		 </anterior></campo><campo nombre="Ciudad"><actual>a</actual><anterior>a</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Ninguna </actual><anterior>Ninguna </anterior></campo></tabla></modificacion_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (146, '2012-01-22 05:42:22.912', 49, 10, '<?xml version="1.0" standalone="yes"?><modificacion_de_pacientes>
				 <tabla nombre="pacientes"><campo nombre="Nombre"><actual>Bggh</actual><anterior>B</anterior></campo><campo nombre="Apellido"><actual>Bggh</actual><anterior>B</anterior></campo><campo nombre="Cédula"><actual>17302818</actual><anterior>17302815</anterior></campo><campo nombre="Fecha Nacimiento"><actual>2012-01-16</actual><anterior>2012-01-16</anterior></campo><campo nombre="Sexo"><actual>F</actual><anterior>F</anterior></campo><campo nombre="Nacionalidad"><actual>Venezolano</actual><anterior>Venezolano</anterior></campo><campo nombre="Teléfono Habitación"><actual>36222225555</actual><anterior>3622222</anterior></campo><campo nombre="Teléfono Célular"><actual>15930135555</actual><anterior>15930135</anterior></campo><campo nombre="Ocupación"><actual>Profesional</actual><anterior>Profesional</anterior></campo><campo nombre="País"><actual>Venezuela</actual><anterior>Venezuela</anterior></campo><campo nombre="Estado"><actual>Monagas</actual><anterior>Monagas</anterior></campo><campo nombre="Municipio"><actual>	Aguasay		 </actual><anterior>	Aguasay		 </anterior></campo><campo nombre="Ciudad"><actual>GUrena%%</actual><anterior>GUrenas</anterior></campo></tabla><tabla nombre="antecedentes_personales"><campo nombre="Antecedentes Personales"><actual>Obesidad ,Diabetes </actual><anterior>Obesidad ,Diabetes </anterior></campo></tabla></modificacion_de_pacientes>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (147, '2012-01-22 06:19:49.28', 49, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Otros </actual><anterior></anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Otros</actual><anterior></anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Otro</actual><anterior></anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Otr</actual><anterior></anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>-111111</actual><anterior>-111111</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (148, '2012-01-22 07:44:50.939', 49, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Otros </actual><anterior>Otros </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Otros</actual><anterior>Otros</anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Otro</actual><anterior>Otro</anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Otr</actual><anterior>Otr</anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>-111111</actual><anterior>-111111</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (149, '2012-01-22 07:45:19.447', 49, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Otros </actual><anterior>Otros </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Otros</actual><anterior>Otros</anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Otro</actual><anterior>Otro</anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Otr</actual><anterior>Otr</anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>-111111</actual><anterior>-111111</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (150, '2012-01-22 07:45:52.844', 49, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Otros </actual><anterior>Otros </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Otros</actual><anterior>Otros</anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Otro</actual><anterior>Otro</anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Otr</actual><anterior>Otr</anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>-111111</actual><anterior>-111111</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (151, '2012-01-22 07:46:26.791', 49, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Otros </actual><anterior>Otros </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Otros</actual><anterior>Otros</anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Otro</actual><anterior>Otro</anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Otr</actual><anterior>Otr</anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>-111111</actual><anterior>-111111</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (152, '2012-01-22 07:57:34.426', 49, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Otros </actual><anterior>Otros </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Otros</actual><anterior>Otros</anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Otro</actual><anterior>Otro</anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Otr</actual><anterior>Otr</anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>-111111</actual><anterior>-111111</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (153, '2012-01-22 07:58:41.293', 49, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Otros </actual><anterior>Otros </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Otros</actual><anterior>Otros</anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Otro</actual><anterior>Otro</anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Otr</actual><anterior>Otr</anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>-111111</actual><anterior>-111111</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (154, '2012-01-22 08:10:03.21', 49, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Otros </actual><anterior>Otros </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Otros</actual><anterior>Otros</anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Otro</actual><anterior>Otro</anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Otr</actual><anterior>Otr</anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>-111111</actual><anterior>-111111</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (155, '2012-01-22 08:10:09.412', 49, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Otros </actual><anterior>Otros </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Otros</actual><anterior>Otros</anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Otro</actual><anterior>Otro</anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Otr</actual><anterior>Otr</anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>-111111</actual><anterior>-111111</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (156, '2012-01-22 08:10:30.804', 49, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Otros </actual><anterior>Otros </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Otros</actual><anterior>Otros</anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Otro</actual><anterior>Otro</anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Otr</actual><anterior>Otr</anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>-111111</actual><anterior>-111111</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (157, '2012-01-22 08:11:40.482', 49, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Otros </actual><anterior>Otros </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Otros</actual><anterior>Otros</anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Otro</actual><anterior>Otro</anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Otr</actual><anterior>Otr</anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>-111111</actual><anterior>-111111</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (158, '2012-01-22 08:17:26.197', 49, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Otros </actual><anterior>Otros </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Otros</actual><anterior>Otros</anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Otro</actual><anterior>Otro</anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Otr</actual><anterior>Otr</anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>-111111</actual><anterior>-111111</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (159, '2012-01-22 08:20:44.371', 49, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Otros </actual><anterior>Otros </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Otros Otros </actual><anterior>Otros</anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Otros Otros Otros </actual><anterior>Otro</anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Otros Otros Otros Otros </actual><anterior>Otr</anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>-111111</actual><anterior>-111111</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (160, '2012-01-22 08:22:20.257', 49, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Otros </actual><anterior>Otros </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Otros Otros </actual><anterior>Otros Otros </anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Otros Otros Otros </actual><anterior>Otros Otros Otros </anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Otros Otros Otros Otros </actual><anterior>Otros Otros Otros Otros </anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>-111111</actual><anterior>-111111</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (161, '2012-01-22 08:36:10.752', 49, 15, '<?xml version="1.0" standalone="yes"?><registrar_muestra_clínica_paciente>
			 <tabla nombre="muestras_pacientes"><campo nombre="Nombre"><actual>Bggh</actual><anterior>Bggh</anterior></campo><campo nombre="Apellido"><actual>Bggh</actual><anterior>Bggh</anterior></campo><campo nombre="Cédula"><actual>17302818</actual><anterior>17302818</anterior></campo><campo nombre="Muestra Clínica"><actual>ninguno</actual><anterior>ninguno</anterior></campo></tabla></registrar_muestra_clínica_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (162, '2012-01-22 08:36:28.38', 49, 15, '<?xml version="1.0" standalone="yes"?><registrar_muestra_clínica_paciente>
			 <tabla nombre="muestras_pacientes"><campo nombre="Nombre"><actual>Bggh</actual><anterior>Bggh</anterior></campo><campo nombre="Apellido"><actual>Bggh</actual><anterior>Bggh</anterior></campo><campo nombre="Cédula"><actual>17302818</actual><anterior>17302818</anterior></campo><campo nombre="Muestra Clínica"><actual>ninguno</actual><anterior>ninguno</anterior></campo></tabla></registrar_muestra_clínica_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (163, '2012-01-22 08:42:37.006', 49, 15, '<?xml version="1.0" standalone="yes"?><registrar_muestra_clínica_paciente>
			 <tabla nombre="muestras_pacientes"><campo nombre="Nombre"><actual>Bggh</actual><anterior>Bggh</anterior></campo><campo nombre="Apellido"><actual>Bggh</actual><anterior>Bggh</anterior></campo><campo nombre="Cédula"><actual>17302818</actual><anterior>17302818</anterior></campo><campo nombre="Muestra Clínica"><actual>ninguno</actual><anterior>ninguno</anterior></campo></tabla></registrar_muestra_clínica_paciente>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (164, '2012-01-22 11:28:32.197', 49, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Otros </actual><anterior>Otros </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Otros Otros </actual><anterior>Otros Otros </anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Otros Otros Otros </actual><anterior>Otros Otros Otros </anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Otros Otros Otros Otros </actual><anterior>Otros Otros Otros Otros </anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>-111111</actual><anterior>-111111</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (165, '2012-01-22 11:29:18.052', 49, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Otros </actual><anterior>Otros </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Otros Otros </actual><anterior>Otros Otros </anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Otros Otros Otros </actual><anterior>Otros Otros Otros </anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Otros Otros Otros Otros </actual><anterior>Otros Otros Otros Otros </anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>-111111</actual><anterior>-111111</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (166, '2012-01-22 11:29:18.481', 49, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Otros </actual><anterior>Otros </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Otros Otros </actual><anterior>Otros Otros </anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Otros Otros Otros </actual><anterior>Otros Otros Otros </anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Otros Otros Otros Otros </actual><anterior>Otros Otros Otros Otros </anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>-111111</actual><anterior>-111111</anterior></campo></tabla></Información_adicional>');
INSERT INTO auditoria_transacciones (id_aud_tra, fec_aud_tra, id_tip_usu_usu, id_tip_tra, data_xml) VALUES (167, '2012-01-22 11:29:57.013', 49, 16, '<?xml version="1.0" standalone="yes"?><Información_adicional>
			 <tabla nombre="centro_salud_pacientes"><campo nombre="Centros de Salud"><actual>Otros </actual><anterior>Otros </anterior></campo></tabla><tabla nombre="tipos_consultas_pacientes"><campo nombre="Tipos de Consultas"><actual>Otros Otros </actual><anterior>Otros Otros </anterior></campo></tabla><tabla nombre="contactos_animales"><campo nombre="Animales"><actual>Otros Otros Otros </actual><anterior>Otros Otros Otros </anterior></campo></tabla><tabla nombre="tratamientos_pacientes"><campo nombre="Tratamientos"><actual>Otros Otros Otros Otros </actual><anterior>Otros Otros Otros Otros </anterior></campo></tabla><tabla nombre="tiempo_evoluciones"><campo nombre="Evolución"><actual>-111111</actual><anterior>-111111</anterior></campo></tabla></Información_adicional>');


--
-- TOC entry 2327 (class 0 OID 32456)
-- Dependencies: 1680
-- Data for Name: categorias__cuerpos_micosis; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO categorias__cuerpos_micosis (id_cat_cue_mic, id_cat_cue, id_tip_mic) VALUES (1, 1, 1);
INSERT INTO categorias__cuerpos_micosis (id_cat_cue_mic, id_cat_cue, id_tip_mic) VALUES (2, 2, 1);
INSERT INTO categorias__cuerpos_micosis (id_cat_cue_mic, id_cat_cue, id_tip_mic) VALUES (13, 3, 1);
INSERT INTO categorias__cuerpos_micosis (id_cat_cue_mic, id_cat_cue, id_tip_mic) VALUES (14, 4, 2);
INSERT INTO categorias__cuerpos_micosis (id_cat_cue_mic, id_cat_cue, id_tip_mic) VALUES (17, 5, 3);


--
-- TOC entry 2328 (class 0 OID 32461)
-- Dependencies: 1682
-- Data for Name: categorias_cuerpos; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO categorias_cuerpos (id_cat_cue, nom_cat_cue) VALUES (1, 'Uña');
INSERT INTO categorias_cuerpos (id_cat_cue, nom_cat_cue) VALUES (2, 'Cuerpo');
INSERT INTO categorias_cuerpos (id_cat_cue, nom_cat_cue) VALUES (3, 'Piel');
INSERT INTO categorias_cuerpos (id_cat_cue, nom_cat_cue) VALUES (4, 'Piel');
INSERT INTO categorias_cuerpos (id_cat_cue, nom_cat_cue) VALUES (5, 'Cuerpo');


--
-- TOC entry 2329 (class 0 OID 32464)
-- Dependencies: 1683
-- Data for Name: categorias_cuerpos__lesiones; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (2, 1, 1);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (3, 2, 1);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (4, 3, 1);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (5, 4, 1);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (6, 5, 1);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (7, 6, 1);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (8, 7, 1);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (9, 8, 1);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (10, 9, 3);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (11, 10, 3);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (12, 11, 3);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (13, 12, 3);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (14, 13, 3);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (15, 14, 3);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (16, 15, 3);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (17, 19, 3);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (18, 16, 3);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (19, 17, 3);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (20, 18, 3);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (21, 20, 3);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (66, 22, 4);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (22, 21, 1);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (67, 23, 4);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (68, 24, 4);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (69, 25, 4);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (70, 26, 4);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (71, 27, 4);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (72, 28, 4);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (73, 29, 4);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (74, 30, 4);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (75, 31, 4);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (76, 32, 4);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (77, 33, 4);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (78, 34, 4);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (79, 35, 4);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (80, 36, 4);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (81, 37, 4);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (82, 38, 4);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (83, 39, 4);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (84, 40, 4);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (85, 41, 4);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (23, 21, 3);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (86, 42, 4);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (87, 43, 4);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (88, 44, 4);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (89, 45, 4);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (90, 46, 4);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (91, 47, 4);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (92, 48, 4);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (93, 49, 4);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (94, 50, 4);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (95, 51, 4);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (96, 52, 4);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (97, 53, 4);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (98, 54, 4);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (99, 55, 5);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (100, 56, 5);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (101, 57, 5);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (102, 58, 5);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (103, 59, 5);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (104, 60, 5);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (105, 61, 5);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (106, 62, 5);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (107, 63, 5);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (108, 64, 5);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (109, 65, 5);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (110, 66, 5);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (111, 67, 5);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (112, 68, 5);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (113, 69, 5);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (114, 70, 5);
INSERT INTO categorias_cuerpos__lesiones (id_cat_cue_les, id_les, id_cat_cue) VALUES (115, 71, 5);


--
-- TOC entry 2330 (class 0 OID 32469)
-- Dependencies: 1685
-- Data for Name: centro_salud_doctores; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO centro_salud_doctores (id_cen_sal_doc, id_cen_sal, id_doc, otr_cen_sal) VALUES (5, 5, 33, NULL);
INSERT INTO centro_salud_doctores (id_cen_sal_doc, id_cen_sal, id_doc, otr_cen_sal) VALUES (6, 6, 6, NULL);
INSERT INTO centro_salud_doctores (id_cen_sal_doc, id_cen_sal, id_doc, otr_cen_sal) VALUES (9, 5, 34, NULL);
INSERT INTO centro_salud_doctores (id_cen_sal_doc, id_cen_sal, id_doc, otr_cen_sal) VALUES (11, 7, 32, NULL);
INSERT INTO centro_salud_doctores (id_cen_sal_doc, id_cen_sal, id_doc, otr_cen_sal) VALUES (14, 5, 28, NULL);
INSERT INTO centro_salud_doctores (id_cen_sal_doc, id_cen_sal, id_doc, otr_cen_sal) VALUES (15, 12, 35, NULL);


--
-- TOC entry 2332 (class 0 OID 32479)
-- Dependencies: 1689
-- Data for Name: centro_salud_pacientes; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO centro_salud_pacientes (id_cen_sal_pac, id_his, id_cen_sal, otr_cen_sal) VALUES (209, 24, 5, NULL);
INSERT INTO centro_salud_pacientes (id_cen_sal_pac, id_his, id_cen_sal, otr_cen_sal) VALUES (210, 24, 7, NULL);
INSERT INTO centro_salud_pacientes (id_cen_sal_pac, id_his, id_cen_sal, otr_cen_sal) VALUES (228, 25, 12, 'Biopsia Piel; Biopsia Otros Órganos; Líquido Peritoneal; Líquido Sinovial; Cefalorraquídeo (LC); uña');


--
-- TOC entry 2331 (class 0 OID 32474)
-- Dependencies: 1687
-- Data for Name: centro_saluds; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO centro_saluds (id_cen_sal, nom_cen_sal, des_cen_sal) VALUES (1, 'Hospital General', 'Hospital General');
INSERT INTO centro_saluds (id_cen_sal, nom_cen_sal, des_cen_sal) VALUES (2, 'Hospital Universitario', 'Hospital Universitario');
INSERT INTO centro_saluds (id_cen_sal, nom_cen_sal, des_cen_sal) VALUES (3, 'Hospital Especializado', 'Hospital Especializado');
INSERT INTO centro_saluds (id_cen_sal, nom_cen_sal, des_cen_sal) VALUES (4, 'Ambulatorio Urbano', 'Ambulatorio Urbano');
INSERT INTO centro_saluds (id_cen_sal, nom_cen_sal, des_cen_sal) VALUES (5, 'Ambulatorio Rural', 'Ambulatorio Rural');
INSERT INTO centro_saluds (id_cen_sal, nom_cen_sal, des_cen_sal) VALUES (6, 'Instituto', 'Instituto');
INSERT INTO centro_saluds (id_cen_sal, nom_cen_sal, des_cen_sal) VALUES (7, 'Clínica', 'Clínica');
INSERT INTO centro_saluds (id_cen_sal, nom_cen_sal, des_cen_sal) VALUES (8, 'Dispensario', 'Dispensario');
INSERT INTO centro_saluds (id_cen_sal, nom_cen_sal, des_cen_sal) VALUES (9, 'Barrio Adentro I', 'Barrio Adentro I');
INSERT INTO centro_saluds (id_cen_sal, nom_cen_sal, des_cen_sal) VALUES (10, 'Barrio Adentro II', 'Barrio Adentro II');
INSERT INTO centro_saluds (id_cen_sal, nom_cen_sal, des_cen_sal) VALUES (11, 'Barrio Adentro III', 'Barrio Adentro III');
INSERT INTO centro_saluds (id_cen_sal, nom_cen_sal, des_cen_sal) VALUES (12, 'Otros', 'Otros');


--
-- TOC entry 2333 (class 0 OID 32484)
-- Dependencies: 1691
-- Data for Name: contactos_animales; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO contactos_animales (id_con_ani, id_his, id_ani, otr_ani) VALUES (181, 25, 5, 'Biopsia Piel; Biopsia Otros Órganos; Líquido Peritoneal; Líquido Sinovial; Cefalorraquídeo (LC); uña');


--
-- TOC entry 2334 (class 0 OID 32489)
-- Dependencies: 1693
-- Data for Name: doctores; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO doctores (id_doc, nom_doc, ape_doc, ced_doc, pas_doc, tel_doc, cor_doc, log_doc, fec_reg_doc) VALUES (27, 'SAIB', 'SAIB', NULL, '83422503bcfc01d303030e8a7cc80efc', '3622824', NULL, 'SAIB', '2011-06-26 01:06:59.641-04:30');
INSERT INTO doctores (id_doc, nom_doc, ape_doc, ced_doc, pas_doc, tel_doc, cor_doc, log_doc, fec_reg_doc) VALUES (33, 'Mary', 'Lopez', '8752299', '9f4b04c2eac4a3cfa351aff1564f7995', '54564545646', 'mlopez@gmail.com', 'mlopez', '2011-06-26 01:06:59.641-04:30');
INSERT INTO doctores (id_doc, nom_doc, ape_doc, ced_doc, pas_doc, tel_doc, cor_doc, log_doc, fec_reg_doc) VALUES (6, 'Luis', 'Marin', '17302857', '3e46a122f1961a8ec71f2a369f6d16ee', '3622222', 'ninja.aoshi@gmail.com', 'lmarin', '2011-06-26 01:06:59.641-04:30');
INSERT INTO doctores (id_doc, nom_doc, ape_doc, ced_doc, pas_doc, tel_doc, cor_doc, log_doc, fec_reg_doc) VALUES (34, 'Luis', 'Marin', '17302858', '3e46a122f1961a8ec71f2a369f6d16ee', '3622222', 'lrm.prigramador@gmail.com', 'lmarinn', '2011-07-08 15:58:52.908-04:30');
INSERT INTO doctores (id_doc, nom_doc, ape_doc, ced_doc, pas_doc, tel_doc, cor_doc, log_doc, fec_reg_doc) VALUES (32, 'Lisseth', 'Lozada', '17651233', '3e46a122f1961a8ec71f2a369f6d16ee', '04269150722', 'risusefu15@gmail.com', 'llozada', '2011-06-26 01:06:59.641-04:30');
INSERT INTO doctores (id_doc, nom_doc, ape_doc, ced_doc, pas_doc, tel_doc, cor_doc, log_doc, fec_reg_doc) VALUES (28, 'Mireya', 'Gonzalez', '17302859', 'b107e9a7ba2cd6d9e878c1a1c277554c', '04265168824', 'marmont04@hotmail.com', 'mgonzalez', '2011-06-26 01:06:59.641-04:30');
INSERT INTO doctores (id_doc, nom_doc, ape_doc, ced_doc, pas_doc, tel_doc, cor_doc, log_doc, fec_reg_doc) VALUES (35, 'Moises', 'Perez', '18403190', 'bbc5d47920c1adc1ab1f4d43a1832282', '04123818120', 'moisevic@hotmail.com', 'Moises', '2012-01-16 10:02:40.54-04:30');


--
-- TOC entry 2335 (class 0 OID 32498)
-- Dependencies: 1695
-- Data for Name: enfermedades_micologicas; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO enfermedades_micologicas (id_enf_mic, nom_enf_mic, id_tip_mic) VALUES (1, 'Dermatofitosis', 1);
INSERT INTO enfermedades_micologicas (id_enf_mic, nom_enf_mic, id_tip_mic) VALUES (2, 'Onicomicosis dermatofitica', 1);
INSERT INTO enfermedades_micologicas (id_enf_mic, nom_enf_mic, id_tip_mic) VALUES (3, 'Onicomicosis no dermatofitica', 1);
INSERT INTO enfermedades_micologicas (id_enf_mic, nom_enf_mic, id_tip_mic) VALUES (5, 'Piedra blanca', 1);
INSERT INTO enfermedades_micologicas (id_enf_mic, nom_enf_mic, id_tip_mic) VALUES (6, 'Tiña negra', 1);
INSERT INTO enfermedades_micologicas (id_enf_mic, nom_enf_mic, id_tip_mic) VALUES (7, 'Oculomicosis', 1);
INSERT INTO enfermedades_micologicas (id_enf_mic, nom_enf_mic, id_tip_mic) VALUES (8, 'Otomicosis', 1);
INSERT INTO enfermedades_micologicas (id_enf_mic, nom_enf_mic, id_tip_mic) VALUES (9, 'Tinea capitis', 1);
INSERT INTO enfermedades_micologicas (id_enf_mic, nom_enf_mic, id_tip_mic) VALUES (10, 'Tinea barbae', 1);
INSERT INTO enfermedades_micologicas (id_enf_mic, nom_enf_mic, id_tip_mic) VALUES (11, 'Tinea corporis', 1);
INSERT INTO enfermedades_micologicas (id_enf_mic, nom_enf_mic, id_tip_mic) VALUES (12, 'Tinea cruris', 1);
INSERT INTO enfermedades_micologicas (id_enf_mic, nom_enf_mic, id_tip_mic) VALUES (13, 'Tinea imbricata', 1);
INSERT INTO enfermedades_micologicas (id_enf_mic, nom_enf_mic, id_tip_mic) VALUES (14, 'Tinea manuum', 1);
INSERT INTO enfermedades_micologicas (id_enf_mic, nom_enf_mic, id_tip_mic) VALUES (15, 'Tinea pedis', 1);
INSERT INTO enfermedades_micologicas (id_enf_mic, nom_enf_mic, id_tip_mic) VALUES (16, 'Tinea unguium', 1);
INSERT INTO enfermedades_micologicas (id_enf_mic, nom_enf_mic, id_tip_mic) VALUES (17, 'Cromomicosis dermatofitica', 1);
INSERT INTO enfermedades_micologicas (id_enf_mic, nom_enf_mic, id_tip_mic) VALUES (19, 'Actinomicetoma', 2);
INSERT INTO enfermedades_micologicas (id_enf_mic, nom_enf_mic, id_tip_mic) VALUES (20, 'Eumicetoma', 2);
INSERT INTO enfermedades_micologicas (id_enf_mic, nom_enf_mic, id_tip_mic) VALUES (21, 'Esporotricosis', 2);
INSERT INTO enfermedades_micologicas (id_enf_mic, nom_enf_mic, id_tip_mic) VALUES (22, 'Cromoblastomicosis', 2);
INSERT INTO enfermedades_micologicas (id_enf_mic, nom_enf_mic, id_tip_mic) VALUES (23, 'Lobomicosis', 2);
INSERT INTO enfermedades_micologicas (id_enf_mic, nom_enf_mic, id_tip_mic) VALUES (24, 'Coccidioidomicosis', 3);
INSERT INTO enfermedades_micologicas (id_enf_mic, nom_enf_mic, id_tip_mic) VALUES (25, 'Histoplasmosis', 3);
INSERT INTO enfermedades_micologicas (id_enf_mic, nom_enf_mic, id_tip_mic) VALUES (26, 'Paracoccidioidomicosis', 3);
INSERT INTO enfermedades_micologicas (id_enf_mic, nom_enf_mic, id_tip_mic) VALUES (27, 'Otros', 2);
INSERT INTO enfermedades_micologicas (id_enf_mic, nom_enf_mic, id_tip_mic) VALUES (28, 'Otros', 3);
INSERT INTO enfermedades_micologicas (id_enf_mic, nom_enf_mic, id_tip_mic) VALUES (18, 'Otros', 1);
INSERT INTO enfermedades_micologicas (id_enf_mic, nom_enf_mic, id_tip_mic) VALUES (4, 'Pitiriasis versicolor', 1);
INSERT INTO enfermedades_micologicas (id_enf_mic, nom_enf_mic, id_tip_mic) VALUES (29, 'Piedra negra', 1);


--
-- TOC entry 2336 (class 0 OID 32503)
-- Dependencies: 1697
-- Data for Name: enfermedades_pacientes; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO enfermedades_pacientes (id_enf_pac, id_enf_mic, otr_enf_mic, esp_enf_mic, id_tip_mic_pac) VALUES (426, 2, NULL, NULL, 109);
INSERT INTO enfermedades_pacientes (id_enf_pac, id_enf_mic, otr_enf_mic, esp_enf_mic, id_tip_mic_pac) VALUES (427, 1, NULL, NULL, 109);
INSERT INTO enfermedades_pacientes (id_enf_pac, id_enf_mic, otr_enf_mic, esp_enf_mic, id_tip_mic_pac) VALUES (449, 24, NULL, NULL, 180);
INSERT INTO enfermedades_pacientes (id_enf_pac, id_enf_mic, otr_enf_mic, esp_enf_mic, id_tip_mic_pac) VALUES (450, 28, 'Biopsia Piel, Biopsia Otros Órganos, Líquido Peritoneal, Líquido Sinovial, Cefalorraquídeo (LC), uña', NULL, 180);
INSERT INTO enfermedades_pacientes (id_enf_pac, id_enf_mic, otr_enf_mic, esp_enf_mic, id_tip_mic_pac) VALUES (451, 20, NULL, NULL, 181);
INSERT INTO enfermedades_pacientes (id_enf_pac, id_enf_mic, otr_enf_mic, esp_enf_mic, id_tip_mic_pac) VALUES (452, 27, 'Biopsia Piel, Biopsia Otros Órganos, Líquido Peritoneal, Líquido Sinovial, Cefalorraquídeo (LC), uña', NULL, 181);
INSERT INTO enfermedades_pacientes (id_enf_pac, id_enf_mic, otr_enf_mic, esp_enf_mic, id_tip_mic_pac) VALUES (453, 8, NULL, NULL, 179);
INSERT INTO enfermedades_pacientes (id_enf_pac, id_enf_mic, otr_enf_mic, esp_enf_mic, id_tip_mic_pac) VALUES (454, 18, 'Biopsia Piel, Biopsia Otros Órganos, Líquido Peritoneal, Líquido Sinovial, Cefalorraquídeo (LC), uña', NULL, 179);


--
-- TOC entry 2337 (class 0 OID 32508)
-- Dependencies: 1699
-- Data for Name: estados; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO estados (id_est, des_est, id_pai) VALUES (1, 'Distrito Capital', 1);
INSERT INTO estados (id_est, des_est, id_pai) VALUES (2, 'Anzoátegui', 1);
INSERT INTO estados (id_est, des_est, id_pai) VALUES (3, 'Apure', 1);
INSERT INTO estados (id_est, des_est, id_pai) VALUES (4, 'Aragua', 1);
INSERT INTO estados (id_est, des_est, id_pai) VALUES (5, 'Barinas', 1);
INSERT INTO estados (id_est, des_est, id_pai) VALUES (6, 'Bolívar', 1);
INSERT INTO estados (id_est, des_est, id_pai) VALUES (7, 'Carabobo', 1);
INSERT INTO estados (id_est, des_est, id_pai) VALUES (8, 'Cojedes', 1);
INSERT INTO estados (id_est, des_est, id_pai) VALUES (9, 'Delta Amacuro', 1);
INSERT INTO estados (id_est, des_est, id_pai) VALUES (10, 'Falcón', 1);
INSERT INTO estados (id_est, des_est, id_pai) VALUES (11, 'Guárico', 1);
INSERT INTO estados (id_est, des_est, id_pai) VALUES (12, 'Lara', 1);
INSERT INTO estados (id_est, des_est, id_pai) VALUES (13, 'Mérida', 1);
INSERT INTO estados (id_est, des_est, id_pai) VALUES (14, 'Miranda', 1);
INSERT INTO estados (id_est, des_est, id_pai) VALUES (15, 'Monagas', 1);
INSERT INTO estados (id_est, des_est, id_pai) VALUES (16, 'Nueva Esparta', 1);
INSERT INTO estados (id_est, des_est, id_pai) VALUES (18, 'Portuguesa', 1);
INSERT INTO estados (id_est, des_est, id_pai) VALUES (19, 'Sucre', 1);
INSERT INTO estados (id_est, des_est, id_pai) VALUES (20, 'Táchira', 1);
INSERT INTO estados (id_est, des_est, id_pai) VALUES (21, 'Trujillo', 1);
INSERT INTO estados (id_est, des_est, id_pai) VALUES (22, 'Vargas', 1);
INSERT INTO estados (id_est, des_est, id_pai) VALUES (23, 'Yaracuy', 1);
INSERT INTO estados (id_est, des_est, id_pai) VALUES (24, 'Zulia', 1);
INSERT INTO estados (id_est, des_est, id_pai) VALUES (25, 'Amazonas', 1);


--
-- TOC entry 2338 (class 0 OID 32513)
-- Dependencies: 1701
-- Data for Name: examenes_pacientes; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO examenes_pacientes (id_exa_pac, id_tip_mic_pac, exa_pac_est, id_tip_exa) VALUES (59, 180, 0, 1);
INSERT INTO examenes_pacientes (id_exa_pac, id_tip_mic_pac, exa_pac_est, id_tip_exa) VALUES (60, 180, 0, 2);
INSERT INTO examenes_pacientes (id_exa_pac, id_tip_mic_pac, exa_pac_est, id_tip_exa) VALUES (61, 181, 3, 1);
INSERT INTO examenes_pacientes (id_exa_pac, id_tip_mic_pac, exa_pac_est, id_tip_exa) VALUES (62, 181, 3, 2);
INSERT INTO examenes_pacientes (id_exa_pac, id_tip_mic_pac, exa_pac_est, id_tip_exa) VALUES (63, 179, 0, 1);
INSERT INTO examenes_pacientes (id_exa_pac, id_tip_mic_pac, exa_pac_est, id_tip_exa) VALUES (64, 179, 0, 2);


--
-- TOC entry 2339 (class 0 OID 32518)
-- Dependencies: 1703
-- Data for Name: forma_infecciones; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO forma_infecciones (id_for_inf, des_for_inf) VALUES (2, 'Picada de insecto');
INSERT INTO forma_infecciones (id_for_inf, des_for_inf) VALUES (4, 'Mordedura de roedores');
INSERT INTO forma_infecciones (id_for_inf, des_for_inf) VALUES (5, 'Instrumento metálico');
INSERT INTO forma_infecciones (id_for_inf, des_for_inf) VALUES (6, 'Caza animales');
INSERT INTO forma_infecciones (id_for_inf, des_for_inf) VALUES (8, 'Otros');
INSERT INTO forma_infecciones (id_for_inf, des_for_inf) VALUES (1, 'Traumática');
INSERT INTO forma_infecciones (id_for_inf, des_for_inf) VALUES (3, 'Pinchazo de espinas');
INSERT INTO forma_infecciones (id_for_inf, des_for_inf) VALUES (7, 'Accidente laboratorio');
INSERT INTO forma_infecciones (id_for_inf, des_for_inf) VALUES (9, 'Inhalatoria');
INSERT INTO forma_infecciones (id_for_inf, des_for_inf) VALUES (10, 'Traumática');
INSERT INTO forma_infecciones (id_for_inf, des_for_inf) VALUES (11, 'Accidente loboratorio');
INSERT INTO forma_infecciones (id_for_inf, des_for_inf) VALUES (12, 'Otros');


--
-- TOC entry 2340 (class 0 OID 32521)
-- Dependencies: 1704
-- Data for Name: forma_infecciones__pacientes; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO forma_infecciones__pacientes (id_for_pac, id_for_inf, otr_for_inf, id_tip_mic_pac) VALUES (74, 10, NULL, 180);
INSERT INTO forma_infecciones__pacientes (id_for_pac, id_for_inf, otr_for_inf, id_tip_mic_pac) VALUES (75, 12, 'Biopsia Piel, Biopsia Otros Órganos, Líquido Peritoneal, Líquido Sinovial, Cefalorraquídeo (LC), uña', 180);
INSERT INTO forma_infecciones__pacientes (id_for_pac, id_for_inf, otr_for_inf, id_tip_mic_pac) VALUES (76, 5, NULL, 181);
INSERT INTO forma_infecciones__pacientes (id_for_pac, id_for_inf, otr_for_inf, id_tip_mic_pac) VALUES (77, 8, 'Biopsia Piel, Biopsia Otros Órganos, Líquido Peritoneal, Líquido Sinovial, Cefalorraquídeo (LC), uña', 181);


--
-- TOC entry 2341 (class 0 OID 32526)
-- Dependencies: 1706
-- Data for Name: forma_infecciones__tipos_micosis; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO forma_infecciones__tipos_micosis (id_for_inf_tip_mic, id_tip_mic, id_for_inf) VALUES (1, 2, 1);
INSERT INTO forma_infecciones__tipos_micosis (id_for_inf_tip_mic, id_tip_mic, id_for_inf) VALUES (2, 2, 2);
INSERT INTO forma_infecciones__tipos_micosis (id_for_inf_tip_mic, id_tip_mic, id_for_inf) VALUES (3, 2, 3);
INSERT INTO forma_infecciones__tipos_micosis (id_for_inf_tip_mic, id_tip_mic, id_for_inf) VALUES (6, 2, 4);
INSERT INTO forma_infecciones__tipos_micosis (id_for_inf_tip_mic, id_tip_mic, id_for_inf) VALUES (7, 2, 5);
INSERT INTO forma_infecciones__tipos_micosis (id_for_inf_tip_mic, id_tip_mic, id_for_inf) VALUES (8, 2, 6);
INSERT INTO forma_infecciones__tipos_micosis (id_for_inf_tip_mic, id_tip_mic, id_for_inf) VALUES (9, 2, 7);
INSERT INTO forma_infecciones__tipos_micosis (id_for_inf_tip_mic, id_tip_mic, id_for_inf) VALUES (10, 2, 8);
INSERT INTO forma_infecciones__tipos_micosis (id_for_inf_tip_mic, id_tip_mic, id_for_inf) VALUES (18, 3, 9);
INSERT INTO forma_infecciones__tipos_micosis (id_for_inf_tip_mic, id_tip_mic, id_for_inf) VALUES (19, 3, 10);
INSERT INTO forma_infecciones__tipos_micosis (id_for_inf_tip_mic, id_tip_mic, id_for_inf) VALUES (20, 3, 11);
INSERT INTO forma_infecciones__tipos_micosis (id_for_inf_tip_mic, id_tip_mic, id_for_inf) VALUES (21, 3, 12);


--
-- TOC entry 2342 (class 0 OID 32533)
-- Dependencies: 1709
-- Data for Name: historiales_pacientes; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO historiales_pacientes (id_his, id_pac, des_his, id_doc, des_adi_pac_his, fec_his, pag_his) VALUES (22, 16, 'prueba', 28, 'prueba', '2012-01-16 02:18:35.698-04:30', 1);
INSERT INTO historiales_pacientes (id_his, id_pac, des_his, id_doc, des_adi_pac_his, fec_his, pag_his) VALUES (24, 56, '', 28, '', '2012-01-16 23:04:09.453-04:30', 1);
INSERT INTO historiales_pacientes (id_his, id_pac, des_his, id_doc, des_adi_pac_his, fec_his, pag_his) VALUES (25, 54, 'demo', 6, 'dem', '2012-01-22 10:27:09.579-04:30', 1);


--
-- TOC entry 2343 (class 0 OID 32543)
-- Dependencies: 1711
-- Data for Name: lesiones; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO lesiones (id_les, nom_les) VALUES (2, 'Onicodistrofia total');
INSERT INTO lesiones (id_les, nom_les) VALUES (6, 'Leuconiquia');
INSERT INTO lesiones (id_les, nom_les) VALUES (8, 'Dermatofitoma');
INSERT INTO lesiones (id_les, nom_les) VALUES (10, 'Descamativa');
INSERT INTO lesiones (id_les, nom_les) VALUES (11, 'Pruriginosa');
INSERT INTO lesiones (id_les, nom_les) VALUES (12, 'Bordes activos');
INSERT INTO lesiones (id_les, nom_les) VALUES (13, 'Inflamatoria');
INSERT INTO lesiones (id_les, nom_les) VALUES (14, 'Extensa');
INSERT INTO lesiones (id_les, nom_les) VALUES (15, 'Multiples');
INSERT INTO lesiones (id_les, nom_les) VALUES (16, 'Pustulas');
INSERT INTO lesiones (id_les, nom_les) VALUES (17, 'Alopecia');
INSERT INTO lesiones (id_les, nom_les) VALUES (18, 'Granuloma tricofitico');
INSERT INTO lesiones (id_les, nom_les) VALUES (19, 'Foliculitis');
INSERT INTO lesiones (id_les, nom_les) VALUES (20, 'Querion de celso');
INSERT INTO lesiones (id_les, nom_les) VALUES (21, 'Otros');
INSERT INTO lesiones (id_les, nom_les) VALUES (22, 'Cabeza');
INSERT INTO lesiones (id_les, nom_les) VALUES (24, 'Espalda');
INSERT INTO lesiones (id_les, nom_les) VALUES (54, 'Otros');
INSERT INTO lesiones (id_les, nom_les) VALUES (3, 'Coloración blanco-amarillenta');
INSERT INTO lesiones (id_les, nom_les) VALUES (5, 'Onicolisis subungueal proximal');
INSERT INTO lesiones (id_les, nom_les) VALUES (7, 'Coloración pardo-naranja');
INSERT INTO lesiones (id_les, nom_les) VALUES (4, 'Coloración negruzca');
INSERT INTO lesiones (id_les, nom_les) VALUES (1, 'Onicolisis subungueal distal');
INSERT INTO lesiones (id_les, nom_les) VALUES (9, 'Placas eritematoscamosa');
INSERT INTO lesiones (id_les, nom_les) VALUES (23, 'Tórax anterior');
INSERT INTO lesiones (id_les, nom_les) VALUES (25, 'Flanco derecho');
INSERT INTO lesiones (id_les, nom_les) VALUES (26, 'Flanco izquierdo');
INSERT INTO lesiones (id_les, nom_les) VALUES (27, 'Brazo derecho');
INSERT INTO lesiones (id_les, nom_les) VALUES (28, 'Brazo izquierdo');
INSERT INTO lesiones (id_les, nom_les) VALUES (29, 'Pierna derecha');
INSERT INTO lesiones (id_les, nom_les) VALUES (30, 'Pierna izquierda');
INSERT INTO lesiones (id_les, nom_les) VALUES (31, 'Pie derecho');
INSERT INTO lesiones (id_les, nom_les) VALUES (32, 'Pie izquierdo');
INSERT INTO lesiones (id_les, nom_les) VALUES (33, 'Lesión única');
INSERT INTO lesiones (id_les, nom_les) VALUES (34, 'Lesión múltiple');
INSERT INTO lesiones (id_les, nom_les) VALUES (35, 'Con fístula');
INSERT INTO lesiones (id_les, nom_les) VALUES (36, 'Sin fístula');
INSERT INTO lesiones (id_les, nom_les) VALUES (37, 'Secreción granos de la fístula');
INSERT INTO lesiones (id_les, nom_les) VALUES (38, 'Aumento volumen');
INSERT INTO lesiones (id_les, nom_les) VALUES (39, 'Sin aumento volumen');
INSERT INTO lesiones (id_les, nom_les) VALUES (40, 'Afectación hueso');
INSERT INTO lesiones (id_les, nom_les) VALUES (41, 'Cutánea verrugosa');
INSERT INTO lesiones (id_les, nom_les) VALUES (42, 'Cutánea tumoral');
INSERT INTO lesiones (id_les, nom_les) VALUES (43, 'Cutánea en placa');
INSERT INTO lesiones (id_les, nom_les) VALUES (44, 'Nódulos eritematosos');
INSERT INTO lesiones (id_les, nom_les) VALUES (45, 'Atrofia central');
INSERT INTO lesiones (id_les, nom_les) VALUES (46, 'Bordes activos');
INSERT INTO lesiones (id_les, nom_les) VALUES (47, 'Cutánea fija');
INSERT INTO lesiones (id_les, nom_les) VALUES (48, 'Cutánea linfangítica');
INSERT INTO lesiones (id_les, nom_les) VALUES (49, 'Cutánea múltiple');
INSERT INTO lesiones (id_les, nom_les) VALUES (50, 'Cutánea queloidal');
INSERT INTO lesiones (id_les, nom_les) VALUES (51, 'Cutánea infiltrante');
INSERT INTO lesiones (id_les, nom_les) VALUES (52, 'Cutánea gomosa');
INSERT INTO lesiones (id_les, nom_les) VALUES (53, 'Cutánea ulcerada');
INSERT INTO lesiones (id_les, nom_les) VALUES (55, 'Cutánea');
INSERT INTO lesiones (id_les, nom_les) VALUES (56, 'Pulmonar');
INSERT INTO lesiones (id_les, nom_les) VALUES (57, 'Pulmonar leve');
INSERT INTO lesiones (id_les, nom_les) VALUES (58, 'Pulmonar moderada');
INSERT INTO lesiones (id_les, nom_les) VALUES (59, 'Pulmonar aguda');
INSERT INTO lesiones (id_les, nom_les) VALUES (60, 'Pulmonar crónica benigna');
INSERT INTO lesiones (id_les, nom_les) VALUES (61, 'Pulmonar prograsiva');
INSERT INTO lesiones (id_les, nom_les) VALUES (62, 'Diseminada');
INSERT INTO lesiones (id_les, nom_les) VALUES (63, 'Tegumentaria (mucocutánea)');
INSERT INTO lesiones (id_les, nom_les) VALUES (64, 'Ganglionar');
INSERT INTO lesiones (id_les, nom_les) VALUES (65, 'Visceral');
INSERT INTO lesiones (id_les, nom_les) VALUES (66, 'Mixta');
INSERT INTO lesiones (id_les, nom_les) VALUES (67, 'Meníngea');
INSERT INTO lesiones (id_les, nom_les) VALUES (68, 'Hepatoesplenomegalia');
INSERT INTO lesiones (id_les, nom_les) VALUES (69, 'Generalizada');
INSERT INTO lesiones (id_les, nom_les) VALUES (70, 'Histoplasmoma');
INSERT INTO lesiones (id_les, nom_les) VALUES (71, 'Otros');


--
-- TOC entry 2344 (class 0 OID 32550)
-- Dependencies: 1714
-- Data for Name: lesiones_partes_cuerpos__pacientes; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO lesiones_partes_cuerpos__pacientes (id_les_par_cue_pac, otr_les_par_cue, id_cat_cue_les, id_par_cue_cat_cue, id_tip_mic_pac) VALUES (329, NULL, 3, 1, 109);
INSERT INTO lesiones_partes_cuerpos__pacientes (id_les_par_cue_pac, otr_les_par_cue, id_cat_cue_les, id_par_cue_cat_cue, id_tip_mic_pac) VALUES (330, NULL, 7, 1, 109);
INSERT INTO lesiones_partes_cuerpos__pacientes (id_les_par_cue_pac, otr_les_par_cue, id_cat_cue_les, id_par_cue_cat_cue, id_tip_mic_pac) VALUES (331, NULL, 11, 3, 109);
INSERT INTO lesiones_partes_cuerpos__pacientes (id_les_par_cue_pac, otr_les_par_cue, id_cat_cue_les, id_par_cue_cat_cue, id_tip_mic_pac) VALUES (332, NULL, 12, 3, 109);
INSERT INTO lesiones_partes_cuerpos__pacientes (id_les_par_cue_pac, otr_les_par_cue, id_cat_cue_les, id_par_cue_cat_cue, id_tip_mic_pac) VALUES (363, NULL, 100, 6, 180);
INSERT INTO lesiones_partes_cuerpos__pacientes (id_les_par_cue_pac, otr_les_par_cue, id_cat_cue_les, id_par_cue_cat_cue, id_tip_mic_pac) VALUES (364, NULL, 101, 6, 180);
INSERT INTO lesiones_partes_cuerpos__pacientes (id_les_par_cue_pac, otr_les_par_cue, id_cat_cue_les, id_par_cue_cat_cue, id_tip_mic_pac) VALUES (365, 'Biopsia Piel, Biopsia Otros Órganos, Líquido Peritoneal, Líquido Sinovial, Cefalorraquídeo (LC), uña', 115, 6, 180);
INSERT INTO lesiones_partes_cuerpos__pacientes (id_les_par_cue_pac, otr_les_par_cue, id_cat_cue_les, id_par_cue_cat_cue, id_tip_mic_pac) VALUES (366, 'Biopsia Piel, Biopsia Otros Órganos, Líquido Peritoneal, Líquido Sinovial, Cefalorraquídeo (LC), uña', 98, 5, 181);
INSERT INTO lesiones_partes_cuerpos__pacientes (id_les_par_cue_pac, otr_les_par_cue, id_cat_cue_les, id_par_cue_cat_cue, id_tip_mic_pac) VALUES (367, NULL, 6, 1, 179);
INSERT INTO lesiones_partes_cuerpos__pacientes (id_les_par_cue_pac, otr_les_par_cue, id_cat_cue_les, id_par_cue_cat_cue, id_tip_mic_pac) VALUES (368, 'Biopsia Piel, Biopsia Otros Órganos, Líquido Peritoneal, Líquido Sinovial, Cefalorraquídeo (LC), uña', 22, 1, 179);
INSERT INTO lesiones_partes_cuerpos__pacientes (id_les_par_cue_pac, otr_les_par_cue, id_cat_cue_les, id_par_cue_cat_cue, id_tip_mic_pac) VALUES (369, 'Biopsia Piel, Biopsia Otros Órganos, Líquido Peritoneal, Líquido Sinovial, Cefalorraquídeo (LC), uña', 22, 2, 179);
INSERT INTO lesiones_partes_cuerpos__pacientes (id_les_par_cue_pac, otr_les_par_cue, id_cat_cue_les, id_par_cue_cat_cue, id_tip_mic_pac) VALUES (370, NULL, 10, 3, 179);
INSERT INTO lesiones_partes_cuerpos__pacientes (id_les_par_cue_pac, otr_les_par_cue, id_cat_cue_les, id_par_cue_cat_cue, id_tip_mic_pac) VALUES (371, NULL, 17, 3, 179);
INSERT INTO lesiones_partes_cuerpos__pacientes (id_les_par_cue_pac, otr_les_par_cue, id_cat_cue_les, id_par_cue_cat_cue, id_tip_mic_pac) VALUES (372, 'Biopsia Piel, Biopsia Otros Órganos, Líquido Peritoneal, Líquido Sinovial, Cefalorraquídeo (LC), uña', 23, 3, 179);
INSERT INTO lesiones_partes_cuerpos__pacientes (id_les_par_cue_pac, otr_les_par_cue, id_cat_cue_les, id_par_cue_cat_cue, id_tip_mic_pac) VALUES (373, NULL, 20, 4, 179);
INSERT INTO lesiones_partes_cuerpos__pacientes (id_les_par_cue_pac, otr_les_par_cue, id_cat_cue_les, id_par_cue_cat_cue, id_tip_mic_pac) VALUES (374, 'Biopsia Piel, Biopsia Otros Órganos, Líquido Peritoneal, Líquido Sinovial, Cefalorraquídeo (LC), uña', 23, 4, 179);


--
-- TOC entry 2345 (class 0 OID 32555)
-- Dependencies: 1716
-- Data for Name: localizaciones_cuerpos; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--



--
-- TOC entry 2346 (class 0 OID 32560)
-- Dependencies: 1718
-- Data for Name: modulos; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO modulos (id_mod, cod_mod, des_mod, id_tip_usu) VALUES (1, 'C', 'Configuración', 2);
INSERT INTO modulos (id_mod, cod_mod, des_mod, id_tip_usu) VALUES (2, 'R', 'Reportes', 2);


--
-- TOC entry 2347 (class 0 OID 32565)
-- Dependencies: 1720
-- Data for Name: muestras_clinicas; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO muestras_clinicas (id_mue_cli, nom_mue_cli) VALUES (1, 'Pelo');
INSERT INTO muestras_clinicas (id_mue_cli, nom_mue_cli) VALUES (2, 'Escama');
INSERT INTO muestras_clinicas (id_mue_cli, nom_mue_cli) VALUES (3, 'Uñas');
INSERT INTO muestras_clinicas (id_mue_cli, nom_mue_cli) VALUES (4, 'Exudado');
INSERT INTO muestras_clinicas (id_mue_cli, nom_mue_cli) VALUES (5, 'Biopsia Piel');
INSERT INTO muestras_clinicas (id_mue_cli, nom_mue_cli) VALUES (6, 'Biopsia Otros Órganos');
INSERT INTO muestras_clinicas (id_mue_cli, nom_mue_cli) VALUES (7, 'Líquido Peritoneal');
INSERT INTO muestras_clinicas (id_mue_cli, nom_mue_cli) VALUES (8, 'Líquido Sinovial');
INSERT INTO muestras_clinicas (id_mue_cli, nom_mue_cli) VALUES (9, 'Líquido Cefalorraquídeo(LCR)');
INSERT INTO muestras_clinicas (id_mue_cli, nom_mue_cli) VALUES (10, 'Líquido Pleural');
INSERT INTO muestras_clinicas (id_mue_cli, nom_mue_cli) VALUES (11, 'Lavado Bronquial');
INSERT INTO muestras_clinicas (id_mue_cli, nom_mue_cli) VALUES (12, 'Esputo Espontáneo');
INSERT INTO muestras_clinicas (id_mue_cli, nom_mue_cli) VALUES (13, 'Esputo Inducido');
INSERT INTO muestras_clinicas (id_mue_cli, nom_mue_cli) VALUES (14, 'Aspirado Traqueal');
INSERT INTO muestras_clinicas (id_mue_cli, nom_mue_cli) VALUES (15, 'Cepillado Protegido');
INSERT INTO muestras_clinicas (id_mue_cli, nom_mue_cli) VALUES (16, 'Punción Pulmonar');
INSERT INTO muestras_clinicas (id_mue_cli, nom_mue_cli) VALUES (17, 'Punción Pleural');
INSERT INTO muestras_clinicas (id_mue_cli, nom_mue_cli) VALUES (18, 'Médula Ósea');
INSERT INTO muestras_clinicas (id_mue_cli, nom_mue_cli) VALUES (20, 'Exudado Vaginal');
INSERT INTO muestras_clinicas (id_mue_cli, nom_mue_cli) VALUES (21, 'Orina');
INSERT INTO muestras_clinicas (id_mue_cli, nom_mue_cli) VALUES (22, 'Heces');
INSERT INTO muestras_clinicas (id_mue_cli, nom_mue_cli) VALUES (23, 'Cateterismo');
INSERT INTO muestras_clinicas (id_mue_cli, nom_mue_cli) VALUES (24, 'Sondaje');
INSERT INTO muestras_clinicas (id_mue_cli, nom_mue_cli) VALUES (25, 'Bolsa Colectora');
INSERT INTO muestras_clinicas (id_mue_cli, nom_mue_cli) VALUES (26, 'Cavidad Oral');
INSERT INTO muestras_clinicas (id_mue_cli, nom_mue_cli) VALUES (27, 'Exudado Nasal');
INSERT INTO muestras_clinicas (id_mue_cli, nom_mue_cli) VALUES (28, 'Muestras Ópticas');
INSERT INTO muestras_clinicas (id_mue_cli, nom_mue_cli) VALUES (29, 'Exudado Conjuntival');
INSERT INTO muestras_clinicas (id_mue_cli, nom_mue_cli) VALUES (30, 'Raspado Corneal');
INSERT INTO muestras_clinicas (id_mue_cli, nom_mue_cli) VALUES (31, 'Aspirado Ocular');
INSERT INTO muestras_clinicas (id_mue_cli, nom_mue_cli) VALUES (32, 'Lentes de Contacto');
INSERT INTO muestras_clinicas (id_mue_cli, nom_mue_cli) VALUES (33, 'Catéteres Intravasculares');
INSERT INTO muestras_clinicas (id_mue_cli, nom_mue_cli) VALUES (34, 'Catéteres Diálisis Peritoneal');
INSERT INTO muestras_clinicas (id_mue_cli, nom_mue_cli) VALUES (35, 'Prótesis');
INSERT INTO muestras_clinicas (id_mue_cli, nom_mue_cli) VALUES (36, 'Otros');
INSERT INTO muestras_clinicas (id_mue_cli, nom_mue_cli) VALUES (19, 'Sangre');


--
-- TOC entry 2348 (class 0 OID 32570)
-- Dependencies: 1722
-- Data for Name: muestras_pacientes; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO muestras_pacientes (id_mue_pac, id_his, id_mue_cli, otr_mue_cli) VALUES (105, 24, 1, NULL);
INSERT INTO muestras_pacientes (id_mue_pac, id_his, id_mue_cli, otr_mue_cli) VALUES (106, 24, 2, NULL);
INSERT INTO muestras_pacientes (id_mue_pac, id_his, id_mue_cli, otr_mue_cli) VALUES (107, 24, 3, NULL);
INSERT INTO muestras_pacientes (id_mue_pac, id_his, id_mue_cli, otr_mue_cli) VALUES (117, 25, 1, NULL);
INSERT INTO muestras_pacientes (id_mue_pac, id_his, id_mue_cli, otr_mue_cli) VALUES (118, 25, 35, NULL);
INSERT INTO muestras_pacientes (id_mue_pac, id_his, id_mue_cli, otr_mue_cli) VALUES (119, 25, 36, 'Biopsia Piel; Biopsia Otros Órganos; Líquido Peritoneal; Líquido Sinovial; Cefalorraquídeo (LC); uña');


--
-- TOC entry 2349 (class 0 OID 32575)
-- Dependencies: 1724
-- Data for Name: municipios; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (1, '	Libertador Caracas		 ', 1);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (2, '	Alto Orinoco		 ', 25);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (3, '	Atabapo		 ', 25);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (4, '	Atures		 ', 25);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (5, '	Autana		 ', 25);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (6, '	Manapiare		 ', 25);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (7, '	Maroa		 ', 25);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (8, '	Río Negro		 ', 25);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (9, '	Anaco		 ', 2);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (10, '	Aragua		 ', 2);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (11, '	Bolívar		 ', 2);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (12, '	Bruzual		 ', 2);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (13, '	Cajigal		 ', 2);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (14, '	Carvajal		 ', 2);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (15, '	Diego Bautista Urbaneja		 ', 2);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (16, '	Freites		 ', 2);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (17, '	Guanipa		 ', 2);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (18, '	Guanta		 ', 2);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (19, '	Independencia		 ', 2);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (20, '	Libertad		 ', 2);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (21, '	McGregor		 ', 2);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (22, '	Miranda		 ', 2);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (23, '	Monagas		 ', 2);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (24, '	Peñalver		 ', 2);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (25, '	Píritu		 ', 2);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (26, '	San Juan de Capistrano		 ', 2);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (27, '	Santa Ana		 ', 2);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (28, '	Simón Rodriguez		 ', 2);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (29, '	Sotillo		 ', 2);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (30, '	Achaguas		 ', 3);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (31, '	Biruaca		 ', 3);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (32, '	Muñoz		 ', 3);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (33, '	Páez		 ', 3);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (34, '	Pedro Camejo		 ', 3);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (35, '	Rómulo Gallegos		 ', 3);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (36, '	San Fernando		 ', 3);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (37, '	Bolívar		 ', 4);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (38, '	Camatagua		 ', 4);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (39, '	Francisco Linares Alcántara		 ', 4);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (40, '	Girardot		 ', 4);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (41, '	José Angel Lamas		 ', 4);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (42, '	José Félix Ribas		 ', 4);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (43, '	José Rafael Revenga		 ', 4);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (44, '	Libertador		 ', 4);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (45, '	Mario Briceño Iragorry		 ', 4);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (46, '	Ocumare de la Costa de Oro		 ', 4);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (47, '	San Casimiro		 ', 4);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (48, '	San Sebastián		 ', 4);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (49, '	Santiago Mariño		 ', 4);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (50, '	Santos Michelena		 ', 4);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (51, '	Sucre		 ', 4);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (52, '	Tovar		 ', 4);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (53, '	Urdaneta		 ', 4);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (54, '	Zamora		 ', 4);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (55, '	Alberto Arvelo Torrealba		 ', 5);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (56, '	Andrés Eloy Blanco		 ', 5);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (57, '	Antonio José de Sucre		 ', 5);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (58, '	Arismendi		 ', 5);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (59, '	Barinas		 ', 5);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (60, '	Bolívar		 ', 5);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (61, '	Cruz Paredes		 ', 5);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (62, '	Ezequiel Zamora		 ', 5);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (63, '	Obispos		 ', 5);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (64, '	Pedraza		 ', 5);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (65, '	Rojas		 ', 5);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (66, '	Sosa		 ', 5);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (67, '	Caroní		 ', 6);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (68, '	Cedeño		 ', 6);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (69, '	El Callao		 ', 6);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (70, '	Gran Sabana		 ', 6);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (71, '	Heres		 ', 6);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (72, '	Piar		 ', 6);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (73, '	Raúl Leoni		 ', 6);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (74, '	Roscio		 ', 6);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (75, '	Sifontes		 ', 6);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (76, '	Sucre		 ', 6);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (77, '	Padre Pedro Chien		 ', 6);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (78, '	Bejuma		 ', 7);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (79, '	Carlos Arvelo		 ', 7);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (80, '	Diego Ibarra		 ', 7);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (81, '	Guacara		 ', 7);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (82, '	Juan José Mora		 ', 7);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (83, '	Libertador		 ', 7);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (84, '	Los Guayos		 ', 7);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (85, '	Miranda		 ', 7);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (86, '	Montalbán		 ', 7);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (87, '	Naguanagua		 ', 7);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (88, '	Puerto Cabello		 ', 7);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (89, '	San Diego		 ', 7);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (90, '	San Joaquín		 ', 7);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (91, '	Valencia		 ', 7);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (92, '	Anzoátegui		 ', 8);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (93, '	Falcón		 ', 8);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (94, '	Girardot		 ', 8);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (95, '	Lima Blanco		 ', 8);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (96, '	Pao de San Juan Bautista		 ', 8);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (97, '	Ricaurte		 ', 8);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (98, '	Rómulo Gallegos		 ', 8);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (99, '	San Carlos		 ', 8);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (100, '	Tinaco		 ', 8);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (101, '	Antonio Díaz		 ', 9);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (102, '	Casacoima		 ', 9);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (103, '	Pedernales		 ', 9);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (104, '	Tucupita		 ', 9);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (105, '	Acosta		 ', 10);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (106, '	Bolívar		 ', 10);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (107, '	Buchivacoa		 ', 10);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (108, '	Cacique Manaure		 ', 10);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (109, '	Carirubana		 ', 10);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (110, '	Colina		 ', 10);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (111, '	Dabajuro		 ', 10);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (112, '	Democracia		 ', 10);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (113, '	Falcón		 ', 10);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (114, '	Federación		 ', 10);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (115, '	Jacura		 ', 10);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (116, '	Los Taques		 ', 10);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (117, '	Mauroa		 ', 10);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (118, '	Miranda		 ', 10);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (119, '	Monseñor Iturriza		 ', 10);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (120, '	Palmasola		 ', 10);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (121, '	Petit		 ', 10);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (122, '	Píritu		 ', 10);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (123, '	San Francisco		 ', 10);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (124, '	Silva		 ', 10);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (125, '	Sucre		 ', 10);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (126, '	Tocópero		 ', 10);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (127, '	Unión		 ', 10);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (128, '	Urumaco		 ', 10);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (129, '	Zamora		 ', 10);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (130, '	Camaguán		 ', 11);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (131, '	Chaguaramas		 ', 11);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (132, '	El Socorro		 ', 11);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (133, '	Sebastian Francisco de Miranda		 ', 11);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (134, '	José Félix Ribas		 ', 11);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (135, '	José Tadeo Monagas		 ', 11);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (136, '	Juan Germán Roscio		 ', 11);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (137, '	Julián Mellado		 ', 11);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (138, '	Las Mercedes		 ', 11);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (139, '	Leonardo Infante		 ', 11);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (140, '	Pedro Zaraza		 ', 11);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (141, '	Ortiz		 ', 11);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (142, '	San Gerónimo de Guayabal		 ', 11);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (143, '	San José de Guaribe		 ', 11);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (144, '	Santa María de Ipire		 ', 11);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (145, '	Andrés Eloy Blanco		 ', 12);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (146, '	Crespo		 ', 12);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (147, '	Iribarren		 ', 12);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (148, '	Jiménez		 ', 12);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (149, '	Morán		 ', 12);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (150, '	Palavecino		 ', 12);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (151, '	Simón Planas		 ', 12);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (152, '	Torres		 ', 12);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (153, '	Urdaneta		 ', 12);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (154, '	Alberto Adriani		 ', 13);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (155, '	Andrés Bello		 ', 13);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (156, '	Antonio Pinto Salinas		 ', 13);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (157, '	Aricagua		 ', 13);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (158, '	Arzobispo Chacón		 ', 13);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (159, '	Campo Elías		 ', 13);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (160, '	Caracciolo Parra Olmedo		 ', 13);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (161, '	Cardenal Quintero		 ', 13);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (162, '	Guaraque		 ', 13);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (163, '	Julio César Salas		 ', 13);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (164, '	Justo Briceño		 ', 13);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (165, '	Libertador		 ', 13);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (166, '	Miranda		 ', 13);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (167, '	Obispo Ramos de Lora		 ', 13);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (168, '	Padre Noguera		 ', 13);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (169, '	Pueblo Llano		 ', 13);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (170, '	Rangel		 ', 13);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (171, '	Rivas Dávila		 ', 13);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (172, '	Santos Marquina		 ', 13);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (173, '	Sucre		 ', 13);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (174, '	Tovar		 ', 13);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (175, '	Tulio Febres Cordero		 ', 13);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (176, '	Zea		 ', 14);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (177, '	Acevedo		 ', 14);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (178, '	Andrés Bello		 ', 14);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (179, '	Baruta		 ', 14);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (180, '	Brión		 ', 14);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (181, '	Buroz		 ', 14);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (182, '	Carrizal		 ', 14);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (183, '	Chacao		 ', 14);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (184, '	Cristóbal Rojas		 ', 14);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (185, '	El Hatillo		 ', 14);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (186, '	Guaicaipuro		 ', 14);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (187, '	Independencia		 ', 14);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (188, '	Lander		 ', 14);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (189, '	Los Salias		 ', 14);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (190, '	Páez		 ', 14);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (191, '	Paz Castillo		 ', 14);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (192, '	Pedro Gual		 ', 14);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (193, '	Plaza		 ', 14);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (194, '	Simón Bolívar		 ', 14);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (195, '	Sucre		 ', 14);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (196, '	Urdaneta		 ', 14);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (197, '	Zamora		 ', 14);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (198, '	Acosta		 ', 15);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (199, '	Aguasay		 ', 15);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (200, '	Bolívar		 ', 15);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (201, '	Caripe		 ', 15);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (202, '	Cedeño		 ', 15);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (203, '	Ezequiel Zamora		 ', 15);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (204, '	Libertador		 ', 15);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (205, '	Maturín		 ', 15);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (206, '	Piar		 ', 15);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (207, '	Punceres		 ', 15);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (208, '	Santa Bárbara		 ', 15);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (209, '	Sotillo		 ', 15);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (210, '	Uracoa		 ', 15);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (211, '	Antolín del Campo		 ', 16);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (212, '	Arismendi		 ', 16);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (213, '	Díaz		 ', 16);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (214, '	García		 ', 16);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (215, '	Gómez		 ', 16);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (216, '	Maneiro		 ', 16);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (217, '	Marcano		 ', 16);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (218, '	Mariño		 ', 16);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (219, '	Península de Macanao		 ', 16);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (220, '	Tubores		 ', 16);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (221, '	Villalba		 ', 16);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (222, '	Agua Blanca		 ', 18);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (223, '	Araure		 ', 18);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (224, '	Esteller		 ', 18);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (225, '	Guanare		 ', 18);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (226, '	Guanarito		 ', 18);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (227, '	Monseñor José Vicente de Unda		 ', 18);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (228, '	Ospino		 ', 18);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (229, '	Páez		 ', 18);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (230, '	Papelón		 ', 18);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (231, '	San Genaro de Boconoíto		 ', 18);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (232, '	San Rafael de Onoto		 ', 18);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (233, '	Santa Rosalía		 ', 18);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (234, '	Sucre		 ', 18);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (235, '	Turén		 ', 18);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (236, '	Andrés Eloy Blanco		 ', 19);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (237, '	Andrés Mata		 ', 19);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (238, '	Arismendi		 ', 19);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (239, '	Benítez		 ', 19);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (240, '	Bermúdez		 ', 19);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (241, '	Bolívar		 ', 19);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (242, '	Cajigal		 ', 19);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (243, '	Cruz Salmerón Acosta		 ', 19);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (244, '	Libertador		 ', 19);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (245, '	Mariño		 ', 19);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (246, '	Mejía		 ', 19);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (247, '	Montes		 ', 19);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (248, '	Ribero		 ', 19);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (249, '	Sucre		 ', 19);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (250, '	Valdez		 ', 19);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (251, '	Andrés Bello		 ', 20);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (252, '	Antonio Rómulo Costa		 ', 20);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (253, '	Ayacucho		 ', 20);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (254, '	Bolívar		 ', 20);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (255, '	Cárdenas		 ', 20);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (256, '	Córdoba		 ', 20);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (257, '	Fernández Feo		 ', 20);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (258, '	Francisco de Miranda		 ', 20);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (259, '	García de Hevia		 ', 20);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (260, '	Guásimos		 ', 20);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (261, '	Independencia		 ', 20);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (262, '	Jáuregui		 ', 20);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (263, '	José María Vargas		 ', 20);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (264, '	Junín		 ', 20);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (265, '	Libertad		 ', 20);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (266, '	Libertador		 ', 20);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (267, '	17. Lobatera		 ', 20);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (268, '	Michelena		 ', 20);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (269, '	Panamericano		 ', 20);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (270, '	Pedro María Ureña		 ', 20);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (271, '	Rafael Urdaneta		 ', 20);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (272, '	Samuel Darío Maldonado		 ', 20);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (273, '	San Cristóbal		 ', 20);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (274, '	Seboruco		 ', 20);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (275, '	Simón Rodríguez		 ', 20);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (276, '	Sucre		 ', 20);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (277, '	Torbes		 ', 20);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (278, '	Uribante		 ', 20);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (279, '	San Judas Tadeo		 ', 20);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (280, '	Andrés Bello		 ', 21);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (281, '	Boconó		 ', 21);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (282, '	Bolívar		 ', 21);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (283, '	Candelaria		 ', 21);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (284, '	Carache		 ', 21);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (285, '	Escuque		 ', 21);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (286, '	José Felipe Márquez Cañizalez		 ', 21);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (287, '	Juan Vicente Campos Elías		 ', 21);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (288, '	La Ceiba		 ', 21);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (289, '	Miranda		 ', 21);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (290, '	Monte Carmelo		 ', 21);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (291, '	Motatán		 ', 21);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (292, '	Pampán		 ', 21);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (293, '	Pampanito		 ', 21);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (294, '	Rafael Rangel		 ', 21);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (295, '	San Rafael de Carvajal		 ', 21);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (296, '	Sucre		 ', 21);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (297, '	Trujillo		 ', 21);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (298, '	Urdaneta		 ', 21);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (299, '	Valera		 ', 21);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (300, '	Vargas		 ', 22);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (301, '	Arístides Bastidas		 ', 23);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (302, '	Bolívar		 ', 23);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (303, '	Bruzual		 ', 23);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (304, '	Cocorote		 ', 23);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (305, '	Independencia		 ', 23);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (306, '	José Antonio Páez		 ', 23);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (307, '	La Trinidad		 ', 23);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (308, '	Manuel Monge		 ', 23);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (309, '	Nirgua		 ', 23);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (310, '	Peña		 ', 23);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (311, '	San Felipe		 ', 23);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (312, '	Sucre		 ', 23);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (313, '	Urachiche		 ', 23);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (314, '	Veroes		 ', 23);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (315, '	Almirante Padilla		 ', 24);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (316, '	Baralt		 ', 24);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (317, '	Cabimas		 ', 24);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (318, '	Catatumbo		 ', 24);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (319, '	Colón		 ', 24);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (320, '	Francisco Javier Pulgar		 ', 24);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (321, '	Guajira		 ', 24);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (322, '	Jesús Enrique Losada		 ', 24);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (323, '	Jesús María Semprún		 ', 24);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (324, '	La Cañada de Urdaneta		 ', 24);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (325, '	Lagunillas		 ', 24);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (326, '	Machiques de Perijá		 ', 24);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (327, '	Mara		 ', 24);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (328, '	Maracaibo		 ', 24);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (329, '	Miranda		 ', 24);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (330, '	Rosario de Perijá		 ', 24);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (331, '	San Francisco		 ', 24);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (332, '	Santa Rita		 ', 24);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (333, '	Simón Bolívar		 ', 24);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (334, '	Sucre		 ', 24);
INSERT INTO municipios (id_mun, des_mun, id_est) VALUES (335, '	Valmore Rodríguez		 ', 24);


--
-- TOC entry 2350 (class 0 OID 32580)
-- Dependencies: 1726
-- Data for Name: pacientes; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO pacientes (id_pac, ape_pac, nom_pac, ced_pac, fec_nac_pac, nac_pac, tel_hab_pac, tel_cel_pac, ocu_pac, ciu_pac, id_pai, id_est, id_mun, id_par, num_pac, id_doc, fec_reg_pac, sex_pac) VALUES (16, 'Paciente', 'Paciente', '17302857', '2011-07-09', '1', '3622824', '17302857', '1', 'Guarenas', 1, 1, 69, NULL, 6, 6, '2011-07-08 18:14:22.448-04:30', 'M');
INSERT INTO pacientes (id_pac, ape_pac, nom_pac, ced_pac, fec_nac_pac, nac_pac, tel_hab_pac, tel_cel_pac, ocu_pac, ciu_pac, id_pai, id_est, id_mun, id_par, num_pac, id_doc, fec_reg_pac, sex_pac) VALUES (56, 'Lozada', 'Lisseth', '17234567', '2000-01-01', '1', '12345678', '04261234567', '2', 'aa', 1, 16, 214, NULL, 17, 28, '2012-01-16 23:03:31.012-04:30', 'F');
INSERT INTO pacientes (id_pac, ape_pac, nom_pac, ced_pac, fec_nac_pac, nac_pac, tel_hab_pac, tel_cel_pac, ocu_pac, ciu_pac, id_pai, id_est, id_mun, id_par, num_pac, id_doc, fec_reg_pac, sex_pac) VALUES (57, 'marin', 'luis', '17568741', '1985-01-22', '1', '04268741232', '02129358741', '1', 'dddd', 1, 2, 10, NULL, 4, 32, '2012-01-22 02:51:35.348-04:30', 'M');
INSERT INTO pacientes (id_pac, ape_pac, nom_pac, ced_pac, fec_nac_pac, nac_pac, tel_hab_pac, tel_cel_pac, ocu_pac, ciu_pac, id_pai, id_est, id_mun, id_par, num_pac, id_doc, fec_reg_pac, sex_pac) VALUES (58, '$jhjh', 'muñoz', '87897987', '1985-01-22', '1', '04268741232', '02129358741', '1', 'dddd', 1, 2, 9, NULL, 5, 32, '2012-01-22 05:16:05.98-04:30', 'F');
INSERT INTO pacientes (id_pac, ape_pac, nom_pac, ced_pac, fec_nac_pac, nac_pac, tel_hab_pac, tel_cel_pac, ocu_pac, ciu_pac, id_pai, id_est, id_mun, id_par, num_pac, id_doc, fec_reg_pac, sex_pac) VALUES (63, 'fdfadf', 'muñoz', '42325244', '2000-01-08', '1', '04268741232', '02129358741', '2', 'dddd', 1, 2, 10, NULL, 7, 32, '2012-01-22 05:25:42.791-04:30', 'F');
INSERT INTO pacientes (id_pac, ape_pac, nom_pac, ced_pac, fec_nac_pac, nac_pac, tel_hab_pac, tel_cel_pac, ocu_pac, ciu_pac, id_pai, id_est, id_mun, id_par, num_pac, id_doc, fec_reg_pac, sex_pac) VALUES (59, 'fggfg', 'hsdf', '17651234', '1985-01-22', '1', '04268741232', '02129358741', '1', 'a', 1, 3, 31, NULL, 6, 32, '2012-01-22 05:19:04.184-04:30', 'F');
INSERT INTO pacientes (id_pac, ape_pac, nom_pac, ced_pac, fec_nac_pac, nac_pac, tel_hab_pac, tel_cel_pac, ocu_pac, ciu_pac, id_pai, id_est, id_mun, id_par, num_pac, id_doc, fec_reg_pac, sex_pac) VALUES (54, 'Bggh', 'Bggh', '17302818', '2012-01-16', '1', '36222225555', '15930135555', '1', 'GUrena%%', 1, 15, 199, NULL, 17, 6, '2012-01-16 20:04:18.942-04:30', 'F');


--
-- TOC entry 2351 (class 0 OID 32586)
-- Dependencies: 1728
-- Data for Name: paises; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO paises (id_pai, des_pai, cod_pai) VALUES (1, 'Venezuela', 'VEN');


--
-- TOC entry 2352 (class 0 OID 32591)
-- Dependencies: 1730
-- Data for Name: parroquias; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--



--
-- TOC entry 2353 (class 0 OID 32596)
-- Dependencies: 1732
-- Data for Name: partes_cuerpos; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO partes_cuerpos (id_par_cue, nom_par_cue) VALUES (1, 'Pie');
INSERT INTO partes_cuerpos (id_par_cue, nom_par_cue) VALUES (2, 'Mano');
INSERT INTO partes_cuerpos (id_par_cue, nom_par_cue) VALUES (5, 'Cabeza');
INSERT INTO partes_cuerpos (id_par_cue, nom_par_cue) VALUES (6, 'Tórax anterior');
INSERT INTO partes_cuerpos (id_par_cue, nom_par_cue) VALUES (7, 'Flanco derecho');
INSERT INTO partes_cuerpos (id_par_cue, nom_par_cue) VALUES (8, 'Flanco Izquierdo');
INSERT INTO partes_cuerpos (id_par_cue, nom_par_cue) VALUES (9, 'Brazo derecho');
INSERT INTO partes_cuerpos (id_par_cue, nom_par_cue) VALUES (10, 'Brazo izquierdo');
INSERT INTO partes_cuerpos (id_par_cue, nom_par_cue) VALUES (11, 'Pierna derecha');
INSERT INTO partes_cuerpos (id_par_cue, nom_par_cue) VALUES (12, 'Pierna izquierda');
INSERT INTO partes_cuerpos (id_par_cue, nom_par_cue) VALUES (13, 'Pie derecho');
INSERT INTO partes_cuerpos (id_par_cue, nom_par_cue) VALUES (14, 'Pie izquierdo');
INSERT INTO partes_cuerpos (id_par_cue, nom_par_cue) VALUES (15, 'Piel');
INSERT INTO partes_cuerpos (id_par_cue, nom_par_cue) VALUES (16, 'Pelo');
INSERT INTO partes_cuerpos (id_par_cue, nom_par_cue) VALUES (18, 'Órganos');
INSERT INTO partes_cuerpos (id_par_cue, nom_par_cue) VALUES (19, 'Huesos');


--
-- TOC entry 2354 (class 0 OID 32599)
-- Dependencies: 1733
-- Data for Name: partes_cuerpos__categorias_cuerpos; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO partes_cuerpos__categorias_cuerpos (id_par_cue_cat_cue, id_cat_cue, id_par_cue) VALUES (1, 1, 1);
INSERT INTO partes_cuerpos__categorias_cuerpos (id_par_cue_cat_cue, id_cat_cue, id_par_cue) VALUES (2, 1, 2);
INSERT INTO partes_cuerpos__categorias_cuerpos (id_par_cue_cat_cue, id_cat_cue, id_par_cue) VALUES (3, 3, 15);
INSERT INTO partes_cuerpos__categorias_cuerpos (id_par_cue_cat_cue, id_cat_cue, id_par_cue) VALUES (4, 3, 16);
INSERT INTO partes_cuerpos__categorias_cuerpos (id_par_cue_cat_cue, id_cat_cue, id_par_cue) VALUES (5, 4, 15);
INSERT INTO partes_cuerpos__categorias_cuerpos (id_par_cue_cat_cue, id_cat_cue, id_par_cue) VALUES (6, 5, 18);


--
-- TOC entry 2355 (class 0 OID 32606)
-- Dependencies: 1736
-- Data for Name: tiempo_evoluciones; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO tiempo_evoluciones (id_tie_evo, id_his, tie_evo) VALUES (8, 22, 0);
INSERT INTO tiempo_evoluciones (id_tie_evo, id_his, tie_evo) VALUES (10, 24, 0);
INSERT INTO tiempo_evoluciones (id_tie_evo, id_his, tie_evo) VALUES (11, 25, -111111);


--
-- TOC entry 2356 (class 0 OID 32612)
-- Dependencies: 1738
-- Data for Name: tipos_consultas; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO tipos_consultas (id_tip_con, nom_tip_con) VALUES (1, 'Consulta');
INSERT INTO tipos_consultas (id_tip_con, nom_tip_con) VALUES (2, 'Dermatologia');
INSERT INTO tipos_consultas (id_tip_con, nom_tip_con) VALUES (3, 'Pediatria');
INSERT INTO tipos_consultas (id_tip_con, nom_tip_con) VALUES (4, 'Neumologia');
INSERT INTO tipos_consultas (id_tip_con, nom_tip_con) VALUES (5, 'Consulta Interna');
INSERT INTO tipos_consultas (id_tip_con, nom_tip_con) VALUES (6, 'Geriatria');
INSERT INTO tipos_consultas (id_tip_con, nom_tip_con) VALUES (7, 'urologia');
INSERT INTO tipos_consultas (id_tip_con, nom_tip_con) VALUES (8, 'Infectologia');
INSERT INTO tipos_consultas (id_tip_con, nom_tip_con) VALUES (9, 'Otros');


--
-- TOC entry 2357 (class 0 OID 32617)
-- Dependencies: 1740
-- Data for Name: tipos_consultas_pacientes; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO tipos_consultas_pacientes (id_tip_con_pac, id_tip_con, id_his, otr_tip_con) VALUES (193, 4, 24, NULL);
INSERT INTO tipos_consultas_pacientes (id_tip_con_pac, id_tip_con, id_his, otr_tip_con) VALUES (199, 9, 25, 'Biopsia Piel; Biopsia Otros Órganos; Líquido Peritoneal; Líquido Sinovial; Cefalorraquídeo (LC); uña');


--
-- TOC entry 2358 (class 0 OID 32622)
-- Dependencies: 1742
-- Data for Name: tipos_estudios_micologicos; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (1, 1, 'Hifas delgadas tabicadas', 1);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (2, 1, 'Hifas gruesas tabicadas', 1);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (3, 1, 'Blastoconidias', 1);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (4, 1, 'Pseudohifas', 1);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (5, 1, 'Artroconidias', 1);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (6, 1, 'Hifas cortas y agrupamiento de esporas', 1);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (7, 1, 'Esporas endotrix', 1);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (8, 1, 'Esporas ectoendotrix', 1);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (9, 1, 'Microsporum canis', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (10, 1, 'Microsporum gypseum', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (14, 1, 'Trichophyton tonsurans', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (15, 1, 'Trichophyton verrucosum', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (16, 1, 'Trichophyton violaceum', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (18, 1, 'Trichosporon', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (19, 1, 'Geotrichum spp', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (20, 1, 'Candita albicans', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (21, 1, 'Candida no Candida albicans', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (11, 1, 'Microsporum nanum', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (12, 1, 'Trichophyton rubrum', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (13, 1, 'Trichophyton mentagrophytes', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (17, 1, 'Epidermophyton floccosum', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (22, 1, 'Malassezia furfur', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (23, 1, 'Malassezia pachydermatis', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (24, 1, 'Malassezia spp', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (25, 2, 'Levaduras simples', 1);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (26, 2, 'Blastoconidias', 1);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (27, 2, 'Levaduras en cadena', 1);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (28, 2, 'Células fumagoides', 1);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (29, 2, 'Hifas dematiaceas', 1);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (30, 2, 'Cuerpos asteroides', 1);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (31, 2, 'Otros', 1);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (32, 2, 'Sporothix schenckii', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (33, 2, 'Cladiophialophora carrionii', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (34, 2, 'Fonseca pedrosoi', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (35, 2, 'Phialophora verrucosa', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (36, 2, 'Rhinocladiella aquaspersa', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (37, 2, 'Acremionium spp', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (38, 2, 'Acremionium falciforme', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (39, 2, 'Madurella grisea', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (40, 2, 'Pseudallescheria boydii', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (41, 2, 'Fusarium oxisporum', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (42, 2, 'Fusarium solami', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (44, 2, 'Aspergillus flavus', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (45, 2, 'Aspergillus nidulans', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (46, 2, 'Aspergillus fumigatus', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (47, 2, 'Aspergillus spp', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (48, 2, 'Nocardia brasiliensis', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (49, 2, 'Streptomyces somaliensis', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (50, 2, 'Actinomadura madurae', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (51, 2, 'Fusarium spp', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (52, 2, 'Paracoccidioide loboi (Histopatología)', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (53, 2, 'Otros', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (43, 2, 'Fusarium spp', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (54, 3, 'Levaduras simples', 1);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (55, 3, 'Levaduras múltiples', 1);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (56, 3, 'Esférulas pared doble', 1);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (57, 3, 'Levaduras intracelulares', 1);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (58, 3, 'Otros', 1);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (59, 3, 'Coccidioides posadasii', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (60, 3, 'Histoplasma capsulatum', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (61, 3, 'Paracoccidioides brasiliensis', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (62, 3, 'Otros', 2);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (63, 1, 'Otros', 1);
INSERT INTO tipos_estudios_micologicos (id_tip_est_mic, id_tip_mic, nom_tip_est_mic, id_tip_exa) VALUES (64, 1, 'Otros', 2);


--
-- TOC entry 2359 (class 0 OID 32627)
-- Dependencies: 1744
-- Data for Name: tipos_examenes; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO tipos_examenes (id_tip_exa, nom_tip_exa) VALUES (1, 'Examen directo');
INSERT INTO tipos_examenes (id_tip_exa, nom_tip_exa) VALUES (2, 'Agente Aislado');


--
-- TOC entry 2360 (class 0 OID 32632)
-- Dependencies: 1746
-- Data for Name: tipos_micosis; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO tipos_micosis (id_tip_mic, nom_tip_mic) VALUES (1, 'Superficiales');
INSERT INTO tipos_micosis (id_tip_mic, nom_tip_mic) VALUES (3, 'Profundas');
INSERT INTO tipos_micosis (id_tip_mic, nom_tip_mic) VALUES (2, 'Subcutaneas');


--
-- TOC entry 2361 (class 0 OID 32637)
-- Dependencies: 1748
-- Data for Name: tipos_micosis_pacientes; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO tipos_micosis_pacientes (id_tip_mic_pac, id_tip_mic, id_his) VALUES (105, 1, 22);
INSERT INTO tipos_micosis_pacientes (id_tip_mic_pac, id_tip_mic, id_his) VALUES (109, 1, 24);
INSERT INTO tipos_micosis_pacientes (id_tip_mic_pac, id_tip_mic, id_his) VALUES (179, 1, 25);
INSERT INTO tipos_micosis_pacientes (id_tip_mic_pac, id_tip_mic, id_his) VALUES (180, 3, 25);
INSERT INTO tipos_micosis_pacientes (id_tip_mic_pac, id_tip_mic, id_his) VALUES (181, 2, 25);


--
-- TOC entry 2362 (class 0 OID 32640)
-- Dependencies: 1749
-- Data for Name: tipos_micosis_pacientes__tipos_estudios_micologicos; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO tipos_micosis_pacientes__tipos_estudios_micologicos (id_tip_mic_pac_tip_est_mic, id_tip_mic_pac, id_tip_est_mic, otr_tip_est_mic) VALUES (96, 109, 4, NULL);
INSERT INTO tipos_micosis_pacientes__tipos_estudios_micologicos (id_tip_mic_pac_tip_est_mic, id_tip_mic_pac, id_tip_est_mic, otr_tip_est_mic) VALUES (97, 109, 5, NULL);
INSERT INTO tipos_micosis_pacientes__tipos_estudios_micologicos (id_tip_mic_pac_tip_est_mic, id_tip_mic_pac, id_tip_est_mic, otr_tip_est_mic) VALUES (98, 109, 11, NULL);
INSERT INTO tipos_micosis_pacientes__tipos_estudios_micologicos (id_tip_mic_pac_tip_est_mic, id_tip_mic_pac, id_tip_est_mic, otr_tip_est_mic) VALUES (99, 109, 12, NULL);
INSERT INTO tipos_micosis_pacientes__tipos_estudios_micologicos (id_tip_mic_pac_tip_est_mic, id_tip_mic_pac, id_tip_est_mic, otr_tip_est_mic) VALUES (139, 180, 57, NULL);
INSERT INTO tipos_micosis_pacientes__tipos_estudios_micologicos (id_tip_mic_pac_tip_est_mic, id_tip_mic_pac, id_tip_est_mic, otr_tip_est_mic) VALUES (140, 180, 58, 'Biopsia Piel, Biopsia Otros Órganos, Líquido Peritoneal, Líquido Sinovial, Cefalorraquídeo (LC), uña');
INSERT INTO tipos_micosis_pacientes__tipos_estudios_micologicos (id_tip_mic_pac_tip_est_mic, id_tip_mic_pac, id_tip_est_mic, otr_tip_est_mic) VALUES (141, 180, 60, NULL);
INSERT INTO tipos_micosis_pacientes__tipos_estudios_micologicos (id_tip_mic_pac_tip_est_mic, id_tip_mic_pac, id_tip_est_mic, otr_tip_est_mic) VALUES (142, 180, 62, 'Biopsia Piel, Biopsia Otros Órganos, Líquido Peritoneal, Líquido Sinovial, Cefalorraquídeo (LC), uña');
INSERT INTO tipos_micosis_pacientes__tipos_estudios_micologicos (id_tip_mic_pac_tip_est_mic, id_tip_mic_pac, id_tip_est_mic, otr_tip_est_mic) VALUES (143, 181, 31, 'Biopsia Piel, Biopsia Otros Órganos, Líquido Peritoneal, Líquido Sinovial, Cefalorraquídeo (LC), uña');
INSERT INTO tipos_micosis_pacientes__tipos_estudios_micologicos (id_tip_mic_pac_tip_est_mic, id_tip_mic_pac, id_tip_est_mic, otr_tip_est_mic) VALUES (144, 181, 53, 'Biopsia Piel, Biopsia Otros Órganos, Líquido Peritoneal, Líquido Sinovial, Cefalorraquídeo (LC), uña');
INSERT INTO tipos_micosis_pacientes__tipos_estudios_micologicos (id_tip_mic_pac_tip_est_mic, id_tip_mic_pac, id_tip_est_mic, otr_tip_est_mic) VALUES (145, 179, 5, NULL);
INSERT INTO tipos_micosis_pacientes__tipos_estudios_micologicos (id_tip_mic_pac_tip_est_mic, id_tip_mic_pac, id_tip_est_mic, otr_tip_est_mic) VALUES (146, 179, 8, NULL);
INSERT INTO tipos_micosis_pacientes__tipos_estudios_micologicos (id_tip_mic_pac_tip_est_mic, id_tip_mic_pac, id_tip_est_mic, otr_tip_est_mic) VALUES (147, 179, 63, 'Biopsia Piel, Biopsia Otros Órganos, Líquido Peritoneal, Líquido Sinovial, Cefalorraquídeo (LC), uña');
INSERT INTO tipos_micosis_pacientes__tipos_estudios_micologicos (id_tip_mic_pac_tip_est_mic, id_tip_mic_pac, id_tip_est_mic, otr_tip_est_mic) VALUES (148, 179, 13, NULL);
INSERT INTO tipos_micosis_pacientes__tipos_estudios_micologicos (id_tip_mic_pac_tip_est_mic, id_tip_mic_pac, id_tip_est_mic, otr_tip_est_mic) VALUES (149, 179, 24, NULL);
INSERT INTO tipos_micosis_pacientes__tipos_estudios_micologicos (id_tip_mic_pac_tip_est_mic, id_tip_mic_pac, id_tip_est_mic, otr_tip_est_mic) VALUES (150, 179, 64, 'Biopsia Piel, Biopsia Otros Órganos, Líquido Peritoneal, Líquido Sinovial, Cefalorraquídeo (LC), uña');


--
-- TOC entry 2363 (class 0 OID 32647)
-- Dependencies: 1752
-- Data for Name: tipos_usuarios; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO tipos_usuarios (id_tip_usu, cod_tip_usu, des_tip_usu) VALUES (1, 'adm', 'Administrador');
INSERT INTO tipos_usuarios (id_tip_usu, cod_tip_usu, des_tip_usu) VALUES (2, 'med', 'Médicos');


--
-- TOC entry 2364 (class 0 OID 32650)
-- Dependencies: 1753
-- Data for Name: tipos_usuarios__usuarios; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO tipos_usuarios__usuarios (id_tip_usu_usu, id_doc, id_usu_adm, id_tip_usu) VALUES (17, 6, NULL, 2);
INSERT INTO tipos_usuarios__usuarios (id_tip_usu_usu, id_doc, id_usu_adm, id_tip_usu) VALUES (36, NULL, 17, 1);
INSERT INTO tipos_usuarios__usuarios (id_tip_usu_usu, id_doc, id_usu_adm, id_tip_usu) VALUES (41, NULL, 21, 1);
INSERT INTO tipos_usuarios__usuarios (id_tip_usu_usu, id_doc, id_usu_adm, id_tip_usu) VALUES (43, 27, NULL, 2);
INSERT INTO tipos_usuarios__usuarios (id_tip_usu_usu, id_doc, id_usu_adm, id_tip_usu) VALUES (44, 28, NULL, 2);
INSERT INTO tipos_usuarios__usuarios (id_tip_usu_usu, id_doc, id_usu_adm, id_tip_usu) VALUES (45, NULL, 22, 1);
INSERT INTO tipos_usuarios__usuarios (id_tip_usu_usu, id_doc, id_usu_adm, id_tip_usu) VALUES (49, 32, NULL, 2);
INSERT INTO tipos_usuarios__usuarios (id_tip_usu_usu, id_doc, id_usu_adm, id_tip_usu) VALUES (50, 33, NULL, 2);
INSERT INTO tipos_usuarios__usuarios (id_tip_usu_usu, id_doc, id_usu_adm, id_tip_usu) VALUES (51, 34, NULL, 2);
INSERT INTO tipos_usuarios__usuarios (id_tip_usu_usu, id_doc, id_usu_adm, id_tip_usu) VALUES (52, NULL, 23, 1);
INSERT INTO tipos_usuarios__usuarios (id_tip_usu_usu, id_doc, id_usu_adm, id_tip_usu) VALUES (53, NULL, 24, 1);
INSERT INTO tipos_usuarios__usuarios (id_tip_usu_usu, id_doc, id_usu_adm, id_tip_usu) VALUES (54, 35, NULL, 2);


--
-- TOC entry 2365 (class 0 OID 32657)
-- Dependencies: 1756
-- Data for Name: transacciones; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO transacciones (id_tip_tra, cod_tip_tra, des_tip_tra, id_mod) VALUES (1, 'RED', 'Registrar enfermedades dermatologicas', 1);
INSERT INTO transacciones (id_tip_tra, cod_tip_tra, des_tip_tra, id_mod) VALUES (2, 'MED', 'Modificar enfermedades dermatologicas', 1);
INSERT INTO transacciones (id_tip_tra, cod_tip_tra, des_tip_tra, id_mod) VALUES (3, 'EED', 'Eliminar enfermedades dermatologicas', 1);
INSERT INTO transacciones (id_tip_tra, cod_tip_tra, des_tip_tra, id_mod) VALUES (4, 'REF', 'Reportes de las estadisticas por enfermedad', 2);
INSERT INTO transacciones (id_tip_tra, cod_tip_tra, des_tip_tra, id_mod) VALUES (9, 'RP', 'Registrar Paciente', 1);
INSERT INTO transacciones (id_tip_tra, cod_tip_tra, des_tip_tra, id_mod) VALUES (10, 'MP', 'Modificar Paciente', 1);
INSERT INTO transacciones (id_tip_tra, cod_tip_tra, des_tip_tra, id_mod) VALUES (11, 'EP', 'Eliminar Paciente', 1);
INSERT INTO transacciones (id_tip_tra, cod_tip_tra, des_tip_tra, id_mod) VALUES (12, 'RHP', 'Registrar Historial de paciente', 1);
INSERT INTO transacciones (id_tip_tra, cod_tip_tra, des_tip_tra, id_mod) VALUES (13, 'MHP', 'Modificar Historial de paciente', 1);
INSERT INTO transacciones (id_tip_tra, cod_tip_tra, des_tip_tra, id_mod) VALUES (14, 'EHP', 'Modificar Historial de paciente', 1);
INSERT INTO transacciones (id_tip_tra, cod_tip_tra, des_tip_tra, id_mod) VALUES (15, 'MCP', 'Muestra Clínica del paciente', 1);
INSERT INTO transacciones (id_tip_tra, cod_tip_tra, des_tip_tra, id_mod) VALUES (16, 'IAP', 'Información Adicional del Paciente', 1);


--
-- TOC entry 2366 (class 0 OID 32662)
-- Dependencies: 1758
-- Data for Name: transacciones_usuarios; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (1, 50, 86);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (2, 50, 87);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (3, 50, 88);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (1, 17, 93);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (2, 17, 94);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (3, 17, 95);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (4, 17, 96);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (1, 51, 105);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (2, 51, 106);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (3, 51, 107);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (4, 51, 108);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (1, 43, 48);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (2, 43, 49);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (3, 43, 50);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (4, 43, 51);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (1, 49, 113);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (2, 49, 114);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (3, 49, 115);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (4, 49, 116);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (1, 44, 139);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (2, 44, 140);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (3, 44, 141);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (4, 44, 142);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (10, 44, 143);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (11, 44, 144);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (12, 44, 145);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (13, 44, 146);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (14, 44, 147);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (15, 44, 148);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (16, 44, 149);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (1, 54, 150);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (2, 54, 151);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (3, 54, 152);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (4, 54, 153);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (9, 54, 154);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (10, 54, 155);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (11, 54, 156);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (12, 54, 157);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (13, 54, 158);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (14, 54, 159);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (15, 54, 160);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (16, 54, 161);


--
-- TOC entry 2367 (class 0 OID 32667)
-- Dependencies: 1760
-- Data for Name: tratamientos; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO tratamientos (id_tra, nom_tra) VALUES (1, 'Uso Antimicóticos');
INSERT INTO tratamientos (id_tra, nom_tra) VALUES (2, 'Uso Antibióticos');
INSERT INTO tratamientos (id_tra, nom_tra) VALUES (3, 'Tópicos');
INSERT INTO tratamientos (id_tra, nom_tra) VALUES (4, 'Sistémicos');
INSERT INTO tratamientos (id_tra, nom_tra) VALUES (5, 'Hormonas Sexuales');
INSERT INTO tratamientos (id_tra, nom_tra) VALUES (6, 'Glucorticoides');
INSERT INTO tratamientos (id_tra, nom_tra) VALUES (7, 'Citotóxicos');
INSERT INTO tratamientos (id_tra, nom_tra) VALUES (8, 'Radioterapia');
INSERT INTO tratamientos (id_tra, nom_tra) VALUES (9, 'Inmunosupresores');
INSERT INTO tratamientos (id_tra, nom_tra) VALUES (10, 'Otros');


--
-- TOC entry 2368 (class 0 OID 32672)
-- Dependencies: 1762
-- Data for Name: tratamientos_pacientes; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO tratamientos_pacientes (id_tra_pac, id_his, id_tra, otr_tra) VALUES (254, 24, 9, NULL);
INSERT INTO tratamientos_pacientes (id_tra_pac, id_his, id_tra, otr_tra) VALUES (260, 25, 10, 'Biopsia Piel; Biopsia Otros Órganos; Líquido Peritoneal; Líquido Sinovial; Cefalorraquídeo (LC); uña');


--
-- TOC entry 2369 (class 0 OID 32677)
-- Dependencies: 1764
-- Data for Name: usuarios_administrativos; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO usuarios_administrativos (id_usu_adm, nom_usu_adm, ape_usu_adm, pas_usu_adm, log_usu_adm, tel_usu_adm, fec_reg_usu_adm, adm_usu) VALUES (21, 'Luis', 'Marin', '3e46a122f1961a8ec71f2a369f6d16ee', 'lmarin', '04265168824', '2011-06-10 20:02:12.07', true);
INSERT INTO usuarios_administrativos (id_usu_adm, nom_usu_adm, ape_usu_adm, pas_usu_adm, log_usu_adm, tel_usu_adm, fec_reg_usu_adm, adm_usu) VALUES (23, 'lmarin', 'marin', '3e46a122f1961a8ec71f2a369f6d16ee', 'lmarin2', '36222222', '2011-07-08 16:10:19.402', true);
INSERT INTO usuarios_administrativos (id_usu_adm, nom_usu_adm, ape_usu_adm, pas_usu_adm, log_usu_adm, tel_usu_adm, fec_reg_usu_adm, adm_usu) VALUES (22, 'Lisseth', 'Lozada', '3e46a122f1961a8ec71f2a369f6d16ee', 'llozada', '04269150722', '2011-06-24 15:22:46.934', true);
INSERT INTO usuarios_administrativos (id_usu_adm, nom_usu_adm, ape_usu_adm, pas_usu_adm, log_usu_adm, tel_usu_adm, fec_reg_usu_adm, adm_usu) VALUES (17, 'SAIB', 'SAIB', 'b107e9a7ba2cd6d9e878c1a1c277554c', 'SAIB', '04162102903', '2011-06-04 14:24:44.315', true);
INSERT INTO usuarios_administrativos (id_usu_adm, nom_usu_adm, ape_usu_adm, pas_usu_adm, log_usu_adm, tel_usu_adm, fec_reg_usu_adm, adm_usu) VALUES (24, 'Moises', 'Perez', 'bbc5d47920c1adc1ab1f4d43a1832282', 'Moises', '04123818120', '2012-01-16 10:01:40.862', true);


SET search_path = saib_model, pg_catalog;

--
-- TOC entry 2370 (class 0 OID 32692)
-- Dependencies: 1768
-- Data for Name: wwwsqldesigner; Type: TABLE DATA; Schema: saib_model; Owner: postgres
--

INSERT INTO wwwsqldesigner (keyword, xmldata, dt) VALUES ('saib', '<?xml version="1.0" encoding="utf-8" ?>
<!-- SQL XML created by WWW SQL Designer, http://code.google.com/p/wwwsqldesigner/ -->
<!-- Active URL: http://127.0.0.1/wwwsqldesigner-2.6/ -->
<sql>
<datatypes db="postgresql">

	<group label="Numeric" color="rgb(238,238,170)">

		<type label="Integer" length="0" sql="INTEGER" re="INT" quote=""/>

		<type label="Small Integer" length="0" sql="SMALLINT" quote=""/>

		<type label="Big Integer" length="0" sql="BIGINT" quote=""/>

		<type label="Decimal" length="1" sql="DECIMAL" re="numeric" quote=""/>

		<type label="Serial" length="0" sql="SERIAL" re="SERIAL4" fk="Integer" quote=""/>

		<type label="Big Serial" length="0" sql="BIGSERIAL" re="SERIAL8" fk="Big Integer" quote=""/>

		<type label="Real" length="0" sql="BIGINT" quote=""/>

		<type label="Single precision" length="0" sql="FLOAT" quote=""/>

		<type label="Double precision" length="0" sql="DOUBLE" re="DOUBLE" quote=""/>

	</group>



	<group label="Character" color="rgb(255,200,200)">

		<type label="Char" length="1" sql="CHAR" quote="''"/>

		<type label="Varchar" length="1" sql="VARCHAR" re="CHARACTER VARYING" quote="''"/>

		<type label="Text" length="0" sql="TEXT" quote="''"/>

		<type label="Binary" length="1" sql="BYTEA" quote="''"/>

		<type label="Boolean" length="0" sql="BOOLEAN" quote="''"/>

	</group>



	<group label="Date &amp; Time" color="rgb(200,255,200)">

		<type label="Date" length="0" sql="DATE" quote="''"/>

		<type label="Time" length="1" sql="TIME" quote="''"/>

		<type label="Time w/ TZ" length="0" sql="TIME WITH TIME ZONE" quote="''"/>

		<type label="Interval" length="1" sql="INTERVAL" quote="''"/>

		<type label="Timestamp" length="1" sql="TIMESTAMP" quote="''"/>

		<type label="Timestamp w/ TZ" length="0" sql="TIMESTAMP WITH TIME ZONE" quote="''"/>

		<type label="Timestamp wo/ TZ" length="0" sql="TIMESTAMP WITHOUT TIME ZONE" quote="''"/>

	</group>



	<group label="Miscellaneous" color="rgb(200,200,255)">

		<type label="XML" length="1" sql="XML" quote="''"/>

		<type label="Bit" length="1" sql="BIT" quote="''"/>

		<type label="Bit Varying" length="1" sql="VARBIT" re="BIT VARYING" quote="''"/>

		<type label="Inet Host Addr" length="0" sql="INET" quote="''"/>

		<type label="Inet CIDR Addr" length="0" sql="CIDR" quote="''"/>

		<type label="Geometry" length="0" sql="GEOMETRY" quote="''"/>

	</group>

</datatypes><table x="1233" y="495" name="historiales_pacientes">
<row name="id_his" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''historiales_pacientes_id_his_seq''::regclass)</default></row>
<row name="id_pac" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<relation table="pacientes" row="id_pac" />
</row>
<row name="des_his" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<row name="id_doc" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default><relation table="doctores" row="id_doc" />
</row>
<row name="des_adi_pac_his" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default><comment>
	Discripción adicional de si el paciente padece o no una enfermedad u otra cosa adicional.
</comment>
</row>
<row name="fec_his" null="1" autoincrement="0">
<datatype>TIMESTAMP WITH TIME ZONE</datatype>
<default>''now()''</default></row>
<row name="pag_his" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default></row>
<key type="CHECK" name="17105_17204_1_not_null">
</key>
<key type="CHECK" name="17105_17204_2_not_null">
</key>
<key type="PRIMARY" name="historiales_pacientes_pkey">
<part>id_his</part>
</key>
</table>
<table x="488" y="228" name="pacientes">
<row name="id_pac" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''pacientes_id_pac_seq''::regclass)</default><comment>Id paciente</comment>
</row>
<row name="ape_pac" null="0" autoincrement="0">
<datatype>VARCHAR</datatype>
<comment>Apellido del paciente</comment>
</row>
<row name="nom_pac" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default><comment>Nombre del paciente</comment>
</row>
<row name="ced_pac" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default><comment>Cedula del paciente</comment>
</row>
<row name="fec_nac_pac" null="0" autoincrement="0">
<datatype>DATE</datatype>
<comment>Fecha de nacimiento del paciente</comment>
</row>
<row name="nac_pac" null="0" autoincrement="0">
<datatype>VARCHAR</datatype>
<comment>Nacionalidad del paciente</comment>
</row>
<row name="tel_hab_pac" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<row name="tel_cel_pac" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<row name="ocu_pac" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default><comment>Ocupacion del paciente</comment>
</row>
<row name="ciu_pac" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default><comment>Ciudad del paciente</comment>
</row>
<row name="id_pai" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default><relation table="paises" row="id_pai" />
</row>
<row name="id_est" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default><relation table="estados" row="id_est" />
</row>
<row name="id_mun" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default><relation table="municipios" row="id_mun" />
</row>
<row name="id_par" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default><relation table="parroquias" row="id_par" />
</row>
<row name="num_pac" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default></row>
<row name="id_doc" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default><relation table="doctores" row="id_doc" />
</row>
<row name="fec_reg_pac" null="1" autoincrement="0">
<datatype>TIMESTAMP WITH TIME ZONE</datatype>
<default>''now()''</default><comment>Fecha de registro del paciente</comment>
</row>
<row name="sex_pac" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
</row>
<key type="CHECK" name="17105_17244_1_not_null">
</key>
<key type="CHECK" name="17105_17244_2_not_null">
</key>
<key type="CHECK" name="17105_17244_23_not_null">
</key>
<key type="CHECK" name="17105_17244_5_not_null">
</key>
<key type="CHECK" name="17105_17244_6_not_null">
</key>
<key type="PRIMARY" name="pacientes_pkey">
<part>id_pac</part>
</key>
</table>
<table x="2054" y="781" name="tipos_micosis_pacientes">
<row name="id_tip_mic_pac" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''tipos_micosis_pacientes_id_tip_mic_pac_seq''::regclass)</default></row>
<row name="id_tip_mic" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default><relation table="tipos_micosis" row="id_tip_mic" />
</row>
<row name="id_his" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default><relation table="historiales_pacientes" row="id_his" />
</row>
<key type="CHECK" name="17105_19170_1_not_null">
</key>
<key type="PRIMARY" name="tipos_micosis_pacientes_pkey">
<part>id_tip_mic_pac</part>
</key>
<key type="UNIQUE" name="tipos_micosis_pacientes_unique">
<part>id_his</part>
<part>id_tip_mic</part>
</key>
</table>
<table x="2896" y="714" name="tipos_micosis">
<row name="id_tip_mic" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''tipos_micosis_id_tip_mic_seq''::regclass)</default></row>
<row name="nom_tip_mic" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<key type="CHECK" name="17105_17277_1_not_null">
</key>
<key type="PRIMARY" name="tipos_micosis_pkey">
<part>id_tip_mic</part>
</key>
</table>
<table x="21" y="32" name="tipos_usuarios__usuarios">
<row name="id_tip_usu_usu" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''tipos_usuarios__usuarios_id_tip_usu_usu_seq''::regclass)</default></row>
<row name="id_doc" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default><relation table="doctores" row="id_doc" />
</row>
<row name="id_usu_adm" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default><relation table="usuarios_administrativos" row="id_usu_adm" />
</row>
<row name="id_tip_usu" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<relation table="tipos_usuarios" row="id_tip_usu" />
</row>
<key type="CHECK" name="17105_17285_1_not_null">
</key>
<key type="CHECK" name="17105_17285_4_not_null">
</key>
<key type="PRIMARY" name="tipos_usuarios__usuarios_pkey">
<part>id_tip_usu_usu</part>
</key>
<key type="UNIQUE" name="unique_tipos_usuarios__usuarios">
<part>id_tip_usu</part>
<part>id_usu_adm</part>
<part>id_doc</part>
</key>
</table>
<table x="978" y="164" name="doctores">
<row name="id_doc" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''doctores_id_doc_seq''::regclass)</default><comment>identificador único para los doctores</comment>
</row>
<row name="nom_doc" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default><comment>Nombre del doctor</comment>
</row>
<row name="ape_doc" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default><comment>Apellido del doctor</comment>
</row>
<row name="ced_doc" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default><comment>Cédula del doctor</comment>
</row>
<row name="pas_doc" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default><comment>Contraseña del doctor</comment>
</row>
<row name="tel_doc" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default><comment>Teléfono del doctor</comment>
</row>
<row name="cor_doc" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default><comment>Correo electronico del doctor</comment>
</row>
<row name="log_doc" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default><comment>Login con el que se loguara el doctor</comment>
</row>
<row name="fec_reg_doc" null="1" autoincrement="0">
<datatype>TIMESTAMP WITH TIME ZONE</datatype>
<default>''now()''</default></row>
<key type="CHECK" name="17105_17166_1_not_null">
</key>
<key type="PRIMARY" name="doctores_pkey">
<part>id_doc</part>
</key>
<comment>Registro de todos los doctores que del aplicativo</comment>
</table>
<table x="158" y="773" name="municipios">
<row name="id_mun" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''municipios_id_mun_seq''::regclass)</default></row>
<row name="des_mun" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<row name="id_est" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default><relation table="estados" row="id_est" />
</row>
<key type="CHECK" name="17105_18428_1_not_null">
</key>
<key type="PRIMARY" name="municipios_pkey">
<part>id_mun</part>
</key>
</table>
<table x="86" y="651" name="estados">
<row name="id_est" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''estados_id_est_seq''::regclass)</default></row>
<row name="des_est" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<row name="id_pai" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default><relation table="paises" row="id_pai" />
</row>
<key type="CHECK" name="17105_18420_1_not_null">
</key>
<key type="PRIMARY" name="estados_pkey">
<part>id_est</part>
</key>
</table>
<table x="799" y="1142" name="partes_cuerpos__categorias_cuerpos">
<row name="id_par_cue_cat_cue" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''partes_cuerpos__categorias_cuerpos_id_par_cue_cat_cue_seq''::regclass)</default></row>
<row name="id_cat_cue" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<relation table="categorias_cuerpos" row="id_cat_cue" />
</row>
<row name="id_par_cue" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<relation table="partes_cuerpos" row="id_par_cue" />
</row>
<key type="CHECK" name="17105_19125_1_not_null">
</key>
<key type="CHECK" name="17105_19125_2_not_null">
</key>
<key type="CHECK" name="17105_19125_3_not_null">
</key>
<key type="PRIMARY" name="partes_cuerpos__categorias_cuerpos_pkey">
<part>id_par_cue_cat_cue</part>
</key>
<key type="UNIQUE" name="partes_cuerpos__categorias_cuerpos_unique">
<part>id_par_cue</part>
<part>id_cat_cue</part>
</key>
<comment>Permite seleccionar a que categoria pertenece la parte del cuerpo</comment>
</table>
<table x="1194" y="1013" name="categorias_cuerpos">
<row name="id_cat_cue" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''categorias_cuerpos_id_cat_cue_seq''::regclass)</default></row>
<row name="nom_cat_cue" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<key type="CHECK" name="17105_17131_1_not_null">
</key>
<key type="PRIMARY" name="categorias_cuerpos_pkey">
<part>id_cat_cue</part>
</key>
</table>
<table x="1506" y="914" name="categorias_cuerpos__lesiones">
<row name="id_cat_cue_les" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''lesiones__partes_cuerpos_id_les_par_cue_seq''::regclass)</default></row>
<row name="id_les" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default><relation table="lesiones" row="id_les" />
</row>
<row name="id_cat_cue" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default><relation table="categorias_cuerpos" row="id_cat_cue" />
</row>
<key type="CHECK" name="17105_17209_1_not_null">
</key>
<key type="PRIMARY" name="lesiones__partes_cuerpos_pkey">
<part>id_cat_cue_les</part>
</key>
</table>
<table x="1473" y="1150" name="lesiones_partes_cuerpos__pacientes">
<row name="id_les_par_cue_pac" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''lesiones_partes_cuerpos__pacientes_id_les_par_cue_pac_seq''::regclass)</default><comment>Leciones parted del cuerpo paciente</comment>
</row>
<row name="otr_les_par_cue" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default><comment>Otras leciones de la parte del cuerpo del paciente</comment>
</row>
<row name="id_cat_cue_les" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default><relation table="categorias_cuerpos__lesiones" row="id_cat_cue_les" />
</row>
<row name="id_par_cue_cat_cue" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default><relation table="partes_cuerpos__categorias_cuerpos" row="id_par_cue_cat_cue" />
</row>
<row name="id_tip_mic_pac" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default><relation table="tipos_micosis_pacientes" row="id_tip_mic_pac" />
</row>
<key type="CHECK" name="17105_17214_1_not_null">
</key>
<key type="PRIMARY" name="lesiones_partes_cuerpos__pacientes_pkey">
<part>id_les_par_cue_pac</part>
</key>
<key type="UNIQUE" name="lesiones_partes_cuerpos__pacientes_unique">
<part>id_par_cue_cat_cue</part>
<part>id_cat_cue_les</part>
<part>id_tip_mic_pac</part>
</key>
</table>
<table x="2753" y="963" name="tipos_estudios_micologicos">
<row name="id_tip_est_mic" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''tipos_estudios_micologicos_id_tip_est_mic_seq''::regclass)</default></row>
<row name="id_tip_mic" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<relation table="tipos_micosis" row="id_tip_mic" />
</row>
<row name="nom_tip_est_mic" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<row name="id_tip_exa" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default><relation table="tipos_examenes" row="id_tip_exa" />
</row>
<key type="CHECK" name="17105_17272_1_not_null">
</key>
<key type="CHECK" name="17105_17272_2_not_null">
</key>
<key type="PRIMARY" name="tipos_estudios_micologicos_pkey">
<part>id_tip_est_mic</part>
</key>
</table>
<table x="1134" y="2443" name="transacciones">
<row name="id_tip_tra" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''transacciones_id_tip_tra_seq''::regclass)</default></row>
<row name="cod_tip_tra" null="0" autoincrement="0">
<datatype>VARCHAR</datatype>
</row>
<row name="des_tip_tra" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<row name="id_mod" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default><relation table="modulos" row="id_mod" />
</row>
<key type="CHECK" name="17105_17292_1_not_null">
</key>
<key type="CHECK" name="17105_17292_2_not_null">
</key>
<key type="UNIQUE" name="transacciones_cod_tip_tra__id_mod">
<part>cod_tip_tra</part>
<part>id_mod</part>
</key>
<key type="PRIMARY" name="transacciones_pkey">
<part>id_tip_tra</part>
</key>
</table>
<table x="2392" y="605" name="centro_salud_doctores">
<row name="id_cen_sal_doc" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''centro_salud_doctores_id_cen_sal_doc_seq''::regclass)</default><comment>Identificación del Centro de Salud del doctor</comment>
</row>
<row name="id_cen_sal" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<relation table="centro_saluds" row="id_cen_sal" />
<comment>Identificación del Centro de Salud</comment>
</row>
<row name="id_doc" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<relation table="doctores" row="id_doc" />
<comment>Identificación del doctor</comment>
</row>
<row name="otr_cen_sal" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default><comment>Otro Centro de Salud</comment>
</row>
<key type="CHECK" name="17105_18773_1_not_null">
</key>
<key type="CHECK" name="17105_18773_2_not_null">
</key>
<key type="CHECK" name="17105_18773_3_not_null">
</key>
<key type="PRIMARY" name="centro_salud_doctores_pkey">
<part>id_cen_sal_doc</part>
</key>
<key type="UNIQUE" name="centro_salud_doctores_unique">
<part>id_doc</part>
<part>id_cen_sal</part>
</key>
</table>
<table x="69" y="903" name="parroquias">
<row name="id_par" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''parroquias_id_par_seq''::regclass)</default></row>
<row name="des_par" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<row name="id_mun" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default><relation table="municipios" row="id_mun" />
</row>
<key type="CHECK" name="17105_18436_1_not_null">
</key>
<key type="PRIMARY" name="parroquias_pkey">
<part>id_par</part>
</key>
</table>
<table x="57" y="525" name="paises">
<row name="id_pai" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''paises_id_pai_seq''::regclass)</default></row>
<row name="des_pai" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<row name="cod_pai" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<key type="CHECK" name="17105_18412_1_not_null">
</key>
<key type="PRIMARY" name="paises_pkey">
<part>id_pai</part>
</key>
</table>
<table x="1770" y="1496" name="tipos_micosis_pacientes__tipos_estudios_micologicos">
<row name="id_tip_mic_pac_tip_est_mic" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''tipos_micosis_pacientes__tipos_e_id_tip_mic_pac_tip_est_mic_seq''::regclass)</default></row>
<row name="id_tip_mic_pac" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default><relation table="tipos_micosis_pacientes" row="id_tip_mic_pac" />
</row>
<row name="id_tip_est_mic" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default><relation table="tipos_estudios_micologicos" row="id_tip_est_mic" />
</row>
<row name="otr_tip_est_mic" null="1" autoincrement="0">
<datatype>VARCHAR(100)</datatype>
<default>NULL</default><comment>Otros tipos de estudio micologico asociado a muestras pacientes</comment>
</row>
<key type="CHECK" name="17105_19305_1_not_null">
</key>
<key type="PRIMARY" name="tipos_micosis_pacientes__tipos_estudios_micologicos_pkey">
<part>id_tip_mic_pac_tip_est_mic</part>
</key>
</table>
<table x="1623" y="2740" name="auditoria_transacciones">
<row name="id_aud_tra" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''auditoria_transacciones_id_aud_tra_seq''::regclass)</default></row>
<row name="fec_aud_tra" null="1" autoincrement="0">
<datatype>TIMESTAMP WITHOUT TIME ZONE</datatype>
<default>NULL</default></row>
<row name="id_tip_usu_usu" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<relation table="tipos_usuarios__usuarios" row="id_tip_usu_usu" />
</row>
<row name="id_tip_tra" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<relation table="transacciones" row="id_tip_tra" />
</row>
<row name="data_xml" null="1" autoincrement="0">
<datatype>XML</datatype>
<default>NULL</default><comment>Se guarda las modificaciones de la tabla y atributos realizada por los usuarios, todo en forma de XML</comment>
</row>
<key type="CHECK" name="17105_17121_1_not_null">
</key>
<key type="CHECK" name="17105_17121_3_not_null">
</key>
<key type="CHECK" name="17105_17121_4_not_null">
</key>
<key type="PRIMARY" name="auditoria_transacciones_pkey">
<part>id_aud_tra</part>
</key>
<comment>Se guarda todos los eventos generados por los usuarios</comment>
</table>
<table x="1453" y="1468" name="antecedentes_pacientes">
<row name="id_ant_pac" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''antecedentes_pacientes_id_ant_pac_seq''::regclass)</default></row>
<row name="id_ant_per" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<relation table="antecedentes_personales" row="id_ant_per" />
</row>
<row name="id_pac" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default><relation table="pacientes" row="id_pac" />
</row>
<key type="CHECK" name="17105_17111_1_not_null">
</key>
<key type="CHECK" name="17105_17111_2_not_null">
</key>
<key type="PRIMARY" name="antecedentes_pacientes_pkey">
<part>id_ant_pac</part>
</key>
</table>
<table x="1949" y="1058" name="categorias__cuerpos_micosis">
<row name="id_cat_cue_mic" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''categorias__cuerpos_micosis_id_cat_cue_mic_seq''::regclass)</default></row>
<row name="id_cat_cue" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<relation table="categorias_cuerpos" row="id_cat_cue" />
</row>
<row name="id_tip_mic" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<relation table="tipos_micosis" row="id_tip_mic" />
</row>
<key type="CHECK" name="17105_17126_1_not_null">
</key>
<key type="CHECK" name="17105_17126_2_not_null">
</key>
<key type="CHECK" name="17105_17126_3_not_null">
</key>
<key type="PRIMARY" name="categorias__cuerpos_micosis_pkey">
<part>id_cat_cue_mic</part>
</key>
<key type="UNIQUE" name="categorias__cuerpos_micosis_unique">
<part>id_tip_mic</part>
<part>id_cat_cue</part>
</key>
</table>
<table x="2364" y="1108" name="enfermedades_micologicas">
<row name="id_enf_mic" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''enfermedades_micologicas_id_enf_mic_seq''::regclass)</default></row>
<row name="nom_enf_mic" null="0" autoincrement="0">
<datatype>VARCHAR</datatype>
</row>
<row name="id_tip_mic" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<relation table="tipos_micosis" row="id_tip_mic" />
</row>
<key type="CHECK" name="17105_17174_1_not_null">
</key>
<key type="CHECK" name="17105_17174_2_not_null">
</key>
<key type="CHECK" name="17105_17174_3_not_null">
</key>
<key type="PRIMARY" name="enfermedades_micologicas_pkey">
<part>id_enf_mic</part>
</key>
</table>
<table x="1838" y="1266" name="enfermedades_pacientes">
<row name="id_enf_pac" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''enfermedades_pacientes_id_enf_pac_seq''::regclass)</default></row>
<row name="id_enf_mic" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<relation table="enfermedades_micologicas" row="id_enf_mic" />
</row>
<row name="otr_enf_mic" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<row name="esp_enf_mic" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<row name="id_tip_mic_pac" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default><relation table="tipos_micosis_pacientes" row="id_tip_mic_pac" />
</row>
<key type="CHECK" name="17105_17179_1_not_null">
</key>
<key type="CHECK" name="17105_17179_3_not_null">
</key>
<key type="PRIMARY" name="enfermedades_pacientes_pkey">
<part>id_enf_pac</part>
</key>
</table>
<table x="2045" y="256" name="centro_salud_pacientes">
<row name="id_cen_sal_pac" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''centro_salud_pacientes_id_cen_sal_pac_seq''::regclass)</default></row>
<row name="id_his" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<relation table="historiales_pacientes" row="id_his" />
</row>
<row name="id_cen_sal" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<relation table="centro_saluds" row="id_cen_sal" />
</row>
<row name="otr_cen_sal" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<key type="CHECK" name="17105_17146_1_not_null">
</key>
<key type="CHECK" name="17105_17146_2_not_null">
</key>
<key type="CHECK" name="17105_17146_3_not_null">
</key>
<key type="PRIMARY" name="centro_salud_pacientes_pkey">
<part>id_cen_sal_pac</part>
</key>
<key type="UNIQUE" name="centro_salud_pacientes_unique">
<part>id_his</part>
<part>id_cen_sal</part>
</key>
</table>
<table x="2360" y="1458" name="contactos_animales">
<row name="id_con_ani" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''contactos_animales_id_con_ani_seq''::regclass)</default></row>
<row name="id_his" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<relation table="historiales_pacientes" row="id_his" />
</row>
<row name="id_ani" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<relation table="animales" row="id_ani" />
</row>
<row name="otr_ani" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<key type="CHECK" name="17105_17161_1_not_null">
</key>
<key type="CHECK" name="17105_17161_2_not_null">
</key>
<key type="CHECK" name="17105_17161_3_not_null">
</key>
<key type="PRIMARY" name="contactos_animales_pkey">
<part>id_con_ani</part>
</key>
<key type="UNIQUE" name="contactos_animales_unique">
<part>id_his</part>
<part>id_ani</part>
</key>
</table>
<table x="2768" y="419" name="centro_saluds">
<row name="id_cen_sal" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''centro_salud_id_cen_sal_seq''::regclass)</default></row>
<row name="nom_cen_sal" null="0" autoincrement="0">
<datatype>VARCHAR</datatype>
</row>
<row name="des_cen_sal" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<key type="CHECK" name="17105_17141_1_not_null">
</key>
<key type="CHECK" name="17105_17141_2_not_null">
</key>
<key type="PRIMARY" name="centro_salud_pkey">
<part>id_cen_sal</part>
</key>
</table>
<table x="3829" y="721" name="forma_infecciones__tipos_micosis">
<row name="id_for_inf_tip_mic" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''forma_infecciones__tipos_micosis_id_for_inf_tip_mic_seq''::regclass)</default></row>
<row name="id_tip_mic" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<relation table="tipos_micosis" row="id_tip_mic" />
</row>
<row name="id_for_inf" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<relation table="forma_infecciones" row="id_for_inf" />
</row>
<key type="CHECK" name="17105_17197_1_not_null">
</key>
<key type="CHECK" name="17105_17197_2_not_null">
</key>
<key type="CHECK" name="17105_17197_3_not_null">
</key>
<key type="PRIMARY" name="forma_infecciones__tipos_micosis_pkey">
<part>id_for_inf_tip_mic</part>
</key>
<key type="UNIQUE" name="forma_infecciones__tipos_micosis_unique">
<part>id_tip_mic</part>
<part>id_for_inf</part>
</key>
</table>
<table x="903" y="2316" name="modulos">
<row name="id_mod" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''modulos_id_mod_seq''::regclass)</default></row>
<row name="cod_mod" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<row name="des_mod" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<row name="id_tip_usu" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default><relation table="tipos_usuarios" row="id_tip_usu" />
</row>
<key type="CHECK" name="17105_17229_1_not_null">
</key>
<key type="UNIQUE" name="modulos_cod_mod_unique">
<part>cod_mod</part>
<part>id_tip_usu</part>
</key>
<key type="PRIMARY" name="modulos_pkey">
<part>id_mod</part>
</key>
</table>
<table x="3153" y="845" name="forma_infecciones__pacientes">
<row name="id_for_pac" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''forma_infecciones__pacientes_id_for_pac_seq''::regclass)</default></row>
<row name="id_for_inf" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<relation table="forma_infecciones" row="id_for_inf" />
</row>
<row name="otr_for_inf" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<row name="id_tip_mic_pac" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default><relation table="tipos_micosis_pacientes" row="id_tip_mic_pac" />
</row>
<key type="CHECK" name="17105_17192_1_not_null">
</key>
<key type="CHECK" name="17105_17192_2_not_null">
</key>
<key type="PRIMARY" name="forma_infecciones__pacientes_pkey">
<part>id_for_pac</part>
</key>
<key type="UNIQUE" name="forma_infecciones__pacientes_unique">
<part>id_tip_mic_pac</part>
<part>id_for_inf</part>
</key>
</table>
<table x="3550" y="798" name="forma_infecciones">
<row name="id_for_inf" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''forma_infecciones_id_for_inf_seq''::regclass)</default></row>
<row name="des_for_inf" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<key type="CHECK" name="17105_17189_1_not_null">
</key>
<key type="PRIMARY" name="forma_infecciones_pkey">
<part>id_for_inf</part>
</key>
</table>
<table x="1963" y="1797" name="muestras_pacientes">
<row name="id_mue_pac" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''muestras_pacientes_id_mue_pac_seq''::regclass)</default><comment>Id de la meustra del paciente</comment>
</row>
<row name="id_his" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<relation table="historiales_pacientes" row="id_his" />
<comment>Id del historial</comment>
</row>
<row name="id_mue_cli" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<relation table="muestras_clinicas" row="id_mue_cli" />
<comment>Id muestra cli</comment>
</row>
<row name="otr_mue_cli" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default><comment>Otra meustra clinica</comment>
</row>
<key type="CHECK" name="17105_17239_1_not_null">
</key>
<key type="CHECK" name="17105_17239_2_not_null">
</key>
<key type="CHECK" name="17105_17239_3_not_null">
</key>
<key type="PRIMARY" name="muestras_pacientes_pkey">
<part>id_mue_pac</part>
</key>
<key type="UNIQUE" name="muestras_pacientes_unique">
<part>id_mue_cli</part>
<part>id_his</part>
</key>
</table>
<table x="1989" y="2519" name="transacciones_usuarios">
<row name="id_tip_tra" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<relation table="transacciones" row="id_tip_tra" />
</row>
<row name="id_tip_usu_usu" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default><relation table="tipos_usuarios__usuarios" row="id_tip_usu_usu" />
</row>
<row name="id_tra_usu" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''transacciones_usuarios_id_tra_usu_seq''::regclass)</default></row>
<key type="CHECK" name="17105_17297_2_not_null">
</key>
<key type="CHECK" name="17105_17297_6_not_null">
</key>
<key type="PRIMARY" name="transacciones_usuarios_pkey">
<part>id_tra_usu</part>
</key>
</table>
<table x="157" y="1807" name="tipos_consultas_pacientes">
<row name="id_tip_con_pac" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''tipos_consultas_pacientes_id_tip_con_pac_seq''::regclass)</default><comment>Id tipos de consulta paciente</comment>
</row>
<row name="id_tip_con" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<relation table="tipos_consultas" row="id_tip_con" />
<comment>Id tipos de consulta</comment>
</row>
<row name="id_his" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<relation table="historiales_pacientes" row="id_his" />
<comment>Id historico</comment>
</row>
<row name="otr_tip_con" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default><comment>Otro tipo de consulta</comment>
</row>
<key type="CHECK" name="17105_17267_1_not_null">
</key>
<key type="CHECK" name="17105_17267_2_not_null">
</key>
<key type="CHECK" name="17105_17267_3_not_null">
</key>
<key type="PRIMARY" name="tipos_consultas_pacientes_pkey">
<part>id_tip_con_pac</part>
</key>
<key type="UNIQUE" name="tipos_consultas_pacientes_unique">
<part>id_tip_con</part>
<part>id_his</part>
</key>
</table>
<table x="510" y="1061" name="partes_cuerpos">
<row name="id_par_cue" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''partes_cuerpos_id_par_cue_seq''::regclass)</default></row>
<row name="nom_par_cue" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<key type="CHECK" name="17105_17252_1_not_null">
</key>
<key type="PRIMARY" name="partes_cuerpos_pkey">
<part>id_par_cue</part>
</key>
</table>
<table x="624" y="1849" name="tratamientos_pacientes">
<row name="id_tra_pac" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''tratamientos_pacientes_id_tra_pac_seq''::regclass)</default><comment>Id transaccion paciente</comment>
</row>
<row name="id_his" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<relation table="historiales_pacientes" row="id_his" />
<comment>Id historico</comment>
</row>
<row name="id_tra" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<relation table="tratamientos" row="id_tra" />
<comment>Id tratamiento</comment>
</row>
<row name="otr_tra" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default><comment>Otro tratamiento</comment>
</row>
<key type="CHECK" name="17105_17307_1_not_null">
</key>
<key type="CHECK" name="17105_17307_2_not_null">
</key>
<key type="CHECK" name="17105_17307_3_not_null">
</key>
<key type="PRIMARY" name="tratamientos_pacientes_pkey">
<part>id_tra_pac</part>
</key>
<key type="UNIQUE" name="tratamientos_pacientes_unique">
<part>id_his</part>
<part>id_tra</part>
</key>
</table>
<table x="988" y="1803" name="tipos_usuarios">
<row name="id_tip_usu" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''tipos_usuarios_id_tip_usu_seq''::regclass)</default></row>
<row name="cod_tip_usu" null="0" autoincrement="0">
<datatype>VARCHAR</datatype>
</row>
<row name="des_tip_usu" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<key type="CHECK" name="17105_17282_1_not_null">
</key>
<key type="CHECK" name="17105_17282_2_not_null">
</key>
<key type="PRIMARY" name="tipos_usuarios_pkey">
<part>id_tip_usu</part>
</key>
<key type="UNIQUE" name="tipos_usuarios_unique">
<part>cod_tip_usu</part>
</key>
</table>
<table x="1101" y="869" name="lesiones">
<row name="id_les" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''lesiones_id_les_seq''::regclass)</default></row>
<row name="nom_les" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<key type="CHECK" name="17105_19087_1_not_null">
</key>
<key type="PRIMARY" name="lesiones_id_les_pkey">
<part>id_les</part>
</key>
</table>
<table x="1232" y="730" name="tiempo_evoluciones">
<row name="id_tie_evo" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''tiempo_evoluciones_id_tie_evo_seq''::regclass)</default></row>
<row name="id_his" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default><relation table="historiales_pacientes" row="id_his" />
</row>
<row name="tie_evo" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>0</default></row>
<key type="CHECK" name="17105_18883_1_not_null">
</key>
<key type="PRIMARY" name="tiempo_evoluciones_pkey">
<part>id_tie_evo</part>
</key>
</table>
<table x="3224" y="675" name="tipos_examenes">
<row name="id_tip_exa" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''tipos_examenes_id_tip_exa_seq''::regclass)</default></row>
<row name="nom_tip_exa" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<key type="CHECK" name="17105_19279_1_not_null">
</key>
<key type="PRIMARY" name="tipos_examenes_pkey">
<part>id_tip_exa</part>
</key>
</table>
<table x="18" y="2282" name="antecedentes_personales">
<row name="id_ant_per" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''antecedentes_personales_id_ant_per_seq''::regclass)</default></row>
<row name="nom_ant_per" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<key type="CHECK" name="17105_17116_1_not_null">
</key>
<key type="PRIMARY" name="antecedentes_personales_pkey">
<part>id_ant_per</part>
</key>
</table>
<table x="2660" y="1246" name="animales">
<row name="id_ani" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''animales_id_ani_seq''::regclass)</default></row>
<row name="nom_ani" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<key type="CHECK" name="17105_17106_1_not_null">
</key>
<key type="PRIMARY" name="animales_pkey">
<part>id_ani</part>
</key>
</table>
<table x="471" y="1582" name="tipos_consultas">
<row name="id_tip_con" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''tipos_consultas_id_tip_con_seq''::regclass)</default><comment>id tipos consultas</comment>
</row>
<row name="nom_tip_con" null="0" autoincrement="0">
<datatype>VARCHAR</datatype>
</row>
<key type="CHECK" name="17105_17262_1_not_null">
</key>
<key type="CHECK" name="17105_17262_2_not_null">
</key>
<key type="PRIMARY" name="tipos_consultas_pkey">
<part>id_tip_con</part>
</key>
</table>
<table x="1454" y="1931" name="muestras_clinicas">
<row name="id_mue_cli" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''muestras_clinicas_id_mue_cli_seq''::regclass)</default><comment>Identificacion de la muestra clinica</comment>
</row>
<row name="nom_mue_cli" null="0" autoincrement="0">
<datatype>VARCHAR</datatype>
<comment>Nombre muestra clinica</comment>
</row>
<key type="CHECK" name="17105_17234_1_not_null">
</key>
<key type="CHECK" name="17105_17234_2_not_null">
</key>
<key type="PRIMARY" name="muestras_clinicas_pkey">
<part>id_mue_cli</part>
</key>
</table>
<table x="726" y="1338" name="localizaciones_cuerpos">
<row name="id_loc_cue" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''localizaciones_cuerpos_id_loc_cue_seq''::regclass)</default></row>
<row name="nom_loc_cue" null="0" autoincrement="0">
<datatype>VARCHAR</datatype>
</row>
<row name="id_par_cue" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default><relation table="partes_cuerpos" row="id_par_cue" />
</row>
<key type="CHECK" name="17105_17219_1_not_null">
</key>
<key type="CHECK" name="17105_17219_2_not_null">
</key>
<key type="PRIMARY" name="localizaciones_cuerpos_pkey">
<part>id_loc_cue</part>
</key>
</table>
<table x="1460" y="82" name="usuarios_administrativos">
<row name="id_usu_adm" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''usuarios_administrativos_id_usu_adm_seq''::regclass)</default></row>
<row name="nom_usu_adm" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<row name="ape_usu_adm" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<row name="pas_usu_adm" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<row name="log_usu_adm" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<row name="tel_usu_adm" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<row name="fec_reg_usu_adm" null="1" autoincrement="0">
<datatype>TIMESTAMP WITHOUT TIME ZONE</datatype>
<default>''now()''</default><comment>Fecha de registro de los usuarios</comment>
</row>
<row name="adm_usu" null="1" autoincrement="0">
<datatype>BOOLEAN</datatype>
<default>NULL</default><comment>
	TRUE: si es un super usuario
	FALSE: si es usuario com limitaciones
</comment>
</row>
<key type="CHECK" name="17105_17312_1_not_null">
</key>
<key type="UNIQUE" name="usuarios_administrativos_log_usu_adm_unique">
<part>log_usu_adm</part>
</key>
<key type="PRIMARY" name="usuarios_administrativos_pkey">
<part>id_usu_adm</part>
</key>
</table>
<table x="1709" y="2106" name="tratamientos">
<row name="id_tra" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''tratamientos_id_tra_seq''::regclass)</default></row>
<row name="nom_tra" null="1" autoincrement="0">
<datatype>VARCHAR</datatype>
<default>NULL</default></row>
<key type="CHECK" name="17105_17302_1_not_null">
</key>
<key type="PRIMARY" name="tratamientos_pkey">
<part>id_tra</part>
</key>
</table>
<table x="1771" y="2254" name="wwwsqldesigner">
<row name="keyword" null="0" autoincrement="0">
<datatype>VARCHAR</datatype>
</row>
<row name="xmldata" null="1" autoincrement="0">
<datatype>TEXT</datatype>
<default>NULL</default></row>
<row name="dt" null="1" autoincrement="0">
<datatype>TIMESTAMP WITHOUT TIME ZONE</datatype>
<default>NULL</default></row>
<key type="CHECK" name="27541_27542_1_not_null">
</key>
<key type="PRIMARY" name="wwwsqldesigner_pkey">
<part>keyword</part>
</key>
</table>
<table x="3221" y="415" name="examenes_pacientes">
<row name="id_exa_pac" null="1" autoincrement="1">
<datatype>INTEGER</datatype>
<default>NULL</default><comment>Id auto incremetnal de los tipos de examenes del paciente.</comment>
</row>
<row name="id_tip_mic_pac" null="0" autoincrement="0">
<datatype>INTEGER</datatype>
<default>nextval(''tipos_micosis_pacientes_id_tip_mic_pac_seq''::regclass)</default><relation table="tipos_micosis_pacientes" row="id_tip_mic_pac" />
</row>
<row name="id_tip_exa" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default><relation table="tipos_examenes" row="id_tip_exa" />
</row>
<row name="exa_pac_est" null="1" autoincrement="0">
<datatype>INTEGER</datatype>
<default>NULL</default></row>
<key type="PRIMARY" name="">
<part>id_exa_pac</part>
</key>
<comment>Contiene los examenes asociados al paciente, aqui tambien se almacena si el examen si es positivo o no.</comment>
</table>
</sql>
', NULL);


SET search_path = public, pg_catalog;

--
-- TOC entry 2103 (class 2606 OID 32747)
-- Dependencies: 1672 1672
-- Name: animales_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY animales
    ADD CONSTRAINT animales_pkey PRIMARY KEY (id_ani);


--
-- TOC entry 2105 (class 2606 OID 32749)
-- Dependencies: 1674 1674
-- Name: antecedentes_pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY antecedentes_pacientes
    ADD CONSTRAINT antecedentes_pacientes_pkey PRIMARY KEY (id_ant_pac);


--
-- TOC entry 2108 (class 2606 OID 32751)
-- Dependencies: 1676 1676
-- Name: antecedentes_personales_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY antecedentes_personales
    ADD CONSTRAINT antecedentes_personales_pkey PRIMARY KEY (id_ant_per);


SET default_tablespace = saib;

--
-- TOC entry 2110 (class 2606 OID 32753)
-- Dependencies: 1678 1678
-- Name: auditoria_transacciones_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

ALTER TABLE ONLY auditoria_transacciones
    ADD CONSTRAINT auditoria_transacciones_pkey PRIMARY KEY (id_aud_tra);


SET default_tablespace = '';

--
-- TOC entry 2113 (class 2606 OID 32755)
-- Dependencies: 1680 1680
-- Name: categorias__cuerpos_micosis_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY categorias__cuerpos_micosis
    ADD CONSTRAINT categorias__cuerpos_micosis_pkey PRIMARY KEY (id_cat_cue_mic);


--
-- TOC entry 2115 (class 2606 OID 32757)
-- Dependencies: 1680 1680 1680
-- Name: categorias__cuerpos_micosis_unique; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY categorias__cuerpos_micosis
    ADD CONSTRAINT categorias__cuerpos_micosis_unique UNIQUE (id_cat_cue, id_tip_mic);


--
-- TOC entry 2120 (class 2606 OID 32759)
-- Dependencies: 1683 1683 1683
-- Name: categorias_cuerpos__lesiones_unique; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY categorias_cuerpos__lesiones
    ADD CONSTRAINT categorias_cuerpos__lesiones_unique UNIQUE (id_les, id_cat_cue);


--
-- TOC entry 2118 (class 2606 OID 32761)
-- Dependencies: 1682 1682
-- Name: categorias_cuerpos_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY categorias_cuerpos
    ADD CONSTRAINT categorias_cuerpos_pkey PRIMARY KEY (id_cat_cue);


--
-- TOC entry 2126 (class 2606 OID 32763)
-- Dependencies: 1685 1685
-- Name: centro_salud_doctores_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY centro_salud_doctores
    ADD CONSTRAINT centro_salud_doctores_pkey PRIMARY KEY (id_cen_sal_doc);


--
-- TOC entry 2128 (class 2606 OID 32765)
-- Dependencies: 1685 1685 1685
-- Name: centro_salud_doctores_unique; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY centro_salud_doctores
    ADD CONSTRAINT centro_salud_doctores_unique UNIQUE (id_doc, id_cen_sal);


--
-- TOC entry 2134 (class 2606 OID 32767)
-- Dependencies: 1689 1689
-- Name: centro_salud_pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY centro_salud_pacientes
    ADD CONSTRAINT centro_salud_pacientes_pkey PRIMARY KEY (id_cen_sal_pac);


--
-- TOC entry 2136 (class 2606 OID 32769)
-- Dependencies: 1689 1689 1689
-- Name: centro_salud_pacientes_unique; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY centro_salud_pacientes
    ADD CONSTRAINT centro_salud_pacientes_unique UNIQUE (id_his, id_cen_sal);


--
-- TOC entry 2131 (class 2606 OID 32771)
-- Dependencies: 1687 1687
-- Name: centro_salud_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY centro_saluds
    ADD CONSTRAINT centro_salud_pkey PRIMARY KEY (id_cen_sal);


--
-- TOC entry 2139 (class 2606 OID 32773)
-- Dependencies: 1691 1691
-- Name: contactos_animales_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY contactos_animales
    ADD CONSTRAINT contactos_animales_pkey PRIMARY KEY (id_con_ani);


--
-- TOC entry 2141 (class 2606 OID 32775)
-- Dependencies: 1691 1691 1691
-- Name: contactos_animales_unique; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY contactos_animales
    ADD CONSTRAINT contactos_animales_unique UNIQUE (id_his, id_ani);


--
-- TOC entry 2143 (class 2606 OID 32777)
-- Dependencies: 1693 1693
-- Name: doctores_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY doctores
    ADD CONSTRAINT doctores_pkey PRIMARY KEY (id_doc);


--
-- TOC entry 2146 (class 2606 OID 32779)
-- Dependencies: 1695 1695
-- Name: enfermedades_micologicas_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY enfermedades_micologicas
    ADD CONSTRAINT enfermedades_micologicas_pkey PRIMARY KEY (id_enf_mic);


--
-- TOC entry 2148 (class 2606 OID 32781)
-- Dependencies: 1697 1697
-- Name: enfermedades_pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY enfermedades_pacientes
    ADD CONSTRAINT enfermedades_pacientes_pkey PRIMARY KEY (id_enf_pac);


--
-- TOC entry 2150 (class 2606 OID 32783)
-- Dependencies: 1697 1697 1697
-- Name: enfermedades_pacientes_unique; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY enfermedades_pacientes
    ADD CONSTRAINT enfermedades_pacientes_unique UNIQUE (id_enf_mic, id_tip_mic_pac);


--
-- TOC entry 2152 (class 2606 OID 32785)
-- Dependencies: 1699 1699
-- Name: estados_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY estados
    ADD CONSTRAINT estados_pkey PRIMARY KEY (id_est);


--
-- TOC entry 2154 (class 2606 OID 32787)
-- Dependencies: 1701 1701
-- Name: examenes_pacientes_pk; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY examenes_pacientes
    ADD CONSTRAINT examenes_pacientes_pk PRIMARY KEY (id_exa_pac);


--
-- TOC entry 2156 (class 2606 OID 32789)
-- Dependencies: 1701 1701 1701
-- Name: examenes_pacientes_unique; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY examenes_pacientes
    ADD CONSTRAINT examenes_pacientes_unique UNIQUE (id_tip_mic_pac, id_tip_exa);


--
-- TOC entry 2162 (class 2606 OID 32791)
-- Dependencies: 1704 1704
-- Name: forma_infecciones__pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY forma_infecciones__pacientes
    ADD CONSTRAINT forma_infecciones__pacientes_pkey PRIMARY KEY (id_for_pac);


--
-- TOC entry 2164 (class 2606 OID 32793)
-- Dependencies: 1704 1704 1704
-- Name: forma_infecciones__pacientes_unique; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY forma_infecciones__pacientes
    ADD CONSTRAINT forma_infecciones__pacientes_unique UNIQUE (id_for_inf, id_tip_mic_pac);


--
-- TOC entry 2167 (class 2606 OID 32795)
-- Dependencies: 1706 1706
-- Name: forma_infecciones__tipos_micosis_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY forma_infecciones__tipos_micosis
    ADD CONSTRAINT forma_infecciones__tipos_micosis_pkey PRIMARY KEY (id_for_inf_tip_mic);


--
-- TOC entry 2169 (class 2606 OID 32797)
-- Dependencies: 1706 1706 1706
-- Name: forma_infecciones__tipos_micosis_unique; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY forma_infecciones__tipos_micosis
    ADD CONSTRAINT forma_infecciones__tipos_micosis_unique UNIQUE (id_tip_mic, id_for_inf);


--
-- TOC entry 2159 (class 2606 OID 32799)
-- Dependencies: 1703 1703
-- Name: forma_infecciones_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY forma_infecciones
    ADD CONSTRAINT forma_infecciones_pkey PRIMARY KEY (id_for_inf);


--
-- TOC entry 2172 (class 2606 OID 32801)
-- Dependencies: 1709 1709
-- Name: historiales_pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY historiales_pacientes
    ADD CONSTRAINT historiales_pacientes_pkey PRIMARY KEY (id_his);


--
-- TOC entry 2123 (class 2606 OID 32803)
-- Dependencies: 1683 1683
-- Name: lesiones__partes_cuerpos_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY categorias_cuerpos__lesiones
    ADD CONSTRAINT lesiones__partes_cuerpos_pkey PRIMARY KEY (id_cat_cue_les);


--
-- TOC entry 2174 (class 2606 OID 32805)
-- Dependencies: 1711 1711
-- Name: lesiones_id_les_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY lesiones
    ADD CONSTRAINT lesiones_id_les_pkey PRIMARY KEY (id_les);


--
-- TOC entry 2177 (class 2606 OID 32807)
-- Dependencies: 1714 1714
-- Name: lesiones_partes_cuerpos__pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY lesiones_partes_cuerpos__pacientes
    ADD CONSTRAINT lesiones_partes_cuerpos__pacientes_pkey PRIMARY KEY (id_les_par_cue_pac);


--
-- TOC entry 2179 (class 2606 OID 32809)
-- Dependencies: 1714 1714 1714 1714
-- Name: lesiones_partes_cuerpos__pacientes_unique; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY lesiones_partes_cuerpos__pacientes
    ADD CONSTRAINT lesiones_partes_cuerpos__pacientes_unique UNIQUE (id_cat_cue_les, id_par_cue_cat_cue, id_tip_mic_pac);


--
-- TOC entry 2182 (class 2606 OID 32811)
-- Dependencies: 1716 1716
-- Name: localizaciones_cuerpos_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY localizaciones_cuerpos
    ADD CONSTRAINT localizaciones_cuerpos_pkey PRIMARY KEY (id_loc_cue);


--
-- TOC entry 2184 (class 2606 OID 32813)
-- Dependencies: 1718 1718 1718
-- Name: modulos_cod_mod_unique; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY modulos
    ADD CONSTRAINT modulos_cod_mod_unique UNIQUE (cod_mod, id_tip_usu);


--
-- TOC entry 2186 (class 2606 OID 32815)
-- Dependencies: 1718 1718
-- Name: modulos_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY modulos
    ADD CONSTRAINT modulos_pkey PRIMARY KEY (id_mod);


--
-- TOC entry 2189 (class 2606 OID 32817)
-- Dependencies: 1720 1720
-- Name: muestras_clinicas_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY muestras_clinicas
    ADD CONSTRAINT muestras_clinicas_pkey PRIMARY KEY (id_mue_cli);


--
-- TOC entry 2191 (class 2606 OID 32819)
-- Dependencies: 1722 1722
-- Name: muestras_pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY muestras_pacientes
    ADD CONSTRAINT muestras_pacientes_pkey PRIMARY KEY (id_mue_pac);


--
-- TOC entry 2193 (class 2606 OID 32821)
-- Dependencies: 1722 1722 1722
-- Name: muestras_pacientes_unique; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY muestras_pacientes
    ADD CONSTRAINT muestras_pacientes_unique UNIQUE (id_his, id_mue_cli);


--
-- TOC entry 2195 (class 2606 OID 32823)
-- Dependencies: 1724 1724
-- Name: municipios_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY municipios
    ADD CONSTRAINT municipios_pkey PRIMARY KEY (id_mun);


--
-- TOC entry 2198 (class 2606 OID 32825)
-- Dependencies: 1726 1726
-- Name: pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY pacientes
    ADD CONSTRAINT pacientes_pkey PRIMARY KEY (id_pac);


--
-- TOC entry 2200 (class 2606 OID 32827)
-- Dependencies: 1728 1728
-- Name: paises_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY paises
    ADD CONSTRAINT paises_pkey PRIMARY KEY (id_pai);


--
-- TOC entry 2202 (class 2606 OID 32829)
-- Dependencies: 1730 1730
-- Name: parroquias_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY parroquias
    ADD CONSTRAINT parroquias_pkey PRIMARY KEY (id_par);


--
-- TOC entry 2207 (class 2606 OID 32831)
-- Dependencies: 1733 1733
-- Name: partes_cuerpos__categorias_cuerpos_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY partes_cuerpos__categorias_cuerpos
    ADD CONSTRAINT partes_cuerpos__categorias_cuerpos_pkey PRIMARY KEY (id_par_cue_cat_cue);


--
-- TOC entry 2209 (class 2606 OID 32833)
-- Dependencies: 1733 1733 1733
-- Name: partes_cuerpos__categorias_cuerpos_unique; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY partes_cuerpos__categorias_cuerpos
    ADD CONSTRAINT partes_cuerpos__categorias_cuerpos_unique UNIQUE (id_cat_cue, id_par_cue);


--
-- TOC entry 2205 (class 2606 OID 32835)
-- Dependencies: 1732 1732
-- Name: partes_cuerpos_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY partes_cuerpos
    ADD CONSTRAINT partes_cuerpos_pkey PRIMARY KEY (id_par_cue);


--
-- TOC entry 2211 (class 2606 OID 32837)
-- Dependencies: 1736 1736
-- Name: tiempo_evoluciones_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY tiempo_evoluciones
    ADD CONSTRAINT tiempo_evoluciones_pkey PRIMARY KEY (id_tie_evo);


--
-- TOC entry 2217 (class 2606 OID 32839)
-- Dependencies: 1740 1740
-- Name: tipos_consultas_pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY tipos_consultas_pacientes
    ADD CONSTRAINT tipos_consultas_pacientes_pkey PRIMARY KEY (id_tip_con_pac);


--
-- TOC entry 2219 (class 2606 OID 32841)
-- Dependencies: 1740 1740 1740
-- Name: tipos_consultas_pacientes_unique; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY tipos_consultas_pacientes
    ADD CONSTRAINT tipos_consultas_pacientes_unique UNIQUE (id_tip_con, id_his);


--
-- TOC entry 2214 (class 2606 OID 32843)
-- Dependencies: 1738 1738
-- Name: tipos_consultas_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY tipos_consultas
    ADD CONSTRAINT tipos_consultas_pkey PRIMARY KEY (id_tip_con);


--
-- TOC entry 2222 (class 2606 OID 32845)
-- Dependencies: 1742 1742
-- Name: tipos_estudios_micologicos_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY tipos_estudios_micologicos
    ADD CONSTRAINT tipos_estudios_micologicos_pkey PRIMARY KEY (id_tip_est_mic);


--
-- TOC entry 2224 (class 2606 OID 32847)
-- Dependencies: 1744 1744
-- Name: tipos_examenes_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY tipos_examenes
    ADD CONSTRAINT tipos_examenes_pkey PRIMARY KEY (id_tip_exa);


--
-- TOC entry 2233 (class 2606 OID 32849)
-- Dependencies: 1749 1749
-- Name: tipos_micosis_pacientes__tipos_estudios_micologicos_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY tipos_micosis_pacientes__tipos_estudios_micologicos
    ADD CONSTRAINT tipos_micosis_pacientes__tipos_estudios_micologicos_pkey PRIMARY KEY (id_tip_mic_pac_tip_est_mic);


--
-- TOC entry 2235 (class 2606 OID 32851)
-- Dependencies: 1749 1749 1749
-- Name: tipos_micosis_pacientes__tipos_estudios_micologicos_unique; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY tipos_micosis_pacientes__tipos_estudios_micologicos
    ADD CONSTRAINT tipos_micosis_pacientes__tipos_estudios_micologicos_unique UNIQUE (id_tip_mic_pac, id_tip_est_mic);


--
-- TOC entry 2229 (class 2606 OID 32853)
-- Dependencies: 1748 1748
-- Name: tipos_micosis_pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY tipos_micosis_pacientes
    ADD CONSTRAINT tipos_micosis_pacientes_pkey PRIMARY KEY (id_tip_mic_pac);


--
-- TOC entry 2231 (class 2606 OID 32855)
-- Dependencies: 1748 1748 1748
-- Name: tipos_micosis_pacientes_unique; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY tipos_micosis_pacientes
    ADD CONSTRAINT tipos_micosis_pacientes_unique UNIQUE (id_tip_mic, id_his);


--
-- TOC entry 2227 (class 2606 OID 32857)
-- Dependencies: 1746 1746
-- Name: tipos_micosis_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY tipos_micosis
    ADD CONSTRAINT tipos_micosis_pkey PRIMARY KEY (id_tip_mic);


--
-- TOC entry 2241 (class 2606 OID 32859)
-- Dependencies: 1753 1753
-- Name: tipos_usuarios__usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY tipos_usuarios__usuarios
    ADD CONSTRAINT tipos_usuarios__usuarios_pkey PRIMARY KEY (id_tip_usu_usu);


--
-- TOC entry 2237 (class 2606 OID 32861)
-- Dependencies: 1752 1752
-- Name: tipos_usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY tipos_usuarios
    ADD CONSTRAINT tipos_usuarios_pkey PRIMARY KEY (id_tip_usu);


SET default_tablespace = saib;

--
-- TOC entry 2239 (class 2606 OID 32863)
-- Dependencies: 1752 1752
-- Name: tipos_usuarios_unique; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

ALTER TABLE ONLY tipos_usuarios
    ADD CONSTRAINT tipos_usuarios_unique UNIQUE (cod_tip_usu);


SET default_tablespace = '';

--
-- TOC entry 2245 (class 2606 OID 32865)
-- Dependencies: 1756 1756 1756
-- Name: transacciones_cod_tip_tra__id_mod; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY transacciones
    ADD CONSTRAINT transacciones_cod_tip_tra__id_mod UNIQUE (id_mod, cod_tip_tra);


--
-- TOC entry 2247 (class 2606 OID 32867)
-- Dependencies: 1756 1756
-- Name: transacciones_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY transacciones
    ADD CONSTRAINT transacciones_pkey PRIMARY KEY (id_tip_tra);


--
-- TOC entry 2249 (class 2606 OID 32869)
-- Dependencies: 1758 1758
-- Name: transacciones_usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY transacciones_usuarios
    ADD CONSTRAINT transacciones_usuarios_pkey PRIMARY KEY (id_tra_usu);


--
-- TOC entry 2255 (class 2606 OID 32871)
-- Dependencies: 1762 1762
-- Name: tratamientos_pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY tratamientos_pacientes
    ADD CONSTRAINT tratamientos_pacientes_pkey PRIMARY KEY (id_tra_pac);


--
-- TOC entry 2257 (class 2606 OID 32873)
-- Dependencies: 1762 1762 1762
-- Name: tratamientos_pacientes_unique; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY tratamientos_pacientes
    ADD CONSTRAINT tratamientos_pacientes_unique UNIQUE (id_his, id_tra);


--
-- TOC entry 2252 (class 2606 OID 32875)
-- Dependencies: 1760 1760
-- Name: tratamientos_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY tratamientos
    ADD CONSTRAINT tratamientos_pkey PRIMARY KEY (id_tra);


--
-- TOC entry 2243 (class 2606 OID 32877)
-- Dependencies: 1753 1753 1753 1753
-- Name: unique_tipos_usuarios__usuarios; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY tipos_usuarios__usuarios
    ADD CONSTRAINT unique_tipos_usuarios__usuarios UNIQUE (id_doc, id_usu_adm, id_tip_usu);


--
-- TOC entry 2259 (class 2606 OID 32879)
-- Dependencies: 1764 1764
-- Name: usuarios_administrativos_log_usu_adm_unique; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY usuarios_administrativos
    ADD CONSTRAINT usuarios_administrativos_log_usu_adm_unique UNIQUE (log_usu_adm);


SET default_tablespace = saib;

--
-- TOC entry 2261 (class 2606 OID 32881)
-- Dependencies: 1764 1764
-- Name: usuarios_administrativos_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

ALTER TABLE ONLY usuarios_administrativos
    ADD CONSTRAINT usuarios_administrativos_pkey PRIMARY KEY (id_usu_adm);


SET search_path = saib_model, pg_catalog;

SET default_tablespace = '';

--
-- TOC entry 2263 (class 2606 OID 32883)
-- Dependencies: 1768 1768
-- Name: wwwsqldesigner_pkey; Type: CONSTRAINT; Schema: saib_model; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY wwwsqldesigner
    ADD CONSTRAINT wwwsqldesigner_pkey PRIMARY KEY (keyword);


SET search_path = public, pg_catalog;

SET default_tablespace = saib;

--
-- TOC entry 2101 (class 1259 OID 32884)
-- Dependencies: 1672
-- Name: animales_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX animales_index ON animales USING btree (id_ani);


--
-- TOC entry 2106 (class 1259 OID 32885)
-- Dependencies: 1676
-- Name: antecedentes_personales_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX antecedentes_personales_index ON antecedentes_personales USING btree (id_ant_per);


--
-- TOC entry 2111 (class 1259 OID 32886)
-- Dependencies: 1680
-- Name: categorias__cuerpos_micosis_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX categorias__cuerpos_micosis_index ON categorias__cuerpos_micosis USING btree (id_cat_cue_mic);


--
-- TOC entry 2116 (class 1259 OID 32887)
-- Dependencies: 1682
-- Name: categorias_cuerpos_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX categorias_cuerpos_index ON categorias_cuerpos USING btree (id_cat_cue);


SET default_tablespace = '';

--
-- TOC entry 2124 (class 1259 OID 32888)
-- Dependencies: 1685 1685 1685
-- Name: centro_salud_doctores_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: 
--

CREATE INDEX centro_salud_doctores_index ON centro_salud_doctores USING btree (id_cen_sal_doc, id_doc, id_cen_sal);


SET default_tablespace = saib;

--
-- TOC entry 2129 (class 1259 OID 32889)
-- Dependencies: 1687
-- Name: centro_salud_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX centro_salud_index ON centro_saluds USING btree (id_cen_sal);


--
-- TOC entry 2132 (class 1259 OID 32890)
-- Dependencies: 1689 1689 1689
-- Name: centro_salud_pacientes_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX centro_salud_pacientes_index ON centro_salud_pacientes USING btree (id_cen_sal_pac, id_his, id_cen_sal);


--
-- TOC entry 2137 (class 1259 OID 32891)
-- Dependencies: 1691 1691 1691
-- Name: contactos_animales_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX contactos_animales_index ON contactos_animales USING btree (id_con_ani, id_his, id_ani);


--
-- TOC entry 2144 (class 1259 OID 32892)
-- Dependencies: 1695
-- Name: enfermedades_micologicas_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX enfermedades_micologicas_index ON enfermedades_micologicas USING btree (id_enf_mic);


--
-- TOC entry 2160 (class 1259 OID 32893)
-- Dependencies: 1704
-- Name: forma_infecciones__pacientes_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX forma_infecciones__pacientes_index ON forma_infecciones__pacientes USING btree (id_for_pac);


--
-- TOC entry 2165 (class 1259 OID 32894)
-- Dependencies: 1706
-- Name: forma_infecciones__tipos_micosis_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX forma_infecciones__tipos_micosis_index ON forma_infecciones__tipos_micosis USING btree (id_for_inf_tip_mic);


--
-- TOC entry 2157 (class 1259 OID 32895)
-- Dependencies: 1703
-- Name: forma_infecciones_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX forma_infecciones_index ON forma_infecciones USING btree (id_for_inf);


--
-- TOC entry 2170 (class 1259 OID 32896)
-- Dependencies: 1709
-- Name: historiales_pacientes_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX historiales_pacientes_index ON historiales_pacientes USING btree (id_his);


--
-- TOC entry 2121 (class 1259 OID 32897)
-- Dependencies: 1683
-- Name: lesiones__partes_cuerpos_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX lesiones__partes_cuerpos_index ON categorias_cuerpos__lesiones USING btree (id_cat_cue_les);


--
-- TOC entry 2175 (class 1259 OID 32898)
-- Dependencies: 1714
-- Name: lesiones_partes_cuerpos__pacientes_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX lesiones_partes_cuerpos__pacientes_index ON lesiones_partes_cuerpos__pacientes USING btree (id_les_par_cue_pac);


--
-- TOC entry 2180 (class 1259 OID 32899)
-- Dependencies: 1716
-- Name: localizaciones_cuerpos_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX localizaciones_cuerpos_index ON localizaciones_cuerpos USING btree (id_loc_cue);


--
-- TOC entry 2187 (class 1259 OID 32900)
-- Dependencies: 1720
-- Name: muestras_clinicas_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX muestras_clinicas_index ON muestras_clinicas USING btree (id_mue_cli);


--
-- TOC entry 2196 (class 1259 OID 32901)
-- Dependencies: 1726
-- Name: pacientes_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX pacientes_index ON pacientes USING btree (id_pac);


--
-- TOC entry 2203 (class 1259 OID 32902)
-- Dependencies: 1732
-- Name: partes_cuerpos_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX partes_cuerpos_index ON partes_cuerpos USING btree (id_par_cue);


--
-- TOC entry 2212 (class 1259 OID 32903)
-- Dependencies: 1738
-- Name: tipos_consultas_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX tipos_consultas_index ON tipos_consultas USING btree (id_tip_con);


--
-- TOC entry 2215 (class 1259 OID 32904)
-- Dependencies: 1740 1740 1740
-- Name: tipos_consultas_pacientes_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX tipos_consultas_pacientes_index ON tipos_consultas_pacientes USING btree (id_tip_con_pac, id_tip_con, id_his);


--
-- TOC entry 2220 (class 1259 OID 32905)
-- Dependencies: 1742
-- Name: tipos_estudios_micologicos_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX tipos_estudios_micologicos_index ON tipos_estudios_micologicos USING btree (id_tip_est_mic);


--
-- TOC entry 2225 (class 1259 OID 32906)
-- Dependencies: 1746
-- Name: tipos_micosis_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX tipos_micosis_index ON tipos_micosis USING btree (id_tip_mic);


--
-- TOC entry 2250 (class 1259 OID 32907)
-- Dependencies: 1760
-- Name: tratamientos_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX tratamientos_index ON tratamientos USING btree (id_tra);


--
-- TOC entry 2253 (class 1259 OID 32908)
-- Dependencies: 1762 1762 1762
-- Name: tratamientos_pacientes_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX tratamientos_pacientes_index ON tratamientos_pacientes USING btree (id_tra_pac, id_his, id_tra);


--
-- TOC entry 2264 (class 2606 OID 32909)
-- Dependencies: 2107 1676 1674
-- Name: antecedentes_pacientes_id_ant_per_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY antecedentes_pacientes
    ADD CONSTRAINT antecedentes_pacientes_id_ant_per_fkey FOREIGN KEY (id_ant_per) REFERENCES antecedentes_personales(id_ant_per) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2265 (class 2606 OID 32914)
-- Dependencies: 2197 1726 1674
-- Name: antecedentes_pacientes_id_pac_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY antecedentes_pacientes
    ADD CONSTRAINT antecedentes_pacientes_id_pac_fkey FOREIGN KEY (id_pac) REFERENCES pacientes(id_pac) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2266 (class 2606 OID 32919)
-- Dependencies: 1678 1756 2246
-- Name: auditoria_transacciones_id_tip_tra_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY auditoria_transacciones
    ADD CONSTRAINT auditoria_transacciones_id_tip_tra_fkey FOREIGN KEY (id_tip_tra) REFERENCES transacciones(id_tip_tra) ON UPDATE CASCADE;


--
-- TOC entry 2267 (class 2606 OID 32924)
-- Dependencies: 2240 1753 1678
-- Name: auditoria_transacciones_id_tip_usu_usu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY auditoria_transacciones
    ADD CONSTRAINT auditoria_transacciones_id_tip_usu_usu_fkey FOREIGN KEY (id_tip_usu_usu) REFERENCES tipos_usuarios__usuarios(id_tip_usu_usu) ON UPDATE CASCADE;


--
-- TOC entry 2270 (class 2606 OID 32929)
-- Dependencies: 1682 1683 2117
-- Name: categoria_cuerpos__partes_cuerpos_id_cat_cue_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY categorias_cuerpos__lesiones
    ADD CONSTRAINT categoria_cuerpos__partes_cuerpos_id_cat_cue_fkey FOREIGN KEY (id_cat_cue) REFERENCES categorias_cuerpos(id_cat_cue) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2268 (class 2606 OID 32934)
-- Dependencies: 1682 2117 1680
-- Name: categorias__cuerpos_micosis_id_cat_cue_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY categorias__cuerpos_micosis
    ADD CONSTRAINT categorias__cuerpos_micosis_id_cat_cue_fkey FOREIGN KEY (id_cat_cue) REFERENCES categorias_cuerpos(id_cat_cue) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2269 (class 2606 OID 32939)
-- Dependencies: 1680 1746 2226
-- Name: categorias__cuerpos_micosis_id_tip_mic_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY categorias__cuerpos_micosis
    ADD CONSTRAINT categorias__cuerpos_micosis_id_tip_mic_fkey FOREIGN KEY (id_tip_mic) REFERENCES tipos_micosis(id_tip_mic) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2272 (class 2606 OID 32944)
-- Dependencies: 1687 2130 1685
-- Name: centro_salud_doctores_id_cen_sal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY centro_salud_doctores
    ADD CONSTRAINT centro_salud_doctores_id_cen_sal_fkey FOREIGN KEY (id_cen_sal) REFERENCES centro_saluds(id_cen_sal) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2273 (class 2606 OID 32949)
-- Dependencies: 1693 2142 1685
-- Name: centro_salud_doctores_id_doc_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY centro_salud_doctores
    ADD CONSTRAINT centro_salud_doctores_id_doc_fkey FOREIGN KEY (id_doc) REFERENCES doctores(id_doc) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2274 (class 2606 OID 32954)
-- Dependencies: 1687 2130 1689
-- Name: centro_salud_pacientes_id_cen_sal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY centro_salud_pacientes
    ADD CONSTRAINT centro_salud_pacientes_id_cen_sal_fkey FOREIGN KEY (id_cen_sal) REFERENCES centro_saluds(id_cen_sal) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2275 (class 2606 OID 32959)
-- Dependencies: 1689 1709 2171
-- Name: centro_salud_pacientes_id_his_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY centro_salud_pacientes
    ADD CONSTRAINT centro_salud_pacientes_id_his_fkey FOREIGN KEY (id_his) REFERENCES historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2276 (class 2606 OID 32964)
-- Dependencies: 2102 1691 1672
-- Name: contactos_animales_id_ani_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY contactos_animales
    ADD CONSTRAINT contactos_animales_id_ani_fkey FOREIGN KEY (id_ani) REFERENCES animales(id_ani) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2277 (class 2606 OID 32969)
-- Dependencies: 2171 1709 1691
-- Name: contactos_animales_id_his_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY contactos_animales
    ADD CONSTRAINT contactos_animales_id_his_fkey FOREIGN KEY (id_his) REFERENCES historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2278 (class 2606 OID 32974)
-- Dependencies: 1746 2226 1695
-- Name: enfermedades_micologicas_id_tip_mic_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY enfermedades_micologicas
    ADD CONSTRAINT enfermedades_micologicas_id_tip_mic_fkey FOREIGN KEY (id_tip_mic) REFERENCES tipos_micosis(id_tip_mic) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2279 (class 2606 OID 32979)
-- Dependencies: 1695 2145 1697
-- Name: enfermedades_pacientes_id_enf_mic_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY enfermedades_pacientes
    ADD CONSTRAINT enfermedades_pacientes_id_enf_mic_fkey FOREIGN KEY (id_enf_mic) REFERENCES enfermedades_micologicas(id_enf_mic) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2280 (class 2606 OID 32984)
-- Dependencies: 1748 2228 1697
-- Name: enfermedades_pacientes_id_tip_enf_pac_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY enfermedades_pacientes
    ADD CONSTRAINT enfermedades_pacientes_id_tip_enf_pac_fkey FOREIGN KEY (id_tip_mic_pac) REFERENCES tipos_micosis_pacientes(id_tip_mic_pac) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2281 (class 2606 OID 32989)
-- Dependencies: 1699 1728 2199
-- Name: estados_id_pai_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY estados
    ADD CONSTRAINT estados_id_pai_fkey FOREIGN KEY (id_pai) REFERENCES paises(id_pai) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2282 (class 2606 OID 32994)
-- Dependencies: 1701 1744 2223
-- Name: examenes_pacientes__id_tip_exa_fk; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY examenes_pacientes
    ADD CONSTRAINT examenes_pacientes__id_tip_exa_fk FOREIGN KEY (id_tip_exa) REFERENCES tipos_examenes(id_tip_exa) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2284 (class 2606 OID 32999)
-- Dependencies: 1704 2158 1703
-- Name: forma_infecciones__pacientes_id_for_inf_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY forma_infecciones__pacientes
    ADD CONSTRAINT forma_infecciones__pacientes_id_for_inf_fkey FOREIGN KEY (id_for_inf) REFERENCES forma_infecciones(id_for_inf) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2285 (class 2606 OID 33004)
-- Dependencies: 1748 1704 2228
-- Name: forma_infecciones__pacientes_id_tip_mic_pac_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY forma_infecciones__pacientes
    ADD CONSTRAINT forma_infecciones__pacientes_id_tip_mic_pac_fkey FOREIGN KEY (id_tip_mic_pac) REFERENCES tipos_micosis_pacientes(id_tip_mic_pac) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2286 (class 2606 OID 33009)
-- Dependencies: 1706 1703 2158
-- Name: forma_infecciones__tipos_micosis_id_for_inf_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY forma_infecciones__tipos_micosis
    ADD CONSTRAINT forma_infecciones__tipos_micosis_id_for_inf_fkey FOREIGN KEY (id_for_inf) REFERENCES forma_infecciones(id_for_inf) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2287 (class 2606 OID 33014)
-- Dependencies: 1706 1746 2226
-- Name: forma_infecciones__tipos_micosis_id_tip_mic_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY forma_infecciones__tipos_micosis
    ADD CONSTRAINT forma_infecciones__tipos_micosis_id_tip_mic_fkey FOREIGN KEY (id_tip_mic) REFERENCES tipos_micosis(id_tip_mic) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2288 (class 2606 OID 33019)
-- Dependencies: 1709 1693 2142
-- Name: historiales_pacientes_id_doc_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY historiales_pacientes
    ADD CONSTRAINT historiales_pacientes_id_doc_fkey FOREIGN KEY (id_doc) REFERENCES doctores(id_doc) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2289 (class 2606 OID 33024)
-- Dependencies: 1709 1726 2197
-- Name: historiales_pacientes_id_pac_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY historiales_pacientes
    ADD CONSTRAINT historiales_pacientes_id_pac_fkey FOREIGN KEY (id_pac) REFERENCES pacientes(id_pac) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2271 (class 2606 OID 33029)
-- Dependencies: 1683 1711 2173
-- Name: lesiones__partes_cuerpos_id_les_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY categorias_cuerpos__lesiones
    ADD CONSTRAINT lesiones__partes_cuerpos_id_les_fkey FOREIGN KEY (id_les) REFERENCES lesiones(id_les) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2290 (class 2606 OID 33034)
-- Dependencies: 1714 1683 2122
-- Name: lesiones_partes_cuerpos__pacientes_id_cat_cue_les_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY lesiones_partes_cuerpos__pacientes
    ADD CONSTRAINT lesiones_partes_cuerpos__pacientes_id_cat_cue_les_fkey FOREIGN KEY (id_cat_cue_les) REFERENCES categorias_cuerpos__lesiones(id_cat_cue_les) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2291 (class 2606 OID 33039)
-- Dependencies: 1714 1733 2206
-- Name: lesiones_partes_cuerpos__pacientes_id_par_cue_cat_cue_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY lesiones_partes_cuerpos__pacientes
    ADD CONSTRAINT lesiones_partes_cuerpos__pacientes_id_par_cue_cat_cue_fkey FOREIGN KEY (id_par_cue_cat_cue) REFERENCES partes_cuerpos__categorias_cuerpos(id_par_cue_cat_cue) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2292 (class 2606 OID 33044)
-- Dependencies: 1714 1748 2228
-- Name: lesiones_partes_cuerpos__pacientes_id_tip_mic_pac_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY lesiones_partes_cuerpos__pacientes
    ADD CONSTRAINT lesiones_partes_cuerpos__pacientes_id_tip_mic_pac_fkey FOREIGN KEY (id_tip_mic_pac) REFERENCES tipos_micosis_pacientes(id_tip_mic_pac) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2293 (class 2606 OID 33049)
-- Dependencies: 1716 2204 1732
-- Name: localizaciones_cuerpos_id_par_cue_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY localizaciones_cuerpos
    ADD CONSTRAINT localizaciones_cuerpos_id_par_cue_fkey FOREIGN KEY (id_par_cue) REFERENCES partes_cuerpos(id_par_cue) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2294 (class 2606 OID 33054)
-- Dependencies: 1752 1718 2236
-- Name: modulos_id_tip_usu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY modulos
    ADD CONSTRAINT modulos_id_tip_usu_fkey FOREIGN KEY (id_tip_usu) REFERENCES tipos_usuarios(id_tip_usu) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2295 (class 2606 OID 33059)
-- Dependencies: 2171 1709 1722
-- Name: muestras_pacientes_id_his_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY muestras_pacientes
    ADD CONSTRAINT muestras_pacientes_id_his_fkey FOREIGN KEY (id_his) REFERENCES historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2296 (class 2606 OID 33064)
-- Dependencies: 2188 1722 1720
-- Name: muestras_pacientes_id_mue_cli_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY muestras_pacientes
    ADD CONSTRAINT muestras_pacientes_id_mue_cli_fkey FOREIGN KEY (id_mue_cli) REFERENCES muestras_clinicas(id_mue_cli) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2297 (class 2606 OID 33069)
-- Dependencies: 2151 1724 1699
-- Name: municipios_id_est_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY municipios
    ADD CONSTRAINT municipios_id_est_fkey FOREIGN KEY (id_est) REFERENCES estados(id_est) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2298 (class 2606 OID 33074)
-- Dependencies: 1726 1693 2142
-- Name: pacientes_id_doc_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY pacientes
    ADD CONSTRAINT pacientes_id_doc_fkey FOREIGN KEY (id_doc) REFERENCES doctores(id_doc) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2299 (class 2606 OID 33079)
-- Dependencies: 1699 2151 1726
-- Name: pacientes_id_est_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY pacientes
    ADD CONSTRAINT pacientes_id_est_fkey FOREIGN KEY (id_est) REFERENCES estados(id_est) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2300 (class 2606 OID 33084)
-- Dependencies: 1724 2194 1726
-- Name: pacientes_id_mun_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY pacientes
    ADD CONSTRAINT pacientes_id_mun_fkey FOREIGN KEY (id_mun) REFERENCES municipios(id_mun) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2301 (class 2606 OID 33089)
-- Dependencies: 2199 1726 1728
-- Name: pacientes_id_pai_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY pacientes
    ADD CONSTRAINT pacientes_id_pai_fkey FOREIGN KEY (id_pai) REFERENCES paises(id_pai) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2302 (class 2606 OID 33094)
-- Dependencies: 1726 1730 2201
-- Name: pacientes_id_par_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY pacientes
    ADD CONSTRAINT pacientes_id_par_fkey FOREIGN KEY (id_par) REFERENCES parroquias(id_par) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2303 (class 2606 OID 33099)
-- Dependencies: 2194 1730 1724
-- Name: parroquias_id_mun_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY parroquias
    ADD CONSTRAINT parroquias_id_mun_fkey FOREIGN KEY (id_mun) REFERENCES municipios(id_mun) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2304 (class 2606 OID 33104)
-- Dependencies: 1682 2117 1733
-- Name: partes_cuerpos__categorias_cuerpos_id_cat_cue_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY partes_cuerpos__categorias_cuerpos
    ADD CONSTRAINT partes_cuerpos__categorias_cuerpos_id_cat_cue_fkey FOREIGN KEY (id_cat_cue) REFERENCES categorias_cuerpos(id_cat_cue) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2305 (class 2606 OID 33109)
-- Dependencies: 1733 1732 2204
-- Name: partes_cuerpos__categorias_cuerpos_id_par_cue_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY partes_cuerpos__categorias_cuerpos
    ADD CONSTRAINT partes_cuerpos__categorias_cuerpos_id_par_cue_fkey FOREIGN KEY (id_par_cue) REFERENCES partes_cuerpos(id_par_cue) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2306 (class 2606 OID 33114)
-- Dependencies: 1736 1709 2171
-- Name: tiempo_evoluciones_id_his_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY tiempo_evoluciones
    ADD CONSTRAINT tiempo_evoluciones_id_his_fkey FOREIGN KEY (id_his) REFERENCES historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2307 (class 2606 OID 33119)
-- Dependencies: 2171 1740 1709
-- Name: tipos_consultas_pacientes_id_his_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY tipos_consultas_pacientes
    ADD CONSTRAINT tipos_consultas_pacientes_id_his_fkey FOREIGN KEY (id_his) REFERENCES historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2308 (class 2606 OID 33124)
-- Dependencies: 1740 2213 1738
-- Name: tipos_consultas_pacientes_id_tip_con_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY tipos_consultas_pacientes
    ADD CONSTRAINT tipos_consultas_pacientes_id_tip_con_fkey FOREIGN KEY (id_tip_con) REFERENCES tipos_consultas(id_tip_con) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2309 (class 2606 OID 33129)
-- Dependencies: 1742 2223 1744
-- Name: tipos_estudios_micologicos_id_tip_exa_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY tipos_estudios_micologicos
    ADD CONSTRAINT tipos_estudios_micologicos_id_tip_exa_fkey FOREIGN KEY (id_tip_exa) REFERENCES tipos_examenes(id_tip_exa) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2310 (class 2606 OID 33134)
-- Dependencies: 1742 2226 1746
-- Name: tipos_estudios_micologicos_id_tip_mic_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY tipos_estudios_micologicos
    ADD CONSTRAINT tipos_estudios_micologicos_id_tip_mic_fkey FOREIGN KEY (id_tip_mic) REFERENCES tipos_micosis(id_tip_mic) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2313 (class 2606 OID 33139)
-- Dependencies: 1749 2221 1742
-- Name: tipos_micosis_pacientes__tipos_estudios_mic_id_tip_est_mic_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY tipos_micosis_pacientes__tipos_estudios_micologicos
    ADD CONSTRAINT tipos_micosis_pacientes__tipos_estudios_mic_id_tip_est_mic_fkey FOREIGN KEY (id_tip_est_mic) REFERENCES tipos_estudios_micologicos(id_tip_est_mic) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2314 (class 2606 OID 33144)
-- Dependencies: 1748 1749 2228
-- Name: tipos_micosis_pacientes__tipos_estudios_mic_id_tip_mic_pac_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY tipos_micosis_pacientes__tipos_estudios_micologicos
    ADD CONSTRAINT tipos_micosis_pacientes__tipos_estudios_mic_id_tip_mic_pac_fkey FOREIGN KEY (id_tip_mic_pac) REFERENCES tipos_micosis_pacientes(id_tip_mic_pac) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2311 (class 2606 OID 33149)
-- Dependencies: 2171 1709 1748
-- Name: tipos_micosis_pacientes_id_his_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY tipos_micosis_pacientes
    ADD CONSTRAINT tipos_micosis_pacientes_id_his_fkey FOREIGN KEY (id_his) REFERENCES historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2312 (class 2606 OID 33154)
-- Dependencies: 2226 1748 1746
-- Name: tipos_micosis_pacientes_id_tip_mic_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY tipos_micosis_pacientes
    ADD CONSTRAINT tipos_micosis_pacientes_id_tip_mic_fkey FOREIGN KEY (id_tip_mic) REFERENCES tipos_micosis(id_tip_mic) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2283 (class 2606 OID 33159)
-- Dependencies: 1701 1748 2228
-- Name: tipos_micosis_pacientes_id_tip_mic_pac; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY examenes_pacientes
    ADD CONSTRAINT tipos_micosis_pacientes_id_tip_mic_pac FOREIGN KEY (id_tip_mic_pac) REFERENCES tipos_micosis_pacientes(id_tip_mic_pac) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2315 (class 2606 OID 33164)
-- Dependencies: 1753 2142 1693
-- Name: tipos_usuarios__usuarios_id_doc_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY tipos_usuarios__usuarios
    ADD CONSTRAINT tipos_usuarios__usuarios_id_doc_fkey FOREIGN KEY (id_doc) REFERENCES doctores(id_doc) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2316 (class 2606 OID 33169)
-- Dependencies: 1753 2236 1752
-- Name: tipos_usuarios__usuarios_id_tip_usu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY tipos_usuarios__usuarios
    ADD CONSTRAINT tipos_usuarios__usuarios_id_tip_usu_fkey FOREIGN KEY (id_tip_usu) REFERENCES tipos_usuarios(id_tip_usu) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2317 (class 2606 OID 33174)
-- Dependencies: 2260 1753 1764
-- Name: tipos_usuarios__usuarios_id_usu_adm_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY tipos_usuarios__usuarios
    ADD CONSTRAINT tipos_usuarios__usuarios_id_usu_adm_fkey FOREIGN KEY (id_usu_adm) REFERENCES usuarios_administrativos(id_usu_adm) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2318 (class 2606 OID 33179)
-- Dependencies: 2185 1756 1718
-- Name: transacciones_id_mod_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY transacciones
    ADD CONSTRAINT transacciones_id_mod_fkey FOREIGN KEY (id_mod) REFERENCES modulos(id_mod) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2319 (class 2606 OID 33184)
-- Dependencies: 1756 2246 1758
-- Name: transacciones_usuarios_id_tip_tra_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY transacciones_usuarios
    ADD CONSTRAINT transacciones_usuarios_id_tip_tra_fkey FOREIGN KEY (id_tip_tra) REFERENCES transacciones(id_tip_tra) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2320 (class 2606 OID 33189)
-- Dependencies: 1753 1758 2240
-- Name: transacciones_usuarios_id_tip_usu_usu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY transacciones_usuarios
    ADD CONSTRAINT transacciones_usuarios_id_tip_usu_usu_fkey FOREIGN KEY (id_tip_usu_usu) REFERENCES tipos_usuarios__usuarios(id_tip_usu_usu) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2321 (class 2606 OID 33194)
-- Dependencies: 1709 1762 2171
-- Name: tratamientos_pacientes_id_his_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY tratamientos_pacientes
    ADD CONSTRAINT tratamientos_pacientes_id_his_fkey FOREIGN KEY (id_his) REFERENCES historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2322 (class 2606 OID 33199)
-- Dependencies: 2251 1762 1760
-- Name: tratamientos_pacientes_id_tra_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY tratamientos_pacientes
    ADD CONSTRAINT tratamientos_pacientes_id_tra_fkey FOREIGN KEY (id_tra) REFERENCES tratamientos(id_tra) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2375 (class 0 OID 0)
-- Dependencies: 7
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2012-01-22 11:42:25

--
-- PostgreSQL database dump complete
--

