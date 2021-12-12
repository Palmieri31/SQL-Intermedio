create database alkemy;
use alkemy;

create table profesor (
	id int primary key not null auto_increment,
    nombre varchar(45) not null,
    apellido varchar(45) not null,
    fecha_nacimiento date not null,
    salario float not null
);

create table curso (
	codigo int primary key not null,
  	nombre varchar(45) not null,
  	descripcion varchar(45),
    cupo int not null,
  	turno varchar(45) not null,
    PROFESOR_id int,
    constraint fk_curso_profesor foreign key(PROFESOR_id) references profesor(id)
);

create table estudiante (
	legajo int primary key not null,
    nombre varchar(45) not null,
    apellido varchar(45) not null,
    fecha_nacimiento date not null,
    carrera varchar(45) not null
);

create table inscripcion (
	numero int primary key not null auto_increment,
    CURSO_codigo int,
    ESTUDIANTE_legajo int,
    fecha_hora timestamp not null,
    constraint fk_inscripcion_curso foreign key(CURSO_codigo) references curso(codigo),
    constraint fk_inscripcion_estudiante foreign key(ESTUDIANTE_legajo) references estudiante(legajo)
);

/* 1. Escriba una consulta para saber cuántos estudiantes son de la carrera Mecánica.*/
select count(carrera) as 'Estudiantes Mecanica' from estudiante e where e.carrera = 'Mecanica';

/* 2. Escriba una consulta para saber, de la tabla PROFESOR, el salario mínimo de los profesores nacidos en la década del 80.*/
select min(salario) as 'Salario Minimo 80' from profesor where fecha_nacimiento between '1980-01-01' and '1989-12-31';

/***************************************************************************************************************************************************************************/

create table pais(
	id int primary key not null auto_increment,
    nombre varchar(30) not null
);

create table pasajero(
	id int primary key not null,
    nombre varchar(45) not null,
    apaterno varchar(45) not null,
    amaterno varchar(45),
    tipo_documento varchar(10) not null,
    fecha_nacimiento date not null,
    id_pais int not null,
    telefono int not null,
    email varchar(50) not null,
    clave varchar(50) not null,
    constraint fk_pasajero_pais foreign key(id_pais) references pais(id)
);

create table pago(
	id int primary key not null auto_increment,
    idreserva int not null,
    fecha date not null,
    idpasajero int not null,
    monto float not null,
    tipo_comprobante varchar(3) not null,
    num_comprobante int not null,
    impuesto float not null,
    constraint fk_pago_pasajero foreign key(idpasajero) references pasajero(id)
);

/* Cantidad de pasajeros por país*/
select pais.nombre, count(*) as 'pasajeros' from pasajero inner join pais on pasajero.id_pais = pais.id group by pais.nombre;

/* Suma de todos los pagos realizados*/
select sum(round(((monto * impuesto) + monto), 2)) as 'pagos totales' from pago; 

/* Suma de todos los pagos que realizó un pasajero. El monto debe aparecer con dos decimales. */
select pasajero.nombre, sum(round(((monto * impuesto) + monto), 2)) as monto_total from pago inner join pasajero on pago.idpasajero = pasajero.id group by pasajero.nombre;

/* Promedio de los pagos que realizó un pasajero. */
select  pasajero.nombre, round(avg((monto * impuesto) + monto), 2) as promedio_pagos from pago inner join pasajero on pago.idpasajero = pasajero.id group by pasajero.nombre;

