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

/* 1. Escriba una consulta que devuelva la cantidad de profesores que dictan más de un curso en el turno Noche. */
select count(*) as 'cantidad profesores'
from (
select p.id, count(*) 
from profesor p inner join curso c on p.id = c.PROFESOR_id
where c.turno = 'Noche'
group by p.id having count(*) > 1) as resultado;

/* 2. Escriba una consulta para obtener la información de todos los estudiantes que no realizan el curso con código 105. */
select * from estudiante e
where e.legajo not in (select i.ESTUDIANTE_legajo
from inscripcion i
where i.CURSO_codigo in (105));