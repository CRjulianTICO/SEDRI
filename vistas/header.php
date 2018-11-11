<?php
  session_start();
  if(isset($_SESSION["token"])){
    require_once "../modelo/AutenticacionTokens.php";
    $token = $_SESSION["token"];
    $instAuth = new Auth();
    $instAuth->Check($token);
    $dataToken = [];
    $dataTokenEncrip = $instAuth->GetData($token);
    foreach ($dataTokenEncrip as $key => $value) {
        $dataToken += ["".$key."" => $value];
    }
    $nombre = $dataToken["nombre"];
    $grupo = $dataToken["grupo"];
    $tipoProfe = $dataToken["tipoProfesor"];
  }else
  {
    header("Location: http://localhost:8888/SEDRI/vistas/Login.php");
  }
?>
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
  <link href="../public/datatables/responsive.dataTables.min.css" rel="stylesheet" />
  <link href="../public/css/menuProfesor.css?ki" rel="stylesheet" />
  <link href="../public/css/estilos.css" rel="stylesheet" />




</head>

<body>

  <!--PRINCIPIO DEL MENU-->
  <nav>
    <div class="nav-wrapper bg-blue">

      <!--ESTE CONTAINER TIENE LA PARTE DEL MENU LATERAL Y EL FRONTAL-->
      <div id="container">


        <!--EL MENU LATERAL ES TODO ESTO-->
        <div id="menu">

          <ul id="slide-out" class="side-nav fixed show-on-large-only">

            <li><a href="#" class="waves-effect">
                <?php echo $nombre; ?><i class="material-icons left black-text">account_circle</i> </a></li>

            <li>
              <div class="border-grey"></div>
            </li>

            <li class="no-padding">
              <ul class="collapsible collapsible-accordion">
                <li>
                  <a class="collapsible-header waves-effect">Alumnos<i class="material-icons right grey-text">arrow_drop_down</i><i class="material-icons left grey-text">face</i></a>
                  <div class="collapsible-body">
                    <ul>
                      <a href="../vistas/UIMantenimientoAlumno.php" class="waves-effect">Registro<i class="material-icons left red-text registroIcono">folder_shared</i></a>

                      <li>
                        <a onclick="redireccionarAlumno(); mostrarform(true);" class="waves-effect">Agregar<i class="material-icons left green-text agregarIcono">add_circle</i></a>
                      </li>

                    </ul>
                  </div>
                </li>



                <li>
                  <a class="collapsible-header waves-effect">Asistencias<i class="material-icons right blue-text">arrow_drop_down</i><i class="material-icons left blue-text">group</i></a>
                  <div class="collapsible-body">
                    <ul>
                      <a href="../vistas/UIAsistenciaAlumno.php" class="waves-effect">Asistencia<i class="material-icons left pink-text registroIcono">content_paste</i></a>
                      <li>
                        <a href="../vistas/UIRegistroAsistencia.php" class="waves-effect">Registro<i class="material-icons left green-text agregarIcono">add_circle</i></a>
                      </li>

                    </ul>
                  </div>
                </li>
                
                 <li id="divEncargado">
                  <a class="collapsible-header waves-effect">Encargado<i class="material-icons right grey-text">arrow_drop_down</i><i class="material-icons left grey-text">assignment_ind</i></a>
                  <div class="collapsible-body">
                    <ul>
                      <a href="UiMantenimientoEncargado.php" class="waves-effect">Registro<i class="material-icons left red-text registroIcono">folder_shared</i></a>
                      <li>
                        <a onclick="redireccionarEncargado();" class="waves-effect">Agregar<i class="material-icons left green-text agregarIcono">add_circle</i></a>
                      </li>
                    </ul>
                  </div>
                </li>
               
               

                <li>
                  <a  class="collapsible-header waves-effect">Notas<i class="material-icons right grey-text">arrow_drop_down</i><i class="material-icons left grey-text">description</i></a>
                  <div class="collapsible-body">
                    <ul>

                      <a href="../vistas/UIMantenimientoNotas.php" class="waves-effect">Registro<i class="material-icons left red-text registroIcono">grid_on</i></a>
                      <li>
                        <a onclick="" class="waves-effect">Agregar<i class="material-icons left green-text agregarIcono">add_circle</i></a>
                      </li>

                    </ul>
                  </div>
                </li>
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
