<!DOCTYPE html>
<html>
<head>
	<title></title>
	<!-- JQuery / Materialize CSS + JavaScript imports -->

  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

    <!-- DATATABLES -->

<link href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.0/css/materialize.min.css" rel="stylesheet" />
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="../public/datatables/jquery.dataTables.min.css">
<link href="../public/datatables/responsive.dataTables.min.css" rel="stylesheet"/>
<link href="../public/css/estilos.css?hi" rel="stylesheet"/>
<link href="../public/css/menuProfesor.css?ki" rel="stylesheet"/>




</head>




<body>

<!--PRINCIPIO DEL MENU-->
<nav>
<div class="nav-wrapper blue">

<!--ESTE CONTAINER TIENE LA PARTE DEL MENU LATERAL Y EL FRONTAL-->
<div id="container">


<!--EL MENU LATERAL ES TODO ESTO-->
  <div id="menu">

    <ul id="slide-out" class="side-nav fixed show-on-large-only">
      <li><a href="#" class="waves-effect">Nombre Director <i class="material-icons left blue-grey-text">account_circle</i>  </a></li>
      <li> <div class="divider"></div></li>
      <li class="no-padding">
        <ul class="collapsible collapsible-accordion">
          <li>
            <a class="collapsible-header waves-effect">Alumnos<i class="material-icons right blue-text">arrow_drop_down</i><i class="material-icons left orange-text">face</i></a>
            <div class="collapsible-body">
              <ul>
                <a onclick="mostrarform(false)" class="waves-effect">Registro<i class="material-icons left pink-text registroIcono">folder_shared</i></a>
                <li>
                <a onclick="mostrarform(true)" class="waves-effect">Agregar<i class="material-icons left green-text agregarIcono">add_circle</i></a></li>
              </ul>
            </div>
          </li>

           <li>
            <a class="collapsible-header waves-effect">Docentes<i class="material-icons right blue-text">arrow_drop_down</i><i class="material-icons left orange-text">group</i></a>
            <div class="collapsible-body">
              <ul>
                <a onclick="mostrarform(false)" class="waves-effect">Registro<i class="material-icons left pink-text registroIcono">folder_shared</i></a>
                <li>
                <a onclick="mostrarform(true)" class="waves-effect">Agregar<i class="material-icons left green-text agregarIcono">add_circle</i></a>
                </li>
                <li>
                <a onclick="mostrarform(false)" class="waves-effect">Asignar Grupos<i class="material-icons left blue-text agregarIcono">assignment</i></a>
                </li>
              </ul>
            </div>
          </li>

           <li>
            <a class="collapsible-header waves-effect">Becas<i class="material-icons right blue-text">arrow_drop_down</i><i class="material-icons left orange-text">description</i></a>
            <div class="collapsible-body">
              <ul>
                <a onclick="mostrarform(false)" class="waves-effect">Registro<i class="material-icons left pink-text registroIcono">folder_special</i></a>
                <li>
                <a onclick="mostrarform(true)" class="waves-effect">Agregar<i class="material-icons left green-text agregarIcono">add_circle</i></a></li>
              </ul>
            </div>
          </li>
        </ul>
      </li>
      

    </ul>
    <!--menu frontal-->
      <ul id="nav-mobile" class="right ">

        <li><a href="#">Cerrar Sesion<i class="material-icons left">exit_to_app</i></a></li>
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
   <div class="tabla" id="tabla">
        <table id="tbAlumno" class="display responsive nowrap tabla" style="width: 100%">
        <thead>
          <th>Cedula</th>
          <th data-priority="1">Nombre</th>
          <th data-priority="2">Primer Apellido</th>
          <th>Segundo Apellido</th>
          <th>Sexo</th>
          <th>Direccion</th>
          <th>Nacionalidad</th>
          <th>Estado</th>
          <th>Opciones</th>
        </thead>
        <tbody>
        </tbody>
      </table>


      </div>
    <div class="container">


      <!--Inicia Formulario-->
      <div id="formulario">

        <form method="POST" id="formAlumno" name="formAlumno">

      <div class='row'>
      <div class='input-field col s6'>
        <input placeholder="" class='validate' type='text' name='cedula' id='cedula' min="1000000" max="9999999" required />
                <label for='cedula'>Ingresa la Cédula</label>
      </div>

        <div class='input-field col s6'>
        <input placeholder="Nombre" class='validate' type='text' name='nombre' id='nombre' maxlength="30" required />
                <label for='nombre'>Ingresa el Nombre</label>
      </div>
      </div>


      <div class='row'>
      <div class='input-field col s6'>
        <input  placeholder="Primer Apeliido" class='validate' type='text' name='apellido1' id='apellido1' maxlength="30" required />
                <label for='apellido1'>Ingresar Primer Apellido</label>
             </div>

       <div class='row'><div class='input-field col s6'>
        <input placeholder="Segundo Apellido" class='validate' type='text' name='apellido2' id='apellido2' maxlength="30" required />
                <label for='apellido2'>Ingresar Segundo Apellido</label>
              </div>
              </div>


      <select  name="sexo" id="sexo" class="browser-default " required>
      <option value="" disabled selected hidden>Seleccionar el Género</option>
      <option value="Masculino">Masculino</option>
      <option value="Femenino">Femenino</option>

    </select>
    <br>
    <div class="row">

          <div class="input-field col s12">
            <textarea placeholder="Direccion" id="direccion" class="materialize-textarea validate" name="direccion" data-length="100" required></textarea>
            <label for="direccion">Ingresa la Dirección</label>
          </div>
        </div>
        <br>
      <select  name="nacionalidad" id="nacionalidad" class="browser-default" required>
    </select>
    <br><br>
    <div class="row">
      <div class="col s4">
      <button class="btn waves-effect waves-light green guardaEst" type="submit" name="Guardar" id="btnguardar">Guardar
    <i class="material-icons right">done</i><br></button></div>


    </div>
    <!--Termina formulario-->



    </div>
    <br>


  </form>
	<div class="row" id="botones">
		<div class="col s6">
		<button name="editar"  onclick="editar();" class="btn waves-effect waves-light blue editaEst">Editar<i class="material-icons right">edit</i></button>
		</div>
		<div class="col s6">
		<button class="btn waves-effect waves-light red cancelEst"  name="eliminar" onclick="cancelarform();">Cancelar
		<i class="material-icons right">clear</i><br></button>
		</div>
	</div>


      </div>

    </div>
 </div>
<!-- FINALIZA EL CONTENIDO-->

<script src="../public/js/jquery-3.1.1.min.js"></script>
<script src="../public/datatables/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="../public/datatables/responsiveDatables.js"></script>
<script src="../public/js/materialize.min.js"></script>

<script src="js/alumno.js?mae"></script>
<!--EL SCRIPT PARA EL MENU RESPONSIVE-->
	<script type="text/javascript">
	$('.button-collapse').sideNav({
  menuWidth: 300, 
  edge: 'left', 
  closeOnClick: false, 
  draggable: true 
});


  $(document).ready(function() {
    M.updateTextFields();
  });
        

</script>




<script type="text/javascript">
 $(document).ready(function() {
    $('direccion#direccion').characterCounter();
  });


</script>

</body>
</html>