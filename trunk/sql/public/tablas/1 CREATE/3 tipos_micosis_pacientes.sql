CREATE TABLE tipos_micosis_pacientes(
	id_tip_mic_pac SERIAL NOT NULL PRIMARY KEY ,
	id_tip_mic INTEGER REFERENCES tipos_micosis(id_tip_mic) MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE,
	id_his INTEGER REFERENCES historiales_pacientes(id_his) MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE
);
