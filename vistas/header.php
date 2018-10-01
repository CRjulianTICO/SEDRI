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
      <li><a href="#" class="waves-effect">Nombre Profesor <i class="material-icons left blue-grey-text">account_circle</i>  </a></li>
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
<!--FINAL DEL MENU-->