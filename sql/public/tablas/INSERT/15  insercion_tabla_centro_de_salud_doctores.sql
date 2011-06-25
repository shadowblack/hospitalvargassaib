CREATE TABLE centro_salud_doctores
(
  id_cen_sal_doc serial NOT NULL,
  id_cen_sal integer NOT NULL,
  id_doc integer NOT NULL,
  otr_cen_sal character varying(100),
  CONSTRAINT centro_salud_doctores_pkey PRIMARY KEY (id_cen_sal_doc),
  CONSTRAINT centro_salud_doctores_id_cen_sal_fkey FOREIGN KEY (id_cen_sal)
      REFERENCES centro_salud (id_cen_sal) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT centro_salud_doctores_id_doc_fkey FOREIGN KEY (id_doc)
      REFERENCES doctores (id_doc) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT centro_salud_doctores_unique UNIQUE (id_doc, id_cen_sal)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE centro_salud_doctores OWNER TO desarrollo_g;


CREATE INDEX centro_salud_doctores_index
  ON centro_salud_doctores
  USING btree
  (id_cen_sal_doc, id_doc, id_cen_sal);


COMMENT ON COLUMN centro_salud_doctores.id_cen_sal_doc IS 'Identificación del Centro de Salud del doctor';
COMMENT ON COLUMN centro_salud_doctores.id_cen_sal IS 'Identificación del Centro de Salud';
COMMENT ON COLUMN centro_salud_doctores.id_doc IS 'Identificación del doctor';
COMMENT ON COLUMN centro_salud_doctores.otr_cen_sal IS 'Otro Centro de Salud';
