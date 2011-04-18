ALTER TABLE usuarios_administrativos
   ALTER COLUMN fec_reg_usu_adm SET DEFAULT now(),
   ADD CONSTRAINT usuarios_administrativos_log_usu_adm_unique UNIQUE(log_usu_adm)
   ;
