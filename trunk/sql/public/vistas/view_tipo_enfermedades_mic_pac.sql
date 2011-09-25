-- View: view_tipo_enfermedades_mic_pac

-- DROP VIEW view_tipo_enfermedades_mic_pac;

CREATE OR REPLACE VIEW view_tipo_enfermedades_mic_pac AS 
	SELECT 	hp.id_his, to_char(hp.fec_his, 'DD/MM/YYYY HH12:MI:SS AM'::text) AS fec_his,
		tm.id_tip_mic, tm.nom_tip_mic,hp.id_pac, hp.id_his::TEXT AS num_his
	FROM tipos_micosis tm
		LEFT JOIN tipos_micosis_pacientes tmp USING(id_tip_mic)
		LEFT JOIN historiales_pacientes hp ON(tmp.id_his = hp.id_his)
		
	WHERE hp.id_his is not null
	ORDER BY tm.nom_tip_mic;
ALTER TABLE view_tipo_enfermedades_mic_pac OWNER TO desarrollo_g;


SELECT "vtemp"."num_his" AS "vtemp__num_his", "vtemp"."fec_his" AS "vtemp__fec_his", "vtemp"."id_tip_mic" AS "vtemp__id_tip_mic", "vtemp"."nom_tip_mic" AS "vtemp__nom_tip_mic", 
"Paciente"."ced_pac" AS "Paciente__ced_pac", "Paciente"."nom_pac" AS "Paciente__nom_pac", "Paciente"."ape_pac" AS "Paciente__ape_pac" 
FROM "pacientes" AS "Paciente" 
	JOIN view_tipo_enfermedades_mic_pac AS "vtemp" ON ("vtemp"."id_pac" = "Paciente"."id_pac") 
WHERE "Paciente"."ced_pac" ilike '%17651233%' 
	AND "Paciente"."nom_pac" ilike '%%' 
	AND "Paciente"."ape_pac" ilike '%%' 
	AND CAST("vtemp"."fec_his" AS DATE) >= '2011-07-01 00:00' 
	AND CAST("vtemp"."fec_his" AS DATE) <= '2011-09-24 23:59' 
	AND "vtemp"."num_his" ilike '%%' 
	AND "vtemp"."id_tip_mic" = '' 
ORDER BY "tm"."nom_tip_mic" ASC LIMIT 12
