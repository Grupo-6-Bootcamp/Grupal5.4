-- ABP Ejercicio Grupal 5.4 Cynthia - Esteban - Alvaro - Guido

# Parte 1: Crear entorno de trabajo
#Crear una base de datos
CREATE DATABASE appejercicio4;
USE appejercicio4; 
#Crear un usuario con todos los privilegios para trabajar con la base de datos recién creada.
CREATE USER 'appingreso'@'%' IDENTIFIED BY 'appingreso123'; -- Creacion del usuario appingreso
GRANT ALL PRIVILEGES ON appejercicio4.* TO 'appingreso'@'%'; -- Otorgamos todos los permisos sobre el usuario appingreso

#Parte 2: Crear dos tablas.
CREATE TABLE usuarios (
  id_usuario INT PRIMARY KEY AUTO_INCREMENT, -- 5. Es optimo al ser un valor unico
  nombre VARCHAR(15) NOT NULL, -- 5. Consideramos optimo un varchar pequeño para el proceso de indexacion
  apellido VARCHAR(15) NOT NULL, -- 5. Aplicamos una logica similar en este valor
  contrasena VARCHAR(15) NOT NULL, -- 5. Nuevamente aplicamos la misma logica, cabe aclarar que todos los valores son NN para forzar su ingreso
  zona_horaria VARCHAR(15) DEFAULT 'UTC-3',-- 5. Definimos zona horaria local acorde a nuestra app, de requerirlo el clte se modificaria en caso de una migracion
  genero ENUM('Masculino', 'Femenino', 'Otro') NOT NULL, -- 5. En este caso utilizamos enum debido a que solo tenemos 3 opciones y forzamos la utilizacion del campo
  telefono VARCHAR(13) NOT NULL  -- 5. Creemos que lo mas optimo es un varchar en caso de necesitar + en el celular 
);

CREATE TABLE ingreso(
id_ingreso INT PRIMARY KEY AUTO_INCREMENT,
id_usuario INT NOT NULL,
dyt_ingreso DATETIME DEFAULT CURRENT_TIMESTAMP(),
CONSTRAINT ingreso_usuarioid_pk FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

#Parte 3: Modificación de la tabla usuarios en la columna zona_horaria
ALTER TABLE appejercicio4.usuarios MODIFY COLUMN zona_horaria varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'UTC-2' NULL;

#Parte 4: Creacion de registros
INSERT INTO usuarios(id_usuario,nombre,apellido,contrasena,genero,telefono)
VALUES
(1, "Javier", "González", "123456", "Masculino", "+56912345678"), -- Creacion de usuarios
(2, "María", "López", "qwerty", "Femenino", "+56987654321"), -- Creacion de usuarios
(3, "Juan", "Rodríguez", "abc123",  "Masculino", "+56955555555"), -- Creacion de usuarios
(4, "Carolina", "Silva", "password", "Femenino", "+56977777777"), -- Creacion de usuarios
(5, "Pedro", "Morales", "securepass", "Masculino", "+56999999999"), -- Creacion de usuarios
(6, "Fernanda", "Gómez", "p@ssw0rd", "Femenino", "+56911111111"), -- Creacion de usuarios
(7, "Luis", "Muñoz", "ilovecats", "Masculino", "+56922222222"), -- Creacion de usuarios
(8, "Ana", "Herrera", "letmein", "Femenino", "+56933333333"); -- Creacion de usuarios

INSERT INTO ingreso(id_ingreso,id_usuario,dyt_ingreso)
VALUES
(10, 1, '2023-05-26 08:30:00'), -- Datos para tabla ingreso
(20, 2, '2023-05-26 09:15:00'), -- Datos para tabla ingreso
(30, 3, '2023-05-26 10:00:00'), -- Datos para tabla ingreso
(40, 4, '2023-05-26 11:45:00'), -- Datos para tabla ingreso
(50, 5, '2023-05-26 13:20:00'), -- Datos para tabla ingreso
(60, 6, '2023-05-26 14:10:00'), -- Datos para tabla ingreso
(70, 7, '2023-05-26 15:30:00'), -- Datos para tabla ingreso
(80, 8, '2023-05-26 16:45:00'); -- Datos para tabla ingreso

#Parte 5: Justifique cada tipo de dato utilizado. ¿Es el óptimo en cada caso?
#Se encontrara el la justificacion a modo de comentarios en los valores de cada tabla 

#Parte 6: Creen una nueva tabla llamada Contactos (id_contacto, id_usuario, numero de telefono,correo electronico).
CREATE TABLE contactos (
  id_contacto INT PRIMARY KEY AUTO_INCREMENT, -- 5. Consideramos optimo una primary key para tener un control de identidad sobre el usuario 
  id_usuario INT NOT NULL, -- 5. Utilizamos NN y asi evitar posibles errores debido a que es un parametro que proximamente es vital
  telefono VARCHAR(13), -- 5. En el caso de telefono utilizamos varchar debido a que en algun momento se puede necesitar +
  correo VARCHAR(25) -- 5. Creemos optimo un VARCHAR(25) en este caso ya que hay usuarios que pueden presentar mails extensos
);

INSERT INTO contactos(id_usuario,telefono,correo)
VALUES
(1,56980103232,'contacto1@email.cl'), -- Datos para tabla contactos
(2,56980203232,'contacto2@email.cl'), -- Datos para tabla contactos
(3,56980303232,'contacto3@email.cl'), -- Datos para tabla contactos
(4,569806403232,'contacto4@email.cl'), -- Datos para tabla contactos
(5,56980653232,'contacto5@email.cl'), -- Datos para tabla contactos
(6,56980663232,'contacto6@email.cl'), -- Datos para tabla contactos
(7,56980673232,'contacto7@email.cl'), -- Datos para tabla contactos
(8,56980683232,'contacto8@email.cl'); -- Datos para tabla contactos

SELECT * FROM contactos;
#Parte 7: Modifique la columna teléfono de contacto, para crear un vínculo entre la tabla Usuarios y la tabla Contactos.
ALTER TABLE usuarios DROP COLUMN telefono; -- Se elimina la columna con telefonos original
ALTER TABLE usuarios ADD COLUMN telefono INT; -- Se vuelve a agregar
#Se vincula las columnas telefono y id_contacto para vincularse entre si
ALTER TABLE usuarios ADD CONSTRAINT usuarios_telefono_fk FOREIGN KEY (telefono) REFERENCES contactos(id_contacto); 
UPDATE usuarios SET telefono = 1 WHERE id_usuario = 1;
UPDATE usuarios SET telefono = 2 WHERE id_usuario = 2;
UPDATE usuarios SET telefono = 3 WHERE id_usuario = 3;
UPDATE usuarios SET telefono = 4 WHERE id_usuario = 4;
UPDATE usuarios SET telefono = 5 WHERE id_usuario = 5;
UPDATE usuarios SET telefono = 6 WHERE id_usuario = 6;
UPDATE usuarios SET telefono = 7 WHERE id_usuario = 7;
UPDATE usuarios SET telefono = 8 WHERE id_usuario = 8;
#Finalmente verificamos el vinculo entre la tabla contacto y usuarios
SELECT * FROM usuarios u JOIN contactos c on u.telefono  = c.id_contacto;








