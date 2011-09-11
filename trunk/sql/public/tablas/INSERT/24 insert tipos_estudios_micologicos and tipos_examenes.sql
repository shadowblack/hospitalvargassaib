INSERT INTO tipos_examenes(
	id_tip_exa,
	nom_tip_exa
) VALUES (
	1,
	'Examen directo'
),
(
	2,
	'Agente Aislado'
);

ALTER SEQUENCE tipos_examenes_id_tip_exa_seq RESTART 3;

ALTER TABLE tipos_estudios_micologicos
	ALTER COLUMN nom_tip_est_mic TYPE CHARACTER VARYING(255);
INSERT INTO tipos_estudios_micologicos(
	id_tip_est_mic,
	id_tip_mic,
	nom_tip_est_mic,
	id_tip_exa
) VALUES (
	1,
	1,
	'Hifas delgadas tabicadas',
	1
),
(
	2,
	1,
	'Hifas gruesas tabicadas',
	1
),
(
	3,
	1,
	'Blastoconidias',
	1
),
(
	4,
	1,
	'Pseudohifas',
	1
),
(
	5,
	1,
	'Artroconidias',
	1
),
(
	6,
	1,
	'Hifas cortas y agrupamiento de esporas',
	1
),
(
	7,
	1,
	'Esporas endotrix',
	1
),
(
	8,
	1,
	'Esporas ectoendotrix',
	1
),
(
	9,
	2,
	'Microsporum canis',
	1
),
(
	10,
	2,
	'Microsporum gypseum',
	1
),
(
	11,
	2,
	'Microsporum nunum',
	1
),
(
	12,
	2,
	'Truchophyton rubrum',
	1
),
(
	13,
	2,
	'Trichophyton mentafrophytes',
	1
),
(
	14,
	2,
	'Trichophyton tonsurans',
	1
),
(
	15,
	2,
	'Trichophyton verrucosum',
	1
),
(
	16,
	2,
	'Trichophyton violaceum',
	1
),
(
	17,
	2,
	'Epidermophyton verrucosum',
	1
),
(
	18,
	2,
	'Trichosporon',
	1
),
(
	19,
	2,
	'Geotrichum spp',
	1
),
(
	20,
	2,
	'Candita albicans',
	1
),
(
	21,
	2,
	'Candida no Candida albicans',
	1
),
(
	22,
	2,
	'Makassezia furfur',
	1
),
(
	23,
	2,
	'Makassezia pachydermatis',
	1
),
(
	24,
	2,
	'Makassezia spp',
	1
);
ALTER SEQUENCE tipos_estudios_micologicos_id_tip_est_mic_seq RESTART 25;