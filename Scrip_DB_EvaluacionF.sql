-- CREACION DE TABLAS:

-- TABLA CARGO EMPLEADO
CREATE TABLE CARGO_EMPLEADO (
    id_cargo NUMBER(1) NOT NULL,
    cargo    VARCHAR2(15) NOT NULL,
    CONSTRAINT PK_CARGO_EMPLEADO PRIMARY KEY (id_cargo)
);

-- TABLA CATEGORIA

CREATE TABLE CATEGORIA (
    id_categoria  NUMBER(1) NOT NULL,
    nom_categoria VARCHAR2(30) NOT NULL,
    CONSTRAINT PK_CATEGORIA PRIMARY KEY (id_categoria)
);

-- TABLA EMPLEADO

CREATE TABLE EMPLEADO (
    numrut_emp    NUMBER(10) NOT NULL,
    num_interno   NUMBER(6) NOT NULL UNIQUE,
    dvrut_emp     VARCHAR2(1) NOT NULL,
    nombre_emp    VARCHAR2(60) NOT NULL,
    direccion_emp VARCHAR2(60) NOT NULL,
    fecing_emp    DATE NOT NULL,
    sueldo_emp    NUMBER(7) NOT NULL,
    id_categoria  NUMBER(1) NOT NULL,
    numrut_superv NUMBER(10),
    CONSTRAINT PK_EMPLEADO PRIMARY KEY (numrut_emp)
);
-- CORECCION DE LA TABLA
ALTER TABLE EMPLEADO
ADD telefono_emp  NUMBER(10) NOT NULL;

ALTER TABLE EMPLEADO
ADD id_cargo NUMBER(1) NOT NULL;

ALTER TABLE EMPLEADO
DROP COLUMN numrut_superv;

ALTER TABLE EMPLEADO 
MODIFY nombre_emp VARCHAR2(20);

ALTER TABLE EMPLEADO 
MODIFY direccion_emp VARCHAR2(25);

ALTER TABLE EMPLEADO 
MODIFY fecing_emp DATE DEFAULT SYSDATE;

-- TABLA ESTADO CIVIL

CREATE TABLE ESTADO_CIVIL (
    id_estado_civil NUMBER(1) NOT NULL,
    estado_civil    VARCHAR2(10) NOT NULL,
    CONSTRAINT PK_ESTADO_CIVIL PRIMARY KEY (id_estado_civil)
);
ALTER TABLE ESTADO_CIVIL
ADD CONSTRAINT CK_ESTADO_CIVIL
CHECK (estado_civil IN ('Soltero', 'Casado', 'Divorciado', 'Viudo', 'Conviviente Civil'));

-- TABLA CLIENTE

CREATE TABLE CLIENTE (
    num_rut_cliente NUMBER(10) NOT NULL,
    dvrut_cli      VARCHAR2(1) NOT NULL,
    appaterno_cli   VARCHAR2(15) NOT NULL,
    apmaterno_cli   VARCHAR2(15) NOT NULL,
    nombre_cli      VARCHAR2(25) NOT NULL,
    direccion_cli   NUMBER(38) NOT NULL,
    est_civil       VARCHAR2(10),
    CONSTRAINT PK_CLIENTE PRIMARY KEY (num_rut_cliente)
);

-- CORRECION Y MODIFICACION DE TABLA CLIENTE:
ALTER TABLE CLIENTE 
ADD id_estado_civil NUMBER(1) NOT NULL;

ALTER TABLE CLIENTE 
DROP COLUMN est_civil;

ALTER TABLE CLIENTE 
MODIFY dvrut_cli NUMBER(1);

ALTER TABLE CLIENTE 
MODIFY direccion_cli VARCHAR2(25);

--CREACION DE TABLA VISITA_PROPIEDAD

CREATE TABLE VISITA_PROPIEDAD (
    fecha           DATE NOT NULL,
    num_rut_cliente NUMBER(10) NOT NULL,
    nro_propiedad   NUMBER(4) NOT NULL,
    comentarios     DATE NOT NULL,
    CONSTRAINT PK_VISITA_PROPIEDAD PRIMARY KEY (nro_propiedad,num_rut_cliente)
);

-- CORRECION Y MODIFICACION DE TABLA 
ALTER TABLE VISITA_PROPIEDAD
DROP COLUMN comentarios;

-- CREACION DE TABLA COMENTARIO

CREATE TABLE COMENTARIO (
    id_comentario   NUMBER(4) NOT NULL,
    comentario      VARCHAR2(40),
    num_rut_cliente NUMBER(10) NOT NULL,
    nro_propiedad   NUMBER(4) NOT NULL,
    CONSTRAINT PK_COMENTARIO PRIMARY KEY (id_comentario)
);

-- CREACION DE LA TABLA PROPIEDAD

CREATE TABLE PROPIEDAD (
    nro_propiedad     NUMBER(4) NOT NULL,
    direcc_propiedad  VARCHAR2(60) NOT NULL,
    nro_dormitorios   NUMBER(1) NOT NULL,
    nro_bannos        NUMBER(1) NOT NULL,
    valor_arriendo    NUMBER(8) NOT NULL,
    valor_gastocomun  NUMBER(6),
    id_tipo_propiedad NUMBER(2) NOT NULL,
    id_comuna         NUMBER(3) NOT NULL,
    numrut_emp        NUMBER(10) NOT NULL,
    CONSTRAINT PK_PROPIEDAD PRIMARY KEY (nro_propiedad)
);

-- MODIFICACION DE LA TABLA

ALTER TABLE PROPIEDAD
MODIFY id_tipo_propiedad NUMBER(4);

ALTER TABLE PROPIEDAD
MODIFY direcc_propiedad  VARCHAR2(30);

ALTER TABLE PROPIEDAD
ADD CONSTRAINT chk_valor_arriendo
CHECK (valor_arriendo <= 600000);

-- CREACION DE LA TABLA COMUNA:

CREATE TABLE COMUNA (
    id_comuna     NUMBER(3) NOT NULL,
    nombre_comuna VARCHAR2(30) NOT NULL,
    CONSTRAINT PK_COMUNA PRIMARY KEY (id_comuna)
);


-- CREACION DE LA TABLA TIPO PROPIEDAD:

CREATE TABLE TIPO_PROPIEDAD (
    id_tipo_propiedad   NUMBER(2) NOT NULL,
    desc_tipo_propiedad VARCHAR2(30),
    CONSTRAINT PK_TIPO_PROPIEDAD PRIMARY KEY (id_tipo_propiedad )
);
-- MODIFICACION DE TABLA
ALTER TABLE TIPO_PROPIEDAD 
MODIFY id_tipo_propiedad   NUMBER(4);


-- CREACION DE SECUENCIA 
-- DROP SEQUENCE SEQ_TIPO_PROPIEDAD

CREATE SEQUENCE SEQ_TIPO_PROPIEDAD
START WITH 1000 INCREMENT BY 5;


-- CREACION DE LLAVES FORANEAS:

ALTER TABLE CLIENTE
    ADD CONSTRAINT FK_CLIENTE_ESTCVIL FOREIGN KEY ( id_estado_civil )
        REFERENCES ESTADO_CIVIL ( id_estado_civil );

ALTER TABLE COMENTARIO
    ADD CONSTRAINT FK_COMENTARIO_VPROPIE FOREIGN KEY ( num_rut_cliente, nro_propiedad )
        REFERENCES VISITA_PROPIEDAD ( num_rut_cliente, nro_propiedad );

ALTER TABLE EMPLEADO
    ADD CONSTRAINT FK_EMPLEADO_CARGO FOREIGN KEY ( id_cargo )
        REFERENCES cargo_empleado ( id_cargo );

ALTER TABLE EMPLEADO
    ADD CONSTRAINT FK_EMPLEADO_CATEGORIA FOREIGN KEY ( id_categoria )
        REFERENCES categoria ( id_categoria );

ALTER TABLE PROPIEDAD
    ADD CONSTRAINT FK_PROPIEDAD_COMUNA FOREIGN KEY ( id_comuna )
        REFERENCES comuna ( id_comuna );

ALTER TABLE PROPIEDAD
    ADD CONSTRAINT FK_PROPIEDAD_EMPLEADO FOREIGN KEY ( numrut_emp )
        REFERENCES empleado ( numrut_emp );

ALTER TABLE PROPIEDAD
    ADD CONSTRAINT FK_POPIEDAD_TIPOP FOREIGN KEY ( id_tipo_propiedad )
        REFERENCES tipo_propiedad ( id_tipo_propiedad );

ALTER TABLE VISITA_PROPIEDAD
    ADD CONSTRAINT FK_VISITA_CLIENTE FOREIGN KEY ( num_rut_cliente )
        REFERENCES cliente ( num_rut_cliente );

ALTER TABLE VISITA_PROPIEDAD
    ADD CONSTRAINT FK_VISITA_PROPIEDAD FOREIGN KEY ( nro_propiedad )
        REFERENCES propiedad ( nro_propiedad );

-- insercion de datos

-- TIPO PROPIEDAD:
INSERT INTO tipo_propiedad (id_tipo_propiedad, desc_tipo_propiedad)
VALUES (SEQ_TIPO_PROPIEDAD.NEXTVAL, 'CASA');

INSERT INTO tipo_propiedad (id_tipo_propiedad, desc_tipo_propiedad)
VALUES (SEQ_TIPO_PROPIEDAD.NEXTVAL, 'DEPARTAMENTO');

INSERT INTO tipo_propiedad (id_tipo_propiedad, desc_tipo_propiedad)
VALUES (SEQ_TIPO_PROPIEDAD.NEXTVAL, 'LOFT');

INSERT INTO tipo_propiedad (id_tipo_propiedad, desc_tipo_propiedad)
VALUES (SEQ_TIPO_PROPIEDAD.NEXTVAL, 'LOCAL');

INSERT INTO tipo_propiedad (id_tipo_propiedad, desc_tipo_propiedad)
VALUES (SEQ_TIPO_PROPIEDAD.NEXTVAL, 'SITIO');

INSERT INTO tipo_propiedad (id_tipo_propiedad, desc_tipo_propiedad)
VALUES (SEQ_TIPO_PROPIEDAD.NEXTVAL, 'PARCELA CON CASA');

-- COMUNA:
INSERT INTO COMUNA VALUES (1, 'Santiago');
INSERT INTO COMUNA VALUES (2, 'Vinna del Mar');

-- CATEGORIA
INSERT INTO CATEGORIA VALUES (1, 'Categoria 1');
INSERT INTO CATEGORIA VALUES (2, 'Categoria 2');

-- ESTADO CIVIL

INSERT INTO ESTADO_CIVIL VALUES (1 ,'Viudo');
INSERT INTO ESTADO_CIVIL VALUES (2 ,'Soltero');

-- CARGO EMPLEADO

INSERT INTO CARGO_EMPLEADO (id_cargo, cargo)
VALUES (1, 'Supervisor');

INSERT INTO CARGO_EMPLEADO (id_cargo, cargo)
VALUES (2, 'Vendedor');


-- CLIENTE:
INSERT INTO CLIENTE (num_rut_cliente, dvrut_cli, appaterno_cli, apmaterno_cli, nombre_cli, direccion_cli, 
                     id_estado_civil)
VALUES (5555555555, 5 , 'VALENZUELA', 'C', 'BRYAN', 'Ahumada 254', 2);

INSERT INTO CLIENTE (num_rut_cliente, dvrut_cli, appaterno_cli, apmaterno_cli, nombre_cli, direccion_cli, 
                     id_estado_civil)
VALUES (6666666666, 5 , 'GONZALEZ', 'M', 'MURIEL', 'Ahumada 254', 1);

-- EMPLEADO:
INSERT INTO EMPLEADO (numrut_emp, num_interno, dvrut_emp, nombre_emp, direccion_emp, sueldo_emp, telefono_emp, id_cargo, id_categoria)
VALUES (1111111111, 1001, '9', 'Juan Pérez', 'Calle Principal 123', 500000, 987654321, 1, 1);

INSERT INTO EMPLEADO (numrut_emp, num_interno, dvrut_emp, nombre_emp, direccion_emp, sueldo_emp, telefono_emp, id_cargo, id_categoria)
VALUES (2222222222, 1002, '1', 'María López', 'Avenida Siempreviva 456', 600000, 123456789, 2, 2);

--PROPIEDAD:

INSERT INTO PROPIEDAD (nro_propiedad, direcc_propiedad, nro_dormitorios, nro_bannos, valor_arriendo, valor_gastocomun, id_tipo_propiedad, id_comuna, numrut_emp)
VALUES (1, 'Principal 123', 2, 1, 500000, 50000, 1010, 1, 1111111111);

INSERT INTO PROPIEDAD (nro_propiedad, direcc_propiedad, nro_dormitorios, nro_bannos, valor_arriendo, valor_gastocomun, id_tipo_propiedad, id_comuna, numrut_emp)
VALUES (2, 'Siempreviva 456', 3, 2, 400000, 80000, 1015, 2, 2222222222);


-- VISITA PROPIEDAD

INSERT INTO VISITA_PROPIEDAD (fecha, num_rut_cliente, nro_propiedad)
VALUES ('04-10-2024', 5555555555, 1);

INSERT INTO VISITA_PROPIEDAD (fecha, num_rut_cliente, nro_propiedad)
VALUES ('03-10-2024', 6666666666, 2);

-- COMENTARIO VISITA 

INSERT INTO COMENTARIO (id_comentario, comentario, num_rut_cliente, nro_propiedad)
VALUES (1, 'Propiedad está en buenas condiciones.', 5555555555, 1);

INSERT INTO COMENTARIO (id_comentario, comentario, num_rut_cliente, nro_propiedad)
VALUES (2, 'El barrio es muy tranquilo.', 6666666666, 2);

-- Desnormalizacion 


CREATE TABLE INFORME_ARRIENDO_MENSUAL (
    id_empleado NUMBER(10) NOT NULL,  
    mes_anno     VARCHAR2(7)  NOT NULL, 
    num_arriendos NUMBER  NOT NULL,     
    total_arriendo NUMBER(10)  NOT NULL, 
    CONSTRAINT PK_INFORME PRIMARY KEY (id_empleado, mes_anno)
);

INSERT INTO INFORME_ARRIENDO_MENSUAL (id_empleado, mes_anno, num_arriendos, total_arriendo)
VALUES (5555555555, '10-2024', 1, 500000);

INSERT INTO INFORME_ARRIENDO_MENSUAL (id_empleado, mes_anno, num_arriendos, total_arriendo)
VALUES (6666666666, '10-2024', 1, 400000);
