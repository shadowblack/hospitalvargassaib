CREATE TABLE partes_cuerpos__categorias_cuerpos (
    id_par_cue_cat_cue SERIAL NOT NULL PRIMARY KEY,
    id_cat_cue integer NOT NULL REFERENCES categorias_cuerpos(id_cat_cue) MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE,
    id_par_cue integer NOT NULL REFERENCES partes_cuerpos(id_par_cue) MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT partes_cuerpos__categorias_cuerpos_unique UNIQUE(id_cat_cue,id_par_cue)
);

COMMENT ON TABLE partes_cuerpos__categorias_cuerpos IS 'Permite seleccionar a que categoria pertenece la parte del cuerpo'; 

ALTER TABLE partes_cuerpos__categorias_cuerpos OWNER TO desarrollo_g;

ALTER TABLE lesiones OWNER TO desarrollo_g;