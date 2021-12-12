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

/* 1. Escriba una consulta que devuelva el legajo y la cantidad de cursos que realiza cada estudiante. */
select e.legajo, count(*) cantidad_cursos
from inscripcion i inner join estudiante e on i.ESTUDIANTE_legajo = e.legajo
group by e.legajo;

/* 2. Escriba una consulta que devuelva el legajo y la cantidad de cursos de los estudiantes que realizan más de un curso. */
select e.legajo, count(*) cantidad_cursos
from inscripcion i inner join estudiante e on i.ESTUDIANTE_legajo = e.legajo
group by e.legajo having cantidad_cursos > 1;

/* 3. Escriba una consulta que devuelva la información de los estudiantes que no realizan ningún curso. */
select * from estudiante e 
left join inscripcion i on i.ESTUDIANTE_legajo = e.legajo 
where i.numero is null;

/* 4. Escriba para cada tabla, los index (incluyendo su tipo) que tiene cada una. */


/* 5. Liste toda la información sobre los estudiantes que realizan cursos con los profesores de apellido “Pérez” y “Paz”. */
select * from estudiante e
inner join inscripcion i on e.legajo = i.ESTUDIANTE_legajo
inner join curso c on i.CURSO_codigo = c.codigo
inner join profesor p on p.id = c.PROFESOR_id
where p.apellido = "Perez" or p.apellido = "Paz";