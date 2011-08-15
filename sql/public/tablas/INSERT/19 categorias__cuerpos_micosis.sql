INSERT INTO categorias__cuerpos_micosis (
	id_cat_cue_mic,
	id_cat_cue,
	id_tip_mic
) VALUES (
	1,
	1,
	1
),
(
	2,
	2,
	1
);

ALTER SEQUENCE categorias__cuerpos_micosis_id_cat_cue_mic_seq
	RESTART 3;