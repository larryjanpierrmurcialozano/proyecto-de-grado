IDEA PRINCIPAL 
creacion de sistema que permita enviar mensajes automaticamente a correos electronicos registrados a la base de datos.
como va a estar relacionada? la conexion dentro de la base de datos con los correos sera relacional con el usuario, sus notas y la planilla automatica de notas definitivas que se formara segun la informacion que se encuentre en la base de datos sobre notas y calificaciones por cada estudiante id, y se relacionara con el correo electronico del estudiante.
se preparo, el espacio para la adicion del correo para padres, dentro de la tabla de estudiantes.

en cuanto a la planilla automatica de notas definitivas, se creara una tabla en la base de datos que contendra la informacion necesaria para generar la planilla. Esta tabla se actualizara automaticamente cada vez que se modifique la informacion de notas o calificaciones en la base de datos. cosas a considerar es saber que informacion se va a necesitar para generar la planilla, como por ejemplo el nombre del usuario, la nota final, la calificacion final, etc. tambien tenemos que recalcar las tablas ya existentes sobre las planillas, considerar si se puede usar la misma tabla para generar las planillas de notas definitivas o si es mas factible crear una nueva tabla que contenga los datos y sus relaciones, se crearia una nueva relacion de uno a varios con los correos, donde los correos estarian relacionados a los usuarios y a la planilla que se realice, la construccion de la nueva tabla sera de forma manual, actualizando tambien la version de la base de datos, para guardar correlacion de los ajustes realizados y tener la previsualizacion de los cambios hechos.

Se incorpora al sistema un módulo para el envío automático de correos electrónicos a los padres o acudientes, utilizando los datos almacenados en la base de datos. Esta actualización permite generar y adjuntar archivos académicos (por ejemplo, en formato Excel) para su envío desde la plataforma.

Se establece como requisito el registro del correo del acudiente y se deja preparada la estructura para la futura integración de una tabla de notas definitivas por periodo. El módulo fue diseñado de forma escalable para facilitar la incorporación del sistema completo de calificaciones en próximas versiones.


![alt text](image.png) imagen del diseño hecho en paint 3d :v full real no ia
