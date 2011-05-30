ALTER TABLE paises
	ADD COLUMN cod_pai CHARACTER VARYING(3);

INSERT INTO paises(
	id_pai,
	des_pai,
	cod_pai
	
) VALUES (
	1,
	'Venezuela',
	'VEN'		
);

INSERT INTO estados(
	id_est,
	des_est,
	id_pai	
) VALUES (
	1,
	'Distrito Capital',
	1
),
(
	2,
	'Anzoátegui',1
),
(
	3,
	'Apure',1
),
(
	4,
	'Aragua',1
),
(
	5,
	'Barinas',1
),
(
	6,
	'Bolívar',1
),
(
	7,
	'Carabobo',1
),
(
	8,
	'Cojedes',1
),
(
	9,
	'Delta Amacuro',1
),
(
	10,
	'Falcón',1
),
(
	11,
	'Guárico',1
),
(
	12,
	'Lara',1
),
(
	13,
	'Mérida',1
),
(
	14,
	'Miranda',1
),
(
	15,
	'Monagas',1
),
(
	16,
	'Nueva Esparta',1
),
(
	18,
	'Portuguesa',1
),
(
	19,
	'Sucre',1
),
(
	20,
	'Táchira',1
),
(
	21,
	'Trujillo',1
),
(
	22,
	'Vargas',1
),
(
	23,
	'Yaracuy',1
),
(
	24,
	'Zulia',1
)
;

ALTER TABLE paises OWNER TO desarrollo_g;
ALTER TABLE estados OWNER TO desarrollo_g;
ALTER TABLE municipios OWNER TO desarrollo_g;
ALTER TABLE parroquias OWNER TO desarrollo_g;