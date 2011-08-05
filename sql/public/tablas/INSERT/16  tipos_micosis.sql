INSERT INTO tipos_micosis(
	id_tip_mic,
	nom_tip_mic	
) VALUES (
	1,
	'Superficiales'
),
(	
	2,
	'Supcutaneas'
),
(
	3,
	'Profundas'
);


ALTER SEQUENCE tipos_micosis_id_tip_mic_seq
	RESTART 4;	