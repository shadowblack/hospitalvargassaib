-- Type: t_validar_usuarios

-- DROP TYPE t_validar_usuarios;

CREATE TYPE t_validar_usuarios AS
   (id_usu integer,
    nom_usu text,
    ape_usu text,
    pas_usu text,
    log_usu text,
    tel_usu text,
    id_tip_usu integer,
    id_tip_usu_usu integer,
    cod_tip_usu text,
    str_trans text,
    des_tip_usu text,
    adm_usu boolean);
ALTER TYPE t_validar_usuarios OWNER TO postgres;
COMMENT ON TYPE t_validar_usuarios IS '
NOMBRE: t_validar_usuarios
TIPO: TIPO
	
CREADOR: Luis Raul Marin	
MODIFICADO: 
FECHA: 20/03/2011
';
