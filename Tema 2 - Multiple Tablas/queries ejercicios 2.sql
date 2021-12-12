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

/* Nombre, apellido y cursos que realiza cada estudiante*/
 select 
 e.nombre,
 e.apellido,
 c.nombre
 from inscripcion i
 inner join estudiante e on i.ESTUDIANTE_legajo = e.legajo
 inner join curso c on i.CURSO_codigo = c.codigo; 
 
/* Nombre, apellido y cursos que realiza cada estudiante, ordenados por el nombre del curso*/
select 
 c.nombre,
 e.nombre,
 e.apellido
 from inscripcion i
 inner join estudiante e on i.ESTUDIANTE_legajo = e.legajo
 inner join curso c on i.CURSO_codigo = c.codigo
 order by c.nombre;
 
/* Nombre, apellido y cursos que dicta cada profesor */
select
p.nombre,
p.apellido,
c.nombre
from curso c
inner join profesor p on c.PROFESOR_id = p.id;

/* Nombre, apellido y cursos que dicta cada profesor, ordenados por el nombre del curso */
select
c.nombre,
p.nombre,
p.apellido
from curso c
inner join profesor p on c.PROFESOR_id = p.id
order by c.nombre;

/* Cupo disponible para cada curso (Si el cupo es de 35 estudiantes y hay 5 inscriptos, el cupo disponible será 30) */
select
c.nombre,
c.cupo - count(*) as 'cupo restante'
from inscripcion i
inner join curso c on i.CURSO_codigo = c.codigo
group by c.nombre;

/* Cursos cuyo cupo disponible sea menor a 10 */
select
c.nombre,
c.cupo - count(*) as cupo
from inscripcion i
inner join curso c on i.CURSO_codigo = c.codigo
group by c.nombre, c.cupo having c.cupo- count(*) < 10;
