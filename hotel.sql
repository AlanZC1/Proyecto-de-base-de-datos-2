/*==============================================================*/
/* Table: AREAS                                                 */
/*==============================================================*/
create table AREAS (
   SER_ID               SERIAL               not null,
   SER_NOMBRE           VARCHAR(256)         not null,
   SER_PRECIO           FLOAT8               not null,
   constraint PK_AREAS primary key (SER_ID)
);
/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE (
   CLI_ID               SERIAL               not null,
   TIPOCL_ID            INT4                 null,
   CLIE_NOMBRE          VARCHAR(50)          not null,
   CLIE_APELLIDO        VARCHAR(50)          not null,
   CLI_DIRECCION        VARCHAR(100)         not null,
   CLI_TELEFONO         VARCHAR(10)          not null,
   CLI_CEDULA           VARCHAR(10)          not null,
   constraint PK_CLIENTE primary key (CLI_ID)
);
/*==============================================================*/
/* Table: EMPLEADO                                              */
/*==============================================================*/
create table EMPLEADO (
   EM_ID                SERIAL               not null,
   TIPO_ID              INT4                 null,
   EM_NOMBRE            VARCHAR(256)         not null,
   EM_APELLIDO          VARCHAR(256)         not null,
   EM_DIRECCION         VARCHAR(256)         not null,
   EM_FNACIMIENTO       DATE                 not null,
   EM_FINGRESOLABORAL   DATE                 not null,
   constraint PK_EMPLEADO primary key (EM_ID)
);

/*==============================================================*/
/* Table: FACTURA                                               */
/*==============================================================*/
create table FACTURA (
   FAC_ID               SERIAL               not null,
   RES_IS               INT4                 null,
   FAC_FECHA            DATE                 not null,
   FAC_TOTAL            FLOAT8               not null,
   constraint PK_FACTURA primary key (FAC_ID)
);

/*==============================================================*/
/* Table: HABITACION                                            */
/*==============================================================*/
create table HABITACION (
   HABITACION_ID        SERIAL               not null,
   NUMERODECAMAS        VARCHAR(256)         not null,
   HABITACION_PRECIO    FLOAT8               not null,
   DESCUENTO            FLOAT8               null,
   DESCRIPCION          VARCHAR(256)         not null,
   constraint PK_HABITACION primary key (HABITACION_ID)
);

/*==============================================================*/
/* Table: MANTENIMIENTO                                         */
/*==============================================================*/
create table MANTENIMIENTO (
   MAN_ID               SERIAL               not null,
   EM_ID                INT4                 null,
   HABITACION_ID        INT4                 null,
   MAN_OBSERVACION      VARCHAR(256)         not null,
   MAN_FECHA            DATE                 null,
   constraint PK_MANTENIMIENTO primary key (MAN_ID)
);

/*==============================================================*/
/* Table: RESERVA                                               */
/*==============================================================*/
create table RESERVA (
   RES_IS               SERIAL               not null,
   EM_ID                INT4                 null,
   CLI_ID               INT4                 null,
   RD_OBSERVACION       INT4                 not null,
   RD_HORA_RESEVA       TIME                 not null,
   constraint PK_RESERVA primary key (RES_IS)
);

/*==============================================================*/
/* Table: RESERVA_AREAS                                         */
/*==============================================================*/
create table RESERVA_AREAS (
   RSV                  SERIAL               not null,
   RES_IS               INT4                 null,
   SER_ID               INT4                 null,
   HABITACION_ID        INT4                 null,
   constraint PK_RESERVA_AREAS primary key (RSV)
);


/*==============================================================*/
/* Table: TIPODECLIENTE                                         */
/*==============================================================*/
create table TIPODECLIENTE (
   TIPOCL_ID            SERIAL               not null,
   TIPOCL_DESWCRIPCION  VARCHAR(256)         not null,
   constraint PK_TIPODECLIENTE primary key (TIPOCL_ID)
);

/*==============================================================*/
/* Table: TIPO_EMPLEADO                                         */
/*==============================================================*/
create table TIPO_EMPLEADO (
   TIPO_ID              SERIAL               not null,
   TIPO_DESCRIPCION     VARCHAR(256)         not null,
   constraint PK_TIPO_EMPLEADO primary key (TIPO_ID)
);

alter table CLIENTE
   add constraint FK_CLIENTE_RELATIONS_TIPODECL foreign key (TIPOCL_ID)
      references TIPODECLIENTE (TIPOCL_ID)
      on delete restrict on update restrict;

alter table EMPLEADO
   add constraint FK_EMPLEADO_RELATIONS_TIPO_EMP foreign key (TIPO_ID)
      references TIPO_EMPLEADO (TIPO_ID)
      on delete restrict on update restrict;

alter table FACTURA
   add constraint FK_FACTURA_RELATIONS_RESERVA foreign key (RES_IS)
      references RESERVA (RES_IS)
      on delete restrict on update restrict;

alter table MANTENIMIENTO
   add constraint FK_MANTENIM_RELATIONS_HABITACI foreign key (HABITACION_ID)
      references HABITACION (HABITACION_ID)
      on delete restrict on update restrict;

alter table MANTENIMIENTO
   add constraint FK_MANTENIM_RELATIONS_EMPLEADO foreign key (EM_ID)
      references EMPLEADO (EM_ID)
      on delete restrict on update restrict;

alter table RESERVA
   add constraint FK_RESERVA_RELATIONS_CLIENTE foreign key (CLI_ID)
      references CLIENTE (CLI_ID)
      on delete restrict on update restrict;

alter table RESERVA
   add constraint FK_RESERVA_RELATIONS_EMPLEADO foreign key (EM_ID)
      references EMPLEADO (EM_ID)
      on delete restrict on update restrict;

alter table RESERVA_AREAS
   add constraint FK_RESERVA__RELATIONS_HABITACI foreign key (HABITACION_ID)
      references HABITACION (HABITACION_ID)
      on delete restrict on update restrict;

alter table RESERVA_AREAS
   add constraint FK_RESERVA__RELATIONS_RESERVA foreign key (RES_IS)
      references RESERVA (RES_IS)
      on delete restrict on update restrict;

alter table RESERVA_AREAS
   add constraint FK_RESERVA__RELATIONS_AREAS foreign key (SER_ID)
      references AREAS (SER_ID)
      on delete restrict on update restrict;

