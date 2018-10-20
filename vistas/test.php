

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
<link href="../public/css/menuProfesor.css?ki" rel="stylesheet"/>
<link href="../public/css/estilos.css" rel="stylesheet"/>


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
      <li><a href="#" class="waves-effect"><?php echo $nombre; ?><i class="material-icons left blue-grey-text">account_circle</i>  </a></li>
     
      <li> <div class="divider"></div></li>
      <li class="no-padding">
        <ul class="collapsible collapsible-accordion">
          <li>
            <a class="collapsible-header waves-effect">Alumnos<i class="material-icons right blue-text">arrow_drop_down</i><i class="material-icons left blue-text">face</i></a>
            <div class="collapsible-body">
              <ul>
                <a href="../vistas/UIMantenimientoAlumno.php" class="waves-effect">Registro<i class="material-icons left pink-text registroIcono">folder_shared</i></a>
                
                <li>
                <a onclick="" class="waves-effect">Agregar<i class="material-icons left green-text agregarIcono">add_circle</i></a>
                </li>
                 
              </ul>
            </div>
          </li>

           <li>
            <a class="collapsible-header waves-effect">Asistencia<i class="material-icons right blue-text">arrow_drop_down</i><i class="material-icons left blue-text">group</i></a>
            <div class="collapsible-body">
              <ul>
                <a href="#" class="waves-effect">Registro<i class="material-icons left pink-text registroIcono">content_paste</i></a>
                
              </ul>
            </div>
          </li>

          <li>
            <a class="collapsible-header waves-effect">Encargado<i class="material-icons right blue-text">arrow_drop_down</i><i class="material-icons left blue-text">assignment_ind</i></a>
            <div class="collapsible-body">
              <ul>
                <a href="#" class="waves-effect">Registro<i class="material-icons left pink-text registroIcono">folder_shared</i></a>
                <li>
                <a onclick=""  class="waves-effect">Agregar<i class="material-icons left green-text agregarIcono">add_circle</i></a>
                </li>
              </ul>
            </div>
          </li>

           <li>
            <a class="collapsible-header waves-effect">Notas<i class="material-icons right blue-text">arrow_drop_down</i><i class="material-icons left blue-text">description</i></a>
            <div class="collapsible-body">
              <ul>

                 <a href="#" class="waves-effect">Registro<i class="material-icons left pink-text registroIcono">grid_on</i></a>
                <li>
                <a onclick="" class="waves-effect">Agregar<i class="material-icons left green-text agregarIcono">add_circle</i></a>
		            </li>

              </ul>
            </div>
          </li>
      </li>


             <li>
            <a class="collapsible-header waves-effect">**Materias**<i class="material-icons right blue-text">arrow_drop_down</i><i class="material-icons left blue-text">import_contacts</i></a>
            <div class="collapsible-body">
              <ul>
                <a href="#" class="waves-effect">Registro<i class="material-icons left pink-text registroIcono">folder_shared</i></a>
                <li>
                <a onclick="" class="waves-effect">Agregar<i class="material-icons left green-text agregarIcono">add_circle</i></a>
                </li>
              </ul>
            </div>
          </li>


      <li>
         <a class="collapsible-header waves-effect">**Puestos**<i class="material-icons right blue-text">arrow_drop_down</i><i class="material-icons left blue-text">business_center</i></a>
            <div class="collapsible-body">
              <ul>
                <a href="#"  class="waves-effect">Registro<i class="material-icons left pink-text registroIcono">folder_shared</i></a>
                <li>
                <a onclick="" class="waves-effect">Agregar<i class="material-icons left green-text agregarIcono">add_circle</i></a>
                </li>
              </ul>
            </div>
         </li>



         <li>
            <a class="collapsible-header waves-effect" >**Grados**<i class="material-icons right blue-text">arrow_drop_down</i><i class="material-icons left blue-text">filter_1</i></a>
            <div class="collapsible-body">
              <ul>
                <a href="#" class="waves-effect">Registro<i class="material-icons left pink-text registroIcono">folder_shared</i></a>
                <li>
                <a  onclick="" class="waves-effect formulario">Agregar<i class="material-icons left green-text agregarIcono">add_circle</i></a>
                </li>
              </ul>
            </div>
          </li>





        </ul>

    </ul>
    <!--menu frontal-->
      <ul id="nav-mobile" class="right ">

        <li><a href="../controlador/Logout.php">Cerrar Sesion<i class="material-icons left">exit_to_app</i></a></li>
      </ul>
<!--fin del menu frontal-->
  </div>
<!--FIN DEL MENU LATERAL-->



</div>
<!--AQUI TERMINA EL CONTAINER -->

			<a href="#" data-activates="slide-out" class="button-collapse hide-on-large-only"><i class="material-icons">menu</i></a>

</div>
</nav>

<div id="content">
 <a class="waves-effect waves-light btn modal-trigger" href="#modal1">Modal</a>

<!-- Modal Structure -->
<div id="modal1" class="modal">
  <div class="modal-content">
    <h6>Agregar un encargado del alumno</h6>
    <hr>
    <br>
    <form method="POST" id="formProfesor" name="formProfesor">

<div class='row'>
<div class='input-field col s6'>
  <input placeholder="Cédula" class='validate' type='text' name='cedula' id='cedula' min="1000000" max="9999999" required />
          <label for='cedula'>Ingresa la Cédula</label>
        </div>


        <div class='row'><div class='input-field col s6'>
  <input placeholder="Nombre" class='validate' type='text' name='nombre' id='nombre' maxlength="30" required />
          <label for='nombre'>Ingresa el Nombre</label>
        </div>
        </div>

        <div class='row'>
        <div class='input-field col s6'>
  <input placeholder="Primer Apellido" class='validate' type='text' name='apellido1' id='apellido1' maxlength="30" required />
          <label for='apellido1'>Ingresar el Primer Apellido</label>
        </div>

 <div class='row'><div class='input-field col s6'>
  <input placeholder="Segundo Apellido" class='validate' type='text' name='apellido2' id='apellido2' maxlength="30" required />
          <label for='apellido2'>Ingresar Segundo Apellido</label>
        </div>
        </div>

         <div class='row'>
        <div class='input-field col s6'>
  <input placeholder="Numero de Telefono" class='validate' type='text' name='telefono' id='telefono' maxlength="30" required />
          <label for='telefono'>Ingresar Numero de Telefono</label>
        </div>

 <div class='row'><div class='input-field col s6'>
  <input placeholder="Numero de telefono secundario" class='validate' type='text' name='tel_secundario' id='tel_secundario' maxlength="30" required />
          <label for='tel_secundario'>Secundario</label>
        </div>
        </div>
<div class="row">
  <div class="col s6">
    <select  name="sexo" id="sexo" class="browser-default " required>
    <option value="" disabled selected hidden>Seleccionar el Género</option>
    <option value="Masculino">Masculino</option>
    <option value="Femenino">Femenino</option>
    </select>
  </div>
  <div class="col s6">
    <select  name="nacionalidad" id="nacionalidad"   class="browser-default "  required>
    </select>
  </div>

</div>
<br>
<div class="row">

    <div class="input-field col s12">
      <textarea placeholder="" id="direccion" class="materialize-textarea validate" name="direccion" data-length="100" required></textarea>
      <label for="direccion">Ingresa la Dirección</label>
    </div>
  </div>
  <br>
</div>
<div class="row">
<div class="col s6">
<button class="btn waves-effect waves-light green full-with" type="submit" name="Guardar" id="btnguardar">Guardar
<i class="material-icons right">done</i><br></button>
</div>
<div class="col s6">
<button class="btn waves-effect waves-light red full-with" type="button" name="cancelar" id="btncancelar">Cancelar
<i class="material-icons right">cancel</i><br></button></div>
</div>
</div>
<br>
</form>
  </div>
 
</div>

</div>



















<script src="../public/js/jquery-3.1.1.min.js"></script>
<script src="../public/datatables/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="../public/datatables/responsiveDatables.js"></script>
<script src="../public/js/materialize.min.js"></script>


<!--EL SCRIPT PARA EL MENU RESPONSIVE-->
	<script type="text/javascript">
	$('.button-collapse').sideNav({
  menuWidth: 300, // Default is 300
  edge: 'left', // Choose the horizontal origin
  closeOnClick: false, // Closes side-nav on <a> clicks, useful for Angular/Meteor
  draggable: true // Choose whether you can drag to open on touch screens
});
document.addEventListener('DOMContentLoaded', function() {
    var elems = document.querySelectorAll('.modal');
    var instances = M.Modal.init(elems, options);
  });

  // Or with jQuery

  $(document).ready(function(){
    $('.modal').modal();
  });
          
</script>


<script type="text/javascript">
 $(document).ready(function() {
    $('#descripcionPuesto').characterCounter();
  });
</script>