ALTER TABLE tipos_estudios_micologicos
	ADD COLUMN id_tip_exa INTEGER REFERENCES tipos_examenes (id_tip_exa) MATCH SIMPLE ON DELETE CASCADE ON UPDATE CASCADE
;