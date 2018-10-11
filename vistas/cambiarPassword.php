<?php
$user=isset($_GET['cedula'])?($_GET['cedula']):0;
?>
<!DOCTYPE html>
<html>
<head>
	<title></title>
	<meta charset="utf-8">
  
<link href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.0/css/materialize.min.css" rel="stylesheet" />
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="../public/datatables/jquery.dataTables.min.css">
<link href="../public/datatables/responsive.dataTables.min.css" rel="stylesheet"/>
<link href="../public/css/menuProfesor.css?ki" rel="stylesheet"/>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.28.4/dist/sweetalert2.all.min.js"></script>
<link href="../public/css/estilos.css?hi" rel="stylesheet"/>


</head>
</head>
<body>

<div class="section"></div>
  <main>
    <center>
      

      
      <div class="section"></div>

      <div class="container">
        <div class="z-depth-1 white lighten-4 row" style="display: inline-block; padding: 32px 48px 0px 48px; border: 1px solid #EEE;">

          <form class="col s12" id="formCambio" method="post">
            <div class='row'>
              <div class='col s12'>
              	<h6 class="blue-text">Cambio de contraseña</h6>
              </div>
            </div>

            <div class='row'>
              <div class='input-field col s12'>
                	
              <i class="material-icons prefix">lock</i>
                <input class='validate' type='password' name='pass' id='pass' required maxlength="20"  />
                <label for='pass'>Por favor ingrese su nueva contraseña</label>
              </div>
             
              <label style='float: left;'>
								<a class='blue-text' href='inicio.html'><b>
              <i class="material-icons prefix bot">arrow_back</i> Volver a inicio</b></a>
							</label>
            </div>

            

            <br />
            <center>
              <div class='row'>

                <button type='submit' name='btn_recupera' class='col s12 btn btn-large waves-effect blue'>Guardar</button>
              </div>
              <div id="aviso" style="display:none">
                <img src="../public/images/loading.gif" alt="Por favor espere">
                <h6 class="center-align">Procesando datos</h6>
              </div>
            </center>
          </form>
        </div>
      </div>
    </center>

    <div class="section"></div>
    <div class="section"></div>
  </main>

<script src="../public/js/jquery-3.1.1.min.js"></script>
<script src="../public/datatables/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="../public/datatables/responsiveDatables.js"></script>
<script src="../public/js/materialize.min.js"></script>
 

   <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0-beta/js/materialize.min.js"></script>

   <script> var user = <?php echo $user ?></script>
   <script src="js/login.js?new"></script>

</body>
</html>