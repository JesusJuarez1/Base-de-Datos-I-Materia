CREATE TABLE PACIENTE(
  ID_PACIENTE NUMBER(8) CONSTRAINT PACIENTE_PK PRIMARY KEY,
  NOMBRE VARCHAR(50),
  APATERNO VARCHAR(50),
  AMATERNO VARCHAR(50),
  TELEFONO VARCHAR(20)
);

INSERT INTO PACIENTE VALUES(1,'JUAN','PEREZ','FERNANDEZ','6548736548');
INSERT INTO PACIENTE VALUES(2,'MARIA','AGUIRRE','BARRIOS','8626426643');
INSERT INTO PACIENTE VALUES(3,'PEDRO','FLORES','MARTINEZ','8465637463');

CREATE TABLE ASISTENTE(
  ID_ASISTENTE NUMBER(8) CONSTRAINT ASISTENTE_PK PRIMARY KEY,
  NOMBRE VARCHAR(50),
  APATERNO VARCHAR(50),
  AMATERNO VARCHAR(50),
  TELEFONO VARCHAR(20)
);

INSERT INTO ASISTENTE VALUES(1,'MARIO','FERNANDEZ','PEREZ','6548736548');
INSERT INTO ASISTENTE VALUES(2,'ANTONIO','BARRIOS','AGUIRRE','8626426643');
INSERT INTO ASISTENTE VALUES(3,'GUADALUPE','MARTINEZ','FLORES','8465637463');

CREATE TABLE CITA(
  ID_PACIENTE NUMBER(8),
  ID_ASISTENTE NUMBER(8),
  FECHA_CITA DATE,
  CONSTRAINT CITA_PK PRIMARY KEY (ID_PACIENTE,ID_ASISTENTE,FECHA_CITA),
  CONSTRAINT PA_CI_FK FOREIGN KEY (ID_PACIENTE) REFERENCES PACIENTE(ID_PACIENTE),
  CONSTRAINT AS_CI_FK FOREIGN KEY (ID_ASISTENTE) REFERENCES ASISTENTE(ID_ASISTENTE)
);

INSERT INTO CITA VALUES(1,1,'15/01/20');
INSERT INTO CITA VALUES(2,2,'14/02/19');
INSERT INTO CITA VALUES(3,3,'24/11/20');

CREATE TABLE CONSULTORIO(
  ID_CONSULTORIO NUMBER(3) CONSTRAINT CONSULTORIO_PK PRIMARY KEY,
  PISO NUMBER(3),
  NOMBRE VARCHAR(100)
);

INSERT INTO CONSULTORIO VALUES(1,15,'CONSULTORIO 1');
INSERT INTO CONSULTORIO VALUES(2,12,'CONSULTORIO 2');
INSERT INTO CONSULTORIO VALUES(3,11,'CONSULTORIO 3');

CREATE TABLE MEDICO(
  ID_MEDICO NUMBER(8) CONSTRAINT MEDICO_PK PRIMARY KEY,
  NOMBRE VARCHAR(50),
  APATERNO VARCHAR(50),
  AMATERNO VARCHAR(50),
  TELEFONO VARCHAR(20),
  ESPECIALIDAD VARCHAR(100)
);

INSERT INTO MEDICO VALUES(1,'MARIO','FERNANDEZ','HERNANDEZ','6548736548','GENERAL');
INSERT INTO MEDICO VALUES(2,'JAIR','JARA','BARRIOS','6543847364','GENERAL');
INSERT INTO MEDICO VALUES(3,'MANUEL','FLORES','HERNANDEZ','9876434587','INFECCIONES');

CREATE TABLE TIPO_CONSULTA(
  ID_TIPO_CONSULTA NUMBER(4) CONSTRAINT TIPO_CONSULTA_PK PRIMARY KEY,
  NOMBRE VARCHAR(100)
);

INSERT INTO TIPO_CONSULTA VALUES(1,'GRIPA');
INSERT INTO TIPO_CONSULTA VALUES(2,'HUESO ROTO');
INSERT INTO TIPO_CONSULTA VALUES(3,'HERIDA');

CREATE TABLE CONSULTA(
  ID_PACIENTE NUMBER(8),
  ID_ASISTENTE NUMBER(8),
  FECHA_CITA DATE,
  ID_CONSULTORIO NUMBER(3),
  ID_MEDICO NUMBER(8),
  ID_TIPO_CONSULTA NUMBER(4),
  CONSTRAINT CONSULTA_PK PRIMARY KEY (ID_PACIENTE,ID_ASISTENTE,FECHA_CITA,ID_CONSULTORIO,ID_MEDICO,ID_TIPO_CONSULTA),
  CONSTRAINT CI_CON_FK FOREIGN KEY (ID_PACIENTE,ID_ASISTENTE,FECHA_CITA) REFERENCES CITA(ID_PACIENTE,ID_ASISTENTE,FECHA_CITA),
  CONSTRAINT CON_CON_FK FOREIGN KEY (ID_CONSULTORIO) REFERENCES CONSULTORIO(ID_CONSULTORIO),
  CONSTRAINT MED_CON_FK FOREIGN KEY (ID_MEDICO) REFERENCES MEDICO(ID_MEDICO),
  CONSTRAINT TI_CON_CON_FK FOREIGN KEY (ID_TIPO_CONSULTA) REFERENCES TIPO_CONSULTA(ID_TIPO_CONSULTA)
);

INSERT INTO CONSULTA VALUES(1,1,'15/01/20',1,1,1);
INSERT INTO CONSULTA VALUES(2,2,'14/02/19',2,2,2);
INSERT INTO CONSULTA VALUES(3,3,'24/11/20',3,3,3);

CREATE TABLE TIPO_ANALISIS(
  ID_ANALISIS NUMBER(5) CONSTRAINT TIPO_ANALISIS_PK PRIMARY KEY,
  NOMBRE VARCHAR(100),
  DESCRIPCION VARCHAR(150)
);

INSERT INTO TIPO_ANALISIS VALUES(1,'ANALISIS 1','AN 1');
INSERT INTO TIPO_ANALISIS VALUES(2,'ANALISIS 2','AN 2');
INSERT INTO TIPO_ANALISIS VALUES(3,'ANALISIS 3','AN 3');

CREATE TABLE ANALISIS_CLINICO(
  ID_PACIENTE NUMBER(8),
  ID_ASISTENTE NUMBER(8),
  FECHA_CITA DATE,
  ID_CONSULTORIO NUMBER(3),
  ID_MEDICO NUMBER(8),
  ID_TIPO_CONSULTA NUMBER(4),
  ID_ANALISIS NUMBER(5),
  CONSTRAINT ANA_CLI_PK PRIMARY KEY (ID_PACIENTE,ID_ASISTENTE,FECHA_CITA,ID_CONSULTORIO,ID_MEDICO,ID_TIPO_CONSULTA,ID_ANALISIS),
  CONSTRAINT CON_ANA_CLI_PK FOREIGN KEY (ID_PACIENTE,ID_ASISTENTE,FECHA_CITA,ID_CONSULTORIO,ID_MEDICO,ID_TIPO_CONSULTA) 
    REFERENCES CONSULTA(ID_PACIENTE,ID_ASISTENTE,FECHA_CITA,ID_CONSULTORIO,ID_MEDICO,ID_TIPO_CONSULTA),
  CONSTRAINT TI_ANA_ANA_CLI_FK FOREIGN KEY (ID_ANALISIS) REFERENCES TIPO_ANALISIS(ID_ANALISIS)
);

INSERT INTO ANALISIS_CLINICO VALUES(1,1,'15/01/20',1,1,1,1);
INSERT INTO ANALISIS_CLINICO VALUES(2,2,'14/02/19',2,2,2,2);
INSERT INTO ANALISIS_CLINICO VALUES(3,3,'24/11/20',3,3,3,3);

CREATE TABLE ENFERMERA(
  ID_ENFERMERA NUMBER(8) CONSTRAINT ENFERMERA_PK PRIMARY KEY,
  NOMBRE VARCHAR(50),
  APATERNO VARCHAR(50),
  AMATERNO VARCHAR(50),
  TELEFONO VARCHAR(20)
);

INSERT INTO ENFERMERA VALUES(1,'ESMERALDA','FLORES','BARRIOS','3467589264');
INSERT INTO ENFERMERA VALUES(2,'SAMUEL','AGUILAR','FERNANDEZ','6583642645');
INSERT INTO ENFERMERA VALUES(3,'ANGELA','PEREZ','VILLA','6726482648');

CREATE TABLE CUARTO(
  NUM_CUARTO NUMBER(4) CONSTRAINT CUARTO_PK PRIMARY KEY,
  NOMBRE VARCHAR(50),
  PISO NUMBER(3)
);

INSERT INTO CUARTO VALUES(1,'CUARTO 1',1);
INSERT INTO CUARTO VALUES(2,'CUARTO 2',2);
INSERT INTO CUARTO VALUES(3,'CUARTO 3',3);

CREATE TABLE HOZPITALIZACION(
  ID_PACIENTE NUMBER(8),
  ID_ASISTENTE NUMBER(8),
  FECHA_CITA DATE,
  ID_CONSULTORIO NUMBER(3),
  ID_MEDICO NUMBER(8),
  ID_TIPO_CONSULTA NUMBER(4),
  ID_ENFERMERA NUMBER(8),
  NUM_CUARTO NUMBER(4),
  CONSTRAINT HOZPITALIZACION_PK PRIMARY KEY (ID_PACIENTE,ID_ASISTENTE,FECHA_CITA,ID_CONSULTORIO,ID_MEDICO,ID_TIPO_CONSULTA,ID_ENFERMERA,NUM_CUARTO),
  CONSTRAINT CON_HOZ_FK FOREIGN KEY (ID_PACIENTE,ID_ASISTENTE,FECHA_CITA,ID_CONSULTORIO,ID_MEDICO,ID_TIPO_CONSULTA) 
    REFERENCES CONSULTA(ID_PACIENTE,ID_ASISTENTE,FECHA_CITA,ID_CONSULTORIO,ID_MEDICO,ID_TIPO_CONSULTA),
  CONSTRAINT ENF_HOZ_FK FOREIGN KEY (ID_ENFERMERA) REFERENCES ENFERMERA(ID_ENFERMERA),
  CONSTRAINT CU_HOZ_FK FOREIGN KEY (NUM_CUARTO) REFERENCES CUARTO(NUM_CUARTO)
);

INSERT INTO HOZPITALIZACION VALUES(1,1,'15/01/20',1,1,1,1,1);
INSERT INTO HOZPITALIZACION VALUES(2,2,'14/02/19',2,2,2,2,2);
INSERT INTO HOZPITALIZACION VALUES(3,3,'24/11/20',3,3,3,3,3);

CREATE TABLE MEDICAMENTO(
  ID_MEDICAMENTO NUMBER(8) CONSTRAINT MEDICAMENTO_PPK PRIMARY KEY,
  NOMBRE VARCHAR(100),
  DESCRIPCION VARCHAR(200),
  PRECIO NUMBER(7,2)
);

INSERT INTO MEDICAMENTO VALUES(1,'PARACETAMOL','TODO LO CURA',50.50);
INSERT INTO MEDICAMENTO VALUES(2,'AMOXILINA','DOLORES',35.50);
INSERT INTO MEDICAMENTO VALUES(3,'VITAMINAS','VITAMINAS',20.50);

CREATE TABLE RECETA(
  ID_PACIENTE NUMBER(8),
  ID_ASISTENTE NUMBER(8),
  FECHA_CITA DATE,
  ID_CONSULTORIO NUMBER(3),
  ID_MEDICO NUMBER(8),
  ID_TIPO_CONSULTA NUMBER(4),
  ID_MEDICAMENTO NUMBER(8),
  ID_RECETA NUMBER(8),
  CONSTRAINT RECETA_PK PRIMARY KEY (ID_PACIENTE,ID_ASISTENTE,FECHA_CITA,ID_CONSULTORIO,ID_MEDICO,ID_TIPO_CONSULTA,ID_MEDICAMENTO,ID_RECETA),
  CONSTRAINT CON_REC_FK FOREIGN KEY (ID_PACIENTE,ID_ASISTENTE,FECHA_CITA,ID_CONSULTORIO,ID_MEDICO,ID_TIPO_CONSULTA)
    REFERENCES CONSULTA(ID_PACIENTE,ID_ASISTENTE,FECHA_CITA,ID_CONSULTORIO,ID_MEDICO,ID_TIPO_CONSULTA),
  CONSTRAINT MED_REC_FK FOREIGN KEY (ID_MEDICAMENTO) REFERENCES MEDICAMENTO(ID_MEDICAMENTO)
);

INSERT INTO RECETA VALUES(1,1,'15/01/20',1,1,1,1,1);
INSERT INTO RECETA VALUES(2,2,'14/02/19',2,2,2,2,2);
INSERT INTO RECETA VALUES(3,3,'24/11/20',3,3,3,3,3);





COMMIT;