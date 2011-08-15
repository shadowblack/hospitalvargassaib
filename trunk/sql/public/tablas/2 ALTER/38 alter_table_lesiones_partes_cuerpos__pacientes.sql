/*ALTER TABLE lesiones_partes_cuerpos__pacientes
	drop constraint lesiones_partes_cuerpos__pacientes_id_enf_pac_fkey,
	DROP id_enf_pac,
	ADD COLUMN id_his INTEGER REFERENCES historiales_pacientes (id_his) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE;*/

ALTER TABLE lesiones_partes_cuerpos__pacientes
	drop constraint lesiones_partes_cuerpos__pacientes_id_his_fkey,
	DROP id_his,	
	ADD COLUMN id_enf_pac INTEGER REFERENCES enfermedades_pacientes(id_enf_pac)MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE;
	
