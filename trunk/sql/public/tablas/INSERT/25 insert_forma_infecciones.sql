INSERT INTO forma_infecciones(
	id_for_inf,
	des_for_inf
) VALUES (
	1,
	'Traumatica'
),
(
	2,
	'Picada de insecto'
),
(
	3,
	'Pinchazo espindas'
),
(
	4,
	'Mordedura de roedores'
),
(
	5,
	'Instrumento metálico'
),
(
	6,
	'Caza animales'
),
(
	7,
	'Traumatica'
),
(
	8,
	'Otros'
);

ALTER SEQUENCE forma_infecciones_id_for_inf_seq
RESTART 9;