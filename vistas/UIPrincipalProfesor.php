<!DOCTYPE html>
<html>
<head>
	<title></title>
	<!-- JQuery / Materialize CSS + JavaScript imports -->




<link href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.0/css/materialize.min.css" rel="stylesheet" />
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/material-design-lite/1.1.0/material.min.css">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/dataTables.material.min.css">

<style type="text/css">
	#container {
  padding-left: 300px;
}

#content {
  padding: 20px;
 margin-left: 10%;
}

@media only screen and (max-width : 992px) {
  #container {
    padding-left: 0px;
  }
  #content{
  	margin-left: 0;
  }
}
</style>


</head>




<body>

<!--PRINCIPIO DEL MENU-->
<nav>
<div class="nav-wrapper">

<!--ESTE CONTAINER TIENE LA PARTE DEL MENU LATERAL Y EL FRONTAL-->
<div id="container">


<!--EL MENU LATERAL ES TODO ESTO-->
  <div id="menu">

    <ul id="slide-out" class="side-nav fixed show-on-large-only">
      <li><a href="#">Nombre Profesor <i class="material-icons">account_circle</i>  </a></li>
      <li> <div class="divider"></div></li>
      <li class="no-padding">
        <ul class="collapsible collapsible-accordion">
          <li>
            <a class="collapsible-header">Estudiantes<i class="material-icons right">arrow_drop_down</i><i class="material-icons left">face</i></a>
            <div class="collapsible-body">
              <ul>
                <li><a onclick="mostrarform(false)">Registro de Alumnos<i class="material-icons">table_chart</i></a></li>
                <li><a onclick="mostrarform(true)">Agregar<i class="material-icons left">add_circle</i></a></li>

              </ul>
            </div>
          </li>
        </ul>
      </li>
      <li><a href="#!" class="waves-effect">Notas<i class="material-icons left">description</i></a></li>
      <li><a href="#!" class="waves-effect">Cuotas <i class="material-icons left">attach_money</i></a></li>
 
    </ul>
    <!--menu frontal-->
      <ul id="nav-mobile" class="right ">
        <li><a href="#">Perfil</a></li>
        <li><a href="#">Cerrar Sesion</a></li>
      </ul>
<!--fin del menu frontal-->
  </div>
<!--FIN DEL MENU LATERAL-->


    
</div>
<!--AQUI TERMINA EL CONTAINER -->

			<a href="#" data-activates="slide-out" class="button-collapse hide-on-large-only"><i class="material-icons">menu</i></a>

</div>

</nav>
<!--FINAL DEL MENU-->

<!--AQUI DEBERIA IR TODO EL CONTENIDO DE LA PAGINA-->
 <div id="content">    
    <div class="container">

      <div class="tabla" id="tabla">
         <table id="tbAlumno" class="mdl-data-table" style="width:100%">
          <thead>
            <th>Opciones</th>
            <th>Cedula</th>
            <th>Nombre</th>
            <th>Primer Apellido</th>
            <th>Segundo Apellido</th>
            <th>Sexo</th>
            <th>Direccion</th>
            <th>Nacionalidad</th>
            <th>Estado</th>
          </thead>
          <tbody>
          </tbody>
        </table>


      </div>

      <div id="formulario">
        <form method="POST" id="formAlumno" name="formAlumno">
      <input type="text" class="input-field" name="cedula" id="cedula"  placeholder="cedula" style="display:block;">
      <input type="text" name="nombre" id="nombre" placeholder="nombre" style="display:block;">
      <input type="text" name="apellido1" id="apellido1" placeholder="apellido" style="display:block;">
      <input type="text" name="apellido2" id="apellido2" placeholder="apellido2" style="display:block;">
      <select name="sexo" id="sexo" class="select">
      <option value="Masculino">Masculino</option>
      <option value="Femenino">Femenino</option>

    </select>
    <textarea name="direccion" id="direccion" rows="8" cols="80" placeholder="direccion" style="display:block;"></textarea>
    
    <select name="nacionalidad" id="nacionalidad">
    </select>
    <button type="submit" name="Guardar">Guardar</button>
  </form>


      </div>
     
    </div>
 </div>
<!-- FINALIZA EL CONTENIDO-->

<script src="../public/js/jquery-3.1.1.min.js"></script>
<script src="../public/datatables/jquery.dataTables.min.js"></script>
<script src="../public/datatables/jszip.min.js"></script>
<script src="../public/datatables/pdfmake.min.js"></script>
<script src="../public/datatables/vfs_fonts.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.0/js/materialize.min.js"></script>
<script src="https://cdn.datatables.net/1.10.19/js/dataTables.material.min.js"></script>
<script src="js/alumno.js?xd"></script>
<!--EL SCRIPT PARA EL MENU RESPONSIVE-->
	<script type="text/javascript">
	$('.button-collapse').sideNav({
  menuWidth: 300, // Default is 300
  edge: 'left', // Choose the horizontal origin
  closeOnClick: false, // Closes side-nav on <a> clicks, useful for Angular/Meteor
  draggable: true // Choose whether you can drag to open on touch screens
});

</script>

</body>
</html>




