ALTER TABLE categoria_cuerpos__partes_cuerpos
	drop column id_par_cue;

ALTER TABLE categoria_cuerpos__partes_cuerpos
	ADD COLUMN id_par_cue_cat_cue INTEGER REFERENCES partes_cuerpos__categorias_cuerpos(id_par_cue_cat_cue) MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE categoria_cuerpos__partes_cuerpos OWNER TO desarrollo_g;