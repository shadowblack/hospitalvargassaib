ALTER TABLE lesiones__partes_cuerpos
	DROP COLUMN nom_les_par_cue;
	

CREATE TABLE lesiones(
	id_les SERIAL,
	nom_les CHARACTER VARYING(100)	
);

ALTER TABLE lesiones
	ADD CONSTRAINT 	lesiones_id_les_pkey PRIMARY KEY(id_les);

ALTER TABLE lesiones__partes_cuerpos
	ADD COLUMN id_les INTEGER REFERENCES lesiones(id_les);

ALTER TABLE lesiones__partes_cuerpos
	DROP CONSTRAINT lesiones__partes_cuerpos_id_les_fkey,
	ADD CONSTRAINT lesiones__partes_cuerpos_id_les_fkey FOREIGN KEY(id_les) REFERENCES lesiones(id_les) MATCH SIMPLE
	ON DELETE CASCADE ON UPDATE CASCADE;