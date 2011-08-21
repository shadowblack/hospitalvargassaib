ALTER TABLE lesiones_partes_cuerpos__pacientes
	ADD COLUMN id_par_cue INTEGER REFERENCES partes_cuerpos(id_par_cue) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE;
	
ALTER TABLE lesiones_partes_cuerpos__pacientes
	DROP CONSTRAINT  lesiones_partes_cuerpos__pacientes_id_par_cue_fkey,
	DROP COLUMN id_par_cue,
	ADD COLUMN id_his INTEGER REFERENCES historiales_pacientes(id_his) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE enfermedades_pacientes
	DROP CONSTRAINT enfermedades_pacientes_id_his_fkey,
	DROP COLUMN id_his;

-- usando
ALTER TABLE lesiones_partes_cuerpos__pacientes
	DROP CONSTRAINT  lesiones_partes_cuerpos__pacientes_id_his_fkey,
	DROP COLUMN id_his,
	ADD COLUMN id_tip_mic_pac INTEGER REFERENCES tipos_micosis_pacientes(id_tip_mic_pac) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE categoria_cuerpos__partes_cuerpos RENAME TO categorias_cuerpos__lesiones;

ALTER TABLE lesiones_partes_cuerpos__pacientes
	DROP CONSTRAINT lesiones_partes_cuerpos__pacientes_id_enf_pac_fkey,
	DROP CONSTRAINT lesiones_partes_cuerpos__pacientes_id_les_par_cue_fkey,
	DROP CONSTRAINT lesiones_partes_cuerpos__pacientes_id_tip_mic_pac_fkey,
	DROP COLUMN id_les_par_cue,
	DROP COLUMN id_enf_pac,
	DROP COLUMN id_tip_mic_pac,

	ADD COLUMN id_cat_cue_les INTEGER REFERENCES categorias_cuerpos__lesiones(id_cat_cue_les)MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
	ADD COLUMN id_par_cue_cat_cue INTEGER REFERENCES partes_cuerpos__categorias_cuerpos(id_par_cue_cat_cue)MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE,
	ADD COLUMN id_tip_mic_pac INTEGER REFERENCES tipos_micosis_pacientes (id_tip_mic_pac)MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE;


