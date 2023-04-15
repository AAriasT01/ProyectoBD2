

/**********          Base de Datos Biblioteca/Librería             ************/


--------------------------------------------------------------------------------
--------------------------   USUARIOS Y ROLES   --------------------------------
--------------------------------------------------------------------------------

ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

CREATE USER MCastroT IDENTIFIED BY "proyecto"
    DEFAULT TABLESPACE users
    TEMPORARY TABLESPACE temp
    QUOTA UNLIMITED ON users;
    
CREATE USER AAriasT IDENTIFIED BY "proyecto"
    DEFAULT TABLESPACE users
    TEMPORARY TABLESPACE temp
    QUOTA UNLIMITED ON users;

CREATE ROLE AdministradorBD;

GRANT ALL PRIVILEGES TO AdministradorBD;
GRANT Administrador to MCastroT;
GRANT Administrador to AAriasT;



--------------------------------------------------------------------------------
---------------------------   CREACIÓN TABLAS   --------------------------------
--------------------------------------------------------------------------------
CREATE TABLE Persona(
    idPersona INT NOT NULL,
    pNombre   VARCHAR2(45),
    sNombre     VARCHAR2(45),
    pApellido   VARCHAR2(45),
    sApellido   VARCHAR2(45),
    direccion  VARCHAR2(45),
    email   VARCHAR2(45),
    PRIMARY KEY (idPersona)   
    ); 

CREATE TABLE Contacto (
  idContacto NUMBER NOT NULL,
  idPersona NUMBER NOT NULL,
  numeroTelefonico VARCHAR2(20),
  tipo VARCHAR2(1),
  PRIMARY KEY (idContacto),
  CONSTRAINT fk_contacto_persona
    FOREIGN KEY (idPersona)
    REFERENCES Persona (idPersona));

CREATE TABLE Autor (
  idAutor NUMBER NOT NULL,
  idPersona NUMBER NOT NULL,
  fechaMuerte DATE,
  paisOrigen VARCHAR2(45),
  PRIMARY KEY (idAutor),
  CONSTRAINT fk_autor_persona FOREIGN KEY (idPersona)REFERENCES Persona (idPersona));


CREATE TABLE Cliente(
  idCliente NUMBER NOT NULL,
  idPersona NUMBER NOT NULL,
  fechaRegistro DATE,
  PRIMARY KEY (idCliente),
  CONSTRAINT fk_cliente_persona FOREIGN KEY (idPersona) REFERENCES Persona (idPersona));

CREATE TABLE Empleado (
  idEmpleado NUMBER NOT NULL,
  idPersona NUMBER NOT NULL,
  fechaIngreso DATE,
  numeroEmpleado NUMBER,
  idEmpleadoJefe NUMBER NOT NULL,
  PRIMARY KEY (idEmpleado),
  CONSTRAINT fk_empleado_persona
    FOREIGN KEY (idPersona)
    REFERENCES Persona (idPersona),
  CONSTRAINT fk_empleado_empleado
    FOREIGN KEY (idEmpleadoJefe)
    REFERENCES Empleado (idEmpleado));


CREATE TABLE Proveedor (
  idProveedor NUMBER NOT NULL,
  idPersona NUMBER NOT NULL,
  fechaContratoInicio DATE,
  fechaContratoFin DATE,
  PRIMARY KEY (idProveedor),
  CONSTRAINT fk_proveedor_persona
    FOREIGN KEY (idPersona)
    REFERENCES Persona (idPersona));
    
CREATE TABLE TipoVehiculo (
  idTipoVehiculo NUMBER NOT NULL,
  tipo VARCHAR2(45),
  caracteristica VARCHAR(1),
  PRIMARY KEY (idTipoVehiculo));
  
CREATE TABLE Motorista (
  idMotorista NUMBER NOT NULL,
  idEmpleado NUMBER NOT NULL,
  idTipoVehiculo NUMBER NOT NULL,
  matricula VARCHAR2(45),
  PRIMARY KEY (idMotorista),
  CONSTRAINT fk_motorista_empleado
    FOREIGN KEY (idEmpleado)
    REFERENCES Empleado (idEmpleado),
  CONSTRAINT fk_motorista_tipovehiculo
    FOREIGN KEY (idTipoVehiculo)
    REFERENCES TipoVehiculo (idTipoVehiculo));


CREATE TABLE Cargo (
  idCargo NUMBER NOT NULL,
  nombre VARCHAR2(45),
  sueldo NUMBER,
  PRIMARY KEY (idCargo));

    
CREATE TABLE Empleado_Cargo (
  idEmpleadoCargo NUMBER NOT NULL,
  idEmpleado NUMBER NOT NULL,
  idCargo NUMBER NOT NULL,
  fechaInicio DATE,
  fechaFin DATE,
  PRIMARY KEY (idEmpleadoCargo),
  CONSTRAINT fk_ec_empleado
    FOREIGN KEY (idEmpleado)
    REFERENCES Empleado (idEmpleado),
  CONSTRAINT fk_ec_cargo
    FOREIGN KEY (idCargo)
    REFERENCES Cargo (idCargo));
    
CREATE TABLE Jornada(
  idJornada NUMBER NOT NULL,
  nombre VARCHAR2(45),
  horaInicio INT,
  horaFin INT,
  PRIMARY KEY (idJornada));
  
CREATE TABLE Empleado_Jornada (
  idEmpleadoJornada NUMBER NOT NULL,
  idEmpleado NUMBER NOT NULL,
  idJornada NUMBER NOT NULL,
  fechaInicio DATE,
  fechaFin DATE,
  PRIMARY KEY (idEmpleadoJornada),
  CONSTRAINT fk_ej_empleado
    FOREIGN KEY (idEmpleado)
    REFERENCES Empleado (idEmpleado),
  CONSTRAINT fk_ej_jornada
    FOREIGN KEY (idJornada)
    REFERENCES Jornada (idJornada));
    
    
CREATE TABLE Sucursal (
  idSucursal NUMBER NOT NULL,
  nombre VARCHAR2(45),
  direccion VARCHAR2(45),
  extension NUMBER(4),
  numTelefono VARCHAR2(20),
  PRIMARY KEY (idSucursal));
  
CREATE TABLE Empleado_Sucursal(
  idEmpleadoSucursal NUMBER NOT NULL,
  idEmpleado NUMBER NOT NULL,
  idSucursal NUMBER NOT NULL,
  fechaInicio DATE,
  fechaFin DATE,
  PRIMARY KEY (idEmpleadoSucursal),
  CONSTRAINT fk_es_empleado
    FOREIGN KEY (idEmpleado)
    REFERENCES Empleado (idEmpleado),
  CONSTRAINT fk_es_sucursal
    FOREIGN KEY (idSucursal)
    REFERENCES Sucursal (idSucursal));
    
CREATE TABLE Sala (
  idSala NUMBER NOT NULL,
  idSucursal NUMBER NOT NULL,
  nombre VARCHAR2(45),
  PRIMARY KEY (idSala),
  CONSTRAINT fk_sala_sucursal
    FOREIGN KEY (idSucursal)
    REFERENCES Sucursal (idSucursal));
    
CREATE TABLE Librero(
  idLibrero NUMBER NOT NULL,
  idSala NUMBER NOT NULL,
  descripcion VARCHAR2(45),
  PRIMARY KEY (idLibrero),
  CONSTRAINT fk_librero_sala
    FOREIGN KEY (idSala)
    REFERENCES Sala (idSala));
    
CREATE TABLE Estante (
  idEstante NUMBER NOT NULL,
  idLibrero NUMBER NOT NULL,
  descripcion VARCHAR2(45),
  capacidadMax NUMBER,
  PRIMARY KEY (idEstante),
  CONSTRAINT fk_estante_librero
    FOREIGN KEY (idLibrero)
    REFERENCES Librero (idLibrero));
    
    
CREATE TABLE MesaEstudio(
  idMesaEstudio NUMBER NOT NULL,
  idSala NUMBER NOT NULL,
  PRIMARY KEY (idMesaEstudio),
  CONSTRAINT fk_ms_sala
    FOREIGN KEY (idSala)
    REFERENCES Sala (idSala));
    
CREATE TABLE MesaEstudio_Cliente (
  idMesaEstudioCliente NUMBER NOT NULL,
  idCliente NUMBER NOT NULL,
  idMesaEstudio NUMBER NOT NULL,
  fecha DATE,
  horaInicio INT,
  horaFin INT,
  PRIMARY KEY (idMesaEstudioCliente),
  CONSTRAINT fk_mec_cliente
    FOREIGN KEY (idCliente)
    REFERENCES Cliente (idCliente),
  CONSTRAINT fk_mec_mesaestudio
    FOREIGN KEY (idMesaEstudio)
    REFERENCES MesaEstudio (idMesaEstudio));


CREATE TABLE Editorial (
  idEditorial NUMBER NOT NULL,
  nombre VARCHAR2(45),
  ubicacion VARCHAR2(45),
  PRIMARY KEY (idEditorial));

CREATE TABLE Genero (
  idGenero NUMBER NOT NULL,
  nombre VARCHAR2(45),
  PRIMARY KEY (idGenero));
  
CREATE TABLE Escrito (
  idEscrito NUMBER NOT NULL,
  nombre VARCHAR2(45),
  idAutor NUMBER NOT NULL,
  fechaPublicacion DATE,
  idioma VARCHAR2(45),
  numPaginas NUMBER,
  precio NUMBER,
  idEstante NUMBER NOT NULL,
  idEditorial NUMBER NOT NULL,
  estado VARCHAR2(1),
  PRIMARY KEY (idEscrito),
  CONSTRAINT fk_escrito_autor
    FOREIGN KEY (idAutor)
    REFERENCES Autor (idAutor),
  CONSTRAINT fk_escrito_estante
    FOREIGN KEY (idEstante)
    REFERENCES Estante (idEstante),
  CONSTRAINT fk_escrito_editorial
    FOREIGN KEY (idEditorial)
    REFERENCES Editorial (idEditorial));

CREATE TABLE Escrito_Genero (
  idEscritoGenero NUMBER NOT NULL,
  idEscrito NUMBER NOT NULL,
  idGenero NUMBER NOT NULL,
  PRIMARY KEY (idEscritoGenero),
  CONSTRAINT fk_eg_genero
    FOREIGN KEY (idGenero)
    REFERENCES Genero(idGenero),
  CONSTRAINT fk_eg_escrito
    FOREIGN KEY (idEscrito)
    REFERENCES Escrito (idEscrito));


CREATE TABLE Saga (
  idSaga NUMBER NOT NULL,
  nombre VARCHAR2(45),
  estado VARCHAR2(1),
  PRIMARY KEY (idSaga));


CREATE TABLE Libro (
  idLibro NUMBER NOT NULL,
  idEscrito NUMBER NOT NULL,
  sinopsis VARCHAR2(200),
  tipoTapa VARCHAR2(1),
  idSaga NUMBER NOT NULL,
  PRIMARY KEY (idLibro),
  CONSTRAINT fk_libro_escrito
    FOREIGN KEY (idEscrito)
    REFERENCES Escrito (idEscrito),
  CONSTRAINT fk_libro_saga
    FOREIGN KEY (idSaga)
    REFERENCES Saga (idSaga));

    
CREATE TABLE Tema (
  idTema NUMBER NOT NULL,
  nombre VARCHAR2(45),
  PRIMARY KEY (idTema));
  

CREATE TABLE LibroTexto (
  idLibroTexto NUMBER NOT NULL,
  idEscrito NUMBER NOT NULL,
  idTema NUMBER NOT NULL,
  PRIMARY KEY (idLibroTexto),
  CONSTRAINT fk_lt_escrito
    FOREIGN KEY (idEscrito)
    REFERENCES Escrito (idEscrito),
  CONSTRAINT fk_lt_tema
    FOREIGN KEY (idTema)
    REFERENCES Tema (idTema));
    
CREATE TABLE Revista (
  idRevista NUMBER NOT NULL,
  idEscrito NUMBER NOT NULL,
  tipo VARCHAR2(1),
  PRIMARY KEY (idRevista),
  CONSTRAINT fk_revista_escrito
    FOREIGN KEY (idEscrito)
    REFERENCES Escrito (idEscrito));
    
CREATE TABLE RecursoDigital (
  idRecursoDigital NUMBER NOT NULL,
  idEscrito NUMBER NOT NULL,
  estado VARCHAR2(1),
  PRIMARY KEY (idRecursoDigital),
  CONSTRAINT fk_rd_escrito
    FOREIGN KEY (idEscrito)
    REFERENCES Escrito (idEscrito));
    
    
CREATE TABLE Compra (
  idCompra NUMBER NOT NULL,
  idCliente NUMBER NOT NULL,
  fecha DATE NULL,
  PRIMARY KEY (idCompra),
  CONSTRAINT fk_compra_cliente
    FOREIGN KEY (idCliente)
    REFERENCES Cliente (idCliente));
    
CREATE TABLE DetalleCompra (
  idDetalleCompra NUMBER NOT NULL,
  idCompra NUMBER NOT NULL,
  idEscrito NUMBER NOT NULL,
  PRIMARY KEY (idDetalleCompra),
  CONSTRAINT fk_dc_compra
    FOREIGN KEY (idCompra)
    REFERENCES Compra (idCompra),
  CONSTRAINT fk_dc_escrito
    FOREIGN KEY (idEscrito)
    REFERENCES Escrito (idEscrito));
    
    
CREATE TABLE FormaPago (
  idFormaPago NUMBER NOT NULL,
  nombre VARCHAR2(45),
  PRIMARY KEY (idFormaPago));


CREATE TABLE Descuento (
  idDescuento NUMBER NOT NULL,
  descripcion VARCHAR2(45),
  porcentaje NUMBER,
  PRIMARY KEY (idDescuento));
  


CREATE TABLE FacturaCompra (
  idFactura NUMBER NOT NULL,
  idCompra NUMBER NOT NULL,
  total NUMBER,
  idFormaPago NUMBER NOT NULL,
  PRIMARY KEY (idFactura),
  CONSTRAINT fk_factura_formapago
    FOREIGN KEY (idFormaPago)
    REFERENCES FormaPago (idFormaPago),
  CONSTRAINT fk_factura_compra
    FOREIGN KEY (idCompra)
    REFERENCES Compra(idCompra));
    

CREATE TABLE Descuento_Factura (
  idDescuentoFactura NUMBER NOT NULL,
  idDescuento NUMBER NOT NULL,
  idFactura NUMBER NOT NULL,
  PRIMARY KEY (idDescuentoFactura),
  CONSTRAINT fk_df_descuento
    FOREIGN KEY (idDescuento)
    REFERENCES Descuento (idDescuento),
  CONSTRAINT fk_df_factura
    FOREIGN KEY (idFactura)
    REFERENCES FacturaCompra (idFactura));
  
  
CREATE TABLE Envio (
  idEnvio NUMBER NOT NULL,
  idCompra NUMBER NOT NULL,
  idMotorista NUMBER NOT NULL,
  direccion VARCHAR2(45),
  fechaEntrega DATE,
  calificacion INT,
  PRIMARY KEY (idEnvio),
  CONSTRAINT fk_envio_compra
    FOREIGN KEY (idCompra)
    REFERENCES Compra (idCompra),
  CONSTRAINT fk_envio_motorista
    FOREIGN KEY (idMotorista)
    REFERENCES Motorista (idMotorista));


CREATE TABLE Prestamo (
  idPrestamo NUMBER NOT NULL,
  idCliente NUMBER NOT NULL,
  fechaRegistro DATE,
  fechaDevolucion DATE,
  PRIMARY KEY (idPrestamo),
  CONSTRAINT fk_prestamo_cliente
    FOREIGN KEY (idCliente)
    REFERENCES Cliente (idCliente));
    

CREATE TABLE DetallePestamo(
  idDetallePestamo NUMBER NOT NULL,
  idPrestamo NUMBER NOT NULL,
  idEscrito NUMBER NOT NULL,
  PRIMARY KEY (idDetallePestamo),
  CONSTRAINT fk_dp_escrito
    FOREIGN KEY (idEscrito)
    REFERENCES Escrito (idEscrito),
  CONSTRAINT fk_dp_prestamo
    FOREIGN KEY (idPrestamo)
    REFERENCES Prestamo (idPrestamo));


CREATE TABLE FacturaMora (
  idFacturaMora NUMBER NOT NULL,
  idPrestamo NUMBER NOT  NULL,
  total NUMBER,
  idFormaPago NUMBER NOT NULL,
  PRIMARY KEY (idFacturaMora),
  CONSTRAINT fk_fm_prestamo
    FOREIGN KEY (idPrestamo)
    REFERENCES Prestamo (idPrestamo),
  CONSTRAINT fk_fm_formapago
    FOREIGN KEY (idFormaPago)
    REFERENCES FormaPago (idFormaPago));

    
CREATE TABLE Bitacora_Proyecto (
    idBitacora NUMBER NOT NULL,
    fecha DATE NOT NULL,
    usuario VARCHAR2(45) NOT NULL,
    descripcion VARCHAR2(250) NOT NULL,
    PRIMARY KEY (idBitacora));
   

CREATE TABLE Pais (
  idPais NUMBER NOT NULL,
  nombre VARCHAR2(45),
  PRIMARY KEY (idPais));    
--------------------------------------------------------------------------------
-------------------------  CREACIÓN SECUENCIAS   -------------------------------
--------------------------------------------------------------------------------

CREATE SEQUENCE s_bitacora_Proyecto
    START WITH 1
    INCREMENT BY 1;
    
--Secuencia para la tabla persona
CREATE SEQUENCE s_persona
    START WITH 1
    INCREMENT BY 1;
    
--Secuencia para la tabla contacto
CREATE SEQUENCE s_contacto
    START WITH 1
    INCREMENT BY 1;

--Secuencia para la tabla pais
CREATE SEQUENCE s_pais
    START WITH 1
    INCREMENT BY 1;

--Secuencia para la tabla autor
CREATE SEQUENCE s_autor
    START WITH 1
    INCREMENT BY 1;

--Secuencia para la tabla cliente
CREATE SEQUENCE s_cliente
    START WITH 1
    INCREMENT BY 1;
   
--Secuencia para la tabla empleado
CREATE SEQUENCE s_empleado
    START WITH 1
    INCREMENT BY 1;
    
--Secuencia para la tabla proveedor
CREATE SEQUENCE s_proveedor
    START WITH 1
    INCREMENT BY 1;
    
--Secuencia para la tabla motorista
CREATE SEQUENCE s_motorista
    START WITH 1
    INCREMENT BY 1;
    
--Secuencia para la tabla empleado_cargo
CREATE SEQUENCE s_empleado_cargo
    START WITH 1
    INCREMENT BY 1;
    
--Secuencia para la tabla empleado_jornada
CREATE SEQUENCE s_empleado_jornada
    START WITH 1
    INCREMENT BY 1;
    
--Secuencia para la tabla sucursal
CREATE SEQUENCE s_sucursal
    START WITH 1
    INCREMENT BY 1;
    
--Secuencia para la tabla empleado_sucursal
CREATE SEQUENCE s_empleado_sucursal
    START WITH 1
    INCREMENT BY 1;
    
--Secuencia para la tabla sala
CREATE SEQUENCE s_sala
    START WITH 1
    INCREMENT BY 1;
    
--Secuencia para la tabla librero
CREATE SEQUENCE s_librero
    START WITH 1
    INCREMENT BY 1;
    
--Secuencia para la tabla estante
CREATE SEQUENCE s_estante
    START WITH 1
    INCREMENT BY 1;
    
--Secuencia para la tabla mesaestudio
CREATE SEQUENCE s_mesaestudio
    START WITH 1
    INCREMENT BY 1;
    
--Secuencia para la tabla mesaestudio_cliente
CREATE SEQUENCE s_mesaestudio_cliente
    START WITH 1
    INCREMENT BY 1;
    
--Secuencia para la tabla editorial
CREATE SEQUENCE s_editorial
    START WITH 1
    INCREMENT BY 1;
    
--Secuencia para la tabla escrito
CREATE SEQUENCE s_escrito
    START WITH 1
    INCREMENT BY 1;
    
--Secuencia para la tabla escrito_genero
CREATE SEQUENCE s_escrito_genero
    START WITH 1
    INCREMENT BY 1;
    
--Secuencia para la tabla saga
CREATE SEQUENCE s_saga
    START WITH 2
    INCREMENT BY 1;
    
--Secuencia para la tabla libroTexto
CREATE SEQUENCE s_libroTexto
    START WITH 1
    INCREMENT BY 1;
    
--Secuencia para la tabla libro
CREATE SEQUENCE s_libro
    START WITH 1
    INCREMENT BY 1;
    
--Secuencia para la tabla revista
CREATE SEQUENCE s_revista
    START WITH 1
    INCREMENT BY 1;
    
--Secuencia para la tabla recursoDigital
CREATE SEQUENCE s_recursoDigital
    START WITH 1
    INCREMENT BY 1;

--Secuencia para la tabla compra
CREATE SEQUENCE s_compra
    START WITH 1
    INCREMENT BY 1;
    
--Secuencia para la tabla detallecompra
CREATE SEQUENCE s_detallecompra
    START WITH 1
    INCREMENT BY 1;
    
--Secuencia para la tabla facturacompra
CREATE SEQUENCE s_facturacompra
    START WITH 1
    INCREMENT BY 1;
    
--Secuencia para la tabla descuentofactura
CREATE SEQUENCE s_descuentofactura
    START WITH 1
    INCREMENT BY 1;
    
--Secuencia para la tabla envio
CREATE SEQUENCE s_envio
    START WITH 1
    INCREMENT BY 1;
    
--Secuencia para la tabla prestamo
CREATE SEQUENCE s_prestamo
    START WITH 1
    INCREMENT BY 1;
    
--Secuencia para la tabla detalleprestamo
CREATE SEQUENCE s_detalleprestamo
    START WITH 1
    INCREMENT BY 1;
    
--Secuencia para la tabla facturamora
CREATE SEQUENCE s_facturamora
    START WITH 1
    INCREMENT BY 1;
   
   
   
   
--------------------------------------------------------------------------------
-----------------------------  ALTERS TABLAS   ---------------------------------
--------------------------------------------------------------------------------
ALTER TABLE autor DROP COLUMN paisOrigen;
ALTER TABLE autor ADD idPais NUMBER NOT NUll;
ALTER TABLE autor ADD CONSTRAINT fk_autor_pais FOREIGN KEY (idPais) REFERENCES Pais (idPais);
ALTER TABLE DetalleCompra ADD CONSTRAINT c_dc_escrito UNIQUE (idEscrito);
ALTER TABLE FacturaCompra ADD CONSTRAINT c_fc_compra UNIQUE (idCompra);
ALTER TABLE FacturaMora ADD CONSTRAINT c_fm_prestamo UNIQUE (idPrestamo);
ALTER TABLE Empleado ADD CONSTRAINT c_e_numEmpleado UNIQUE (numeroEmpleado);
ALTER TABLE Autor ADD CONSTRAINT c_a_persona UNIQUE (idPersona);
ALTER TABLE Proveedor ADD CONSTRAINT c_p_persona UNIQUE (idPersona);
ALTER TABLE Cliente ADD CONSTRAINT c_c_persona UNIQUE (idPersona);
ALTER TABLE Empleado ADD CONSTRAINT c_e_persona UNIQUE (idPersona);
ALTER TABLE Motorista ADD CONSTRAINT c_m_empleado UNIQUE (idEmpleado);
ALTER TABLE Motorista ADD CONSTRAINT c_m_matricula UNIQUE (matricula);
ALTER TABLE Cargo ADD CONSTRAINT c_c_nombre UNIQUE (nombre);
ALTER TABLE Empleado MODIFY (idEmpleadoJefe NULL);
ALTER TABLE Envio MODIFY (Calificacion NUMBER(1));
ALTER TABLE Envio ADD CONSTRAINT c_e_compra UNIQUE (idCompra);
ALTER TABLE Jornada MODIFY (HoraInicio NUMBER,HoraFin NUMBER);
ALTER TABLE Pais ADD CONSTRAINT c_p_nombre UNIQUE (nombre);
ALTER TABLE Persona MODIFY (idPersona NUMBER);
ALTER TABLE Libro ADD CONSTRAINT c_l_escrito UNIQUE (idEscrito);
ALTER TABLE LibroTexto ADD CONSTRAINT c_lt_escrito UNIQUE (idEscrito);
ALTER TABLE Revista ADD CONSTRAINT c_r_escrito UNIQUE (idEscrito);
ALTER TABLE RecursoDigital ADD CONSTRAINT c_rd_escrito UNIQUE (idEscrito);
ALTER TABLE Genero ADD CONSTRAINT c_g_nombre UNIQUE (nombre);
ALTER TABLE Saga ADD CONSTRAINT c_s_nombre UNIQUE (nombre);
ALTER TABLE Sucursal ADD CONSTRAINT c_su_nombre UNIQUE (nombre);
ALTER TABLE Sucursal ADD CONSTRAINT c_su_numTelefono UNIQUE (numTelefono);
ALTER TABLE Tema MODIFY (nombre NOT NULL);
ALTER TABLE Tema ADD CONSTRAINT c_t_nombre UNIQUE (nombre);
ALTER TABLE Escrito MODIFY (idEstante NULL);






--------------------------------------------------------------------------------
----------------------------   INSERTS TABLAS   --------------------------------
--------------------------------------------------------------------------------

--Inserts de tabla Bitacora_Proyecto
INSERT INTO bitacora_proyecto VALUES (s_bitacora_proyecto.NEXTVAL, to_date('01-03-2023', 'DD-MM-YYYY'), 'AAriasT', 'Creación script, usuarios, roles, tablas');
INSERT INTO bitacora_proyecto VALUES (s_bitacora_proyecto.NEXTVAL, to_date('02-03-2023', 'DD-MM-YYYY'), 'AAriasT', 'Alters a distintas tablas');
INSERT INTO bitacora_proyecto VALUES (s_bitacora_proyecto.NEXTVAL, to_date('02-03-2023','DD-MM-YYYY'), 'MCastroT', 'Creacion de sequencias');
INSERT INTO bitacora_proyecto VALUES (s_bitacora_proyecto.NEXTVAL, to_date('02-03-2023','DD-MM-YYYY'), 'MCastroT', 'Insertar datos en las tablas');
INSERT INTO bitacora_proyecto VALUES (s_bitacora_proyecto.NEXTVAL, to_date('03-03-2023','DD-MM-YYYY'), 'MCastroT', 'Cambios en los datos en las tablas');
INSERT INTO bitacora_proyecto VALUES (s_bitacora_proyecto.NEXTVAL, to_date('03-03-2023','DD-MM-YYYY'), 'MCastroT', 'Creacion de vistas');
INSERT INTO bitacora_proyecto VALUES (s_bitacora_proyecto.NEXTVAL, to_date('03-03-2023','DD-MM-YYYY'), 'AAriasT', 'Creacion de vistas');


--Tabla tipo Vehiculo
INSERT INTO tipovehiculo VALUES(1,'Automovil','A');
INSERT INTO tipovehiculo VALUES(2,'Motocicleta','A');
INSERT INTO tipovehiculo VALUES(3,'Automovil','M');
INSERT INTO tipovehiculo VALUES(4,'Motocicleta','M');

--Tabla cargo
INSERT INTO cargo VALUES(1,'cajero',1000);
INSERT INTO cargo VALUES(2,'Bibliotecario',1500);
INSERT INTO cargo VALUES(3,'gerente',2500);

--Tabla jornada
INSERT INTO jornada VALUES(1,'Matutina',7,13);
INSERT INTO jornada VALUES(2,'Vespertina',13,19);

--Tabla genero
INSERT INTO genero VALUES(1,'Narrativo');
INSERT INTO genero VALUES(2,'Lirico');
INSERT INTO genero VALUES(3,'Dramatico');
INSERT INTO genero VALUES(4,'Didactico');
INSERT INTO genero VALUES(5,'Cuento');
INSERT INTO genero VALUES(6,'Novela');
INSERT INTO genero VALUES(7,'Fantasía');
INSERT INTO genero VALUES(8,'Romance');
INSERT INTO genero VALUES(9,'Tragedia');

--Tabla saga
INSERT INTO saga VALUES(1,'Autoconclusivo','C');

--Tabla formapago
INSERT INTO formapago VALUES(1,'Efectivo');
INSERT INTO formapago VALUES(2,'Cheque');
INSERT INTO formapago VALUES(3,'Tarjetas de débito');
INSERT INTO formapago VALUES(4,'Tarjetas de crédito');
INSERT INTO formapago VALUES(5,'Transferencia bancaria');
INSERT INTO formapago VALUES(6,'Pago móvil');

--Modulo de RRHH
BEGIN
        --Tabla persona
        FOR i IN 1..150 LOOP
            INSERT INTO persona(idpersona,pnombre,snombre,papellido,sapellido,direccion,email)
            VALUES(s_persona.NEXTVAL,'pNombre'||s_persona.NEXTVAL,'sNombre'||s_persona.NEXTVAL,'pApellido'||s_persona.NEXTVAL,'sApellido'||s_persona.NEXTVAL,
                   'Direccion'||s_persona.NEXTVAL,'Email'||s_persona.NEXTVAL);
        END LOOP;
        
        --Tabla contacto 
        FOR i IN 25..50 LOOP
            INSERT INTO contacto(idcontacto,idpersona,numeroTelefonico,tipo)
            VALUES(s_contacto.NEXTVAL,i,'Numero'||s_contacto.NEXTVAL,'A');
        END LOOP;

        --Tabla pais
        FOR i IN 1..50 LOOP
            INSERT INTO pais(idpais,nombre)
            VALUES(s_pais.NEXTVAL,'Nombre'||s_contacto.NEXTVAL);
        END LOOP; 
        
        --Tabla autor
        FOR i IN 76..125 LOOP
            INSERT INTO autor(idautor,idpersona,idpais)
            VALUES(s_autor.NEXTVAL,i,s_autor.NEXTVAL);
        END LOOP;
        
        --Tabla ciente
        FOR i IN 1..50 LOOP
            INSERT INTO cliente(idcliente,idpersona,fecharegistro) 
            VALUES(s_cliente.NEXTVAL,i,SYSDATE);
        END LOOP;

        --Tabla empleado
        INSERT INTO empleado(idempleado,idpersona,fechaIngreso,numeroEmpleado) VALUES(s_empleado.NEXTVAL,25,SYSDATE,s_empleado.NEXTVAL);

        FOR i IN 26..75 LOOP
            INSERT INTO empleado(idempleado,idpersona,fechaIngreso,numeroEmpleado,IdEmpleadoJefe)
            VALUES(s_empleado.NEXTVAL,i,SYSDATE,s_empleado.NEXTVAL,1);
        END LOOP;
        
        --Tabla proveedor 
        FOR i IN 126..150 LOOP
            INSERT INTO proveedor
            VALUES(s_proveedor.NEXTVAL,i,SYSDATE,SYSDATE+i);
        END LOOP;
        
        --Tabla motorista
        FOR i IN 1..30 LOOP
            INSERT INTO motorista(idmotorista,idempleado,idTipoVehiculo,matricula)
            VALUES(s_motorista.NEXTVAL,s_motorista.NEXTVAL,Mod (i, 2)+1,'matricula'||s_motorista.NEXTVAL);
        END LOOP; 
        
        --Tabla empleado_cargo
        FOR i IN 1..50 LOOP
            INSERT INTO empleado_cargo(idempleadoCargo,idempleado,idCargo,fechainicio, fechafin)
            VALUES(s_empleado_cargo.NEXTVAL,s_empleado_cargo.NEXTVAL,Mod (i, 2)+1,SYSDATE,SYSDATE+i);
        END LOOP;
        
        --Tabla empleado_jornada
        FOR i IN 1..50 LOOP
            INSERT INTO empleado_jornada(idempleadoJornada,idempleado,idJornada,fechainicio, fechafin) 
            VALUES(s_empleado_jornada.NEXTVAL,i,Mod (i, 2)+1,SYSDATE,SYSDATE+i);
        END LOOP;
        
        --Tabla sucursal
        FOR i IN 1..50 LOOP
            INSERT INTO sucursal(idsucursal,nombre,direccion,extension, numtelefono)
            VALUES(s_sucursal.NEXTVAL,'Nombre'||s_sucursal.NEXTVAL,'Direccion'||s_sucursal.NEXTVAL,i,'Telefono'||s_sucursal.NEXTVAL);
        END LOOP;

        --Tabla empleado_sucursal 
        FOR i IN 1..50 LOOP
            INSERT INTO empleado_sucursal
            VALUES(s_empleado_sucursal.NEXTVAL,i,s_empleado_sucursal.NEXTVAL,SYSDATE,SYSDATE+i);
        END LOOP;
        
        COMMIT;
        
        EXCEPTION
            WHEN OTHERS THEN
                dbms_output.put_line('Codigo error '||SQLCODE);
                dbms_output.put_line('Mensaje de error '||SQLERRM);

        ROLLBACK;
END;

--Modulo de Mobiliario y equipo
BEGIN
        --Tabla sala
        FOR i IN 1..50 LOOP
            INSERT INTO sala
            VALUES(s_sala.NEXTVAL,i,'Nombre'||s_sala.NEXTVAL);
        END LOOP;

        --Tabla librero
        FOR i IN 1..50 LOOP
            INSERT INTO librero
            VALUES(s_librero.NEXTVAL,i,'Nombre'||s_librero.NEXTVAL);
        END LOOP;

        --Tabla estante
        FOR i IN 1..50 LOOP
            INSERT INTO estante
            VALUES(s_estante.NEXTVAL,i,'Descripcion'||s_contacto.NEXTVAL,i);
        END LOOP;
        
        --Tabla mesaestudio
        FOR i IN 1..50 LOOP
            INSERT INTO mesaestudio
            VALUES(s_mesaestudio.NEXTVAL,i);
        END LOOP;
        
        --Tabla mesaestudio_cliente
        FOR i IN 1..50 LOOP
            INSERT INTO mesaestudio_cliente
            VALUES(s_mesaestudio_cliente.NEXTVAL,i,i,SYSDATE,To_CHAR(systimestamp,'HH'),To_CHAR(systimestamp,'HH')+2);
        END LOOP;
        
        COMMIT;
        
        EXCEPTION
            WHEN OTHERS THEN
                dbms_output.put_line('Codigo error '||SQLCODE);
                dbms_output.put_line('Mensaje de error '||SQLERRM);

        ROLLBACK;
END;

--Modulo de Recursos
BEGIN
        --Tabla editorial
        FOR i IN 1..50 LOOP
            INSERT INTO editorial
            VALUES(s_editorial.NEXTVAL,'Nombre'||s_editorial.NEXTVAL,'Ubicacion'||s_persona.NEXTVAL);
        END LOOP;
        
        --Tabla escrito 
        FOR i IN 1..200 LOOP
            IF i<50 THEN
                INSERT INTO escrito
                VALUES(s_escrito.NEXTVAL,'Nombre'||s_escrito.NEXTVAL,i,SYSDATE,'Español',i,i,i,i,'A');    
            ELSE
                INSERT INTO escrito
                VALUES(s_escrito.NEXTVAL,'Nombre'||s_escrito.NEXTVAL,ROUND(i/20),SYSDATE,'Español',i,i,ROUND(i/20),ROUND(i/20),'A');
            END IF;   
        END LOOP;

        --Tabla escrito_genero
        FOR i IN 1..50 LOOP
            IF i<6 THEN
                INSERT INTO escrito_genero
                VALUES(s_escrito_genero.NEXTVAL,i,i);
            ELSE
                INSERT INTO escrito_genero
                VALUES(s_escrito_genero.NEXTVAL,i,ROUND(i/10));
            END IF;
        END LOOP; 
        
        --Tabla saga
        FOR i IN 1..49 LOOP
            INSERT INTO saga
            VALUES(s_saga.NEXTVAL,'Nombre'||s_saga.NEXTVAL,'A');
        END LOOP;

        --Tabla libro
        FOR i IN 1..50 LOOP
            INSERT INTO libro
            VALUES(s_libro.NEXTVAL,i,'Sipnosis'||s_libro.NEXTVAL,'D',i);
        END LOOP;
        
        --Tabla tema 
        FOR i IN 1..50 LOOP
            INSERT INTO tema
            VALUES(i,'Nombre'||i);
        END LOOP;
        
        --Tabla librotexto
        FOR i IN 51..100 LOOP
            INSERT INTO librotexto
            VALUES(s_librotexto.NEXTVAL,i,s_librotexto.NEXTVAL);
        END LOOP; 
        
        --Tabla revista
        FOR i IN 101..150 LOOP
            INSERT INTO revista
            VALUES(s_revista.NEXTVAL,i,'A');
        END LOOP;
        
        --Tabla recursodigital
        FOR i IN 151..200 LOOP
            INSERT INTO recursodigital 
            VALUES(s_recursodigital.NEXTVAL,i,'A');
        END LOOP;
        
        COMMIT;
        
        EXCEPTION
            WHEN OTHERS THEN
                dbms_output.put_line('Codigo error '||SQLCODE);
                dbms_output.put_line('Mensaje de error '||SQLERRM);

        ROLLBACK;
END;

--Modulo de servicios
BEGIN
        --Tabla compra
        FOR i IN 1..50 LOOP
            INSERT INTO compra
            VALUES(s_compra.NEXTVAL,i,SYSDATE);
        END LOOP;
        
        --Tabla detallecompra 
        FOR i IN 1..50 LOOP
            INSERT INTO detallecompra
            VALUES(s_detallecompra.NEXTVAL,i,i);  
        END LOOP;

        --Tabla descuento
        FOR i IN 1..10 LOOP
            INSERT INTO descuento
            VALUES(i,'Descripcion'||i,1*0.1);
        END LOOP; 
        
        --Tabla Facturacompra
        FOR i IN 1..50 LOOP
            IF i>6 THEN
                INSERT INTO Facturacompra
                VALUES(s_facturacompra.NEXTVAL,i,i,ROUND(i/9));
            ELSE
                INSERT INTO Facturacompra
                VALUES(s_facturacompra.NEXTVAL,i,i,i);
            END IF;
        END LOOP;

        --Tabla descuento_factura
        FOR i IN 1..50 LOOP
            IF i>10 THEN
                INSERT INTO descuento_factura
                VALUES(s_descuentofactura.NEXTVAL,ROUND(i/10),i);
            ELSE
                INSERT INTO descuento_factura
                VALUES(s_descuentofactura.NEXTVAL,i,i);
            END IF;
        END LOOP;
        
        --Tabla envio 
        FOR i IN 1..50 LOOP
            INSERT INTO envio
            VALUES(s_envio.NEXTVAL,i,ROUND(i/2),'Direccion'||s_envio.NEXTVAL, SYSDATE,Mod (i, 2));
        END LOOP;
        
        --Tabla prestamo
        FOR i IN 1..50 LOOP
            INSERT INTO prestamo
            VALUES(s_prestamo.NEXTVAL,i,SYSDATE,SYSDATE+i);
        END LOOP; 
        
        --Tabla detalleprestamo
        FOR i IN 1..50 LOOP
            INSERT INTO detallepestamo
            VALUES(s_detalleprestamo.NEXTVAL,i,i+50);
        END LOOP;
        
        --Tabla facturamora
        FOR i IN 1..30 LOOP
            IF i>6 THEN
                INSERT INTO facturamora 
                VALUES(s_facturamora.NEXTVAL,i,i,ROUND(i/6));
            ELSE
                INSERT INTO facturamora 
                VALUES(s_facturamora.NEXTVAL,i,i,i);
            END IF;
            
        END LOOP;
        
        COMMIT;
        
        EXCEPTION
            WHEN OTHERS THEN
                dbms_output.put_line('Codigo error '||SQLCODE);
                dbms_output.put_line('Mensaje de error '||SQLERRM);

        ROLLBACK;
END;





--------------------------------------------------------------------------------
--------------------------   CREACION DE VISTAS   ------------------------------
--------------------------------------------------------------------------------

--Información de cada empleado y la sucursal en que trabaja
CREATE VIEW v_empleados_sucursal AS
SELECT p.pnombre||' '||p.snombre||' '||p.papellido||' '||p.sapellido Nombre_empleado, es.fechainicio, s.nombre sucursal
FROM empleado e 
INNER JOIN empleado_sucursal es ON e.idempleado=es.idempleado
INNER JOIN sucursal s ON s.idsucursal=es.idsucursal
INNER JOIN persona p ON e.idpersona=p.idpersona
ORDER BY s.idsucursal;


--Todos los prestamos de libros de texto
CREATE VIEW v_prestamos AS
SELECT pt.idprestamo, e.nombre Titulo_libro, ROUND(pt.fechadevolucion-pt.fechaRegistro) dias_prestamo, 
p.pnombre||' '||p.snombre||' '||p.papellido||' '||p.sapellido Nombre_cliente
FROM prestamo pt 
INNER JOIN detallepestamo dp ON pt.idprestamo=dp.idprestamo
INNER JOIN escrito e ON e.idescrito=dp.idescrito
INNER JOIN librotexto l ON l.idescrito=e.idescrito
INNER JOIN cliente c ON c.idcliente=pt.idcliente
INNER JOIN persona p ON c.idpersona=p.idpersona;


--Compras de escritos de tipo Libro
CREATE VIEW v_compras AS
SELECT cp.idcompra, e.nombre Titulo_libro, cp.fecha, 
p.pnombre||' '||p.snombre||' '||p.papellido||' '||p.sapellido Nombre_cliente
FROM compra cp 
INNER JOIN detallecompra dc ON cp.idcompra=dc.idcompra
INNER JOIN escrito e ON e.idescrito=dc.idescrito
INNER JOIN libro l ON l.idescrito=e.idescrito
INNER JOIN cliente c ON c.idcliente=cp.idcliente
INNER JOIN persona p ON c.idpersona=p.idpersona;


--Lista de libros que incluye cada compra
CREATE VIEW v_listaCompra AS
SELECT c.idCompra, p.pnombre ||' '|| p.papellido Nombre_Cliente, LISTAGG(e.nombre,'; ') Lista_Compra FROM COMPRA C
INNER JOIN detalleCompra dc ON c.idCompra= dc.idCompra
INNER JOIN Cliente cl ON cl.idCliente= c.idCliente
INNER JOIN Persona p ON p.idPersona = cl.idPersona
INNER JOIN Escrito e ON e.idEscrito = dc.idEscrito
GROUP BY c.idCompra, p.pnombre, p.papellido;

--Cantidad de escritos vendidos por cada genero
CREATE VIEW v_GenerosVendidos AS
SELECT g.idGenero, g.nombre, COUNT(g.idGenero) Cantidad_Vendida FROM DetalleCompra dc
INNER JOIN Escrito e ON dc.idEscrito = e.idEscrito
INNER JOIN escrito_Genero eg ON eg.idEscrito = e.idEscrito
INNER JOIN genero g ON g.idGenero = eg.idGenero
GROUP BY g.idGenero, g.nombre;
