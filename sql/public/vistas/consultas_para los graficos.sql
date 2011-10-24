/*Consulta de pacientes por edad*/
SELECT 	id_pac, nom_pac,ape_pac, fec_nac_pac, 
	to_char(age(CURRENT_DATE,fec_nac_pac),'YY') AS edad, count(*)
	--substring(age(now(),fec_nac_pac)::text from 1 for 2)::int  as edad
FROM pacientes
GROUP BY id_pac, nom_pac,ape_pac, fec_nac_pac


/*Consulta de pacientes por edad*/
SELECT 	id_pac, nom_pac,ape_pac, fec_nac_pac, 
	substring(age(now(),fec_nac_pac)::text from 1 for 2)::int  as edad
FROM pacientes


/*Consulta de pacientes por sexo*/
SELECT 	count(*),
	CASE
	    WHEN sex_pac = 'F' THEN 'Femenino' ELSE 'Masculino'
	END AS sexo
FROM pacientes
GROUP BY sex_pac

/*Consulta de pacientes por grupo etario*/

SELECT count(*),
CASE
    WHEN substring(age(now(),fec_nac_pac)::text from 1 for 2)::int between 0 and 12  THEN '1-. INFANTE (0-12)'
    WHEN substring(age(now(),fec_nac_pac)::text from 1 for 2)::int between 13 and 17 THEN '2-. ADOLESCENTE (13-17)'
    WHEN substring(age(now(),fec_nac_pac)::text from 1 for 2)::int between 18 and 28 THEN '3-. JOVEN (18-28)'
    WHEN substring(age(now(),fec_nac_pac)::text from 1 for 2)::int between 29 and 35 THEN '4-. ADULTO JOVEN (29-35)'
    WHEN substring(age(now(),fec_nac_pac)::text from 1 for 2)::int between 36 and 59 THEN '5-. ADULTO (36-59)'
    WHEN substring(age(now(),fec_nac_pac)::text from 1 for 2)::int >= 60 THEN '6-. ADULTO MAYOR (60 o mas)'
END AS grupo_etario
FROM pacientes
GROUP BY grupo_etario
ORDER BY grupo_etario


/*
Cantidad de pacientes por tipo de lesion
*/

SELECT count(lp.id_pac),
	lp.nom_les 
FROM 
	(SELECT DISTINCT 
		hp.id_pac,
		l.nom_les
	FROM pacientes p
		JOIN historiales_pacientes hp ON(p.id_pac = hp.id_pac)
		JOIN tipos_micosis_pacientes tmp ON(hp.id_his = tmp.id_his)
		JOIN lesiones_partes_cuerpos__pacientes lpcp ON(tmp.id_tip_mic_pac = lpcp.id_tip_mic_pac)
		JOIN categorias_cuerpos__lesiones ccl ON(ccl.id_cat_cue_les = lpcp.id_cat_cue_les)
		JOIN lesiones l ON(ccl.id_les = l.id_les)
	ORDER BY l.nom_les) AS lp
GROUP BY lp.nom_les



/*Cantidad de pacientes por tipo de micosis*/
SELECT count(ptm.id_pac),
	ptm.nom_tip_mic
FROM 
	(SELECT DISTINCT 
		p.id_pac,
		tm.nom_tip_mic
	FROM pacientes p
		JOIN historiales_pacientes hp ON(p.id_pac = hp.id_pac)
		JOIN tipos_micosis_pacientes tmp ON(hp.id_his = tmp.id_his)
		JOIN tipos_micosis tm ON(tmp.id_tip_mic = tm.id_tip_mic)
		
	ORDER BY tm.nom_tip_mic) AS ptm
GROUP BY ptm.nom_tip_mic




