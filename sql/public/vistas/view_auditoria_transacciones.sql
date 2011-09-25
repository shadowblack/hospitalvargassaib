-- View: view_auditoria_transacciones

-- DROP VIEW view_auditoria_transacciones;

CREATE OR REPLACE VIEW view_auditoria_transacciones AS 
SELECT to_char(at.fec_aud_tra, 'DD/MM/YYYY HH12:MI:SS AM'::text) AS fecha_tran, (d.nom_doc::text || ' '::text) || d.ape_doc::text AS nom_ape_usu, d.log_doc AS log_usu,
	CASE
	    WHEN at.data_xml IS NOT NULL THEN 'Si'::text
	    ELSE 'No'::text
	END AS detalle, at.id_tip_usu_usu,
	at.data_xml,
	at.id_tip_tra, 
	t.cod_tip_tra,
	t.id_mod
FROM auditoria_transacciones at
   LEFT JOIN transacciones t USING(id_tip_tra)
   LEFT JOIN tipos_usuarios__usuarios tuu USING (id_tip_usu_usu)
   LEFT JOIN doctores d ON tuu.id_doc = d.id_doc
ORDER BY to_char(at.fec_aud_tra, 'DD/MM/YYYY HH12:MI:SS AM'::text) DESC;

ALTER TABLE view_auditoria_transacciones OWNER TO desarrollo_g;



select * from auditoria_transacciones