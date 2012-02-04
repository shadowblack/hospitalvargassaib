-- View: view_auditoria_transacciones

-- DROP VIEW view_auditoria_transacciones;

CREATE OR REPLACE VIEW view_auditoria_transacciones AS 
  SELECT to_char(at.fec_aud_tra, 'DD/MM/YYYY HH12:MI:SS AM'::text) AS fecha_tran,
	CASE 
		WHEN tu.id_tip_usu = 1  THEN (ua.nom_usu_adm::text || ' '::text) || ua.ape_usu_adm::text 
		WHEN tu.id_tip_usu = 2  THEN (d.nom_doc::text || ' '::text) || d.ape_doc::text 
	END AS nom_ape_usu,
	CASE 
		WHEN tu.id_tip_usu = 1  THEN ua.log_usu_adm
		WHEN tu.id_tip_usu = 2  THEN d.log_doc
	END AS log_usu,
        CASE
            WHEN at.data_xml IS NOT NULL THEN 'Si'::text
            ELSE 'No'::text
        END AS detalle, at.id_tip_usu_usu, at.data_xml, at.id_tip_tra, t.cod_tip_tra, t.id_mod,t.des_tip_tra,tu.id_tip_usu,tu.des_tip_usu
   FROM auditoria_transacciones at
   LEFT JOIN transacciones t USING (id_tip_tra)
   LEFT JOIN tipos_usuarios__usuarios tuu USING (id_tip_usu_usu)
   LEFT JOIN tipos_usuarios tu ON tuu.id_tip_usu = tu.id_tip_usu
   LEFT JOIN usuarios_administrativos ua ON tuu.id_usu_adm = ua.id_usu_adm
   LEFT JOIN doctores d ON tuu.id_doc = d.id_doc
  
  ORDER BY to_char(at.fec_aud_tra, 'DD/MM/YYYY HH12:MI:SS AM'::text) DESC;

ALTER TABLE view_auditoria_transacciones OWNER TO desarrollo_g;

