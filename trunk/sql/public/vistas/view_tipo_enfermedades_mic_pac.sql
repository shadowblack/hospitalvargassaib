-- View: view_tipo_enfermedades_mic_pac

-- DROP VIEW view_tipo_enfermedades_mic_pac;

CREATE OR REPLACE VIEW view_tipo_enfermedades_mic_pac AS 
 SELECT hp.id_his, to_char(hp.fec_his, 'DD/MM/YYYY HH12:MI:SS AM'::text) AS fec_his, tm.id_tip_mic, tm.nom_tip_mic, hp.id_pac, hp.id_his::text AS num_his, tmp.id_tip_mic_pac
   FROM tipos_micosis tm
   LEFT JOIN tipos_micosis_pacientes tmp USING (id_tip_mic)
   LEFT JOIN historiales_pacientes hp ON tmp.id_his = hp.id_his
  WHERE hp.id_his IS NOT NULL
  ORDER BY tm.nom_tip_mic;

ALTER TABLE view_tipo_enfermedades_mic_pac OWNER TO desarrollo_g;

