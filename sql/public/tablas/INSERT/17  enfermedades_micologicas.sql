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
);


INSERT INTO enfermedades_micologicas (
	id_enf_mic,
	nom_enf_mic,
	id_tip_mic	
) VALUES 
(
	19,
	'Actinomicetoma',
	'2'
),
(
	20,
	'Eumicetoma',
	'2'
),
(
	21,
	'Esporotricosis',
	'2'
),
(
	22,
	'Cromoblastomicosis',
	'2'
),
(
	23,
	'Lobomicosis',
	'2'
);


INSERT INTO enfermedades_micologicas (
	id_enf_mic,
	nom_enf_mic,
	id_tip_mic	
) VALUES 
(
	24,
	'Coccidioidomicosis',
	'3'
),
(
	25,
	'Histoplasmosis',
	'3'
),
(
	26,
	'Paracoccidioidomicosis',
	'3'
);


ALTER SEQUENCE enfermedades_micologicas_id_enf_mic_seq
	RESTART 26;