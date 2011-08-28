INSERT INTO transacciones 
	(id_tip_tra, cod_tip_tra, des_tip_tra,id_mod)
VALUES
	('1', 'RED','Registrar Enfermedades Dermatológicas',1),
	('2', 'MED','Modificar Enfermedades Dermatológicas',1),
	('3', 'EED','Eliminar Enfermedades Dermatológicas',1);


INSERT INTO transacciones 
	(cod_tip_tra, des_tip_tra,id_mod)
VALUES
	('RP','Registrar Paciente',1),
	('MP','Modificar Paciente',1),
	('EP','Eliminar Paciente',1);

INSERT INTO transacciones 
	(cod_tip_tra, des_tip_tra,id_mod)
VALUES
	('RHP','Registrar Historial de paciente',1),
	('MHP','Modificar Historial de paciente',1),
	('EHP','Modificar Historial de paciente',1);


INSERT INTO transacciones 
	(cod_tip_tra, des_tip_tra,id_mod)
VALUES
	('MCP','Muestra Clínica del paciente',1),
	('IAP','Información Adicional del Paciente',1);


