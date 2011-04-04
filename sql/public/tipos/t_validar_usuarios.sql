DROP FUNCTION IF EXISTS validar_usuarios(_log_usu TEXT,_pas_usu TEXT,_tip_usu TEXT);
DROP TYPE IF EXISTS  t_validar_usuarios;
CREATE TYPE t_validar_usuarios AS
   (
	id_usu 	INTEGER,
	nom_usu 	TEXT,
	ape_usu 	TEXT,
	pas_usu 	TEXT,
	log_usu 	TEXT,
	tel_usu 	TEXT,
	id_tip_usu 	INTEGER,
	cod_tip_usu 	TEXT,
	str_mods	TEXT,
	str_trans	TEXT,
	des_tip_usu 	TEXT
   );
ALTER TYPE t_validar_usuarios OWNER TO postgres;
COMMENT ON TYPE t_validar_usuarios IS '
NOMBRE: t_validar_usuarios
TIPO: TIPO
	
CREADOR: Luis Raul Marin	
MODIFICADO: 
FECHA: 20/03/2011
';