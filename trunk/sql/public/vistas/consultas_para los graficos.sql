/*Consulta de pacientes por edad*/
SELECT 	id_pac, nom_pac,ape_pac, fec_nac_pac, 
	to_char(age(CURRENT_DATE,fec_nac_pac),'YY') AS edad, count(*)
FROM pacientes
GROUP BY id_pac, nom_pac,ape_pac, fec_nac_pac


/*Consulta de pacientes por grupo etario*/

select count(*),
/*substring(age(now(),fec_nac_pac)::text from 1 for 2)::int  as edad, --Descomentar si deseas la edad de las personas*/
case
    when substring(age(now(),fec_nac_pac)::text from 1 for 2)::int between 0 and 12
    then '1-. INFANTE (0-12)'
    when substring(age(now(),fec_nac_pac)::text from 1 for 2)::int between 13 and 17
    then '2-. ADOLESCENTE (13-17)'
    when substring(age(now(),fec_nac_pac)::text from 1 for 2)::int between 18 and 28
    then '3-. JOVEN (18-28)'
    when substring(age(now(),fec_nac_pac)::text from 1 for 2)::int between 29 and 35
    then '4-. ADULTO JOVEN (29-35)'
    when substring(age(now(),fec_nac_pac)::text from 1 for 2)::int between 36 and 59
    then '5-. ADULTO (36-59)'
    when substring(age(now(),fec_nac_pac)::text from 1 for 2)::int >= 60
    then '6-. ADULTO MAYOR (60 o mas)'
end AS grupo_etario
from pacientes
group by grupo_etario /*,edad --Descomentar si deseas la edad de las personas*/
order by grupo_etario


/*Tipo de lesion

Filtrar por id_cat_cue

*/

SELECT count(*),nom_les
FROM partes_cuerpos pc
	LEFT JOIN partes_cuerpos__categorias_cuerpos pccc ON(pc.id_par_cue = pccc.id_par_cue)
	LEFT JOIN categorias_cuerpos cc ON(pccc.id_cat_cue = cc.id_cat_cue)
	LEFT JOIN categorias_cuerpos__lesiones ccl ON(cc.id_cat_cue = ccl.id_cat_cue)
	LEFT JOIN lesiones l ON(ccl.id_les = l.id_les)
WHERE ccl.id_cat_cue = 1
AND pc.id_par_cue = 1
group by l.nom_les


SELECT DISTINCT p.id_pac,p.nom_pac, cc.nom_cat_cue, pc.nom_par_cue,l.nom_les
FROM partes_cuerpos pc
	LEFT JOIN partes_cuerpos__categorias_cuerpos pccc ON(pc.id_par_cue = pccc.id_par_cue)
	LEFT JOIN categorias_cuerpos cc ON(pccc.id_cat_cue = cc.id_cat_cue)
	LEFT JOIN categorias_cuerpos__lesiones ccl ON(cc.id_cat_cue = ccl.id_cat_cue)
	LEFT JOIN lesiones l ON(ccl.id_les = l.id_les)
	LEFT JOIN lesiones_partes_cuerpos__pacientes lpcp ON(ccl.id_cat_cue_les = lpcp.id_cat_cue_les)
	LEFT JOIN tipos_micosis_pacientes tmp ON(lpcp.id_tip_mic_pac = tmp.id_tip_mic_pac)
	LEFT JOIN historiales_pacientes hp ON(tmp.id_his = hp.id_his)
	LEFT JOIN pacientes p ON(hp.id_pac = p.id_pac)
WHERE ccl.id_cat_cue = 1
AND pc.id_par_cue = 2
AND p.id_pac IS NOT NULL
ORDER BY nom_les


SELECT DISTINCT p.id_pac,p.nom_pac, cc.nom_cat_cue, pc.nom_par_cue,l.id_les,l.nom_les, count(p.id_pac||''||l.id_les)
FROM partes_cuerpos pc
	LEFT JOIN partes_cuerpos__categorias_cuerpos pccc ON(pc.id_par_cue = pccc.id_par_cue)
	LEFT JOIN categorias_cuerpos cc ON(pccc.id_cat_cue = cc.id_cat_cue)
	LEFT JOIN categorias_cuerpos__lesiones ccl ON(cc.id_cat_cue = ccl.id_cat_cue)
	LEFT JOIN lesiones l ON(ccl.id_les = l.id_les)
	LEFT JOIN lesiones_partes_cuerpos__pacientes lpcp ON(ccl.id_cat_cue_les = lpcp.id_cat_cue_les)
	LEFT JOIN tipos_micosis_pacientes tmp ON(lpcp.id_tip_mic_pac = tmp.id_tip_mic_pac)
	LEFT JOIN historiales_pacientes hp ON(tmp.id_his = hp.id_his)
	LEFT JOIN pacientes p ON(hp.id_pac = p.id_pac)
WHERE ccl.id_cat_cue = 1
AND pc.id_par_cue = 2
AND p.id_pac IS NOT NULL
group by p.id_pac,p.nom_pac, cc.nom_cat_cue, pc.nom_par_cue,l.id_les,l.nom_les
ORDER BY nom_les


SELECT DISTINCT count(*), 
		cc.nom_cat_cue, pc.nom_par_cue,l.nom_les
FROM partes_cuerpos pc
	LEFT JOIN partes_cuerpos__categorias_cuerpos pccc ON(pc.id_par_cue = pccc.id_par_cue)
	LEFT JOIN categorias_cuerpos cc ON(pccc.id_cat_cue = cc.id_cat_cue)
	LEFT JOIN categorias_cuerpos__lesiones ccl ON(cc.id_cat_cue = ccl.id_cat_cue)
	LEFT JOIN lesiones l ON(ccl.id_les = l.id_les)
	LEFT JOIN lesiones_partes_cuerpos__pacientes lpcp ON(ccl.id_cat_cue_les = lpcp.id_cat_cue_les)
	LEFT JOIN tipos_micosis_pacientes tmp ON(lpcp.id_tip_mic_pac = tmp.id_tip_mic_pac)
	LEFT JOIN historiales_pacientes hp ON(tmp.id_his = hp.id_his)
	LEFT JOIN pacientes p ON(hp.id_pac = p.id_pac)
WHERE ccl.id_cat_cue = 1
AND pc.id_par_cue = 2
AND p.id_pac IS NOT NULL
group by cc.nom_cat_cue, pc.nom_par_cue,l.nom_les
ORDER BY nom_les