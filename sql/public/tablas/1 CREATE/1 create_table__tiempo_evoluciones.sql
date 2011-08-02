CREATE TABLE tiempo_evoluciones(
	id_tie_evo SERIAL,
	id_his INTEGER REFERENCES historiales_pacientes(id_his) MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE,
	tie_evo INTEGER DEFAULT 0
);

ALTER TABLE tiempo_evoluciones OWNER TO desarrollo_g;

ALTER TABLE tiempo_evoluciones
	ADD CONSTRAINT tiempo_evoluciones_pkey PRIMARY KEY (id_tie_evo);