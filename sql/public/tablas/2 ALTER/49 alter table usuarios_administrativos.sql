ALTER TABLE usuarios_administrativos ADD COLUMN ced_usu_adm character varying(20);
ALTER TABLE usuarios_administrativos ADD COLUMN cor_usu_adm character varying(100);

ALTER TABLE usuarios_administrativos
   ALTER COLUMN adm_usu SET DEFAULT FALSE;


