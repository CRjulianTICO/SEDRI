# SEDRI
SEDRI es un sistema academico para profesores, directores y cuerpo administrativo.


# DESCRIPCION DEL PROYECTO:

SEDRI por sus siglas Sistema Educativo De Rendimiento Institucional es un sistema web, 
así las personas que necesiten utilizar el sistema ingresen desde su computadora con solo tener acceso a internet, 
este sistema va a tratar de cubrir todas las necesidades que ocupa una institución educativa 
ya que en el caso de la institución que nos corresponde mantienen el poco control que tienen a papel como se hacía años atrás. 
SEDRI va enfocado a la administración del centro educativo es decir tanto a profesores como el director 
ya que todos los que estudian ahí son niños con edades entre 6 y 12 años 
lo cual no es muy factible crear un sistema especializado hacia ellos 
ya que no van a sacarle tanto provecho como el área de administración.

#Pre-requisitos 
Instalar algun servidor local , recomendamos utilizar APACHE con XAMPP 
Descargar XAMPP de https://www.apachefriends.org/es/download.html
Tener instalado un servidor de Base de datos MYSQL (XAMPP lo incluye).
 

#Instalación 
* Utilizando XAMPP 
Descargar el proyecto SEDRI 
Copiar la carpeta descargada a htdocs por defecto en C:\xampp\htdocs
Abrir XAMPP y activar los servicios de Apache y Mysql 
Desde cualquier navegador acceder a PHPmyadmin 
	Por defecto http://localhost/phpmyadmin/ 
      5. Desde el menú superior seleccionar la opción de importar 
      6. Presionar  Seleccionar archivo y buscar dentro de la carpeta del Proyecto SedriBD.sql 
      7. Presionar continuar y esperar a que termine el proceso 
      8. Desde cualquier editor de texto abrir el proyecto (https://atom.io/)
y seleccionar la carpeta config ->     global.php Dentro del archivo modificar los datos según el servidor y la base importada. 

*Por defecto el valor de usuario es root y contraseña vacía. 
*Para acceder al proyecto acceder a http://localhost/carpetaSedri/vistas
Estas carpetas pueden variar según la instalación de cada usuario.

Hecho con : 
Materialize - A modern responsive front-end framework based on Material Design
Jquery- jQuery is a fast, small, and feature-rich JavaScript library.
Datatables- DataTables is a plug-in for the jQuery Javascript library. It is a highly flexible tool, build upon the foundations of progressive enhancement, that adds all of these advanced features to any HTML table.

Para el Despliegue:
Se necesitaria un servicio de hosting y un dominio o, bien si cuenta con su propio servidor nada mas ocuparia un dominio.


#Autores:

Olman Campos
Kendall Gomez
Yalmer Monge
Julian Perez
Oscar Soto
