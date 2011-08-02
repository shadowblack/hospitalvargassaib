--
-- PostgreSQL database dump
--

-- Dumped from database version 9.0.3
-- Dumped by pg_dump version 9.0.3
-- Started on 2011-08-01 19:44:18

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 457 (class 2612 OID 11574)
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: postgres
--

CREATE OR REPLACE PROCEDURAL LANGUAGE plpgsql;


ALTER PROCEDURAL LANGUAGE plpgsql OWNER TO postgres;

SET search_path = public, pg_catalog;

--
-- TOC entry 346 (class 1247 OID 18821)
-- Dependencies: 6 1735
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
-- TOC entry 2317 (class 0 OID 0)
-- Dependencies: 346
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
-- TOC entry 22 (class 1255 OID 18037)
-- Dependencies: 6 457
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
-- TOC entry 2318 (class 0 OID 0)
-- Dependencies: 22
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
-- TOC entry 25 (class 1255 OID 17896)
-- Dependencies: 457 6
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
-- TOC entry 2319 (class 0 OID 0)
-- Dependencies: 25
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
-- TOC entry 21 (class 1255 OID 18022)
-- Dependencies: 457 6
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
-- TOC entry 2320 (class 0 OID 0)
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
-- TOC entry 23 (class 1255 OID 17895)
-- Dependencies: 6 457
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
-- TOC entry 2321 (class 0 OID 0)
-- Dependencies: 23
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
-- TOC entry 19 (class 1255 OID 18012)
-- Dependencies: 457 6
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
-- TOC entry 2322 (class 0 OID 0)
-- Dependencies: 19
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
-- TOC entry 24 (class 1255 OID 17894)
-- Dependencies: 457 6
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
-- TOC entry 2323 (class 0 OID 0)
-- Dependencies: 24
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
-- TOC entry 18 (class 1255 OID 18866)
-- Dependencies: 457 6
-- Name: med_eliminar_historial(character varying[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION med_eliminar_historial(character varying[]) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$
DECLARE
	
	--Variables
	_data 		ALIAS FOR $1;
	_id_his		historiales_pacientes.id_his%TYPE;
	_id_doc		historiales_pacientes.id_doc%TYPE;

BEGIN
	_id_his := _data[1];
	_id_doc := _data[2];
	
	IF EXISTS(SELECT 1 FROM historiales_pacientes WHERE id_his = _id_his::INTEGER)THEN
		DELETE FROM historiales_pacientes WHERE id_his = _id_his::INTEGER;
		RETURN 1;
	ELSE
		RETURN 0;
	END IF;

	
END;$_$;


ALTER FUNCTION public.med_eliminar_historial(character varying[]) OWNER TO postgres;

--
-- TOC entry 2324 (class 0 OID 0)
-- Dependencies: 18
-- Name: FUNCTION med_eliminar_historial(character varying[]); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION med_eliminar_historial(character varying[]) IS '
NOMBRE: med_eliminar_historial
TIPO: Function (store procedure)

PARAMETROS: Recibe 2 Parámetros
	1:  Id del Historial a eliminar
	2:  Id del doctor que se encuentra actualmente logueado	

DESCRIPCION: 
	Elimina la información del usuario administrativo 

RETORNO:
	1: La función se ejecutó exitosamente
	0: No existe el historial a eliminar

EJEMPLO DE LLAMADA:
	SELECT adm_eliminar_usuario_admin(ARRAY[''1'',''2'']);


AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 01/07/2011 
 
DESCRIPCIÓN: Eliminacion de los historicos
';


--
-- TOC entry 26 (class 1255 OID 18766)
-- Dependencies: 6 457
-- Name: med_eliminar_paciente(character varying[]); Type: FUNCTION; Schema: public; Owner: desarrollo_g
--

CREATE FUNCTION med_eliminar_paciente(character varying[]) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$
DECLARE
	
	--Variables
	_data 	ALIAS FOR $1;
	_id_pac		pacientes.id_pac%TYPE;
	_id_doc		doctores.id_doc%TYPE;

BEGIN
	_id_pac := _data[1];
	_id_doc := _data[2];
	
	IF EXISTS(SELECT 1 FROM pacientes WHERE id_pac = _id_pac::INTEGER)THEN
		DELETE FROM pacientes WHERE id_pac = _id_pac::INTEGER;
		RETURN 1;
	ELSE
		RETURN 0;
	END IF;

	
END;$_$;


ALTER FUNCTION public.med_eliminar_paciente(character varying[]) OWNER TO desarrollo_g;

--
-- TOC entry 2325 (class 0 OID 0)
-- Dependencies: 26
-- Name: FUNCTION med_eliminar_paciente(character varying[]); Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON FUNCTION med_eliminar_paciente(character varying[]) IS '
NOMBRE: med_eliminar_paciente
TIPO: Function (store procedure)

PARAMETROS: Recibe 2 Parámetros
	1:  Id del paciente a eliminar
	2:  Id del doctor que se encuentra actualmente logueado	

DESCRIPCION: 
	Elimina la información del usuario administrativo 

RETORNO:
	1: La función se ejecutó exitosamente
	0: No existe el paciente a eliminar

EJEMPLO DE LLAMADA:
	SELECT adm_eliminar_usuario_admin(ARRAY[''1'',''2'']);


AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 22/04/2011 
 
DESCRIPCIÓN: Eliminacion de los pacientes
';


--
-- TOC entry 31 (class 1255 OID 18865)
-- Dependencies: 6 457
-- Name: med_modificar_hitorial_paciente(character varying[]); Type: FUNCTION; Schema: public; Owner: postgres
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
	_id_doc		doctores.id_doc%TYPE;
	
BEGIN
	-- pacientes
	_id_his 		:= _datos[1];
	_des_his 		:= _datos[2];
	_des_adi_pac_his	:= _datos[3];

	-- doctor	
	_id_doc			:= _datos[4];

	-- historial del paciente
		

	UPDATE historiales_pacientes SET 		
		des_his 	= _des_his, 	
		des_adi_pac_his = _des_adi_pac_his				
		WHERE id_his 	= _id_his;
		
	RETURN 1; -- La función se ejecutó exitosamente
	
	
	

END;$_$;


ALTER FUNCTION public.med_modificar_hitorial_paciente(character varying[]) OWNER TO postgres;

--
-- TOC entry 2326 (class 0 OID 0)
-- Dependencies: 31
-- Name: FUNCTION med_modificar_hitorial_paciente(character varying[]); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION med_modificar_hitorial_paciente(character varying[]) IS '
NOMBRE: med_modificar_hitorial_paciente
TIPO: Function (store procedure)

PARAMETROS: Recibe 4 Parámetros

	1:  Id del historial.
	2:  Descripción delhec historico.
	3:  Descripción adicional del paciente.
	4:  Id del doctor que se encuentra logueado en el sistema.
	
DESCRIPCION: 
	Modifica la información del historico de los pacientes

RETORNO:
	1: La función se ejecutó exitosamente	
	 
EJEMPLO DE LLAMADA:
	SELECT med_registrar_hitorial_paciente(ARRAY[ ''7'', ''lkhlkjh'', ''jhgfjgf'', ''6'' ]) AS result

AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 26/06/2011

';


--
-- TOC entry 32 (class 1255 OID 18759)
-- Dependencies: 6 457
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
	_str_ant_per	TEXT;
	_arr_ant_per	INTEGER[];	

	-- informacion del doctor

	_id_doc		doctores.id_doc%TYPE;
	
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

	-- centros de salud pacientes
	
	
	/* validando pacientes */
	IF EXISTS (SELECT 1 FROM pacientes WHERE id_pac = _id_pac::integer) THEN  
	

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
			id_mun 		= _id_mun			

			WHERE id_pac = _id_pac
		;			

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
			END LOOP;
		END IF;
		
		-- La función se ejecutó exitosamente
		RETURN 1;
		
	
	ELSE
		-- Existe un usuario administrativo con el mismo login
		RETURN 0;
	END IF;

END;$_$;


ALTER FUNCTION public.med_modificar_paciente(character varying[]) OWNER TO desarrollo_g;

--
-- TOC entry 2327 (class 0 OID 0)
-- Dependencies: 32
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
	

DESCRIPCION: 
	Modifica la información de los pacientes

RETORNO:
	1: La función se ejecutó exitosamente
	0: Existe un usuario administrativo con el mismo login
	 
EJEMPLO DE LLAMADA:
	SELECT med_modificar_paciente(ARRAY[''1'',''Prueba'', ''apellido'', ''12354'', ''2011-06-09'',''2'',''3622222'',''3333333'',''albañil'',''caracas'',''1'',''1'',''1'',''1,2,3,4'',''5'']);

AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 09/06/2011

';


--
-- TOC entry 28 (class 1255 OID 18863)
-- Dependencies: 457 6
-- Name: med_registrar_hitorial_paciente(character varying[]); Type: FUNCTION; Schema: public; Owner: postgres
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
	_id_doc		doctores.id_doc%TYPE;
	
BEGIN
	-- pacientes
	_id_pac 		:= _datos[1];
	_des_his 		:= _datos[2];
	_des_adi_pac_his	:= _datos[3];

	-- doctor	
	_id_doc			:= _datos[4];

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

	INSERT INTO tiempo_evoluciones(
		id_his
	) VALUES (
		_id_his
	);
			
	-- La función se ejecutó exitosamente
	RETURN 1;
	
	
	

END;$_$;


ALTER FUNCTION public.med_registrar_hitorial_paciente(character varying[]) OWNER TO postgres;

--
-- TOC entry 2328 (class 0 OID 0)
-- Dependencies: 28
-- Name: FUNCTION med_registrar_hitorial_paciente(character varying[]); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION med_registrar_hitorial_paciente(character varying[]) IS '
NOMBRE: med_registrar_hitorial_paciente
TIPO: Function (store procedure)

PARAMETROS: Recibe 4 Parámetros

	1:  Id del paciente.
	2:  Descripción delhec historico.
	3:  Descripción adicional del paciente.
	4:  Id del doctor que se encuentra logueado en el sistema.
	
DESCRIPCION: 
	Almacena la información del historico de los pacientes

RETORNO:
	1: La función se ejecutó exitosamente	
	 
EJEMPLO DE LLAMADA:
	SELECT med_registrar_hitorial_paciente(ARRAY[ ''7'', ''lkhlkjh'', ''jhgfjgf'', ''6'' ]) AS result

AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 26/06/2011

';


--
-- TOC entry 20 (class 1255 OID 18904)
-- Dependencies: 457 6
-- Name: med_registrar_informacion_adicional(character varying[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION med_registrar_informacion_adicional(character varying[]) RETURNS smallint
    LANGUAGE plpgsql
    AS $_$
DECLARE
	_datos ALIAS FOR $1;

	-- informacion del paciente
	_id_pac		historiales_pacientes.id_his%TYPE;
	_str_cen_sal	TEXT;
	_str_tip_con	TEXT;
	_str_con_ani	TEXT;
	_str_tra_pre	TEXT;
	_tie_evo	tiempo_evoluciones.tie_evo%TYPE;
	_id_doc		doctores.id_doc%TYPE;

	_id_his		historiales_pacientes.id_his%TYPE;
		
	_arr	INTEGER[];	
	
	
	
BEGIN
	-- pacientes
	_id_his			:= _datos[1];	
	_str_cen_sal		:= _datos[2];	
	_str_tip_con		:= _datos[3];	
	_str_con_ani		:= _datos[4];	
	_str_tra_pre		:= _datos[5];	
	_tie_evo		:= _datos[6];	
	_id_doc			:= _datos[7];	

	-- centro de salud del paciente referidos al historico
	DELETE FROM centro_salud_pacientes WHERE id_his = _id_his;

	_arr := STRING_TO_ARRAY(_str_cen_sal,',');
	IF (ARRAY_UPPER(_arr,1) > 0)THEN
		FOR i IN 1..(ARRAY_UPPER(_arr,1)) LOOP
			INSERT INTO centro_salud_pacientes (
				id_his,
				id_cen_sal					
			) VALUES (
				_id_his,
				_arr[i]
			);
		END LOOP;
	END IF;

	-- tipo de consulta del paciente referidos al historico
	DELETE FROM tipos_consultas_pacientes WHERE id_his = _id_his;

	_arr := STRING_TO_ARRAY(_str_tip_con,',');
	IF (ARRAY_UPPER(_arr,1) > 0)THEN
		FOR i IN 1..(ARRAY_UPPER(_arr,1)) LOOP
			INSERT INTO tipos_consultas_pacientes (
				id_his,
				id_tip_con					
			) VALUES (
				_id_his,
				_arr[i]
			);
		END LOOP;
	END IF;

	-- contacto animales del paciente referidos al historico
	DELETE FROM contactos_animales WHERE id_his = _id_his;

	_arr := STRING_TO_ARRAY(_str_con_ani,',');
	IF (ARRAY_UPPER(_arr,1) > 0)THEN
		FOR i IN 1..(ARRAY_UPPER(_arr,1)) LOOP
			INSERT INTO contactos_animales (
				id_his,
				id_ani					
			) VALUES (
				_id_his,
				_arr[i]
			);
		END LOOP;
	END IF;	

	-- contacto animales del paciente referidos al historico
	DELETE FROM tratamientos_pacientes WHERE id_his = _id_his;

	_arr := STRING_TO_ARRAY(_str_tra_pre,',');
	IF (ARRAY_UPPER(_arr,1) > 0)THEN
		FOR i IN 1..(ARRAY_UPPER(_arr,1)) LOOP
			INSERT INTO tratamientos_pacientes (
				id_his,
				id_tra					
			) VALUES (
				_id_his,
				_arr[i]
			);
		END LOOP;
	END IF;
	
	-- centros de salud pacientes
	
	/* validando pacientes */
	raise notice '%','asdf';
	IF NOT EXISTS (SELECT 1 FROM tiempo_evoluciones WHERE id_his = _id_his::integer) THEN  
		INSERT INTO tiempo_evoluciones(
			id_his,
			tie_evo
		) VALUES (
			_id_his,
			_tie_evo
		);
			
	END IF;

	RETURN 1;

END;$_$;


ALTER FUNCTION public.med_registrar_informacion_adicional(character varying[]) OWNER TO postgres;

--
-- TOC entry 2329 (class 0 OID 0)
-- Dependencies: 20
-- Name: FUNCTION med_registrar_informacion_adicional(character varying[]); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION med_registrar_informacion_adicional(character varying[]) IS '
NOMBRE: med_registrar_informacion_adicional
TIPO: Function (store procedure)

PARAMETROS: Recibe 12 Parámetros
	1:  Id del historico del paciente
	2:  Centro de salud del pacient
	3:  Tipo de consulta
	4:  Contacto con animales
	5:  Tratamientos previos
	6:  Tiempo de evolución
	7:  Id del usuario logueado, en este caso el doctor		

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
                ''6''                
                ]
            ) AS result 

AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 09/06/2011

';


--
-- TOC entry 30 (class 1255 OID 18645)
-- Dependencies: 457 6
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
	_str_ant_per	TEXT;
	_arr_ant_per	INTEGER[];

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
	_id_est		:= _datos[10];
	_id_mun		:= _datos[12];
	_str_ant_per	:= _datos[13];
	_id_doc		:= _datos[14];

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
			id_doc		
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
			_id_doc
		);	

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
			END LOOP;
		END IF;	
				
		-- La función se ejecutó exitosamente
		RETURN 1;
		
	
	ELSE
		-- Existe un usuario administrativo con el mismo login
		RETURN 0;
	END IF;

END;$_$;


ALTER FUNCTION public.med_registrar_paciente(character varying[]) OWNER TO desarrollo_g;

--
-- TOC entry 2330 (class 0 OID 0)
-- Dependencies: 30
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
	13: Id del doctor quien realizo la transacción
	

DESCRIPCION: 
	Almacena la información de los pacientes

RETORNO:
	1: La función se ejecutó exitosamente
	0: Existe un usuario administrativo con el mismo login
	 
EJEMPLO DE LLAMADA:
	SELECT med_registrar_paciente(ARRAY[''Prueba'', ''apellido'', ''12354'', ''2011-06-09'',''2'',''3622222'',''3333333'',''albañil'',''caracas'',''1'',''1'',''1'',''1,2,3,4,5'',''5'']);

AUTOR DE CREACIÓN: Luis Marin
FECHA DE CREACIÓN: 09/06/2011

';


--
-- TOC entry 27 (class 1255 OID 18521)
-- Dependencies: 457 6
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
-- TOC entry 2331 (class 0 OID 0)
-- Dependencies: 27
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
-- TOC entry 29 (class 1255 OID 18824)
-- Dependencies: 6 457 346
-- Name: validar_usuarios(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
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


ALTER FUNCTION public.validar_usuarios(_log_usu text, _pas_usu text, _tip_usu text) OWNER TO postgres;

--
-- TOC entry 2332 (class 0 OID 0)
-- Dependencies: 29
-- Name: FUNCTION validar_usuarios(_log_usu text, _pas_usu text, _tip_usu text); Type: COMMENT; Schema: public; Owner: postgres
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
-- TOC entry 1649 (class 1259 OID 17106)
-- Dependencies: 6
-- Name: animales; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE animales (
    id_ani integer NOT NULL,
    nom_ani character varying(20)
);


ALTER TABLE public.animales OWNER TO desarrollo_g;

--
-- TOC entry 1650 (class 1259 OID 17109)
-- Dependencies: 6 1649
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
-- TOC entry 2333 (class 0 OID 0)
-- Dependencies: 1650
-- Name: animales_id_ani_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE animales_id_ani_seq OWNED BY animales.id_ani;


--
-- TOC entry 2334 (class 0 OID 0)
-- Dependencies: 1650
-- Name: animales_id_ani_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('animales_id_ani_seq', 1, false);


--
-- TOC entry 1651 (class 1259 OID 17111)
-- Dependencies: 6
-- Name: antecedentes_pacientes; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE antecedentes_pacientes (
    id_ant_pac integer NOT NULL,
    id_ant_per integer NOT NULL,
    id_pac integer
);


ALTER TABLE public.antecedentes_pacientes OWNER TO desarrollo_g;

--
-- TOC entry 1652 (class 1259 OID 17114)
-- Dependencies: 1651 6
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
-- TOC entry 2335 (class 0 OID 0)
-- Dependencies: 1652
-- Name: antecedentes_pacientes_id_ant_pac_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE antecedentes_pacientes_id_ant_pac_seq OWNED BY antecedentes_pacientes.id_ant_pac;


--
-- TOC entry 2336 (class 0 OID 0)
-- Dependencies: 1652
-- Name: antecedentes_pacientes_id_ant_pac_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('antecedentes_pacientes_id_ant_pac_seq', 25, true);


--
-- TOC entry 1653 (class 1259 OID 17116)
-- Dependencies: 6
-- Name: antecedentes_personales; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE antecedentes_personales (
    id_ant_per integer NOT NULL,
    nom_ant_per character varying(100)
);


ALTER TABLE public.antecedentes_personales OWNER TO desarrollo_g;

--
-- TOC entry 1654 (class 1259 OID 17119)
-- Dependencies: 6 1653
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
-- TOC entry 2337 (class 0 OID 0)
-- Dependencies: 1654
-- Name: antecedentes_personales_id_ant_per_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE antecedentes_personales_id_ant_per_seq OWNED BY antecedentes_personales.id_ant_per;


--
-- TOC entry 2338 (class 0 OID 0)
-- Dependencies: 1654
-- Name: antecedentes_personales_id_ant_per_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('antecedentes_personales_id_ant_per_seq', 1, false);


--
-- TOC entry 1655 (class 1259 OID 17121)
-- Dependencies: 6
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
-- TOC entry 2339 (class 0 OID 0)
-- Dependencies: 1655
-- Name: TABLE auditoria_transacciones; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON TABLE auditoria_transacciones IS 'Se guarda todos los eventos generados por los usuarios';


--
-- TOC entry 2340 (class 0 OID 0)
-- Dependencies: 1655
-- Name: COLUMN auditoria_transacciones.data_xml; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN auditoria_transacciones.data_xml IS 'Se guarda las modificaciones de la tabla y atributos realizada por los usuarios, todo en forma de XML';


--
-- TOC entry 1656 (class 1259 OID 17124)
-- Dependencies: 1655 6
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
-- TOC entry 2341 (class 0 OID 0)
-- Dependencies: 1656
-- Name: auditoria_transacciones_id_aud_tra_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE auditoria_transacciones_id_aud_tra_seq OWNED BY auditoria_transacciones.id_aud_tra;


--
-- TOC entry 2342 (class 0 OID 0)
-- Dependencies: 1656
-- Name: auditoria_transacciones_id_aud_tra_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('auditoria_transacciones_id_aud_tra_seq', 1, false);


--
-- TOC entry 1657 (class 1259 OID 17126)
-- Dependencies: 6
-- Name: categorias__cuerpos_micosis; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE categorias__cuerpos_micosis (
    id_cat_cue_mic integer NOT NULL,
    id_cat_cue integer NOT NULL,
    id_tip_mic integer NOT NULL
);


ALTER TABLE public.categorias__cuerpos_micosis OWNER TO desarrollo_g;

--
-- TOC entry 1658 (class 1259 OID 17129)
-- Dependencies: 6 1657
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
-- TOC entry 2343 (class 0 OID 0)
-- Dependencies: 1658
-- Name: categorias__cuerpos_micosis_id_cat_cue_mic_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE categorias__cuerpos_micosis_id_cat_cue_mic_seq OWNED BY categorias__cuerpos_micosis.id_cat_cue_mic;


--
-- TOC entry 2344 (class 0 OID 0)
-- Dependencies: 1658
-- Name: categorias__cuerpos_micosis_id_cat_cue_mic_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('categorias__cuerpos_micosis_id_cat_cue_mic_seq', 1, false);


--
-- TOC entry 1659 (class 1259 OID 17131)
-- Dependencies: 6
-- Name: categorias_cuerpos; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE categorias_cuerpos (
    id_cat_cue integer NOT NULL,
    nom_cat_cue character varying(20)
);


ALTER TABLE public.categorias_cuerpos OWNER TO desarrollo_g;

--
-- TOC entry 1660 (class 1259 OID 17134)
-- Dependencies: 1659 6
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
-- TOC entry 2345 (class 0 OID 0)
-- Dependencies: 1660
-- Name: categorias_cuerpos_id_cat_cue_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE categorias_cuerpos_id_cat_cue_seq OWNED BY categorias_cuerpos.id_cat_cue;


--
-- TOC entry 2346 (class 0 OID 0)
-- Dependencies: 1660
-- Name: categorias_cuerpos_id_cat_cue_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('categorias_cuerpos_id_cat_cue_seq', 1, false);


--
-- TOC entry 1661 (class 1259 OID 17136)
-- Dependencies: 6
-- Name: categorias_cuerpos_partes_cuerpos; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE categorias_cuerpos_partes_cuerpos (
    id_cat_cue_par_cue integer NOT NULL,
    id_par_cue integer NOT NULL,
    id_cat_cue integer NOT NULL
);


ALTER TABLE public.categorias_cuerpos_partes_cuerpos OWNER TO desarrollo_g;

--
-- TOC entry 1662 (class 1259 OID 17139)
-- Dependencies: 6 1661
-- Name: categorias_cuerpos_partes_cuerpos_id_cat_cue_par_cue_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE categorias_cuerpos_partes_cuerpos_id_cat_cue_par_cue_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categorias_cuerpos_partes_cuerpos_id_cat_cue_par_cue_seq OWNER TO desarrollo_g;

--
-- TOC entry 2347 (class 0 OID 0)
-- Dependencies: 1662
-- Name: categorias_cuerpos_partes_cuerpos_id_cat_cue_par_cue_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE categorias_cuerpos_partes_cuerpos_id_cat_cue_par_cue_seq OWNED BY categorias_cuerpos_partes_cuerpos.id_cat_cue_par_cue;


--
-- TOC entry 2348 (class 0 OID 0)
-- Dependencies: 1662
-- Name: categorias_cuerpos_partes_cuerpos_id_cat_cue_par_cue_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('categorias_cuerpos_partes_cuerpos_id_cat_cue_par_cue_seq', 1, false);


SET default_tablespace = '';

--
-- TOC entry 1734 (class 1259 OID 18773)
-- Dependencies: 6
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
-- TOC entry 2349 (class 0 OID 0)
-- Dependencies: 1734
-- Name: COLUMN centro_salud_doctores.id_cen_sal_doc; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN centro_salud_doctores.id_cen_sal_doc IS 'Identificación del Centro de Salud del doctor';


--
-- TOC entry 2350 (class 0 OID 0)
-- Dependencies: 1734
-- Name: COLUMN centro_salud_doctores.id_cen_sal; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN centro_salud_doctores.id_cen_sal IS 'Identificación del Centro de Salud';


--
-- TOC entry 2351 (class 0 OID 0)
-- Dependencies: 1734
-- Name: COLUMN centro_salud_doctores.id_doc; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN centro_salud_doctores.id_doc IS 'Identificación del doctor';


--
-- TOC entry 2352 (class 0 OID 0)
-- Dependencies: 1734
-- Name: COLUMN centro_salud_doctores.otr_cen_sal; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN centro_salud_doctores.otr_cen_sal IS 'Otro Centro de Salud';


--
-- TOC entry 1733 (class 1259 OID 18771)
-- Dependencies: 6 1734
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
-- TOC entry 2353 (class 0 OID 0)
-- Dependencies: 1733
-- Name: centro_salud_doctores_id_cen_sal_doc_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE centro_salud_doctores_id_cen_sal_doc_seq OWNED BY centro_salud_doctores.id_cen_sal_doc;


--
-- TOC entry 2354 (class 0 OID 0)
-- Dependencies: 1733
-- Name: centro_salud_doctores_id_cen_sal_doc_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('centro_salud_doctores_id_cen_sal_doc_seq', 11, true);


SET default_tablespace = saib;

--
-- TOC entry 1663 (class 1259 OID 17141)
-- Dependencies: 6
-- Name: centro_saluds; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE centro_saluds (
    id_cen_sal integer NOT NULL,
    nom_cen_sal character varying(100) NOT NULL,
    des_cen_sal character varying(100)
);


ALTER TABLE public.centro_saluds OWNER TO desarrollo_g;

--
-- TOC entry 1664 (class 1259 OID 17144)
-- Dependencies: 6 1663
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
-- TOC entry 2355 (class 0 OID 0)
-- Dependencies: 1664
-- Name: centro_salud_id_cen_sal_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE centro_salud_id_cen_sal_seq OWNED BY centro_saluds.id_cen_sal;


--
-- TOC entry 2356 (class 0 OID 0)
-- Dependencies: 1664
-- Name: centro_salud_id_cen_sal_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('centro_salud_id_cen_sal_seq', 34, true);


--
-- TOC entry 1665 (class 1259 OID 17146)
-- Dependencies: 6
-- Name: centro_salud_pacientes; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE centro_salud_pacientes (
    id_cen_sal_pac integer NOT NULL,
    id_his integer NOT NULL,
    id_cen_sal integer NOT NULL,
    otr_cen_sal character varying(20)
);


ALTER TABLE public.centro_salud_pacientes OWNER TO desarrollo_g;

--
-- TOC entry 1666 (class 1259 OID 17149)
-- Dependencies: 6 1665
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
-- TOC entry 2357 (class 0 OID 0)
-- Dependencies: 1666
-- Name: centro_salud_pacientes_id_cen_sal_pac_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE centro_salud_pacientes_id_cen_sal_pac_seq OWNED BY centro_salud_pacientes.id_cen_sal_pac;


--
-- TOC entry 2358 (class 0 OID 0)
-- Dependencies: 1666
-- Name: centro_salud_pacientes_id_cen_sal_pac_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('centro_salud_pacientes_id_cen_sal_pac_seq', 34, true);


--
-- TOC entry 1667 (class 1259 OID 17161)
-- Dependencies: 6
-- Name: contactos_animales; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE contactos_animales (
    id_con_ani integer NOT NULL,
    id_his integer NOT NULL,
    id_ani integer NOT NULL,
    otr_ani character varying(20)
);


ALTER TABLE public.contactos_animales OWNER TO desarrollo_g;

--
-- TOC entry 1668 (class 1259 OID 17164)
-- Dependencies: 6 1667
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
-- TOC entry 2359 (class 0 OID 0)
-- Dependencies: 1668
-- Name: contactos_animales_id_con_ani_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE contactos_animales_id_con_ani_seq OWNED BY contactos_animales.id_con_ani;


--
-- TOC entry 2360 (class 0 OID 0)
-- Dependencies: 1668
-- Name: contactos_animales_id_con_ani_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('contactos_animales_id_con_ani_seq', 16, true);


--
-- TOC entry 1669 (class 1259 OID 17166)
-- Dependencies: 2026 6
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
-- TOC entry 2361 (class 0 OID 0)
-- Dependencies: 1669
-- Name: TABLE doctores; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON TABLE doctores IS 'Registro de todos los doctores que del aplicativo';


--
-- TOC entry 2362 (class 0 OID 0)
-- Dependencies: 1669
-- Name: COLUMN doctores.id_doc; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN doctores.id_doc IS 'identificador único para los doctores';


--
-- TOC entry 2363 (class 0 OID 0)
-- Dependencies: 1669
-- Name: COLUMN doctores.nom_doc; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN doctores.nom_doc IS 'Nombre del doctor';


--
-- TOC entry 2364 (class 0 OID 0)
-- Dependencies: 1669
-- Name: COLUMN doctores.ape_doc; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN doctores.ape_doc IS 'Apellido del doctor';


--
-- TOC entry 2365 (class 0 OID 0)
-- Dependencies: 1669
-- Name: COLUMN doctores.ced_doc; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN doctores.ced_doc IS 'Cédula del doctor';


--
-- TOC entry 2366 (class 0 OID 0)
-- Dependencies: 1669
-- Name: COLUMN doctores.pas_doc; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN doctores.pas_doc IS 'Contraseña del doctor';


--
-- TOC entry 2367 (class 0 OID 0)
-- Dependencies: 1669
-- Name: COLUMN doctores.tel_doc; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN doctores.tel_doc IS 'Teléfono del doctor';


--
-- TOC entry 2368 (class 0 OID 0)
-- Dependencies: 1669
-- Name: COLUMN doctores.cor_doc; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN doctores.cor_doc IS 'Correo electronico del doctor';


--
-- TOC entry 2369 (class 0 OID 0)
-- Dependencies: 1669
-- Name: COLUMN doctores.log_doc; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN doctores.log_doc IS 'Login con el que se loguara el doctor';


--
-- TOC entry 1670 (class 1259 OID 17172)
-- Dependencies: 1669 6
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
-- TOC entry 2370 (class 0 OID 0)
-- Dependencies: 1670
-- Name: doctores_id_doc_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE doctores_id_doc_seq OWNED BY doctores.id_doc;


--
-- TOC entry 2371 (class 0 OID 0)
-- Dependencies: 1670
-- Name: doctores_id_doc_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('doctores_id_doc_seq', 34, true);


--
-- TOC entry 1671 (class 1259 OID 17174)
-- Dependencies: 6
-- Name: enfermedades_micologicas; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE enfermedades_micologicas (
    id_enf_mic integer NOT NULL,
    nom_enf_mic character varying(20) NOT NULL,
    id_tip_mic integer NOT NULL
);


ALTER TABLE public.enfermedades_micologicas OWNER TO desarrollo_g;

--
-- TOC entry 1672 (class 1259 OID 17177)
-- Dependencies: 1671 6
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
-- TOC entry 2372 (class 0 OID 0)
-- Dependencies: 1672
-- Name: enfermedades_micologicas_id_enf_mic_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE enfermedades_micologicas_id_enf_mic_seq OWNED BY enfermedades_micologicas.id_enf_mic;


--
-- TOC entry 2373 (class 0 OID 0)
-- Dependencies: 1672
-- Name: enfermedades_micologicas_id_enf_mic_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('enfermedades_micologicas_id_enf_mic_seq', 1, false);


--
-- TOC entry 1673 (class 1259 OID 17179)
-- Dependencies: 6
-- Name: enfermedades_pacientes; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE enfermedades_pacientes (
    id_enf_pac integer NOT NULL,
    id_his integer NOT NULL,
    id_enf_mic integer NOT NULL,
    otr_enf_mic character varying(20),
    esp_enf_mic character varying(20)
);


ALTER TABLE public.enfermedades_pacientes OWNER TO desarrollo_g;

--
-- TOC entry 1674 (class 1259 OID 17182)
-- Dependencies: 1673 6
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
-- TOC entry 2374 (class 0 OID 0)
-- Dependencies: 1674
-- Name: enfermedades_pacientes_id_enf_pac_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE enfermedades_pacientes_id_enf_pac_seq OWNED BY enfermedades_pacientes.id_enf_pac;


--
-- TOC entry 2375 (class 0 OID 0)
-- Dependencies: 1674
-- Name: enfermedades_pacientes_id_enf_pac_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('enfermedades_pacientes_id_enf_pac_seq', 1, false);


SET default_tablespace = '';

--
-- TOC entry 1728 (class 1259 OID 18420)
-- Dependencies: 6
-- Name: estados; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: 
--

CREATE TABLE estados (
    id_est integer NOT NULL,
    des_est character varying(100),
    id_pai integer
);


ALTER TABLE public.estados OWNER TO desarrollo_g;

--
-- TOC entry 1727 (class 1259 OID 18418)
-- Dependencies: 6 1728
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
-- TOC entry 2376 (class 0 OID 0)
-- Dependencies: 1727
-- Name: estados_id_est_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE estados_id_est_seq OWNED BY estados.id_est;


--
-- TOC entry 2377 (class 0 OID 0)
-- Dependencies: 1727
-- Name: estados_id_est_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('estados_id_est_seq', 6, true);


SET default_tablespace = saib;

--
-- TOC entry 1675 (class 1259 OID 17184)
-- Dependencies: 6
-- Name: estudios_micologicos__pacientes; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE estudios_micologicos__pacientes (
    id_est_mic_pac integer NOT NULL,
    id_his integer NOT NULL,
    id_pro_est_mic integer NOT NULL
);


ALTER TABLE public.estudios_micologicos__pacientes OWNER TO desarrollo_g;

--
-- TOC entry 2378 (class 0 OID 0)
-- Dependencies: 1675
-- Name: COLUMN estudios_micologicos__pacientes.id_est_mic_pac; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN estudios_micologicos__pacientes.id_est_mic_pac IS 'Id estudio micologico del paciente';


--
-- TOC entry 2379 (class 0 OID 0)
-- Dependencies: 1675
-- Name: COLUMN estudios_micologicos__pacientes.id_his; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN estudios_micologicos__pacientes.id_his IS 'Id historial el paciente';


--
-- TOC entry 2380 (class 0 OID 0)
-- Dependencies: 1675
-- Name: COLUMN estudios_micologicos__pacientes.id_pro_est_mic; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN estudios_micologicos__pacientes.id_pro_est_mic IS 'Identificacion de las propiedades estudios micologicos';


--
-- TOC entry 1676 (class 1259 OID 17187)
-- Dependencies: 6 1675
-- Name: estudios_micologicos__pacientes_id_est_mic_pac_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE estudios_micologicos__pacientes_id_est_mic_pac_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.estudios_micologicos__pacientes_id_est_mic_pac_seq OWNER TO desarrollo_g;

--
-- TOC entry 2381 (class 0 OID 0)
-- Dependencies: 1676
-- Name: estudios_micologicos__pacientes_id_est_mic_pac_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE estudios_micologicos__pacientes_id_est_mic_pac_seq OWNED BY estudios_micologicos__pacientes.id_est_mic_pac;


--
-- TOC entry 2382 (class 0 OID 0)
-- Dependencies: 1676
-- Name: estudios_micologicos__pacientes_id_est_mic_pac_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('estudios_micologicos__pacientes_id_est_mic_pac_seq', 1, false);


--
-- TOC entry 1677 (class 1259 OID 17189)
-- Dependencies: 6
-- Name: forma_infecciones; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE forma_infecciones (
    id_for_inf integer NOT NULL,
    des_for_inf character varying(20)
);


ALTER TABLE public.forma_infecciones OWNER TO desarrollo_g;

--
-- TOC entry 1678 (class 1259 OID 17192)
-- Dependencies: 6
-- Name: forma_infecciones__pacientes; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE forma_infecciones__pacientes (
    id_for_pac integer NOT NULL,
    id_for_inf integer NOT NULL,
    id_his integer NOT NULL,
    otr_for_inf character varying(20)
);


ALTER TABLE public.forma_infecciones__pacientes OWNER TO desarrollo_g;

--
-- TOC entry 1679 (class 1259 OID 17195)
-- Dependencies: 1678 6
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
-- TOC entry 2383 (class 0 OID 0)
-- Dependencies: 1679
-- Name: forma_infecciones__pacientes_id_for_pac_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE forma_infecciones__pacientes_id_for_pac_seq OWNED BY forma_infecciones__pacientes.id_for_pac;


--
-- TOC entry 2384 (class 0 OID 0)
-- Dependencies: 1679
-- Name: forma_infecciones__pacientes_id_for_pac_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('forma_infecciones__pacientes_id_for_pac_seq', 1, false);


--
-- TOC entry 1680 (class 1259 OID 17197)
-- Dependencies: 6
-- Name: forma_infecciones__tipos_micosis; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE forma_infecciones__tipos_micosis (
    id_for_inf_tip_mic integer NOT NULL,
    id_tip_mic integer NOT NULL,
    id_for_inf integer NOT NULL
);


ALTER TABLE public.forma_infecciones__tipos_micosis OWNER TO desarrollo_g;

--
-- TOC entry 1681 (class 1259 OID 17200)
-- Dependencies: 6 1680
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
-- TOC entry 2385 (class 0 OID 0)
-- Dependencies: 1681
-- Name: forma_infecciones__tipos_micosis_id_for_inf_tip_mic_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE forma_infecciones__tipos_micosis_id_for_inf_tip_mic_seq OWNED BY forma_infecciones__tipos_micosis.id_for_inf_tip_mic;


--
-- TOC entry 2386 (class 0 OID 0)
-- Dependencies: 1681
-- Name: forma_infecciones__tipos_micosis_id_for_inf_tip_mic_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('forma_infecciones__tipos_micosis_id_for_inf_tip_mic_seq', 1, false);


--
-- TOC entry 1682 (class 1259 OID 17202)
-- Dependencies: 1677 6
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
-- TOC entry 2387 (class 0 OID 0)
-- Dependencies: 1682
-- Name: forma_infecciones_id_for_inf_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE forma_infecciones_id_for_inf_seq OWNED BY forma_infecciones.id_for_inf;


--
-- TOC entry 2388 (class 0 OID 0)
-- Dependencies: 1682
-- Name: forma_infecciones_id_for_inf_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('forma_infecciones_id_for_inf_seq', 1, false);


--
-- TOC entry 1683 (class 1259 OID 17204)
-- Dependencies: 2034 6
-- Name: historiales_pacientes; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE historiales_pacientes (
    id_his integer NOT NULL,
    id_pac integer NOT NULL,
    des_his character varying(255),
    id_doc integer,
    des_adi_pac_his character varying(255),
    fec_his timestamp with time zone DEFAULT now()
);


ALTER TABLE public.historiales_pacientes OWNER TO desarrollo_g;

--
-- TOC entry 2389 (class 0 OID 0)
-- Dependencies: 1683
-- Name: COLUMN historiales_pacientes.des_adi_pac_his; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN historiales_pacientes.des_adi_pac_his IS '
	Discripción adicional de si el paciente padece o no una enfermedad u otra cosa adicional.
';


--
-- TOC entry 1684 (class 1259 OID 17207)
-- Dependencies: 1683 6
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
-- TOC entry 2390 (class 0 OID 0)
-- Dependencies: 1684
-- Name: historiales_pacientes_id_his_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE historiales_pacientes_id_his_seq OWNED BY historiales_pacientes.id_his;


--
-- TOC entry 2391 (class 0 OID 0)
-- Dependencies: 1684
-- Name: historiales_pacientes_id_his_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('historiales_pacientes_id_his_seq', 16, true);


--
-- TOC entry 1685 (class 1259 OID 17209)
-- Dependencies: 6
-- Name: lesiones__partes_cuerpos; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE lesiones__partes_cuerpos (
    id_les_par_cue integer NOT NULL,
    nom_les_par_cue character varying(20),
    id_par_cue integer NOT NULL
);


ALTER TABLE public.lesiones__partes_cuerpos OWNER TO desarrollo_g;

--
-- TOC entry 1686 (class 1259 OID 17212)
-- Dependencies: 1685 6
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
-- TOC entry 2392 (class 0 OID 0)
-- Dependencies: 1686
-- Name: lesiones__partes_cuerpos_id_les_par_cue_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE lesiones__partes_cuerpos_id_les_par_cue_seq OWNED BY lesiones__partes_cuerpos.id_les_par_cue;


--
-- TOC entry 2393 (class 0 OID 0)
-- Dependencies: 1686
-- Name: lesiones__partes_cuerpos_id_les_par_cue_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('lesiones__partes_cuerpos_id_les_par_cue_seq', 1, false);


--
-- TOC entry 1687 (class 1259 OID 17214)
-- Dependencies: 6
-- Name: lesiones_partes_cuerpos__pacientes; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE lesiones_partes_cuerpos__pacientes (
    id_les_par_cue_pac integer NOT NULL,
    id_his integer NOT NULL,
    id_les_par_cue integer NOT NULL,
    otr_les_par_cue character varying(20)
);


ALTER TABLE public.lesiones_partes_cuerpos__pacientes OWNER TO desarrollo_g;

--
-- TOC entry 2394 (class 0 OID 0)
-- Dependencies: 1687
-- Name: COLUMN lesiones_partes_cuerpos__pacientes.id_les_par_cue_pac; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN lesiones_partes_cuerpos__pacientes.id_les_par_cue_pac IS 'Leciones parted del cuerpo paciente';


--
-- TOC entry 2395 (class 0 OID 0)
-- Dependencies: 1687
-- Name: COLUMN lesiones_partes_cuerpos__pacientes.id_his; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN lesiones_partes_cuerpos__pacientes.id_his IS 'Id de historial';


--
-- TOC entry 2396 (class 0 OID 0)
-- Dependencies: 1687
-- Name: COLUMN lesiones_partes_cuerpos__pacientes.id_les_par_cue; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN lesiones_partes_cuerpos__pacientes.id_les_par_cue IS 'Id lesiones partes del cuerpo del paciente';


--
-- TOC entry 2397 (class 0 OID 0)
-- Dependencies: 1687
-- Name: COLUMN lesiones_partes_cuerpos__pacientes.otr_les_par_cue; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN lesiones_partes_cuerpos__pacientes.otr_les_par_cue IS 'Otras leciones de la parte del cuerpo del paciente';


--
-- TOC entry 1688 (class 1259 OID 17217)
-- Dependencies: 1687 6
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
-- TOC entry 2398 (class 0 OID 0)
-- Dependencies: 1688
-- Name: lesiones_partes_cuerpos__pacientes_id_les_par_cue_pac_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE lesiones_partes_cuerpos__pacientes_id_les_par_cue_pac_seq OWNED BY lesiones_partes_cuerpos__pacientes.id_les_par_cue_pac;


--
-- TOC entry 2399 (class 0 OID 0)
-- Dependencies: 1688
-- Name: lesiones_partes_cuerpos__pacientes_id_les_par_cue_pac_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('lesiones_partes_cuerpos__pacientes_id_les_par_cue_pac_seq', 1, false);


--
-- TOC entry 1689 (class 1259 OID 17219)
-- Dependencies: 6
-- Name: localizaciones_cuerpos; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE localizaciones_cuerpos (
    id_loc_cue integer NOT NULL,
    nom_loc_cue character varying(20) NOT NULL
);


ALTER TABLE public.localizaciones_cuerpos OWNER TO desarrollo_g;

--
-- TOC entry 1690 (class 1259 OID 17222)
-- Dependencies: 1689 6
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
-- TOC entry 2400 (class 0 OID 0)
-- Dependencies: 1690
-- Name: localizaciones_cuerpos_id_loc_cue_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE localizaciones_cuerpos_id_loc_cue_seq OWNED BY localizaciones_cuerpos.id_loc_cue;


--
-- TOC entry 2401 (class 0 OID 0)
-- Dependencies: 1690
-- Name: localizaciones_cuerpos_id_loc_cue_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('localizaciones_cuerpos_id_loc_cue_seq', 1, false);


--
-- TOC entry 1691 (class 1259 OID 17229)
-- Dependencies: 6
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
-- TOC entry 1692 (class 1259 OID 17232)
-- Dependencies: 6 1691
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
-- TOC entry 2402 (class 0 OID 0)
-- Dependencies: 1692
-- Name: modulos_id_mod_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE modulos_id_mod_seq OWNED BY modulos.id_mod;


--
-- TOC entry 2403 (class 0 OID 0)
-- Dependencies: 1692
-- Name: modulos_id_mod_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('modulos_id_mod_seq', 2, true);


--
-- TOC entry 1693 (class 1259 OID 17234)
-- Dependencies: 6
-- Name: muestras_clinicas; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE muestras_clinicas (
    id_mue_cli integer NOT NULL,
    nom_mue_cli character varying(100) NOT NULL
);


ALTER TABLE public.muestras_clinicas OWNER TO desarrollo_g;

--
-- TOC entry 2404 (class 0 OID 0)
-- Dependencies: 1693
-- Name: COLUMN muestras_clinicas.id_mue_cli; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN muestras_clinicas.id_mue_cli IS 'Identificacion de la muestra clinica';


--
-- TOC entry 2405 (class 0 OID 0)
-- Dependencies: 1693
-- Name: COLUMN muestras_clinicas.nom_mue_cli; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN muestras_clinicas.nom_mue_cli IS 'Nombre muestra clinica';


--
-- TOC entry 1694 (class 1259 OID 17237)
-- Dependencies: 6 1693
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
-- TOC entry 2406 (class 0 OID 0)
-- Dependencies: 1694
-- Name: muestras_clinicas_id_mue_cli_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE muestras_clinicas_id_mue_cli_seq OWNED BY muestras_clinicas.id_mue_cli;


--
-- TOC entry 2407 (class 0 OID 0)
-- Dependencies: 1694
-- Name: muestras_clinicas_id_mue_cli_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('muestras_clinicas_id_mue_cli_seq', 1, false);


--
-- TOC entry 1695 (class 1259 OID 17239)
-- Dependencies: 6
-- Name: muestras_pacientes; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE muestras_pacientes (
    id_mue_pac integer NOT NULL,
    id_his integer NOT NULL,
    id_mue_cli integer NOT NULL,
    otr_mue_cli character varying(20)
);


ALTER TABLE public.muestras_pacientes OWNER TO desarrollo_g;

--
-- TOC entry 2408 (class 0 OID 0)
-- Dependencies: 1695
-- Name: COLUMN muestras_pacientes.id_mue_pac; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN muestras_pacientes.id_mue_pac IS 'Id de la meustra del paciente';


--
-- TOC entry 2409 (class 0 OID 0)
-- Dependencies: 1695
-- Name: COLUMN muestras_pacientes.id_his; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN muestras_pacientes.id_his IS 'Id del historial';


--
-- TOC entry 2410 (class 0 OID 0)
-- Dependencies: 1695
-- Name: COLUMN muestras_pacientes.id_mue_cli; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN muestras_pacientes.id_mue_cli IS 'Id muestra cli';


--
-- TOC entry 2411 (class 0 OID 0)
-- Dependencies: 1695
-- Name: COLUMN muestras_pacientes.otr_mue_cli; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN muestras_pacientes.otr_mue_cli IS 'Otra meustra clinica';


--
-- TOC entry 1696 (class 1259 OID 17242)
-- Dependencies: 6 1695
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
-- TOC entry 2412 (class 0 OID 0)
-- Dependencies: 1696
-- Name: muestras_pacientes_id_mue_pac_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE muestras_pacientes_id_mue_pac_seq OWNED BY muestras_pacientes.id_mue_pac;


--
-- TOC entry 2413 (class 0 OID 0)
-- Dependencies: 1696
-- Name: muestras_pacientes_id_mue_pac_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('muestras_pacientes_id_mue_pac_seq', 1, false);


SET default_tablespace = '';

--
-- TOC entry 1730 (class 1259 OID 18428)
-- Dependencies: 6
-- Name: municipios; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: 
--

CREATE TABLE municipios (
    id_mun integer NOT NULL,
    des_mun character varying(100),
    id_est integer
);


ALTER TABLE public.municipios OWNER TO desarrollo_g;

--
-- TOC entry 1729 (class 1259 OID 18426)
-- Dependencies: 1730 6
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
-- TOC entry 2414 (class 0 OID 0)
-- Dependencies: 1729
-- Name: municipios_id_mun_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE municipios_id_mun_seq OWNED BY municipios.id_mun;


--
-- TOC entry 2415 (class 0 OID 0)
-- Dependencies: 1729
-- Name: municipios_id_mun_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('municipios_id_mun_seq', 335, true);


SET default_tablespace = saib;

--
-- TOC entry 1697 (class 1259 OID 17244)
-- Dependencies: 2042 6
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
    fec_reg_pac timestamp with time zone DEFAULT now()
);


ALTER TABLE public.pacientes OWNER TO desarrollo_g;

--
-- TOC entry 2416 (class 0 OID 0)
-- Dependencies: 1697
-- Name: COLUMN pacientes.id_pac; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN pacientes.id_pac IS 'Id paciente';


--
-- TOC entry 2417 (class 0 OID 0)
-- Dependencies: 1697
-- Name: COLUMN pacientes.ape_pac; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN pacientes.ape_pac IS 'Apellido del paciente';


--
-- TOC entry 2418 (class 0 OID 0)
-- Dependencies: 1697
-- Name: COLUMN pacientes.nom_pac; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN pacientes.nom_pac IS 'Nombre del paciente';


--
-- TOC entry 2419 (class 0 OID 0)
-- Dependencies: 1697
-- Name: COLUMN pacientes.ced_pac; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN pacientes.ced_pac IS 'Cedula del paciente';


--
-- TOC entry 2420 (class 0 OID 0)
-- Dependencies: 1697
-- Name: COLUMN pacientes.fec_nac_pac; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN pacientes.fec_nac_pac IS 'Fecha de nacimiento del paciente';


--
-- TOC entry 2421 (class 0 OID 0)
-- Dependencies: 1697
-- Name: COLUMN pacientes.nac_pac; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN pacientes.nac_pac IS 'Nacionalidad del paciente';


--
-- TOC entry 2422 (class 0 OID 0)
-- Dependencies: 1697
-- Name: COLUMN pacientes.ocu_pac; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN pacientes.ocu_pac IS 'Ocupacion del paciente';


--
-- TOC entry 2423 (class 0 OID 0)
-- Dependencies: 1697
-- Name: COLUMN pacientes.ciu_pac; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN pacientes.ciu_pac IS 'Ciudad del paciente';


--
-- TOC entry 2424 (class 0 OID 0)
-- Dependencies: 1697
-- Name: COLUMN pacientes.fec_reg_pac; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN pacientes.fec_reg_pac IS 'Fecha de registro del paciente';


--
-- TOC entry 1698 (class 1259 OID 17250)
-- Dependencies: 1697 6
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
-- TOC entry 2425 (class 0 OID 0)
-- Dependencies: 1698
-- Name: pacientes_id_pac_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE pacientes_id_pac_seq OWNED BY pacientes.id_pac;


--
-- TOC entry 2426 (class 0 OID 0)
-- Dependencies: 1698
-- Name: pacientes_id_pac_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('pacientes_id_pac_seq', 28, true);


SET default_tablespace = '';

--
-- TOC entry 1726 (class 1259 OID 18412)
-- Dependencies: 6
-- Name: paises; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: 
--

CREATE TABLE paises (
    id_pai integer NOT NULL,
    des_pai character varying(100),
    cod_pai character varying(3)
);


ALTER TABLE public.paises OWNER TO desarrollo_g;

--
-- TOC entry 1725 (class 1259 OID 18410)
-- Dependencies: 6 1726
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
-- TOC entry 2427 (class 0 OID 0)
-- Dependencies: 1725
-- Name: paises_id_pai_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE paises_id_pai_seq OWNED BY paises.id_pai;


--
-- TOC entry 2428 (class 0 OID 0)
-- Dependencies: 1725
-- Name: paises_id_pai_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('paises_id_pai_seq', 1, false);


--
-- TOC entry 1732 (class 1259 OID 18436)
-- Dependencies: 6
-- Name: parroquias; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: 
--

CREATE TABLE parroquias (
    id_par integer NOT NULL,
    des_par character varying(100),
    id_mun integer
);


ALTER TABLE public.parroquias OWNER TO desarrollo_g;

--
-- TOC entry 1731 (class 1259 OID 18434)
-- Dependencies: 6 1732
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
-- TOC entry 2429 (class 0 OID 0)
-- Dependencies: 1731
-- Name: parroquias_id_par_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE parroquias_id_par_seq OWNED BY parroquias.id_par;


--
-- TOC entry 2430 (class 0 OID 0)
-- Dependencies: 1731
-- Name: parroquias_id_par_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('parroquias_id_par_seq', 1, false);


SET default_tablespace = saib;

--
-- TOC entry 1699 (class 1259 OID 17252)
-- Dependencies: 6
-- Name: partes_cuerpos; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE partes_cuerpos (
    id_par_cue integer NOT NULL,
    nom_par_cue character varying(20),
    id_loc_cue integer NOT NULL
);


ALTER TABLE public.partes_cuerpos OWNER TO desarrollo_g;

--
-- TOC entry 1700 (class 1259 OID 17255)
-- Dependencies: 1699 6
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
-- TOC entry 2431 (class 0 OID 0)
-- Dependencies: 1700
-- Name: partes_cuerpos_id_par_cue_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE partes_cuerpos_id_par_cue_seq OWNED BY partes_cuerpos.id_par_cue;


--
-- TOC entry 2432 (class 0 OID 0)
-- Dependencies: 1700
-- Name: partes_cuerpos_id_par_cue_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('partes_cuerpos_id_par_cue_seq', 1, false);


--
-- TOC entry 1701 (class 1259 OID 17257)
-- Dependencies: 6
-- Name: propiedades_estudios_micologicos; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE propiedades_estudios_micologicos (
    id_pro_est_mic integer NOT NULL,
    nom_pro_est_mic character varying(100) NOT NULL,
    id_tip_est_mic integer NOT NULL
);


ALTER TABLE public.propiedades_estudios_micologicos OWNER TO desarrollo_g;

--
-- TOC entry 2433 (class 0 OID 0)
-- Dependencies: 1701
-- Name: COLUMN propiedades_estudios_micologicos.id_pro_est_mic; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN propiedades_estudios_micologicos.id_pro_est_mic IS 'Id propiedad estudio micologicos';


--
-- TOC entry 2434 (class 0 OID 0)
-- Dependencies: 1701
-- Name: COLUMN propiedades_estudios_micologicos.nom_pro_est_mic; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN propiedades_estudios_micologicos.nom_pro_est_mic IS 'Nombre propiedad estudio micologico';


--
-- TOC entry 2435 (class 0 OID 0)
-- Dependencies: 1701
-- Name: COLUMN propiedades_estudios_micologicos.id_tip_est_mic; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN propiedades_estudios_micologicos.id_tip_est_mic IS 'Id tipos de estudio micologicos';


--
-- TOC entry 1702 (class 1259 OID 17260)
-- Dependencies: 1701 6
-- Name: propiedades_estudios_micologicos_id_pro_est_mic_seq; Type: SEQUENCE; Schema: public; Owner: desarrollo_g
--

CREATE SEQUENCE propiedades_estudios_micologicos_id_pro_est_mic_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.propiedades_estudios_micologicos_id_pro_est_mic_seq OWNER TO desarrollo_g;

--
-- TOC entry 2436 (class 0 OID 0)
-- Dependencies: 1702
-- Name: propiedades_estudios_micologicos_id_pro_est_mic_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE propiedades_estudios_micologicos_id_pro_est_mic_seq OWNED BY propiedades_estudios_micologicos.id_pro_est_mic;


--
-- TOC entry 2437 (class 0 OID 0)
-- Dependencies: 1702
-- Name: propiedades_estudios_micologicos_id_pro_est_mic_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('propiedades_estudios_micologicos_id_pro_est_mic_seq', 1, false);


SET default_tablespace = '';

--
-- TOC entry 1737 (class 1259 OID 18883)
-- Dependencies: 2063 6
-- Name: tiempo_evoluciones; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: 
--

CREATE TABLE tiempo_evoluciones (
    id_tie_evo integer NOT NULL,
    id_his integer,
    tie_evo integer DEFAULT 0
);


ALTER TABLE public.tiempo_evoluciones OWNER TO desarrollo_g;

--
-- TOC entry 1736 (class 1259 OID 18881)
-- Dependencies: 1737 6
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
-- TOC entry 2438 (class 0 OID 0)
-- Dependencies: 1736
-- Name: tiempo_evoluciones_id_tie_evo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE tiempo_evoluciones_id_tie_evo_seq OWNED BY tiempo_evoluciones.id_tie_evo;


--
-- TOC entry 2439 (class 0 OID 0)
-- Dependencies: 1736
-- Name: tiempo_evoluciones_id_tie_evo_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('tiempo_evoluciones_id_tie_evo_seq', 2, true);


SET default_tablespace = saib;

--
-- TOC entry 1703 (class 1259 OID 17262)
-- Dependencies: 6
-- Name: tipos_consultas; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE tipos_consultas (
    id_tip_con integer NOT NULL,
    nom_tip_con character varying(50) NOT NULL
);


ALTER TABLE public.tipos_consultas OWNER TO desarrollo_g;

--
-- TOC entry 2440 (class 0 OID 0)
-- Dependencies: 1703
-- Name: COLUMN tipos_consultas.id_tip_con; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN tipos_consultas.id_tip_con IS 'id tipos consultas';


--
-- TOC entry 1704 (class 1259 OID 17265)
-- Dependencies: 1703 6
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
-- TOC entry 2441 (class 0 OID 0)
-- Dependencies: 1704
-- Name: tipos_consultas_id_tip_con_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE tipos_consultas_id_tip_con_seq OWNED BY tipos_consultas.id_tip_con;


--
-- TOC entry 2442 (class 0 OID 0)
-- Dependencies: 1704
-- Name: tipos_consultas_id_tip_con_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('tipos_consultas_id_tip_con_seq', 9, false);


--
-- TOC entry 1705 (class 1259 OID 17267)
-- Dependencies: 6
-- Name: tipos_consultas_pacientes; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE tipos_consultas_pacientes (
    id_tip_con_pac integer NOT NULL,
    id_tip_con integer NOT NULL,
    id_his integer NOT NULL,
    otr_tip_con character varying(50)
);


ALTER TABLE public.tipos_consultas_pacientes OWNER TO desarrollo_g;

--
-- TOC entry 2443 (class 0 OID 0)
-- Dependencies: 1705
-- Name: COLUMN tipos_consultas_pacientes.id_tip_con_pac; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN tipos_consultas_pacientes.id_tip_con_pac IS 'Id tipos de consulta paciente';


--
-- TOC entry 2444 (class 0 OID 0)
-- Dependencies: 1705
-- Name: COLUMN tipos_consultas_pacientes.id_tip_con; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN tipos_consultas_pacientes.id_tip_con IS 'Id tipos de consulta';


--
-- TOC entry 2445 (class 0 OID 0)
-- Dependencies: 1705
-- Name: COLUMN tipos_consultas_pacientes.id_his; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN tipos_consultas_pacientes.id_his IS 'Id historico';


--
-- TOC entry 2446 (class 0 OID 0)
-- Dependencies: 1705
-- Name: COLUMN tipos_consultas_pacientes.otr_tip_con; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN tipos_consultas_pacientes.otr_tip_con IS 'Otro tipo de consulta';


--
-- TOC entry 1706 (class 1259 OID 17270)
-- Dependencies: 1705 6
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
-- TOC entry 2447 (class 0 OID 0)
-- Dependencies: 1706
-- Name: tipos_consultas_pacientes_id_tip_con_pac_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE tipos_consultas_pacientes_id_tip_con_pac_seq OWNED BY tipos_consultas_pacientes.id_tip_con_pac;


--
-- TOC entry 2448 (class 0 OID 0)
-- Dependencies: 1706
-- Name: tipos_consultas_pacientes_id_tip_con_pac_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('tipos_consultas_pacientes_id_tip_con_pac_seq', 44, true);


--
-- TOC entry 1707 (class 1259 OID 17272)
-- Dependencies: 6
-- Name: tipos_estudios_micologicos; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE tipos_estudios_micologicos (
    id_tip_est_mic integer NOT NULL,
    id_tip_mic integer NOT NULL,
    nom_tip_est_mic character varying(20)
);


ALTER TABLE public.tipos_estudios_micologicos OWNER TO desarrollo_g;

--
-- TOC entry 1708 (class 1259 OID 17275)
-- Dependencies: 1707 6
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
-- TOC entry 2449 (class 0 OID 0)
-- Dependencies: 1708
-- Name: tipos_estudios_micologicos_id_tip_est_mic_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE tipos_estudios_micologicos_id_tip_est_mic_seq OWNED BY tipos_estudios_micologicos.id_tip_est_mic;


--
-- TOC entry 2450 (class 0 OID 0)
-- Dependencies: 1708
-- Name: tipos_estudios_micologicos_id_tip_est_mic_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('tipos_estudios_micologicos_id_tip_est_mic_seq', 1, false);


--
-- TOC entry 1709 (class 1259 OID 17277)
-- Dependencies: 6
-- Name: tipos_micosis; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE tipos_micosis (
    id_tip_mic integer NOT NULL,
    nom_tip_mic character varying(20)
);


ALTER TABLE public.tipos_micosis OWNER TO desarrollo_g;

--
-- TOC entry 1710 (class 1259 OID 17280)
-- Dependencies: 6 1709
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
-- TOC entry 2451 (class 0 OID 0)
-- Dependencies: 1710
-- Name: tipos_micosis_id_tip_mic_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE tipos_micosis_id_tip_mic_seq OWNED BY tipos_micosis.id_tip_mic;


--
-- TOC entry 2452 (class 0 OID 0)
-- Dependencies: 1710
-- Name: tipos_micosis_id_tip_mic_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('tipos_micosis_id_tip_mic_seq', 1, false);


--
-- TOC entry 1711 (class 1259 OID 17282)
-- Dependencies: 6
-- Name: tipos_usuarios; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE tipos_usuarios (
    id_tip_usu integer NOT NULL,
    cod_tip_usu character varying(3) NOT NULL,
    des_tip_usu character varying(100)
);


ALTER TABLE public.tipos_usuarios OWNER TO desarrollo_g;

--
-- TOC entry 1712 (class 1259 OID 17285)
-- Dependencies: 6
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
-- TOC entry 1713 (class 1259 OID 17288)
-- Dependencies: 6 1712
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
-- TOC entry 2453 (class 0 OID 0)
-- Dependencies: 1713
-- Name: tipos_usuarios__usuarios_id_tip_usu_usu_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE tipos_usuarios__usuarios_id_tip_usu_usu_seq OWNED BY tipos_usuarios__usuarios.id_tip_usu_usu;


--
-- TOC entry 2454 (class 0 OID 0)
-- Dependencies: 1713
-- Name: tipos_usuarios__usuarios_id_tip_usu_usu_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('tipos_usuarios__usuarios_id_tip_usu_usu_seq', 52, true);


--
-- TOC entry 1714 (class 1259 OID 17290)
-- Dependencies: 1711 6
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
-- TOC entry 2455 (class 0 OID 0)
-- Dependencies: 1714
-- Name: tipos_usuarios_id_tip_usu_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE tipos_usuarios_id_tip_usu_seq OWNED BY tipos_usuarios.id_tip_usu;


--
-- TOC entry 2456 (class 0 OID 0)
-- Dependencies: 1714
-- Name: tipos_usuarios_id_tip_usu_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('tipos_usuarios_id_tip_usu_seq', 2, true);


--
-- TOC entry 1715 (class 1259 OID 17292)
-- Dependencies: 6
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
-- TOC entry 1716 (class 1259 OID 17295)
-- Dependencies: 6 1715
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
-- TOC entry 2457 (class 0 OID 0)
-- Dependencies: 1716
-- Name: transacciones_id_tip_tra_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE transacciones_id_tip_tra_seq OWNED BY transacciones.id_tip_tra;


--
-- TOC entry 2458 (class 0 OID 0)
-- Dependencies: 1716
-- Name: transacciones_id_tip_tra_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('transacciones_id_tip_tra_seq', 8, true);


--
-- TOC entry 1717 (class 1259 OID 17297)
-- Dependencies: 6
-- Name: transacciones_usuarios; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE transacciones_usuarios (
    id_tip_tra integer NOT NULL,
    id_tip_usu_usu integer,
    id_tra_usu integer NOT NULL
);


ALTER TABLE public.transacciones_usuarios OWNER TO desarrollo_g;

--
-- TOC entry 1724 (class 1259 OID 18028)
-- Dependencies: 1717 6
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
-- TOC entry 2459 (class 0 OID 0)
-- Dependencies: 1724
-- Name: transacciones_usuarios_id_tra_usu_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE transacciones_usuarios_id_tra_usu_seq OWNED BY transacciones_usuarios.id_tra_usu;


--
-- TOC entry 2460 (class 0 OID 0)
-- Dependencies: 1724
-- Name: transacciones_usuarios_id_tra_usu_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('transacciones_usuarios_id_tra_usu_seq', 116, true);


--
-- TOC entry 1718 (class 1259 OID 17302)
-- Dependencies: 6
-- Name: tratamientos; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE tratamientos (
    id_tra integer NOT NULL,
    nom_tra character varying(100)
);


ALTER TABLE public.tratamientos OWNER TO desarrollo_g;

--
-- TOC entry 1719 (class 1259 OID 17305)
-- Dependencies: 1718 6
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
-- TOC entry 2461 (class 0 OID 0)
-- Dependencies: 1719
-- Name: tratamientos_id_tra_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE tratamientos_id_tra_seq OWNED BY tratamientos.id_tra;


--
-- TOC entry 2462 (class 0 OID 0)
-- Dependencies: 1719
-- Name: tratamientos_id_tra_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('tratamientos_id_tra_seq', 1, false);


--
-- TOC entry 1720 (class 1259 OID 17307)
-- Dependencies: 6
-- Name: tratamientos_pacientes; Type: TABLE; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE TABLE tratamientos_pacientes (
    id_tra_pac integer NOT NULL,
    id_his integer NOT NULL,
    id_tra integer NOT NULL,
    otr_tra character varying(20)
);


ALTER TABLE public.tratamientos_pacientes OWNER TO desarrollo_g;

--
-- TOC entry 2463 (class 0 OID 0)
-- Dependencies: 1720
-- Name: COLUMN tratamientos_pacientes.id_tra_pac; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN tratamientos_pacientes.id_tra_pac IS 'Id transaccion paciente';


--
-- TOC entry 2464 (class 0 OID 0)
-- Dependencies: 1720
-- Name: COLUMN tratamientos_pacientes.id_his; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN tratamientos_pacientes.id_his IS 'Id historico';


--
-- TOC entry 2465 (class 0 OID 0)
-- Dependencies: 1720
-- Name: COLUMN tratamientos_pacientes.id_tra; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN tratamientos_pacientes.id_tra IS 'Id tratamiento';


--
-- TOC entry 2466 (class 0 OID 0)
-- Dependencies: 1720
-- Name: COLUMN tratamientos_pacientes.otr_tra; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN tratamientos_pacientes.otr_tra IS 'Otro tratamiento';


--
-- TOC entry 1721 (class 1259 OID 17310)
-- Dependencies: 6 1720
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
-- TOC entry 2467 (class 0 OID 0)
-- Dependencies: 1721
-- Name: tratamientos_pacientes_id_tra_pac_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE tratamientos_pacientes_id_tra_pac_seq OWNED BY tratamientos_pacientes.id_tra_pac;


--
-- TOC entry 2468 (class 0 OID 0)
-- Dependencies: 1721
-- Name: tratamientos_pacientes_id_tra_pac_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('tratamientos_pacientes_id_tra_pac_seq', 23, true);


--
-- TOC entry 1722 (class 1259 OID 17312)
-- Dependencies: 2056 6
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
-- TOC entry 2469 (class 0 OID 0)
-- Dependencies: 1722
-- Name: COLUMN usuarios_administrativos.fec_reg_usu_adm; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN usuarios_administrativos.fec_reg_usu_adm IS 'Fecha de registro de los usuarios';


--
-- TOC entry 2470 (class 0 OID 0)
-- Dependencies: 1722
-- Name: COLUMN usuarios_administrativos.adm_usu; Type: COMMENT; Schema: public; Owner: desarrollo_g
--

COMMENT ON COLUMN usuarios_administrativos.adm_usu IS '
	TRUE: si es un super usuario
	FALSE: si es usuario com limitaciones
';


--
-- TOC entry 1723 (class 1259 OID 17315)
-- Dependencies: 6 1722
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
-- TOC entry 2471 (class 0 OID 0)
-- Dependencies: 1723
-- Name: usuarios_administrativos_id_usu_adm_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: desarrollo_g
--

ALTER SEQUENCE usuarios_administrativos_id_usu_adm_seq OWNED BY usuarios_administrativos.id_usu_adm;


--
-- TOC entry 2472 (class 0 OID 0)
-- Dependencies: 1723
-- Name: usuarios_administrativos_id_usu_adm_seq; Type: SEQUENCE SET; Schema: public; Owner: desarrollo_g
--

SELECT pg_catalog.setval('usuarios_administrativos_id_usu_adm_seq', 23, true);


--
-- TOC entry 2015 (class 2604 OID 17317)
-- Dependencies: 1650 1649
-- Name: id_ani; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE animales ALTER COLUMN id_ani SET DEFAULT nextval('animales_id_ani_seq'::regclass);


--
-- TOC entry 2016 (class 2604 OID 17318)
-- Dependencies: 1652 1651
-- Name: id_ant_pac; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE antecedentes_pacientes ALTER COLUMN id_ant_pac SET DEFAULT nextval('antecedentes_pacientes_id_ant_pac_seq'::regclass);


--
-- TOC entry 2017 (class 2604 OID 17319)
-- Dependencies: 1654 1653
-- Name: id_ant_per; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE antecedentes_personales ALTER COLUMN id_ant_per SET DEFAULT nextval('antecedentes_personales_id_ant_per_seq'::regclass);


--
-- TOC entry 2018 (class 2604 OID 17320)
-- Dependencies: 1656 1655
-- Name: id_aud_tra; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE auditoria_transacciones ALTER COLUMN id_aud_tra SET DEFAULT nextval('auditoria_transacciones_id_aud_tra_seq'::regclass);


--
-- TOC entry 2019 (class 2604 OID 17321)
-- Dependencies: 1658 1657
-- Name: id_cat_cue_mic; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE categorias__cuerpos_micosis ALTER COLUMN id_cat_cue_mic SET DEFAULT nextval('categorias__cuerpos_micosis_id_cat_cue_mic_seq'::regclass);


--
-- TOC entry 2020 (class 2604 OID 17322)
-- Dependencies: 1660 1659
-- Name: id_cat_cue; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE categorias_cuerpos ALTER COLUMN id_cat_cue SET DEFAULT nextval('categorias_cuerpos_id_cat_cue_seq'::regclass);


--
-- TOC entry 2021 (class 2604 OID 17323)
-- Dependencies: 1662 1661
-- Name: id_cat_cue_par_cue; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE categorias_cuerpos_partes_cuerpos ALTER COLUMN id_cat_cue_par_cue SET DEFAULT nextval('categorias_cuerpos_partes_cuerpos_id_cat_cue_par_cue_seq'::regclass);


--
-- TOC entry 2061 (class 2604 OID 18776)
-- Dependencies: 1734 1733 1734
-- Name: id_cen_sal_doc; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE centro_salud_doctores ALTER COLUMN id_cen_sal_doc SET DEFAULT nextval('centro_salud_doctores_id_cen_sal_doc_seq'::regclass);


--
-- TOC entry 2023 (class 2604 OID 17325)
-- Dependencies: 1666 1665
-- Name: id_cen_sal_pac; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE centro_salud_pacientes ALTER COLUMN id_cen_sal_pac SET DEFAULT nextval('centro_salud_pacientes_id_cen_sal_pac_seq'::regclass);


--
-- TOC entry 2022 (class 2604 OID 17324)
-- Dependencies: 1664 1663
-- Name: id_cen_sal; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE centro_saluds ALTER COLUMN id_cen_sal SET DEFAULT nextval('centro_salud_id_cen_sal_seq'::regclass);


--
-- TOC entry 2024 (class 2604 OID 17328)
-- Dependencies: 1668 1667
-- Name: id_con_ani; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE contactos_animales ALTER COLUMN id_con_ani SET DEFAULT nextval('contactos_animales_id_con_ani_seq'::regclass);


--
-- TOC entry 2025 (class 2604 OID 17329)
-- Dependencies: 1670 1669
-- Name: id_doc; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE doctores ALTER COLUMN id_doc SET DEFAULT nextval('doctores_id_doc_seq'::regclass);


--
-- TOC entry 2027 (class 2604 OID 17330)
-- Dependencies: 1672 1671
-- Name: id_enf_mic; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE enfermedades_micologicas ALTER COLUMN id_enf_mic SET DEFAULT nextval('enfermedades_micologicas_id_enf_mic_seq'::regclass);


--
-- TOC entry 2028 (class 2604 OID 17331)
-- Dependencies: 1674 1673
-- Name: id_enf_pac; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE enfermedades_pacientes ALTER COLUMN id_enf_pac SET DEFAULT nextval('enfermedades_pacientes_id_enf_pac_seq'::regclass);


--
-- TOC entry 2058 (class 2604 OID 18423)
-- Dependencies: 1727 1728 1728
-- Name: id_est; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE estados ALTER COLUMN id_est SET DEFAULT nextval('estados_id_est_seq'::regclass);


--
-- TOC entry 2029 (class 2604 OID 17332)
-- Dependencies: 1676 1675
-- Name: id_est_mic_pac; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE estudios_micologicos__pacientes ALTER COLUMN id_est_mic_pac SET DEFAULT nextval('estudios_micologicos__pacientes_id_est_mic_pac_seq'::regclass);


--
-- TOC entry 2030 (class 2604 OID 17333)
-- Dependencies: 1682 1677
-- Name: id_for_inf; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE forma_infecciones ALTER COLUMN id_for_inf SET DEFAULT nextval('forma_infecciones_id_for_inf_seq'::regclass);


--
-- TOC entry 2031 (class 2604 OID 17334)
-- Dependencies: 1679 1678
-- Name: id_for_pac; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE forma_infecciones__pacientes ALTER COLUMN id_for_pac SET DEFAULT nextval('forma_infecciones__pacientes_id_for_pac_seq'::regclass);


--
-- TOC entry 2032 (class 2604 OID 17335)
-- Dependencies: 1681 1680
-- Name: id_for_inf_tip_mic; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE forma_infecciones__tipos_micosis ALTER COLUMN id_for_inf_tip_mic SET DEFAULT nextval('forma_infecciones__tipos_micosis_id_for_inf_tip_mic_seq'::regclass);


--
-- TOC entry 2033 (class 2604 OID 17336)
-- Dependencies: 1684 1683
-- Name: id_his; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE historiales_pacientes ALTER COLUMN id_his SET DEFAULT nextval('historiales_pacientes_id_his_seq'::regclass);


--
-- TOC entry 2035 (class 2604 OID 17337)
-- Dependencies: 1686 1685
-- Name: id_les_par_cue; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE lesiones__partes_cuerpos ALTER COLUMN id_les_par_cue SET DEFAULT nextval('lesiones__partes_cuerpos_id_les_par_cue_seq'::regclass);


--
-- TOC entry 2036 (class 2604 OID 17338)
-- Dependencies: 1688 1687
-- Name: id_les_par_cue_pac; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE lesiones_partes_cuerpos__pacientes ALTER COLUMN id_les_par_cue_pac SET DEFAULT nextval('lesiones_partes_cuerpos__pacientes_id_les_par_cue_pac_seq'::regclass);


--
-- TOC entry 2037 (class 2604 OID 17339)
-- Dependencies: 1690 1689
-- Name: id_loc_cue; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE localizaciones_cuerpos ALTER COLUMN id_loc_cue SET DEFAULT nextval('localizaciones_cuerpos_id_loc_cue_seq'::regclass);


--
-- TOC entry 2038 (class 2604 OID 17341)
-- Dependencies: 1692 1691
-- Name: id_mod; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE modulos ALTER COLUMN id_mod SET DEFAULT nextval('modulos_id_mod_seq'::regclass);


--
-- TOC entry 2039 (class 2604 OID 17342)
-- Dependencies: 1694 1693
-- Name: id_mue_cli; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE muestras_clinicas ALTER COLUMN id_mue_cli SET DEFAULT nextval('muestras_clinicas_id_mue_cli_seq'::regclass);


--
-- TOC entry 2040 (class 2604 OID 17343)
-- Dependencies: 1696 1695
-- Name: id_mue_pac; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE muestras_pacientes ALTER COLUMN id_mue_pac SET DEFAULT nextval('muestras_pacientes_id_mue_pac_seq'::regclass);


--
-- TOC entry 2059 (class 2604 OID 18431)
-- Dependencies: 1729 1730 1730
-- Name: id_mun; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE municipios ALTER COLUMN id_mun SET DEFAULT nextval('municipios_id_mun_seq'::regclass);


--
-- TOC entry 2041 (class 2604 OID 17344)
-- Dependencies: 1698 1697
-- Name: id_pac; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE pacientes ALTER COLUMN id_pac SET DEFAULT nextval('pacientes_id_pac_seq'::regclass);


--
-- TOC entry 2057 (class 2604 OID 18415)
-- Dependencies: 1725 1726 1726
-- Name: id_pai; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE paises ALTER COLUMN id_pai SET DEFAULT nextval('paises_id_pai_seq'::regclass);


--
-- TOC entry 2060 (class 2604 OID 18439)
-- Dependencies: 1732 1731 1732
-- Name: id_par; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE parroquias ALTER COLUMN id_par SET DEFAULT nextval('parroquias_id_par_seq'::regclass);


--
-- TOC entry 2043 (class 2604 OID 17345)
-- Dependencies: 1700 1699
-- Name: id_par_cue; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE partes_cuerpos ALTER COLUMN id_par_cue SET DEFAULT nextval('partes_cuerpos_id_par_cue_seq'::regclass);


--
-- TOC entry 2044 (class 2604 OID 17346)
-- Dependencies: 1702 1701
-- Name: id_pro_est_mic; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE propiedades_estudios_micologicos ALTER COLUMN id_pro_est_mic SET DEFAULT nextval('propiedades_estudios_micologicos_id_pro_est_mic_seq'::regclass);


--
-- TOC entry 2062 (class 2604 OID 18886)
-- Dependencies: 1737 1736 1737
-- Name: id_tie_evo; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE tiempo_evoluciones ALTER COLUMN id_tie_evo SET DEFAULT nextval('tiempo_evoluciones_id_tie_evo_seq'::regclass);


--
-- TOC entry 2045 (class 2604 OID 17347)
-- Dependencies: 1704 1703
-- Name: id_tip_con; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE tipos_consultas ALTER COLUMN id_tip_con SET DEFAULT nextval('tipos_consultas_id_tip_con_seq'::regclass);


--
-- TOC entry 2046 (class 2604 OID 17348)
-- Dependencies: 1706 1705
-- Name: id_tip_con_pac; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE tipos_consultas_pacientes ALTER COLUMN id_tip_con_pac SET DEFAULT nextval('tipos_consultas_pacientes_id_tip_con_pac_seq'::regclass);


--
-- TOC entry 2047 (class 2604 OID 17349)
-- Dependencies: 1708 1707
-- Name: id_tip_est_mic; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE tipos_estudios_micologicos ALTER COLUMN id_tip_est_mic SET DEFAULT nextval('tipos_estudios_micologicos_id_tip_est_mic_seq'::regclass);


--
-- TOC entry 2048 (class 2604 OID 17350)
-- Dependencies: 1710 1709
-- Name: id_tip_mic; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE tipos_micosis ALTER COLUMN id_tip_mic SET DEFAULT nextval('tipos_micosis_id_tip_mic_seq'::regclass);


--
-- TOC entry 2049 (class 2604 OID 17351)
-- Dependencies: 1714 1711
-- Name: id_tip_usu; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE tipos_usuarios ALTER COLUMN id_tip_usu SET DEFAULT nextval('tipos_usuarios_id_tip_usu_seq'::regclass);


--
-- TOC entry 2050 (class 2604 OID 17352)
-- Dependencies: 1713 1712
-- Name: id_tip_usu_usu; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE tipos_usuarios__usuarios ALTER COLUMN id_tip_usu_usu SET DEFAULT nextval('tipos_usuarios__usuarios_id_tip_usu_usu_seq'::regclass);


--
-- TOC entry 2051 (class 2604 OID 17353)
-- Dependencies: 1716 1715
-- Name: id_tip_tra; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE transacciones ALTER COLUMN id_tip_tra SET DEFAULT nextval('transacciones_id_tip_tra_seq'::regclass);


--
-- TOC entry 2052 (class 2604 OID 18030)
-- Dependencies: 1724 1717
-- Name: id_tra_usu; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE transacciones_usuarios ALTER COLUMN id_tra_usu SET DEFAULT nextval('transacciones_usuarios_id_tra_usu_seq'::regclass);


--
-- TOC entry 2053 (class 2604 OID 17355)
-- Dependencies: 1719 1718
-- Name: id_tra; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE tratamientos ALTER COLUMN id_tra SET DEFAULT nextval('tratamientos_id_tra_seq'::regclass);


--
-- TOC entry 2054 (class 2604 OID 17356)
-- Dependencies: 1721 1720
-- Name: id_tra_pac; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE tratamientos_pacientes ALTER COLUMN id_tra_pac SET DEFAULT nextval('tratamientos_pacientes_id_tra_pac_seq'::regclass);


--
-- TOC entry 2055 (class 2604 OID 17357)
-- Dependencies: 1723 1722
-- Name: id_usu_adm; Type: DEFAULT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE usuarios_administrativos ALTER COLUMN id_usu_adm SET DEFAULT nextval('usuarios_administrativos_id_usu_adm_seq'::regclass);


--
-- TOC entry 2269 (class 0 OID 17106)
-- Dependencies: 1649
-- Data for Name: animales; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO animales (id_ani, nom_ani) VALUES (1, 'Perro');
INSERT INTO animales (id_ani, nom_ani) VALUES (2, 'Gato');
INSERT INTO animales (id_ani, nom_ani) VALUES (3, 'Aves');
INSERT INTO animales (id_ani, nom_ani) VALUES (4, 'Animales de Corral');
INSERT INTO animales (id_ani, nom_ani) VALUES (5, 'Otros');


--
-- TOC entry 2270 (class 0 OID 17111)
-- Dependencies: 1651
-- Data for Name: antecedentes_pacientes; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO antecedentes_pacientes (id_ant_pac, id_ant_per, id_pac) VALUES (12, 2, 28);
INSERT INTO antecedentes_pacientes (id_ant_pac, id_ant_per, id_pac) VALUES (13, 3, 28);
INSERT INTO antecedentes_pacientes (id_ant_pac, id_ant_per, id_pac) VALUES (18, 2, 27);
INSERT INTO antecedentes_pacientes (id_ant_pac, id_ant_per, id_pac) VALUES (19, 3, 27);
INSERT INTO antecedentes_pacientes (id_ant_pac, id_ant_per, id_pac) VALUES (22, 9, 7);
INSERT INTO antecedentes_pacientes (id_ant_pac, id_ant_per, id_pac) VALUES (23, 11, 7);
INSERT INTO antecedentes_pacientes (id_ant_pac, id_ant_per, id_pac) VALUES (24, 12, 7);
INSERT INTO antecedentes_pacientes (id_ant_pac, id_ant_per, id_pac) VALUES (25, 1, 13);


--
-- TOC entry 2271 (class 0 OID 17116)
-- Dependencies: 1653
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
-- TOC entry 2272 (class 0 OID 17121)
-- Dependencies: 1655
-- Data for Name: auditoria_transacciones; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--



--
-- TOC entry 2273 (class 0 OID 17126)
-- Dependencies: 1657
-- Data for Name: categorias__cuerpos_micosis; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--



--
-- TOC entry 2274 (class 0 OID 17131)
-- Dependencies: 1659
-- Data for Name: categorias_cuerpos; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--



--
-- TOC entry 2275 (class 0 OID 17136)
-- Dependencies: 1661
-- Data for Name: categorias_cuerpos_partes_cuerpos; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--



--
-- TOC entry 2311 (class 0 OID 18773)
-- Dependencies: 1734
-- Data for Name: centro_salud_doctores; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO centro_salud_doctores (id_cen_sal_doc, id_cen_sal, id_doc, otr_cen_sal) VALUES (5, 5, 33, NULL);
INSERT INTO centro_salud_doctores (id_cen_sal_doc, id_cen_sal, id_doc, otr_cen_sal) VALUES (6, 6, 6, NULL);
INSERT INTO centro_salud_doctores (id_cen_sal_doc, id_cen_sal, id_doc, otr_cen_sal) VALUES (9, 5, 34, NULL);
INSERT INTO centro_salud_doctores (id_cen_sal_doc, id_cen_sal, id_doc, otr_cen_sal) VALUES (11, 7, 32, NULL);


--
-- TOC entry 2277 (class 0 OID 17146)
-- Dependencies: 1665
-- Data for Name: centro_salud_pacientes; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO centro_salud_pacientes (id_cen_sal_pac, id_his, id_cen_sal, otr_cen_sal) VALUES (20, 3, 5, NULL);
INSERT INTO centro_salud_pacientes (id_cen_sal_pac, id_his, id_cen_sal, otr_cen_sal) VALUES (33, 16, 5, NULL);
INSERT INTO centro_salud_pacientes (id_cen_sal_pac, id_his, id_cen_sal, otr_cen_sal) VALUES (34, 16, 4, NULL);


--
-- TOC entry 2276 (class 0 OID 17141)
-- Dependencies: 1663
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


--
-- TOC entry 2278 (class 0 OID 17161)
-- Dependencies: 1667
-- Data for Name: contactos_animales; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO contactos_animales (id_con_ani, id_his, id_ani, otr_ani) VALUES (16, 16, 2, NULL);


--
-- TOC entry 2279 (class 0 OID 17166)
-- Dependencies: 1669
-- Data for Name: doctores; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO doctores (id_doc, nom_doc, ape_doc, ced_doc, pas_doc, tel_doc, cor_doc, log_doc, fec_reg_doc) VALUES (27, 'SAIB', 'SAIB', NULL, '83422503bcfc01d303030e8a7cc80efc', '3622824', NULL, 'SAIB', '2011-06-26 01:06:59.641-04:30');
INSERT INTO doctores (id_doc, nom_doc, ape_doc, ced_doc, pas_doc, tel_doc, cor_doc, log_doc, fec_reg_doc) VALUES (33, 'Mary', 'Lopez', '8752299', '9f4b04c2eac4a3cfa351aff1564f7995', '54564545646', 'mlopez@gmail.com', 'mlopez', '2011-06-26 01:06:59.641-04:30');
INSERT INTO doctores (id_doc, nom_doc, ape_doc, ced_doc, pas_doc, tel_doc, cor_doc, log_doc, fec_reg_doc) VALUES (28, 'Mireya', 'Gonzalez', '17302859', '3e46a122f1961a8ec71f2a369f6d16ee', '04265168824', NULL, 'mgonzalez', '2011-06-26 01:06:59.641-04:30');
INSERT INTO doctores (id_doc, nom_doc, ape_doc, ced_doc, pas_doc, tel_doc, cor_doc, log_doc, fec_reg_doc) VALUES (6, 'Luis', 'Marin', '17302857', '3e46a122f1961a8ec71f2a369f6d16ee', '3622222', 'ninja.aoshi@gmail.com', 'lmarin', '2011-06-26 01:06:59.641-04:30');
INSERT INTO doctores (id_doc, nom_doc, ape_doc, ced_doc, pas_doc, tel_doc, cor_doc, log_doc, fec_reg_doc) VALUES (34, 'Luis', 'Marin', '17302858', '3e46a122f1961a8ec71f2a369f6d16ee', '3622222', 'lrm.prigramador@gmail.com', 'lmarinn', '2011-07-08 15:58:52.908-04:30');
INSERT INTO doctores (id_doc, nom_doc, ape_doc, ced_doc, pas_doc, tel_doc, cor_doc, log_doc, fec_reg_doc) VALUES (32, 'Lisseth', 'Lozada', '17651233', '3e46a122f1961a8ec71f2a369f6d16ee', '04269150722', 'risusefu15@gmail.com', 'llozada', '2011-06-26 01:06:59.641-04:30');


--
-- TOC entry 2280 (class 0 OID 17174)
-- Dependencies: 1671
-- Data for Name: enfermedades_micologicas; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--



--
-- TOC entry 2281 (class 0 OID 17179)
-- Dependencies: 1673
-- Data for Name: enfermedades_pacientes; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--



--
-- TOC entry 2308 (class 0 OID 18420)
-- Dependencies: 1728
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
-- TOC entry 2282 (class 0 OID 17184)
-- Dependencies: 1675
-- Data for Name: estudios_micologicos__pacientes; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--



--
-- TOC entry 2283 (class 0 OID 17189)
-- Dependencies: 1677
-- Data for Name: forma_infecciones; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--



--
-- TOC entry 2284 (class 0 OID 17192)
-- Dependencies: 1678
-- Data for Name: forma_infecciones__pacientes; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--



--
-- TOC entry 2285 (class 0 OID 17197)
-- Dependencies: 1680
-- Data for Name: forma_infecciones__tipos_micosis; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--



--
-- TOC entry 2286 (class 0 OID 17204)
-- Dependencies: 1683
-- Data for Name: historiales_pacientes; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO historiales_pacientes (id_his, id_pac, des_his, id_doc, des_adi_pac_his, fec_his) VALUES (9, 7, '', 6, '', '2011-07-08 12:11:11.417-04:30');
INSERT INTO historiales_pacientes (id_his, id_pac, des_his, id_doc, des_adi_pac_his, fec_his) VALUES (3, 7, 'Nuevamente se inicia otra historia para hacer un seguimiento de rastros de una enfermedad de la piel', 6, 'El paciente por visualizacion padece de una coloracion en la piel.', '2011-07-01 10:24:00.188-04:30');
INSERT INTO historiales_pacientes (id_his, id_pac, des_his, id_doc, des_adi_pac_his, fec_his) VALUES (15, 13, 'demo', 6, '', '2011-07-13 14:01:14.823-04:30');
INSERT INTO historiales_pacientes (id_his, id_pac, des_his, id_doc, des_adi_pac_his, fec_his) VALUES (16, 7, 'demops', 6, 'demos', '2011-07-24 09:39:20.062-04:30');


--
-- TOC entry 2287 (class 0 OID 17209)
-- Dependencies: 1685
-- Data for Name: lesiones__partes_cuerpos; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--



--
-- TOC entry 2288 (class 0 OID 17214)
-- Dependencies: 1687
-- Data for Name: lesiones_partes_cuerpos__pacientes; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--



--
-- TOC entry 2289 (class 0 OID 17219)
-- Dependencies: 1689
-- Data for Name: localizaciones_cuerpos; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--



--
-- TOC entry 2290 (class 0 OID 17229)
-- Dependencies: 1691
-- Data for Name: modulos; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO modulos (id_mod, cod_mod, des_mod, id_tip_usu) VALUES (1, 'C', 'Configuración', 2);
INSERT INTO modulos (id_mod, cod_mod, des_mod, id_tip_usu) VALUES (2, 'R', 'Reportes', 2);


--
-- TOC entry 2291 (class 0 OID 17234)
-- Dependencies: 1693
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
-- TOC entry 2292 (class 0 OID 17239)
-- Dependencies: 1695
-- Data for Name: muestras_pacientes; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--



--
-- TOC entry 2309 (class 0 OID 18428)
-- Dependencies: 1730
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
-- TOC entry 2293 (class 0 OID 17244)
-- Dependencies: 1697
-- Data for Name: pacientes; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO pacientes (id_pac, ape_pac, nom_pac, ced_pac, fec_nac_pac, nac_pac, tel_hab_pac, tel_cel_pac, ocu_pac, ciu_pac, id_pai, id_est, id_mun, id_par, num_pac, id_doc, fec_reg_pac) VALUES (11, 'Hernandez', 'Jose', '17123098', '1976-08-21', '1', '02125682345', '04141235687', '1', 'Caracas', 1, 1, 1, NULL, 4, 27, '2011-06-11 20:03:33.627-04:30');
INSERT INTO pacientes (id_pac, ape_pac, nom_pac, ced_pac, fec_nac_pac, nac_pac, tel_hab_pac, tel_cel_pac, ocu_pac, ciu_pac, id_pai, id_est, id_mun, id_par, num_pac, id_doc, fec_reg_pac) VALUES (12, 'Contreras', 'Gisela ', '13456094', '1970-09-25', '2', '00000', '00000', '4', 'Los Teques', 1, 1, 196, NULL, 5, 27, '2011-06-11 20:20:43.702-04:30');
INSERT INTO pacientes (id_pac, ape_pac, nom_pac, ced_pac, fec_nac_pac, nac_pac, tel_hab_pac, tel_cel_pac, ocu_pac, ciu_pac, id_pai, id_est, id_mun, id_par, num_pac, id_doc, fec_reg_pac) VALUES (14, 'Wester', 'Mary', '8752299', '1965-05-02', '1', '02129874523', '042691587412', '6', 'Guarenas', 1, 1, 193, NULL, 7, 27, '2011-06-11 22:08:34.736-04:30');
INSERT INTO pacientes (id_pac, ape_pac, nom_pac, ced_pac, fec_nac_pac, nac_pac, tel_hab_pac, tel_cel_pac, ocu_pac, ciu_pac, id_pai, id_est, id_mun, id_par, num_pac, id_doc, fec_reg_pac) VALUES (16, 'Paciente', 'Paciente', '17302857', '2011-07-09', '1', '3622824', '17302857', '1', 'Guarenas', 1, 1, 69, NULL, 6, 6, '2011-07-08 18:14:22.448-04:30');
INSERT INTO pacientes (id_pac, ape_pac, nom_pac, ced_pac, fec_nac_pac, nac_pac, tel_hab_pac, tel_cel_pac, ocu_pac, ciu_pac, id_pai, id_est, id_mun, id_par, num_pac, id_doc, fec_reg_pac) VALUES (28, 'sdf', 'demo', '12345', '2011-07-27', '1', '3622222', '17302857', '2', 'Guarenas', 1, 1, 3, NULL, 8, 6, '2011-07-27 21:20:09.521-04:30');
INSERT INTO pacientes (id_pac, ape_pac, nom_pac, ced_pac, fec_nac_pac, nac_pac, tel_hab_pac, tel_cel_pac, ocu_pac, ciu_pac, id_pai, id_est, id_mun, id_par, num_pac, id_doc, fec_reg_pac) VALUES (27, 'asd', 'demo', '1234', '2011-07-27', '1', '3622222', '173028555', '1', 'Guarenas', 1, 1, 1, NULL, 7, 6, '2011-07-27 21:12:19.655-04:30');
INSERT INTO pacientes (id_pac, ape_pac, nom_pac, ced_pac, fec_nac_pac, nac_pac, tel_hab_pac, tel_cel_pac, ocu_pac, ciu_pac, id_pai, id_est, id_mun, id_par, num_pac, id_doc, fec_reg_pac) VALUES (7, 'Lozada', 'Adriana', '17651233', '2011-09-06', '1', '3622824', '04265168824', '2', 'Guarenas', 1, 1, 1, NULL, 1, 6, '2011-06-11 20:03:33.627-04:30');
INSERT INTO pacientes (id_pac, ape_pac, nom_pac, ced_pac, fec_nac_pac, nac_pac, tel_hab_pac, tel_cel_pac, ocu_pac, ciu_pac, id_pai, id_est, id_mun, id_par, num_pac, id_doc, fec_reg_pac) VALUES (13, 'Beltran', 'Carlos', '7098456', '1961-05-02', '1', '0000', '0000', '4', 'Merida', 1, 1, 1, NULL, 6, 27, '2011-06-11 20:35:37.372-04:30');


--
-- TOC entry 2307 (class 0 OID 18412)
-- Dependencies: 1726
-- Data for Name: paises; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO paises (id_pai, des_pai, cod_pai) VALUES (1, 'Venezuela', 'VEN');


--
-- TOC entry 2310 (class 0 OID 18436)
-- Dependencies: 1732
-- Data for Name: parroquias; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--



--
-- TOC entry 2294 (class 0 OID 17252)
-- Dependencies: 1699
-- Data for Name: partes_cuerpos; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--



--
-- TOC entry 2295 (class 0 OID 17257)
-- Dependencies: 1701
-- Data for Name: propiedades_estudios_micologicos; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--



--
-- TOC entry 2312 (class 0 OID 18883)
-- Dependencies: 1737
-- Data for Name: tiempo_evoluciones; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO tiempo_evoluciones (id_tie_evo, id_his, tie_evo) VALUES (1, 16, 1);
INSERT INTO tiempo_evoluciones (id_tie_evo, id_his, tie_evo) VALUES (2, 3, 5);


--
-- TOC entry 2296 (class 0 OID 17262)
-- Dependencies: 1703
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


--
-- TOC entry 2297 (class 0 OID 17267)
-- Dependencies: 1705
-- Data for Name: tipos_consultas_pacientes; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO tipos_consultas_pacientes (id_tip_con_pac, id_tip_con, id_his, otr_tip_con) VALUES (43, 1, 16, NULL);
INSERT INTO tipos_consultas_pacientes (id_tip_con_pac, id_tip_con, id_his, otr_tip_con) VALUES (44, 5, 16, NULL);


--
-- TOC entry 2298 (class 0 OID 17272)
-- Dependencies: 1707
-- Data for Name: tipos_estudios_micologicos; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--



--
-- TOC entry 2299 (class 0 OID 17277)
-- Dependencies: 1709
-- Data for Name: tipos_micosis; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--



--
-- TOC entry 2300 (class 0 OID 17282)
-- Dependencies: 1711
-- Data for Name: tipos_usuarios; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO tipos_usuarios (id_tip_usu, cod_tip_usu, des_tip_usu) VALUES (1, 'adm', 'Administrador');
INSERT INTO tipos_usuarios (id_tip_usu, cod_tip_usu, des_tip_usu) VALUES (2, 'med', 'Médicos');


--
-- TOC entry 2301 (class 0 OID 17285)
-- Dependencies: 1712
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


--
-- TOC entry 2302 (class 0 OID 17292)
-- Dependencies: 1715
-- Data for Name: transacciones; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO transacciones (id_tip_tra, cod_tip_tra, des_tip_tra, id_mod) VALUES (1, 'RED', 'Registrar enfermedades dermatologicas', 1);
INSERT INTO transacciones (id_tip_tra, cod_tip_tra, des_tip_tra, id_mod) VALUES (2, 'MED', 'Modificar enfermedades dermatologicas', 1);
INSERT INTO transacciones (id_tip_tra, cod_tip_tra, des_tip_tra, id_mod) VALUES (3, 'EED', 'Eliminar enfermedades dermatologicas', 1);
INSERT INTO transacciones (id_tip_tra, cod_tip_tra, des_tip_tra, id_mod) VALUES (4, 'REF', 'Reportes de las estadisticas por enfermedad', 2);


--
-- TOC entry 2303 (class 0 OID 17297)
-- Dependencies: 1717
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
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (1, 44, 64);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (2, 44, 65);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (3, 44, 66);
INSERT INTO transacciones_usuarios (id_tip_tra, id_tip_usu_usu, id_tra_usu) VALUES (4, 44, 67);


--
-- TOC entry 2304 (class 0 OID 17302)
-- Dependencies: 1718
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
-- TOC entry 2305 (class 0 OID 17307)
-- Dependencies: 1720
-- Data for Name: tratamientos_pacientes; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO tratamientos_pacientes (id_tra_pac, id_his, id_tra, otr_tra) VALUES (17, 16, 7, NULL);
INSERT INTO tratamientos_pacientes (id_tra_pac, id_his, id_tra, otr_tra) VALUES (18, 16, 6, NULL);
INSERT INTO tratamientos_pacientes (id_tra_pac, id_his, id_tra, otr_tra) VALUES (19, 16, 5, NULL);
INSERT INTO tratamientos_pacientes (id_tra_pac, id_his, id_tra, otr_tra) VALUES (20, 16, 9, NULL);
INSERT INTO tratamientos_pacientes (id_tra_pac, id_his, id_tra, otr_tra) VALUES (21, 16, 8, NULL);
INSERT INTO tratamientos_pacientes (id_tra_pac, id_his, id_tra, otr_tra) VALUES (22, 16, 4, NULL);
INSERT INTO tratamientos_pacientes (id_tra_pac, id_his, id_tra, otr_tra) VALUES (23, 16, 3, NULL);


--
-- TOC entry 2306 (class 0 OID 17312)
-- Dependencies: 1722
-- Data for Name: usuarios_administrativos; Type: TABLE DATA; Schema: public; Owner: desarrollo_g
--

INSERT INTO usuarios_administrativos (id_usu_adm, nom_usu_adm, ape_usu_adm, pas_usu_adm, log_usu_adm, tel_usu_adm, fec_reg_usu_adm, adm_usu) VALUES (17, 'SAIB', 'SAIB', 'fcc8c0a57ab902388613f2782eae3dd6', 'SAIB', '04162102903', '2011-06-04 14:24:44.315', true);
INSERT INTO usuarios_administrativos (id_usu_adm, nom_usu_adm, ape_usu_adm, pas_usu_adm, log_usu_adm, tel_usu_adm, fec_reg_usu_adm, adm_usu) VALUES (21, 'Luis', 'Marin', '3e46a122f1961a8ec71f2a369f6d16ee', 'lmarin', '04265168824', '2011-06-10 20:02:12.07', true);
INSERT INTO usuarios_administrativos (id_usu_adm, nom_usu_adm, ape_usu_adm, pas_usu_adm, log_usu_adm, tel_usu_adm, fec_reg_usu_adm, adm_usu) VALUES (23, 'lmarin', 'marin', '3e46a122f1961a8ec71f2a369f6d16ee', 'lmarin2', '36222222', '2011-07-08 16:10:19.402', true);
INSERT INTO usuarios_administrativos (id_usu_adm, nom_usu_adm, ape_usu_adm, pas_usu_adm, log_usu_adm, tel_usu_adm, fec_reg_usu_adm, adm_usu) VALUES (22, 'Lisseth', 'Lozada', '3e46a122f1961a8ec71f2a369f6d16ee', 'llozada', '04269150722', '2011-06-24 15:22:46.934', true);


SET default_tablespace = '';

--
-- TOC entry 2066 (class 2606 OID 17359)
-- Dependencies: 1649 1649
-- Name: animales_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY animales
    ADD CONSTRAINT animales_pkey PRIMARY KEY (id_ani);


--
-- TOC entry 2068 (class 2606 OID 17361)
-- Dependencies: 1651 1651
-- Name: antecedentes_pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY antecedentes_pacientes
    ADD CONSTRAINT antecedentes_pacientes_pkey PRIMARY KEY (id_ant_pac);


--
-- TOC entry 2071 (class 2606 OID 17365)
-- Dependencies: 1653 1653
-- Name: antecedentes_personales_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY antecedentes_personales
    ADD CONSTRAINT antecedentes_personales_pkey PRIMARY KEY (id_ant_per);


SET default_tablespace = saib;

--
-- TOC entry 2073 (class 2606 OID 17367)
-- Dependencies: 1655 1655
-- Name: auditoria_transacciones_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

ALTER TABLE ONLY auditoria_transacciones
    ADD CONSTRAINT auditoria_transacciones_pkey PRIMARY KEY (id_aud_tra);


SET default_tablespace = '';

--
-- TOC entry 2076 (class 2606 OID 17369)
-- Dependencies: 1657 1657
-- Name: categorias__cuerpos_micosis_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY categorias__cuerpos_micosis
    ADD CONSTRAINT categorias__cuerpos_micosis_pkey PRIMARY KEY (id_cat_cue_mic);


--
-- TOC entry 2078 (class 2606 OID 17371)
-- Dependencies: 1657 1657 1657
-- Name: categorias__cuerpos_micosis_unique; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY categorias__cuerpos_micosis
    ADD CONSTRAINT categorias__cuerpos_micosis_unique UNIQUE (id_cat_cue, id_tip_mic);


--
-- TOC entry 2083 (class 2606 OID 17373)
-- Dependencies: 1661 1661
-- Name: categorias_cuerpos_partes_cuerpos_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY categorias_cuerpos_partes_cuerpos
    ADD CONSTRAINT categorias_cuerpos_partes_cuerpos_pkey PRIMARY KEY (id_cat_cue_par_cue);


--
-- TOC entry 2085 (class 2606 OID 17375)
-- Dependencies: 1661 1661 1661
-- Name: categorias_cuerpos_partes_cuerpos_unique; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY categorias_cuerpos_partes_cuerpos
    ADD CONSTRAINT categorias_cuerpos_partes_cuerpos_unique UNIQUE (id_par_cue, id_cat_cue);


--
-- TOC entry 2081 (class 2606 OID 17377)
-- Dependencies: 1659 1659
-- Name: categorias_cuerpos_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY categorias_cuerpos
    ADD CONSTRAINT categorias_cuerpos_pkey PRIMARY KEY (id_cat_cue);


--
-- TOC entry 2211 (class 2606 OID 18778)
-- Dependencies: 1734 1734
-- Name: centro_salud_doctores_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY centro_salud_doctores
    ADD CONSTRAINT centro_salud_doctores_pkey PRIMARY KEY (id_cen_sal_doc);


--
-- TOC entry 2213 (class 2606 OID 18780)
-- Dependencies: 1734 1734 1734
-- Name: centro_salud_doctores_unique; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY centro_salud_doctores
    ADD CONSTRAINT centro_salud_doctores_unique UNIQUE (id_doc, id_cen_sal);


--
-- TOC entry 2091 (class 2606 OID 17379)
-- Dependencies: 1665 1665
-- Name: centro_salud_pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY centro_salud_pacientes
    ADD CONSTRAINT centro_salud_pacientes_pkey PRIMARY KEY (id_cen_sal_pac);


--
-- TOC entry 2093 (class 2606 OID 17381)
-- Dependencies: 1665 1665 1665
-- Name: centro_salud_pacientes_unique; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY centro_salud_pacientes
    ADD CONSTRAINT centro_salud_pacientes_unique UNIQUE (id_his, id_cen_sal);


--
-- TOC entry 2088 (class 2606 OID 17383)
-- Dependencies: 1663 1663
-- Name: centro_salud_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY centro_saluds
    ADD CONSTRAINT centro_salud_pkey PRIMARY KEY (id_cen_sal);


--
-- TOC entry 2096 (class 2606 OID 17389)
-- Dependencies: 1667 1667
-- Name: contactos_animales_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY contactos_animales
    ADD CONSTRAINT contactos_animales_pkey PRIMARY KEY (id_con_ani);


--
-- TOC entry 2098 (class 2606 OID 17391)
-- Dependencies: 1667 1667 1667
-- Name: contactos_animales_unique; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY contactos_animales
    ADD CONSTRAINT contactos_animales_unique UNIQUE (id_his, id_ani);


--
-- TOC entry 2100 (class 2606 OID 17393)
-- Dependencies: 1669 1669
-- Name: doctores_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY doctores
    ADD CONSTRAINT doctores_pkey PRIMARY KEY (id_doc);


--
-- TOC entry 2103 (class 2606 OID 17395)
-- Dependencies: 1671 1671
-- Name: enfermedades_micologicas_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY enfermedades_micologicas
    ADD CONSTRAINT enfermedades_micologicas_pkey PRIMARY KEY (id_enf_mic);


--
-- TOC entry 2106 (class 2606 OID 17397)
-- Dependencies: 1673 1673
-- Name: enfermedades_pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY enfermedades_pacientes
    ADD CONSTRAINT enfermedades_pacientes_pkey PRIMARY KEY (id_enf_pac);


--
-- TOC entry 2108 (class 2606 OID 17399)
-- Dependencies: 1673 1673 1673
-- Name: enfermedades_pacientes_unique; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY enfermedades_pacientes
    ADD CONSTRAINT enfermedades_pacientes_unique UNIQUE (id_his, id_enf_mic);


--
-- TOC entry 2204 (class 2606 OID 18425)
-- Dependencies: 1728 1728
-- Name: estados_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY estados
    ADD CONSTRAINT estados_pkey PRIMARY KEY (id_est);


--
-- TOC entry 2111 (class 2606 OID 17401)
-- Dependencies: 1675 1675
-- Name: estudios_micologicos__pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY estudios_micologicos__pacientes
    ADD CONSTRAINT estudios_micologicos__pacientes_pkey PRIMARY KEY (id_est_mic_pac);


--
-- TOC entry 2113 (class 2606 OID 17403)
-- Dependencies: 1675 1675 1675
-- Name: estudios_micologicos__pacientes_unique; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY estudios_micologicos__pacientes
    ADD CONSTRAINT estudios_micologicos__pacientes_unique UNIQUE (id_his, id_pro_est_mic);


--
-- TOC entry 2119 (class 2606 OID 17405)
-- Dependencies: 1678 1678
-- Name: forma_infecciones__pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY forma_infecciones__pacientes
    ADD CONSTRAINT forma_infecciones__pacientes_pkey PRIMARY KEY (id_for_pac);


--
-- TOC entry 2121 (class 2606 OID 17407)
-- Dependencies: 1678 1678 1678
-- Name: forma_infecciones__pacientes_unique; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY forma_infecciones__pacientes
    ADD CONSTRAINT forma_infecciones__pacientes_unique UNIQUE (id_for_inf, id_his);


--
-- TOC entry 2124 (class 2606 OID 17409)
-- Dependencies: 1680 1680
-- Name: forma_infecciones__tipos_micosis_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY forma_infecciones__tipos_micosis
    ADD CONSTRAINT forma_infecciones__tipos_micosis_pkey PRIMARY KEY (id_for_inf_tip_mic);


--
-- TOC entry 2126 (class 2606 OID 17411)
-- Dependencies: 1680 1680 1680
-- Name: forma_infecciones__tipos_micosis_unique; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY forma_infecciones__tipos_micosis
    ADD CONSTRAINT forma_infecciones__tipos_micosis_unique UNIQUE (id_tip_mic, id_for_inf);


--
-- TOC entry 2116 (class 2606 OID 17413)
-- Dependencies: 1677 1677
-- Name: forma_infecciones_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY forma_infecciones
    ADD CONSTRAINT forma_infecciones_pkey PRIMARY KEY (id_for_inf);


--
-- TOC entry 2129 (class 2606 OID 17415)
-- Dependencies: 1683 1683
-- Name: historiales_pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY historiales_pacientes
    ADD CONSTRAINT historiales_pacientes_pkey PRIMARY KEY (id_his);


--
-- TOC entry 2132 (class 2606 OID 17417)
-- Dependencies: 1685 1685
-- Name: lesiones__partes_cuerpos_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY lesiones__partes_cuerpos
    ADD CONSTRAINT lesiones__partes_cuerpos_pkey PRIMARY KEY (id_les_par_cue);


--
-- TOC entry 2135 (class 2606 OID 17419)
-- Dependencies: 1687 1687
-- Name: lesiones_partes_cuerpos__pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY lesiones_partes_cuerpos__pacientes
    ADD CONSTRAINT lesiones_partes_cuerpos__pacientes_pkey PRIMARY KEY (id_les_par_cue_pac);


--
-- TOC entry 2137 (class 2606 OID 17421)
-- Dependencies: 1687 1687 1687
-- Name: lesiones_partes_cuerpos__pacientes_unique; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY lesiones_partes_cuerpos__pacientes
    ADD CONSTRAINT lesiones_partes_cuerpos__pacientes_unique UNIQUE (id_his, id_les_par_cue);


--
-- TOC entry 2140 (class 2606 OID 17423)
-- Dependencies: 1689 1689
-- Name: localizaciones_cuerpos_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY localizaciones_cuerpos
    ADD CONSTRAINT localizaciones_cuerpos_pkey PRIMARY KEY (id_loc_cue);


--
-- TOC entry 2142 (class 2606 OID 17849)
-- Dependencies: 1691 1691 1691
-- Name: modulos_cod_mod_unique; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY modulos
    ADD CONSTRAINT modulos_cod_mod_unique UNIQUE (cod_mod, id_tip_usu);


--
-- TOC entry 2144 (class 2606 OID 17427)
-- Dependencies: 1691 1691
-- Name: modulos_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY modulos
    ADD CONSTRAINT modulos_pkey PRIMARY KEY (id_mod);


--
-- TOC entry 2147 (class 2606 OID 17429)
-- Dependencies: 1693 1693
-- Name: muestras_clinicas_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY muestras_clinicas
    ADD CONSTRAINT muestras_clinicas_pkey PRIMARY KEY (id_mue_cli);


--
-- TOC entry 2149 (class 2606 OID 17431)
-- Dependencies: 1695 1695
-- Name: muestras_pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY muestras_pacientes
    ADD CONSTRAINT muestras_pacientes_pkey PRIMARY KEY (id_mue_pac);


--
-- TOC entry 2151 (class 2606 OID 17433)
-- Dependencies: 1695 1695 1695
-- Name: muestras_pacientes_unique; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY muestras_pacientes
    ADD CONSTRAINT muestras_pacientes_unique UNIQUE (id_his, id_mue_cli);


--
-- TOC entry 2206 (class 2606 OID 18433)
-- Dependencies: 1730 1730
-- Name: municipios_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY municipios
    ADD CONSTRAINT municipios_pkey PRIMARY KEY (id_mun);


--
-- TOC entry 2154 (class 2606 OID 17435)
-- Dependencies: 1697 1697
-- Name: pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY pacientes
    ADD CONSTRAINT pacientes_pkey PRIMARY KEY (id_pac);


--
-- TOC entry 2202 (class 2606 OID 18417)
-- Dependencies: 1726 1726
-- Name: paises_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY paises
    ADD CONSTRAINT paises_pkey PRIMARY KEY (id_pai);


--
-- TOC entry 2208 (class 2606 OID 18441)
-- Dependencies: 1732 1732
-- Name: parroquias_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY parroquias
    ADD CONSTRAINT parroquias_pkey PRIMARY KEY (id_par);


--
-- TOC entry 2157 (class 2606 OID 17437)
-- Dependencies: 1699 1699
-- Name: partes_cuerpos_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY partes_cuerpos
    ADD CONSTRAINT partes_cuerpos_pkey PRIMARY KEY (id_par_cue);


--
-- TOC entry 2160 (class 2606 OID 17439)
-- Dependencies: 1701 1701
-- Name: propiedades_estudios_micologicos_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY propiedades_estudios_micologicos
    ADD CONSTRAINT propiedades_estudios_micologicos_pkey PRIMARY KEY (id_pro_est_mic);


--
-- TOC entry 2215 (class 2606 OID 18906)
-- Dependencies: 1737 1737
-- Name: tiempo_evoluciones_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY tiempo_evoluciones
    ADD CONSTRAINT tiempo_evoluciones_pkey PRIMARY KEY (id_tie_evo);


--
-- TOC entry 2166 (class 2606 OID 17441)
-- Dependencies: 1705 1705
-- Name: tipos_consultas_pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY tipos_consultas_pacientes
    ADD CONSTRAINT tipos_consultas_pacientes_pkey PRIMARY KEY (id_tip_con_pac);


--
-- TOC entry 2168 (class 2606 OID 17443)
-- Dependencies: 1705 1705 1705
-- Name: tipos_consultas_pacientes_unique; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY tipos_consultas_pacientes
    ADD CONSTRAINT tipos_consultas_pacientes_unique UNIQUE (id_tip_con, id_his);


--
-- TOC entry 2163 (class 2606 OID 17445)
-- Dependencies: 1703 1703
-- Name: tipos_consultas_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY tipos_consultas
    ADD CONSTRAINT tipos_consultas_pkey PRIMARY KEY (id_tip_con);


--
-- TOC entry 2171 (class 2606 OID 17447)
-- Dependencies: 1707 1707
-- Name: tipos_estudios_micologicos_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY tipos_estudios_micologicos
    ADD CONSTRAINT tipos_estudios_micologicos_pkey PRIMARY KEY (id_tip_est_mic);


--
-- TOC entry 2174 (class 2606 OID 17449)
-- Dependencies: 1709 1709
-- Name: tipos_micosis_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY tipos_micosis
    ADD CONSTRAINT tipos_micosis_pkey PRIMARY KEY (id_tip_mic);


--
-- TOC entry 2180 (class 2606 OID 17451)
-- Dependencies: 1712 1712
-- Name: tipos_usuarios__usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY tipos_usuarios__usuarios
    ADD CONSTRAINT tipos_usuarios__usuarios_pkey PRIMARY KEY (id_tip_usu_usu);


--
-- TOC entry 2176 (class 2606 OID 17453)
-- Dependencies: 1711 1711
-- Name: tipos_usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY tipos_usuarios
    ADD CONSTRAINT tipos_usuarios_pkey PRIMARY KEY (id_tip_usu);


SET default_tablespace = saib;

--
-- TOC entry 2178 (class 2606 OID 17744)
-- Dependencies: 1711 1711
-- Name: tipos_usuarios_unique; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

ALTER TABLE ONLY tipos_usuarios
    ADD CONSTRAINT tipos_usuarios_unique UNIQUE (cod_tip_usu);


SET default_tablespace = '';

--
-- TOC entry 2184 (class 2606 OID 17818)
-- Dependencies: 1715 1715 1715
-- Name: transacciones_cod_tip_tra__id_mod; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY transacciones
    ADD CONSTRAINT transacciones_cod_tip_tra__id_mod UNIQUE (id_mod, cod_tip_tra);


--
-- TOC entry 2186 (class 2606 OID 17455)
-- Dependencies: 1715 1715
-- Name: transacciones_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY transacciones
    ADD CONSTRAINT transacciones_pkey PRIMARY KEY (id_tip_tra);


--
-- TOC entry 2188 (class 2606 OID 18032)
-- Dependencies: 1717 1717
-- Name: transacciones_usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY transacciones_usuarios
    ADD CONSTRAINT transacciones_usuarios_pkey PRIMARY KEY (id_tra_usu);


--
-- TOC entry 2194 (class 2606 OID 17459)
-- Dependencies: 1720 1720
-- Name: tratamientos_pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY tratamientos_pacientes
    ADD CONSTRAINT tratamientos_pacientes_pkey PRIMARY KEY (id_tra_pac);


--
-- TOC entry 2196 (class 2606 OID 17461)
-- Dependencies: 1720 1720 1720
-- Name: tratamientos_pacientes_unique; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY tratamientos_pacientes
    ADD CONSTRAINT tratamientos_pacientes_unique UNIQUE (id_his, id_tra);


--
-- TOC entry 2191 (class 2606 OID 17463)
-- Dependencies: 1718 1718
-- Name: tratamientos_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY tratamientos
    ADD CONSTRAINT tratamientos_pkey PRIMARY KEY (id_tra);


--
-- TOC entry 2182 (class 2606 OID 17469)
-- Dependencies: 1712 1712 1712 1712
-- Name: unique_tipos_usuarios__usuarios; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY tipos_usuarios__usuarios
    ADD CONSTRAINT unique_tipos_usuarios__usuarios UNIQUE (id_doc, id_usu_adm, id_tip_usu);


--
-- TOC entry 2198 (class 2606 OID 17892)
-- Dependencies: 1722 1722
-- Name: usuarios_administrativos_log_usu_adm_unique; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: 
--

ALTER TABLE ONLY usuarios_administrativos
    ADD CONSTRAINT usuarios_administrativos_log_usu_adm_unique UNIQUE (log_usu_adm);


SET default_tablespace = saib;

--
-- TOC entry 2200 (class 2606 OID 17473)
-- Dependencies: 1722 1722
-- Name: usuarios_administrativos_pkey; Type: CONSTRAINT; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

ALTER TABLE ONLY usuarios_administrativos
    ADD CONSTRAINT usuarios_administrativos_pkey PRIMARY KEY (id_usu_adm);


--
-- TOC entry 2064 (class 1259 OID 17474)
-- Dependencies: 1649
-- Name: animales_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX animales_index ON animales USING btree (id_ani);


--
-- TOC entry 2069 (class 1259 OID 17476)
-- Dependencies: 1653
-- Name: antecedentes_personales_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX antecedentes_personales_index ON antecedentes_personales USING btree (id_ant_per);


--
-- TOC entry 2074 (class 1259 OID 17477)
-- Dependencies: 1657
-- Name: categorias__cuerpos_micosis_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX categorias__cuerpos_micosis_index ON categorias__cuerpos_micosis USING btree (id_cat_cue_mic);


--
-- TOC entry 2079 (class 1259 OID 17478)
-- Dependencies: 1659
-- Name: categorias_cuerpos_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX categorias_cuerpos_index ON categorias_cuerpos USING btree (id_cat_cue);


SET default_tablespace = '';

--
-- TOC entry 2209 (class 1259 OID 18791)
-- Dependencies: 1734 1734 1734
-- Name: centro_salud_doctores_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: 
--

CREATE INDEX centro_salud_doctores_index ON centro_salud_doctores USING btree (id_cen_sal_doc, id_doc, id_cen_sal);


SET default_tablespace = saib;

--
-- TOC entry 2086 (class 1259 OID 17479)
-- Dependencies: 1663
-- Name: centro_salud_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX centro_salud_index ON centro_saluds USING btree (id_cen_sal);


--
-- TOC entry 2089 (class 1259 OID 17480)
-- Dependencies: 1665 1665 1665
-- Name: centro_salud_pacientes_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX centro_salud_pacientes_index ON centro_salud_pacientes USING btree (id_cen_sal_pac, id_his, id_cen_sal);


--
-- TOC entry 2094 (class 1259 OID 17481)
-- Dependencies: 1667 1667 1667
-- Name: contactos_animales_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX contactos_animales_index ON contactos_animales USING btree (id_con_ani, id_his, id_ani);


--
-- TOC entry 2101 (class 1259 OID 17482)
-- Dependencies: 1671
-- Name: enfermedades_micologicas_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX enfermedades_micologicas_index ON enfermedades_micologicas USING btree (id_enf_mic);


--
-- TOC entry 2104 (class 1259 OID 17483)
-- Dependencies: 1673 1673 1673
-- Name: enfermedades_pacientes_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX enfermedades_pacientes_index ON enfermedades_pacientes USING btree (id_enf_pac, id_his, id_enf_mic);


--
-- TOC entry 2109 (class 1259 OID 17484)
-- Dependencies: 1675
-- Name: estudios_micologicos__pacientes_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX estudios_micologicos__pacientes_index ON estudios_micologicos__pacientes USING btree (id_est_mic_pac);


--
-- TOC entry 2117 (class 1259 OID 17485)
-- Dependencies: 1678
-- Name: forma_infecciones__pacientes_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX forma_infecciones__pacientes_index ON forma_infecciones__pacientes USING btree (id_for_pac);


--
-- TOC entry 2122 (class 1259 OID 17486)
-- Dependencies: 1680
-- Name: forma_infecciones__tipos_micosis_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX forma_infecciones__tipos_micosis_index ON forma_infecciones__tipos_micosis USING btree (id_for_inf_tip_mic);


--
-- TOC entry 2114 (class 1259 OID 17487)
-- Dependencies: 1677
-- Name: forma_infecciones_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX forma_infecciones_index ON forma_infecciones USING btree (id_for_inf);


--
-- TOC entry 2127 (class 1259 OID 17488)
-- Dependencies: 1683
-- Name: historiales_pacientes_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX historiales_pacientes_index ON historiales_pacientes USING btree (id_his);


--
-- TOC entry 2130 (class 1259 OID 17490)
-- Dependencies: 1685
-- Name: lesiones__partes_cuerpos_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX lesiones__partes_cuerpos_index ON lesiones__partes_cuerpos USING btree (id_les_par_cue);


--
-- TOC entry 2133 (class 1259 OID 17491)
-- Dependencies: 1687
-- Name: lesiones_partes_cuerpos__pacientes_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX lesiones_partes_cuerpos__pacientes_index ON lesiones_partes_cuerpos__pacientes USING btree (id_les_par_cue_pac);


--
-- TOC entry 2138 (class 1259 OID 17492)
-- Dependencies: 1689
-- Name: localizaciones_cuerpos_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX localizaciones_cuerpos_index ON localizaciones_cuerpos USING btree (id_loc_cue);


--
-- TOC entry 2145 (class 1259 OID 17493)
-- Dependencies: 1693
-- Name: muestras_clinicas_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX muestras_clinicas_index ON muestras_clinicas USING btree (id_mue_cli);


--
-- TOC entry 2152 (class 1259 OID 17494)
-- Dependencies: 1697
-- Name: pacientes_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX pacientes_index ON pacientes USING btree (id_pac);


--
-- TOC entry 2155 (class 1259 OID 17495)
-- Dependencies: 1699
-- Name: partes_cuerpos_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX partes_cuerpos_index ON partes_cuerpos USING btree (id_par_cue);


--
-- TOC entry 2158 (class 1259 OID 17496)
-- Dependencies: 1701
-- Name: propiedades_estudios_micologicos_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX propiedades_estudios_micologicos_index ON propiedades_estudios_micologicos USING btree (id_pro_est_mic);


--
-- TOC entry 2161 (class 1259 OID 17497)
-- Dependencies: 1703
-- Name: tipos_consultas_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX tipos_consultas_index ON tipos_consultas USING btree (id_tip_con);


--
-- TOC entry 2164 (class 1259 OID 17498)
-- Dependencies: 1705 1705 1705
-- Name: tipos_consultas_pacientes_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX tipos_consultas_pacientes_index ON tipos_consultas_pacientes USING btree (id_tip_con_pac, id_tip_con, id_his);


--
-- TOC entry 2169 (class 1259 OID 17499)
-- Dependencies: 1707
-- Name: tipos_estudios_micologicos_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX tipos_estudios_micologicos_index ON tipos_estudios_micologicos USING btree (id_tip_est_mic);


--
-- TOC entry 2172 (class 1259 OID 17500)
-- Dependencies: 1709
-- Name: tipos_micosis_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX tipos_micosis_index ON tipos_micosis USING btree (id_tip_mic);


--
-- TOC entry 2189 (class 1259 OID 17501)
-- Dependencies: 1718
-- Name: tratamientos_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX tratamientos_index ON tratamientos USING btree (id_tra);


--
-- TOC entry 2192 (class 1259 OID 17502)
-- Dependencies: 1720 1720 1720
-- Name: tratamientos_pacientes_index; Type: INDEX; Schema: public; Owner: desarrollo_g; Tablespace: saib
--

CREATE INDEX tratamientos_pacientes_index ON tratamientos_pacientes USING btree (id_tra_pac, id_his, id_tra);


--
-- TOC entry 2217 (class 2606 OID 17503)
-- Dependencies: 1653 2070 1651
-- Name: antecedentes_pacientes_id_ant_per_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY antecedentes_pacientes
    ADD CONSTRAINT antecedentes_pacientes_id_ant_per_fkey FOREIGN KEY (id_ant_per) REFERENCES antecedentes_personales(id_ant_per) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2216 (class 2606 OID 18893)
-- Dependencies: 1697 2153 1651
-- Name: antecedentes_pacientes_id_pac_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY antecedentes_pacientes
    ADD CONSTRAINT antecedentes_pacientes_id_pac_fkey FOREIGN KEY (id_pac) REFERENCES pacientes(id_pac) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2218 (class 2606 OID 17790)
-- Dependencies: 1655 2185 1715
-- Name: auditoria_transacciones_id_tip_tra_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY auditoria_transacciones
    ADD CONSTRAINT auditoria_transacciones_id_tip_tra_fkey FOREIGN KEY (id_tip_tra) REFERENCES transacciones(id_tip_tra) ON UPDATE CASCADE;


--
-- TOC entry 2219 (class 2606 OID 17795)
-- Dependencies: 1655 2179 1712
-- Name: auditoria_transacciones_id_tip_usu_usu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY auditoria_transacciones
    ADD CONSTRAINT auditoria_transacciones_id_tip_usu_usu_fkey FOREIGN KEY (id_tip_usu_usu) REFERENCES tipos_usuarios__usuarios(id_tip_usu_usu) ON UPDATE CASCADE;


--
-- TOC entry 2220 (class 2606 OID 17528)
-- Dependencies: 1657 2080 1659
-- Name: categorias__cuerpos_micosis_id_cat_cue_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY categorias__cuerpos_micosis
    ADD CONSTRAINT categorias__cuerpos_micosis_id_cat_cue_fkey FOREIGN KEY (id_cat_cue) REFERENCES categorias_cuerpos(id_cat_cue) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2221 (class 2606 OID 17533)
-- Dependencies: 2173 1657 1709
-- Name: categorias__cuerpos_micosis_id_tip_mic_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY categorias__cuerpos_micosis
    ADD CONSTRAINT categorias__cuerpos_micosis_id_tip_mic_fkey FOREIGN KEY (id_tip_mic) REFERENCES tipos_micosis(id_tip_mic) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2222 (class 2606 OID 17538)
-- Dependencies: 1659 1661 2080
-- Name: categorias_cuerpos_partes_cuerpos_id_cat_cue_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY categorias_cuerpos_partes_cuerpos
    ADD CONSTRAINT categorias_cuerpos_partes_cuerpos_id_cat_cue_fkey FOREIGN KEY (id_cat_cue) REFERENCES categorias_cuerpos(id_cat_cue) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2223 (class 2606 OID 17543)
-- Dependencies: 1699 1661 2156
-- Name: categorias_cuerpos_partes_cuerpos_id_par_cue_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY categorias_cuerpos_partes_cuerpos
    ADD CONSTRAINT categorias_cuerpos_partes_cuerpos_id_par_cue_fkey FOREIGN KEY (id_par_cue) REFERENCES partes_cuerpos(id_par_cue) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2266 (class 2606 OID 18781)
-- Dependencies: 1734 1663 2087
-- Name: centro_salud_doctores_id_cen_sal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY centro_salud_doctores
    ADD CONSTRAINT centro_salud_doctores_id_cen_sal_fkey FOREIGN KEY (id_cen_sal) REFERENCES centro_saluds(id_cen_sal) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2267 (class 2606 OID 18786)
-- Dependencies: 2099 1734 1669
-- Name: centro_salud_doctores_id_doc_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY centro_salud_doctores
    ADD CONSTRAINT centro_salud_doctores_id_doc_fkey FOREIGN KEY (id_doc) REFERENCES doctores(id_doc) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2224 (class 2606 OID 17548)
-- Dependencies: 1665 2087 1663
-- Name: centro_salud_pacientes_id_cen_sal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY centro_salud_pacientes
    ADD CONSTRAINT centro_salud_pacientes_id_cen_sal_fkey FOREIGN KEY (id_cen_sal) REFERENCES centro_saluds(id_cen_sal) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2225 (class 2606 OID 17553)
-- Dependencies: 1683 2128 1665
-- Name: centro_salud_pacientes_id_his_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY centro_salud_pacientes
    ADD CONSTRAINT centro_salud_pacientes_id_his_fkey FOREIGN KEY (id_his) REFERENCES historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2226 (class 2606 OID 17568)
-- Dependencies: 1649 2065 1667
-- Name: contactos_animales_id_ani_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY contactos_animales
    ADD CONSTRAINT contactos_animales_id_ani_fkey FOREIGN KEY (id_ani) REFERENCES animales(id_ani) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2227 (class 2606 OID 17573)
-- Dependencies: 1683 2128 1667
-- Name: contactos_animales_id_his_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY contactos_animales
    ADD CONSTRAINT contactos_animales_id_his_fkey FOREIGN KEY (id_his) REFERENCES historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2228 (class 2606 OID 17583)
-- Dependencies: 2173 1671 1709
-- Name: enfermedades_micologicas_id_tip_mic_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY enfermedades_micologicas
    ADD CONSTRAINT enfermedades_micologicas_id_tip_mic_fkey FOREIGN KEY (id_tip_mic) REFERENCES tipos_micosis(id_tip_mic) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2229 (class 2606 OID 17588)
-- Dependencies: 1673 1671 2102
-- Name: enfermedades_pacientes_id_enf_mic_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY enfermedades_pacientes
    ADD CONSTRAINT enfermedades_pacientes_id_enf_mic_fkey FOREIGN KEY (id_enf_mic) REFERENCES enfermedades_micologicas(id_enf_mic) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2230 (class 2606 OID 17593)
-- Dependencies: 1673 2128 1683
-- Name: enfermedades_pacientes_id_his_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY enfermedades_pacientes
    ADD CONSTRAINT enfermedades_pacientes_id_his_fkey FOREIGN KEY (id_his) REFERENCES historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2263 (class 2606 OID 18462)
-- Dependencies: 1728 2201 1726
-- Name: estados_id_pai_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY estados
    ADD CONSTRAINT estados_id_pai_fkey FOREIGN KEY (id_pai) REFERENCES paises(id_pai) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2231 (class 2606 OID 17598)
-- Dependencies: 1683 1675 2128
-- Name: estudios_micologicos__pacientes_id_his_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY estudios_micologicos__pacientes
    ADD CONSTRAINT estudios_micologicos__pacientes_id_his_fkey FOREIGN KEY (id_his) REFERENCES historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2232 (class 2606 OID 17603)
-- Dependencies: 2159 1675 1701
-- Name: estudios_micologicos__pacientes_id_pro_est_mic_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY estudios_micologicos__pacientes
    ADD CONSTRAINT estudios_micologicos__pacientes_id_pro_est_mic_fkey FOREIGN KEY (id_pro_est_mic) REFERENCES propiedades_estudios_micologicos(id_pro_est_mic) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2233 (class 2606 OID 17608)
-- Dependencies: 1677 2115 1678
-- Name: forma_infecciones__pacientes_id_for_inf_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY forma_infecciones__pacientes
    ADD CONSTRAINT forma_infecciones__pacientes_id_for_inf_fkey FOREIGN KEY (id_for_inf) REFERENCES forma_infecciones(id_for_inf) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2234 (class 2606 OID 17613)
-- Dependencies: 2128 1683 1678
-- Name: forma_infecciones__pacientes_id_his_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY forma_infecciones__pacientes
    ADD CONSTRAINT forma_infecciones__pacientes_id_his_fkey FOREIGN KEY (id_his) REFERENCES historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2235 (class 2606 OID 17618)
-- Dependencies: 1680 1677 2115
-- Name: forma_infecciones__tipos_micosis_id_for_inf_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY forma_infecciones__tipos_micosis
    ADD CONSTRAINT forma_infecciones__tipos_micosis_id_for_inf_fkey FOREIGN KEY (id_for_inf) REFERENCES forma_infecciones(id_for_inf) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2236 (class 2606 OID 17623)
-- Dependencies: 2173 1680 1709
-- Name: forma_infecciones__tipos_micosis_id_tip_mic_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY forma_infecciones__tipos_micosis
    ADD CONSTRAINT forma_infecciones__tipos_micosis_id_tip_mic_fkey FOREIGN KEY (id_tip_mic) REFERENCES tipos_micosis(id_tip_mic) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2238 (class 2606 OID 18795)
-- Dependencies: 2099 1669 1683
-- Name: historiales_pacientes_id_doc_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY historiales_pacientes
    ADD CONSTRAINT historiales_pacientes_id_doc_fkey FOREIGN KEY (id_doc) REFERENCES doctores(id_doc) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2237 (class 2606 OID 17628)
-- Dependencies: 1697 1683 2153
-- Name: historiales_pacientes_id_pac_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY historiales_pacientes
    ADD CONSTRAINT historiales_pacientes_id_pac_fkey FOREIGN KEY (id_pac) REFERENCES pacientes(id_pac) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2239 (class 2606 OID 17633)
-- Dependencies: 1699 1685 2156
-- Name: lesiones__partes_cuerpos_id_par_cue_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY lesiones__partes_cuerpos
    ADD CONSTRAINT lesiones__partes_cuerpos_id_par_cue_fkey FOREIGN KEY (id_par_cue) REFERENCES partes_cuerpos(id_par_cue) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2240 (class 2606 OID 17638)
-- Dependencies: 2128 1683 1687
-- Name: lesiones_partes_cuerpos__pacientes_id_his_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY lesiones_partes_cuerpos__pacientes
    ADD CONSTRAINT lesiones_partes_cuerpos__pacientes_id_his_fkey FOREIGN KEY (id_his) REFERENCES historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2241 (class 2606 OID 17643)
-- Dependencies: 1685 2131 1687
-- Name: lesiones_partes_cuerpos__pacientes_id_les_par_cue_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY lesiones_partes_cuerpos__pacientes
    ADD CONSTRAINT lesiones_partes_cuerpos__pacientes_id_les_par_cue_fkey FOREIGN KEY (id_les_par_cue) REFERENCES lesiones__partes_cuerpos(id_les_par_cue) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2242 (class 2606 OID 17982)
-- Dependencies: 2175 1691 1711
-- Name: modulos_id_tip_usu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY modulos
    ADD CONSTRAINT modulos_id_tip_usu_fkey FOREIGN KEY (id_tip_usu) REFERENCES tipos_usuarios(id_tip_usu) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2243 (class 2606 OID 17658)
-- Dependencies: 1683 1695 2128
-- Name: muestras_pacientes_id_his_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY muestras_pacientes
    ADD CONSTRAINT muestras_pacientes_id_his_fkey FOREIGN KEY (id_his) REFERENCES historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2244 (class 2606 OID 17663)
-- Dependencies: 2146 1693 1695
-- Name: muestras_pacientes_id_mue_cli_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY muestras_pacientes
    ADD CONSTRAINT muestras_pacientes_id_mue_cli_fkey FOREIGN KEY (id_mue_cli) REFERENCES muestras_clinicas(id_mue_cli) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2264 (class 2606 OID 18467)
-- Dependencies: 1728 1730 2203
-- Name: municipios_id_est_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY municipios
    ADD CONSTRAINT municipios_id_est_fkey FOREIGN KEY (id_est) REFERENCES estados(id_est) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2249 (class 2606 OID 18646)
-- Dependencies: 1697 1669 2099
-- Name: pacientes_id_doc_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY pacientes
    ADD CONSTRAINT pacientes_id_doc_fkey FOREIGN KEY (id_doc) REFERENCES doctores(id_doc) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2245 (class 2606 OID 18498)
-- Dependencies: 1728 2203 1697
-- Name: pacientes_id_est_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY pacientes
    ADD CONSTRAINT pacientes_id_est_fkey FOREIGN KEY (id_est) REFERENCES estados(id_est) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2246 (class 2606 OID 18503)
-- Dependencies: 1730 1697 2205
-- Name: pacientes_id_mun_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY pacientes
    ADD CONSTRAINT pacientes_id_mun_fkey FOREIGN KEY (id_mun) REFERENCES municipios(id_mun) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2248 (class 2606 OID 18513)
-- Dependencies: 1697 1726 2201
-- Name: pacientes_id_pai_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY pacientes
    ADD CONSTRAINT pacientes_id_pai_fkey FOREIGN KEY (id_pai) REFERENCES paises(id_pai) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2247 (class 2606 OID 18508)
-- Dependencies: 2207 1732 1697
-- Name: pacientes_id_par_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY pacientes
    ADD CONSTRAINT pacientes_id_par_fkey FOREIGN KEY (id_par) REFERENCES parroquias(id_par) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2265 (class 2606 OID 18472)
-- Dependencies: 1730 2205 1732
-- Name: parroquias_id_mun_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY parroquias
    ADD CONSTRAINT parroquias_id_mun_fkey FOREIGN KEY (id_mun) REFERENCES municipios(id_mun) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2250 (class 2606 OID 17668)
-- Dependencies: 1689 1699 2139
-- Name: partes_cuerpos_id_loc_cue_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY partes_cuerpos
    ADD CONSTRAINT partes_cuerpos_id_loc_cue_fkey FOREIGN KEY (id_loc_cue) REFERENCES localizaciones_cuerpos(id_loc_cue) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2251 (class 2606 OID 17673)
-- Dependencies: 2170 1701 1707
-- Name: propiedades_estudios_micologicos_id_tip_est_mic_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY propiedades_estudios_micologicos
    ADD CONSTRAINT propiedades_estudios_micologicos_id_tip_est_mic_fkey FOREIGN KEY (id_tip_est_mic) REFERENCES tipos_estudios_micologicos(id_tip_est_mic) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2268 (class 2606 OID 18888)
-- Dependencies: 1683 2128 1737
-- Name: tiempo_evoluciones_id_his_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY tiempo_evoluciones
    ADD CONSTRAINT tiempo_evoluciones_id_his_fkey FOREIGN KEY (id_his) REFERENCES historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2252 (class 2606 OID 17678)
-- Dependencies: 2128 1683 1705
-- Name: tipos_consultas_pacientes_id_his_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY tipos_consultas_pacientes
    ADD CONSTRAINT tipos_consultas_pacientes_id_his_fkey FOREIGN KEY (id_his) REFERENCES historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2253 (class 2606 OID 17683)
-- Dependencies: 1705 1703 2162
-- Name: tipos_consultas_pacientes_id_tip_con_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY tipos_consultas_pacientes
    ADD CONSTRAINT tipos_consultas_pacientes_id_tip_con_fkey FOREIGN KEY (id_tip_con) REFERENCES tipos_consultas(id_tip_con) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2254 (class 2606 OID 17688)
-- Dependencies: 2173 1709 1707
-- Name: tipos_estudios_micologicos_id_tip_mic_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY tipos_estudios_micologicos
    ADD CONSTRAINT tipos_estudios_micologicos_id_tip_mic_fkey FOREIGN KEY (id_tip_mic) REFERENCES tipos_micosis(id_tip_mic) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2257 (class 2606 OID 17997)
-- Dependencies: 1669 2099 1712
-- Name: tipos_usuarios__usuarios_id_doc_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY tipos_usuarios__usuarios
    ADD CONSTRAINT tipos_usuarios__usuarios_id_doc_fkey FOREIGN KEY (id_doc) REFERENCES doctores(id_doc) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2255 (class 2606 OID 17765)
-- Dependencies: 1712 2175 1711
-- Name: tipos_usuarios__usuarios_id_tip_usu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY tipos_usuarios__usuarios
    ADD CONSTRAINT tipos_usuarios__usuarios_id_tip_usu_fkey FOREIGN KEY (id_tip_usu) REFERENCES tipos_usuarios(id_tip_usu) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2256 (class 2606 OID 17907)
-- Dependencies: 2199 1712 1722
-- Name: tipos_usuarios__usuarios_id_usu_adm_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY tipos_usuarios__usuarios
    ADD CONSTRAINT tipos_usuarios__usuarios_id_usu_adm_fkey FOREIGN KEY (id_usu_adm) REFERENCES usuarios_administrativos(id_usu_adm) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2258 (class 2606 OID 17805)
-- Dependencies: 1691 2143 1715
-- Name: transacciones_id_mod_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY transacciones
    ADD CONSTRAINT transacciones_id_mod_fkey FOREIGN KEY (id_mod) REFERENCES modulos(id_mod) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2260 (class 2606 OID 18023)
-- Dependencies: 1717 1715 2185
-- Name: transacciones_usuarios_id_tip_tra_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY transacciones_usuarios
    ADD CONSTRAINT transacciones_usuarios_id_tip_tra_fkey FOREIGN KEY (id_tip_tra) REFERENCES transacciones(id_tip_tra) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2259 (class 2606 OID 18013)
-- Dependencies: 1712 1717 2179
-- Name: transacciones_usuarios_id_tip_usu_usu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY transacciones_usuarios
    ADD CONSTRAINT transacciones_usuarios_id_tip_usu_usu_fkey FOREIGN KEY (id_tip_usu_usu) REFERENCES tipos_usuarios__usuarios(id_tip_usu_usu) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2261 (class 2606 OID 17718)
-- Dependencies: 1683 2128 1720
-- Name: tratamientos_pacientes_id_his_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY tratamientos_pacientes
    ADD CONSTRAINT tratamientos_pacientes_id_his_fkey FOREIGN KEY (id_his) REFERENCES historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2262 (class 2606 OID 17723)
-- Dependencies: 2190 1720 1718
-- Name: tratamientos_pacientes_id_tra_fkey; Type: FK CONSTRAINT; Schema: public; Owner: desarrollo_g
--

ALTER TABLE ONLY tratamientos_pacientes
    ADD CONSTRAINT tratamientos_pacientes_id_tra_fkey FOREIGN KEY (id_tra) REFERENCES tratamientos(id_tra) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2316 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: desarrollo_g
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM desarrollo_g;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2011-08-01 19:44:20

--
-- PostgreSQL database dump complete
--

