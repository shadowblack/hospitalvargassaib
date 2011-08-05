INSERT INTO enfermedades_micologicas (
	id_enf_mic,
	nom_enf_mic,
	id_tip_mic	
) VALUES (
	1,
	'Actinomicetoma',
	1
),
(
	2,
	'Eumicetoma',
	1
),
(
	3,
	'Esporotricosis',
	1
),
(
	4,
	'Cromoblastomicosis',
	1
),
(
	5,
	'Lobomicosis',
	1
);

ALTER SEQUENCE enfermedades_micologicas_id_enf_mic_seq
	RESTART 6;