INSERT INTO transacciones 
	(cod_tip_tra, des_tip_tra,id_mod)
VALUES
	('RED','Registrar Enfermedades Dermatológicas',1),
	('MED','Modificar Enfermedades Dermatológicas',1),
	('EED','Eliminar Enfermedades Dermatológicas',1);


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
	
	
INSERT INTO transacciones 
	(cod_tip_tra, des_tip_tra,id_mod)
VALUES
	('EG','Género',3),
	('EGE','Grupo etario',3),
	('EEM','Enfermedades micológicas',3),
	('ETM','Tipo de micosis',3);
	
INSERT INTO transacciones 
	(cod_tip_tra, des_tip_tra,id_mod)
VALUES
	('RTU','Transacciones de Usuarios',2),
	('EMP','Enfermedades Micológicas del Paciente ',2);
	
	
INSERT INTO transacciones 
	(cod_tip_tra, des_tip_tra,id_mod)
VALUES
	('AUA','Agregar usuario administrador',4),
	('MUA','Modificar usuario administrador',4),
	('EUA','Eliminar usuario administrador',4)
	('RCA','Restablecer contraseña del usuario administrador',4);


INSERT INTO transacciones 
	(cod_tip_tra, des_tip_tra,id_mod)
VALUES
	('AUO','Agregar usuario operador',5),
	('MUO','Modificar usuario operador',5),
	('EUO','Eliminar usuario operador',5),
	('RCO','Restablecer contraseña del usuario operador',5);


