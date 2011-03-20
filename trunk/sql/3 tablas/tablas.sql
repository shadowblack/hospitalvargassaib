
CREATE TABLE animales
(
	id_ani                SERIAL,
	nom_ani               VARCHAR(20) NULL
)
TABLESPACE saib
;



ALTER TABLE animales
	ADD  PRIMARY KEY (id_ani)
;



CREATE TABLE antecedentes_pacientes
(
	id_ant_pac            SERIAL,
	id_ant_per            INTEGER NOT NULL,
	id_his                INTEGER NOT NULL,
	otr_ant_per           VARCHAR(20) NULL
)
TABLESPACE saib
;



ALTER TABLE antecedentes_pacientes
	ADD  PRIMARY KEY (id_ant_pac),
	ADD CONSTRAINT antecedentes_pacientes_unique UNIQUE (id_ant_per,id_his)
;


CREATE TABLE antecedentes_personales
(
	id_ant_per            SERIAL,
	nom_ant               VARCHAR(20) NULL
)
TABLESPACE saib
;



ALTER TABLE antecedentes_personales
	ADD  PRIMARY KEY (id_ant_per)
;



CREATE TABLE categorias__cuerpos_micosis
(
	id_cat_cue_mic        SERIAL,
	id_cat_cue            INTEGER NOT NULL,
	id_tip_mic            INTEGER NOT NULL
)
TABLESPACE saib
;



ALTER TABLE categorias__cuerpos_micosis
	ADD  PRIMARY KEY (id_cat_cue_mic),
	ADD CONSTRAINT categorias__cuerpos_micosis_unique UNIQUE (id_cat_cue,id_tip_mic)
;



CREATE TABLE categorias_cuerpos
(
	id_cat_cue            SERIAL,
	nom_cat_cue           VARCHAR(20) NULL
)
TABLESPACE saib
;



ALTER TABLE categorias_cuerpos
	ADD  PRIMARY KEY (id_cat_cue)
;



CREATE TABLE categorias_cuerpos_partes_cuerpos
(
	id_cat_cue_par_cue    SERIAL,
	id_par_cue            INTEGER NOT NULL,
	id_cat_cue            INTEGER NOT NULL
)
TABLESPACE saib
;



ALTER TABLE categorias_cuerpos_partes_cuerpos
	ADD  PRIMARY KEY (id_cat_cue_par_cue),
	ADD CONSTRAINT categorias_cuerpos_partes_cuerpos_unique UNIQUE (id_par_cue,id_cat_cue)
;



CREATE TABLE centro_salud
(
	id_cen_sal            SERIAL,
	nom_cen_sal           VARCHAR(20) NOT NULL
)
TABLESPACE saib
;



ALTER TABLE centro_salud
	ADD  PRIMARY KEY (id_cen_sal)
;



CREATE TABLE centro_salud_pacientes
(
	id_cen_sal_pac        SERIAL,
	id_his                INTEGER NOT NULL,
	id_cen_sal            INTEGER NOT NULL,
	otr_cen_sal           VARCHAR(20) NULL
)
TABLESPACE saib
;



ALTER TABLE centro_salud_pacientes
	ADD  PRIMARY KEY (id_cen_sal_pac),
	ADD CONSTRAINT centro_salud_pacientes_unique UNIQUE (id_his,id_cen_sal)

;



CREATE TABLE contactos_animales
(
	id_con_ani            SERIAL,
	id_his                INTEGER NOT NULL,
	id_ani                INTEGER NOT NULL,
	otr_ani               VARCHAR(20) NULL
)
TABLESPACE saib
;



ALTER TABLE contactos_animales
	ADD  PRIMARY KEY (id_con_ani),
	ADD CONSTRAINT contactos_animales_unique UNIQUE (id_his,id_ani)
;



CREATE TABLE enfermedades_micologicas
(
	id_enf_mic            SERIAL,
	nom_enf_mic           VARCHAR(20) NOT NULL,
	id_tip_mic            INTEGER NOT NULL
)
TABLESPACE saib
;



ALTER TABLE enfermedades_micologicas
	ADD  PRIMARY KEY (id_enf_mic)
;



CREATE TABLE enfermedades_pacientes
(
	id_enf_pac            SERIAL,
	id_his                INTEGER NOT NULL,
	id_enf_mic            INTEGER NOT NULL,
	otr_enf_mic           VARCHAR(20) NULL,
	esp_enf_mic           VARCHAR(20) NULL
)
TABLESPACE saib
;



ALTER TABLE enfermedades_pacientes
	ADD  PRIMARY KEY (id_enf_pac),
	ADD CONSTRAINT enfermedades_pacientes_unique UNIQUE (id_his,id_enf_mic)
;



CREATE TABLE estudios_micologicos__pacientes
(
	id_est_mic_pac        SERIAL,
	id_his                INTEGER NOT NULL,
	id_pro_est_mic        INTEGER NOT NULL
)
TABLESPACE saib
;



ALTER TABLE estudios_micologicos__pacientes
	ADD  PRIMARY KEY (id_est_mic_pac),
	ADD CONSTRAINT estudios_micologicos__pacientes_unique UNIQUE (id_his,id_pro_est_mic)
;



CREATE TABLE forma_infecciones
(
	id_for_inf            SERIAL,
	des_for_inf           VARCHAR(20) NULL
)
TABLESPACE saib
;



ALTER TABLE forma_infecciones
	ADD  PRIMARY KEY (id_for_inf)
;



CREATE TABLE forma_infecciones__pacientes
(
	id_for_pac            SERIAL,
	id_for_inf            INTEGER NOT NULL,
	id_his                INTEGER NOT NULL,
	otr_for_inf           VARCHAR(20) NULL
)
TABLESPACE saib
;



ALTER TABLE forma_infecciones__pacientes
	ADD  PRIMARY KEY (id_for_pac),
	ADD CONSTRAINT forma_infecciones__pacientes_unique UNIQUE (id_for_inf,id_his)
;



CREATE TABLE forma_infecciones__tipos_micosis
(
	id_for_inf_tip_mic    SERIAL,
	id_tip_mic            INTEGER NOT NULL,
	id_for_inf            INTEGER NOT NULL
)
TABLESPACE saib
;



ALTER TABLE forma_infecciones__tipos_micosis
	ADD  PRIMARY KEY (id_for_inf_tip_mic),
	ADD CONSTRAINT forma_infecciones__tipos_micosis_unique UNIQUE (id_tip_mic,id_for_inf)
;



CREATE TABLE historiales_pacientes
(
	id_his                SERIAL,
	id_pac                INTEGER NOT NULL,
	des_his               VARCHAR(20) NULL,
	num_his               INTEGER NULL,
	nun_mic               INTEGER NULL,
	fec_his               DATE NOT NULL,
	nom_med               VARCHAR(20) NULL,
	ape_med               VARCHAR(20) NULL
)
TABLESPACE saib
;



ALTER TABLE historiales_pacientes
	ADD  PRIMARY KEY (id_his)
;



CREATE TABLE lesiones__partes_cuerpos
(
	id_les_par_cue        SERIAL,
	nom_les_par_cue       VARCHAR(20) NULL,
	id_par_cue            INTEGER NOT NULL
)
TABLESPACE saib
;



ALTER TABLE lesiones__partes_cuerpos
	ADD  PRIMARY KEY (id_les_par_cue)
;



CREATE TABLE lesiones_partes_cuerpos__pacientes
(
	id_les_par_cue_pac    SERIAL,
	id_his                INTEGER NOT NULL,
	id_les_par_cue        INTEGER NOT NULL,
	otr_les_par_cue       VARCHAR(20) NULL
)
TABLESPACE saib
;



ALTER TABLE lesiones_partes_cuerpos__pacientes
	ADD  PRIMARY KEY (id_les_par_cue_pac),
	ADD CONSTRAINT lesiones_partes_cuerpos__pacientes_unique UNIQUE (id_his,id_les_par_cue)
;



CREATE TABLE localizaciones_cuerpos
(
	id_loc_cue            SERIAL,
	nom_loc_cue           VARCHAR(20) NOT NULL
)
TABLESPACE saib
;



ALTER TABLE localizaciones_cuerpos
	ADD  PRIMARY KEY (id_loc_cue)
;



CREATE TABLE muestras_clinicas
(
	id_mue_cli            SERIAL,
	nom_mue_cli           VARCHAR(20) NOT NULL
)
TABLESPACE saib
;



ALTER TABLE muestras_clinicas
	ADD  PRIMARY KEY (id_mue_cli)
;



CREATE TABLE muestras_pacientes
(
	id_mue_pac            SERIAL,
	id_his                INTEGER NOT NULL,
	id_mue_cli            INTEGER NOT NULL,
	otr_mue_cli           VARCHAR(20) NULL
)
TABLESPACE saib
;



ALTER TABLE muestras_pacientes
	ADD  PRIMARY KEY (id_mue_pac),
	ADD CONSTRAINT muestras_pacientes_unique UNIQUE (id_his,id_mue_cli)
;



CREATE TABLE pacientes
(
	id_pac                SERIAL,
	nom_pac               VARCHAR(20) NULL,
	ape_pac               VARCHAR(20) NULL,
	ced_pac               INTEGER NULL,
	fec_nac_pac           DATE NULL,
	nac_pac               VARCHAR(20) NULL,
	tel_hab_pac           INTEGER NULL,
	tel_cel_pac           INTEGER NULL,
	ocu_pac               VARCHAR(20) NULL,
	pai_pac               VARCHAR(20) NULL,
	est_pac               VARCHAR(20) NULL,
	par_pac               VARCHAR(20) NULL,
	mun_pac               VARCHAR(20) NULL,
	ciu_pac               VARCHAR(20) NULL
)
TABLESPACE saib
;



ALTER TABLE pacientes
	ADD  PRIMARY KEY (id_pac)
;



CREATE TABLE partes_cuerpos
(
	id_par_cue            SERIAL,
	nom_par_cue           VARCHAR(20) NULL,
	id_loc_cue            INTEGER NOT NULL
)
TABLESPACE saib
;



ALTER TABLE partes_cuerpos
	ADD  PRIMARY KEY (id_par_cue)
;



CREATE TABLE propiedades_estudios_micologicos
(
	id_pro_est_mic        SERIAL,
	nom_pro_est_mic       VARCHAR(20) NULL,
	id_tip_est_mic        INTEGER NOT NULL
)
TABLESPACE saib
;



ALTER TABLE propiedades_estudios_micologicos
	ADD  PRIMARY KEY (id_pro_est_mic)
;



CREATE TABLE tipos_consultas
(
	id_tip_con            SERIAL,
	nom_tip_con           VARCHAR(20) NOT NULL
)
TABLESPACE saib
;



ALTER TABLE tipos_consultas
	ADD  PRIMARY KEY (id_tip_con)
;



CREATE TABLE tipos_consultas_pacientes
(
	id_tip_con_pac        SERIAL,
	id_tip_con            INTEGER NOT NULL,
	id_his                INTEGER NOT NULL,
	otr_tip_con           VARCHAR(20) NULL
)
TABLESPACE saib
;



ALTER TABLE tipos_consultas_pacientes
	ADD  PRIMARY KEY (id_tip_con_pac),
	ADD CONSTRAINT tipos_consultas_pacientes_unique UNIQUE (id_tip_con,id_his)
;



CREATE TABLE tipos_estudios_micologicos
(
	id_tip_est_mic        SERIAL,
	id_tip_mic            INTEGER NOT NULL,
	nom_tip_est_mic       VARCHAR(20) NULL
)
TABLESPACE saib
;



ALTER TABLE tipos_estudios_micologicos
	ADD  PRIMARY KEY (id_tip_est_mic)
;



CREATE TABLE tipos_micosis
(
	id_tip_mic            SERIAL,
	nom_tip_mic           VARCHAR(20) NULL
)
TABLESPACE saib
;



ALTER TABLE tipos_micosis
	ADD  PRIMARY KEY (id_tip_mic)
;



CREATE TABLE tratamientos
(
	id_tra                SERIAL,
	nom_tra               VARCHAR(20) NULL
)
TABLESPACE saib
;



ALTER TABLE tratamientos
	ADD  PRIMARY KEY (id_tra)
;



CREATE TABLE tratamientos_pacientes
(
	id_tra_pac            SERIAL,
	id_his                INTEGER NOT NULL,
	id_tra                INTEGER NOT NULL,
	otr_tra               VARCHAR(20) NULL
)
TABLESPACE saib
;



ALTER TABLE tratamientos_pacientes
	ADD  PRIMARY KEY (id_tra_pac),
	ADD CONSTRAINT tratamientos_pacientes_unique UNIQUE (id_his,id_tra)
;



ALTER TABLE antecedentes_pacientes
ADD CONSTRAINT antecedentes_pacientes_id_ant_per_fkey
	FOREIGN KEY (id_ant_per) REFERENCES antecedentes_personales(id_ant_per) ON UPDATE CASCADE ON DELETE CASCADE;
;


ALTER TABLE antecedentes_pacientes
ADD CONSTRAINT antecedentes_pacientes_id_his_fkey
	FOREIGN KEY (id_his) REFERENCES Historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;
;



ALTER TABLE categorias__cuerpos_micosis
ADD CONSTRAINT categorias__cuerpos_micosis_id_tip_mic_fkey
	FOREIGN KEY (id_tip_mic) REFERENCES tipos_micosis(id_tip_mic) ON UPDATE CASCADE ON DELETE CASCADE;
;


ALTER TABLE categorias__cuerpos_micosis
ADD CONSTRAINT categorias__cuerpos_micosis_id_cat_cue_fkey
	FOREIGN KEY (id_cat_cue) REFERENCES categorias_cuerpos(id_cat_cue) ON UPDATE CASCADE ON DELETE CASCADE;
;



ALTER TABLE categorias_cuerpos_partes_cuerpos
ADD CONSTRAINT categorias_cuerpos_partes_cuerpos_id_cat_cue_fkey
	FOREIGN KEY (id_cat_cue) REFERENCES categorias_cuerpos(id_cat_cue) ON UPDATE CASCADE ON DELETE CASCADE;
;


ALTER TABLE categorias_cuerpos_partes_cuerpos
ADD CONSTRAINT categorias_cuerpos_partes_cuerpos_id_par_cue_fkey
	FOREIGN KEY (id_par_cue) REFERENCES partes_cuerpos(id_par_cue) ON UPDATE CASCADE ON DELETE CASCADE;
;



ALTER TABLE centro_salud_pacientes
ADD CONSTRAINT centro_salud_pacientes_id_his_fkey
	FOREIGN KEY (id_his) REFERENCES Historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;
;


ALTER TABLE centro_salud_pacientes
ADD CONSTRAINT centro_salud_pacientes_id_cen_sal_fkey
	FOREIGN KEY (id_cen_sal) REFERENCES centro_salud(id_cen_sal) ON UPDATE CASCADE ON DELETE CASCADE;
;



ALTER TABLE contactos_animales
ADD CONSTRAINT contactos_animales_id_his_fkey
	FOREIGN KEY (id_his) REFERENCES Historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;
;


ALTER TABLE contactos_animales
ADD CONSTRAINT contactos_animales_id_ani_fkey
	FOREIGN KEY (id_ani) REFERENCES animales(id_ani) ON UPDATE CASCADE ON DELETE CASCADE;
;



ALTER TABLE enfermedades_micologicas
ADD CONSTRAINT enfermedades_micologicas_id_tip_mic_fkey
	FOREIGN KEY (id_tip_mic) REFERENCES tipos_micosis(id_tip_mic) ON UPDATE CASCADE ON DELETE CASCADE;
;



ALTER TABLE enfermedades_pacientes
ADD CONSTRAINT enfermedades_pacientes_id_his_fkey
	FOREIGN KEY (id_his) REFERENCES Historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;
;


ALTER TABLE enfermedades_pacientes
ADD CONSTRAINT enfermedades_pacientes_id_enf_mic_fkey
	FOREIGN KEY (id_enf_mic) REFERENCES enfermedades_micologicas(id_enf_mic) ON UPDATE CASCADE ON DELETE CASCADE;
;



ALTER TABLE estudios_micologicos__pacientes
ADD CONSTRAINT estudios_micologicos__pacientes_id_his_fkey
	FOREIGN KEY (id_his) REFERENCES Historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;
;


ALTER TABLE estudios_micologicos__pacientes
ADD CONSTRAINT estudios_micologicos__pacientes_id_pro_est_mic_fkey
	FOREIGN KEY (id_pro_est_mic) REFERENCES propiedades_estudios_micologicos(id_pro_est_mic) ON UPDATE CASCADE ON DELETE CASCADE;
;



ALTER TABLE forma_infecciones__pacientes
ADD CONSTRAINT forma_infecciones__pacientes_id_for_inf_fkey
	FOREIGN KEY (id_for_inf) REFERENCES forma_infecciones(id_for_inf) ON UPDATE CASCADE ON DELETE CASCADE;
;


ALTER TABLE forma_infecciones__pacientes
ADD CONSTRAINT forma_infecciones__pacientes_id_his_fkey
	FOREIGN KEY (id_his) REFERENCES Historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;
;



ALTER TABLE forma_infecciones__tipos_micosis
ADD CONSTRAINT forma_infecciones__tipos_micosis_id_tip_mic_fkey
	FOREIGN KEY (id_tip_mic) REFERENCES tipos_micosis(id_tip_mic) ON UPDATE CASCADE ON DELETE CASCADE;
;


ALTER TABLE forma_infecciones__tipos_micosis
ADD CONSTRAINT forma_infecciones__tipos_micosis_id_for_inf_fkey
	FOREIGN KEY (id_for_inf) REFERENCES forma_infecciones(id_for_inf) ON UPDATE CASCADE ON DELETE CASCADE;
;


ALTER TABLE Historiales_pacientes
ADD CONSTRAINT Historiales_pacientes_id_pac_fkey
	FOREIGN KEY (id_pac) REFERENCES Pacientes(id_pac) ON UPDATE CASCADE ON DELETE CASCADE;
		
;



ALTER TABLE lesiones__partes_cuerpos
ADD CONSTRAINT lesiones__partes_cuerpos_id_par_cue_fkey
	FOREIGN KEY (id_par_cue) REFERENCES partes_cuerpos(id_par_cue) ON UPDATE CASCADE ON DELETE CASCADE;
;



ALTER TABLE lesiones_partes_cuerpos__pacientes
ADD CONSTRAINT  lesiones_partes_cuerpos__pacientes_id_his_fkey
	FOREIGN KEY  (id_his) REFERENCES Historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;
;


ALTER TABLE lesiones_partes_cuerpos__pacientes
ADD CONSTRAINT lesiones_partes_cuerpos__pacientes_id_les_par_cue_fkey
	FOREIGN KEY  (id_les_par_cue) REFERENCES lesiones__partes_cuerpos(id_les_par_cue) ON UPDATE CASCADE ON DELETE CASCADE;
;



ALTER TABLE muestras_pacientes
ADD CONSTRAINT muestras_pacientes_id_his_fkey
	FOREIGN KEY  (id_his) REFERENCES Historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;
;


ALTER TABLE muestras_pacientes
ADD CONSTRAINT  muestras_pacientes_id_mue_cli_fkey
	FOREIGN KEY  (id_mue_cli) REFERENCES muestras_clinicas(id_mue_cli) ON UPDATE CASCADE ON DELETE CASCADE;
;



ALTER TABLE partes_cuerpos
ADD CONSTRAINT partes_cuerpos_id_loc_cue_fkey
	FOREIGN KEY  (id_loc_cue) REFERENCES localizaciones_cuerpos(id_loc_cue) ON UPDATE CASCADE ON DELETE CASCADE;
;



ALTER TABLE propiedades_estudios_micologicos
ADD CONSTRAINT propiedades_estudios_micologicos_id_tip_est_mic_fkey
	FOREIGN KEY  (id_tip_est_mic) REFERENCES tipos_estudios_micologicos(id_tip_est_mic) ON UPDATE CASCADE ON DELETE CASCADE;
;



ALTER TABLE tipos_consultas_pacientes
ADD CONSTRAINT tipos_consultas_pacientes_id_tip_con_fkey
	FOREIGN KEY (id_tip_con) REFERENCES tipos_consultas(id_tip_con) ON UPDATE CASCADE ON DELETE CASCADE;
;


ALTER TABLE tipos_consultas_pacientes
ADD CONSTRAINT tipos_consultas_pacientes_id_his_fkey
	FOREIGN KEY (id_his) REFERENCES Historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;
;



ALTER TABLE tipos_estudios_micologicos
ADD CONSTRAINT tipos_estudios_micologicos_id_tip_mic_fkey
	FOREIGN KEY (id_tip_mic) REFERENCES tipos_micosis(id_tip_mic) ON UPDATE CASCADE ON DELETE CASCADE;
;



ALTER TABLE tratamientos_pacientes
ADD CONSTRAINT tratamientos_pacientes_id_his_fkey
	FOREIGN KEY (id_his) REFERENCES Historiales_pacientes(id_his) ON UPDATE CASCADE ON DELETE CASCADE;
;


ALTER TABLE tratamientos_pacientes
ADD CONSTRAINT tratamientos_pacientes_id_tra_fkey
	FOREIGN KEY (id_tra) REFERENCES tratamientos(id_tra) ON UPDATE CASCADE ON DELETE CASCADE;
;