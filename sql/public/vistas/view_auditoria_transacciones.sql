--DROP view view_auditoria_transacciones ;

CREATE OR REPLACE VIEW view_auditoria_transacciones AS
	SELECT  id_tip_tra,
		to_char(fec_aud_tra, 'DD/MM/YYYY HH12:MI:SS AM' ) AS fecha_tran,
		d.nom_doc||' '||d.ape_doc AS nom_ape_usu,
		d.log_doc AS log_usu,
		CASE 
			WHEN data_xml IS NOT NULL THEN 'Si' ELSE 'No' 
		END AS detalle,
		id_tip_usu_usu

	FROM auditoria_transacciones at
		    LEFT JOIN tipos_usuarios__usuarios tuu USING(id_tip_usu_usu)
		    LEFT JOIN doctores d ON (tuu.id_doc = d.id_doc)
		    

	
	ORDER BY fecha_tran DESC
--COMMENT ON VIEW view_auditoria_transacciones IS 'Consulta auditorias';
ALTER VIEW view_auditoria_transacciones OWNER TO desarrollo_g;
