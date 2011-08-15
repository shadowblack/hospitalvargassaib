ALTER TABLE lesiones__partes_cuerpos
	ADD CONSTRAINT lesiones__partes_cuerpos_unique UNIQUE(id_par_cue,id_les)

ALTER TABLE lesiones__partes_cuerpos RENAME TO categoria_cuerpos__partes_cuerpos;

ALTER TABLE categoria_cuerpos__partes_cuerpos
	RENAME COLUMN id_les_par_cue TO id_cat_cuer_par_cue;

ALTER TABLE categoria_cuerpos__partes_cuerpos
	DROP CONSTRAINT lesiones__partes_cuerpos_unique;
	
ALTER TABLE lesiones__partes_cuerpos
	DROP CONSTRAINT lesiones__partes_cuerpos_unique,

ALTER TABLE categoria_cuerpos__partes_cuerpos
	DROP CONSTRAINT lesiones__partes_cuerpos_id_par_cue_fkey;
	
ALTER TABLE categoria_cuerpos__partes_cuerpos		
	ADD COLUMN id_cat_cue INTEGER REFERENCES categorias_cuerpos(id_cat_cue) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE;