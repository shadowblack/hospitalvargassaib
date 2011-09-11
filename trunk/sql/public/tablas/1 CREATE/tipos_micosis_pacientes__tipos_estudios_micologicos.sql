CREATE TABLE tipos_micosis_pacientes__tipos_estudios_micologicos(
	id_tip_mic_pac_tip_est_mic SERIAL PRIMARY KEY,
	id_tip_mic_pac INTEGER REFERENCES tipos_micosis_pacientes(id_tip_mic_pac) MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE,
	id_tip_est_mic INTEGER REFERENCES tipos_estudios_micologicos(id_tip_est_mic) MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE
);

