INSERT INTO tipos_consultas (
	id_tip_con,
	nom_tip_con
) VALUES (
	1,
	'Consulta'
),
(
	2,
	'Dermatologia'
),
(
	3,
	'Pediatria'
),
(
	4,
	'Neumologia'
),
(
	5,
	'Consulta Interna'
),
(
	6,
	'Geriatria'
),
(
	7,
	'urologia'
),
(
	8,
	'Infectologia'
)
;

ALTER SEQUENCE tipos_consultas_id_tip_con_seq
RESTART 9;