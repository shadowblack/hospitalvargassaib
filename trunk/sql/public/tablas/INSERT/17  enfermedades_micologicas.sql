ALTER TABLE enfermedades_micologicas
	ALTER nom_enf_mic TYPE CHARACTER VARYING(100);

INSERT INTO enfermedades_micologicas (
	id_enf_mic,
	nom_enf_mic,
	id_tip_mic	
) VALUES (
	1,
	'Dermatofitosis',
	1
),
(
	2,
	'Onicomicosis dermatofitica',
	1
),
(
	3,
	'Onicomicosis no dermatofitica',
	1
),
(
	4,
	'Petitiriasis vericolor',
	1
),
(
	5,
	'Piedra blanca',
	1
),
(
	6,
	'Tiña negra',
	1
),
(
	7,
	'Oculomicosis',
	1
),
(
	8,
	'Otomicosis',
	1
)
,
(
	9,
	'Tinea capitis',
	1
)
,
(
	10,
	'Tinea barbae',
	1
)
,
(
	11,
	'Tinea corporis',
	1
),
(
	12,
	'Tinea cruris',
	1
),
(
	13,
	'Tinea imbricata',
	1
),
(
	14,
	'Tinea manuum',
	1
),
(
	15,
	'Tinea pedis',
	1
),
(
	16,
	'Tinea unguium',
	1
),
(
	17,
	'Cromomicosis dermatofitica',
	1
),
(
	18,
	'Otro',
	1
)
;

ALTER SEQUENCE enfermedades_micologicas_id_enf_mic_seq
	RESTART 19;