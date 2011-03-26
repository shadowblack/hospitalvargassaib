DROP FUNCTION IF EXISTS validar_usuarios(_log_usu TEXT,_pas_usu TEXT,_tip_usu TEXT);
DROP TYPE IF EXISTS  t_validar_usuarios;
CREATE TYPE t_validar_usuarios AS
   (
	id_usu_adm INTEGER,
	nom_usu_adm TEXT,
	ape_usu_adm TEXT,
	pas_usu_adm TEXT,
	log_usu_adm TEXT,
	tel_usu_adm TEXT,
	id_tip_usu INTEGER
   );
ALTER TYPE t_validar_usuarios OWNER TO postgres;
COMMENT ON TYPE t_validar_usuarios IS '
NOMBRE: t_validar_usuarios
TIPO: TIPO
	
CREADOR: Luis Raul Marin	
MODIFICADO: 
FECHA: 20/03/2011
';