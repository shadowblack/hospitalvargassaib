ALTER TABLE partes_cuerpos
	DROP CONSTRAINT partes_cuerpos_id_loc_cue_fkey,
	DROP COLUMN id_loc_cue;

ALTER TABLE localizaciones_cuerpos
	ADD COLUMN id_par_cue INTEGER REFERENCES partes_cuerpos(id_par_cue) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE;


ALTER TABLE localizaciones_cuerpos
	ADD CONSTRAINT localizaciones_cuerpos_id_par_cue_fkey FOREIGN KEY(id_par_cue) REFERENCES partes_cuerpos(id_par_cue) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE;