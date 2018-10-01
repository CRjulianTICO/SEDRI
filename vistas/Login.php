<?php 
  session_start();
  if(isset($_SESSION["token"])){

    header("Location: http://localhost:8888/SEDRI/controlador/autenticacionTokens.php");
    exit();
  }
?>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
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
<div id="contenido">
  <div class="section"></div>
  <main>
    <center>
      

      
      <div class="section"></div>

      <div class="container">
        <div class="z-depth-1 grey lighten-4 row" style="display: inline-block; padding: 32px 48px 0px 48px; border: 1px solid #EEE;">

          <form class="col s12" method="POST" id="formLogin">
            <div class='row'>
              <div class='col s12'>
              	<h5 class="blue-text">Inicia sesión </h5>
              </div>
            </div>

            <div class='row'>
              <div class='input-field col s12'>
                	
             <i class="material-icons prefix ">account_circle</i>
                <input class='validate' type='text' name='user' id='user' min="100000" max="9999999" required />
                <label for='cedula'>Ingresa la Cédula</label>
              </div>
            </div>

            <div class='row'>
              <div class='input-field col s12'>
              	<i class="material-icons prefix">lock</i>
                <input class='validate' type='password' name='pass' id='pass' pattern=".{6,}" title="Debe tener 6-10 caracteres" required />
                <label for='password'>Digita la contraseña</label>
              </div>

              <label style='float: right;'>
								<a class='blue-text' href='recupera.html'><b>Olvido su contraseña </b> <i class="material-icons prefix bot">help_outline</i></a>
							</label>
            </div>

            <br/>
            <center>
              <div class='row'>
                <button name='btn_login' id="btn_login" class='col s12 btn btn-large waves-effect blue' >Iniciar Sesión <i class="material-icons prefix   center ">input</i></button>
              </div>
              <div class="card-panel red white-text" data-error="credeciales malas"id="resp"></div>
            </center>
          </form>
        </div>
      </div>
    </center>

    
    <div class="section"></div>
  </main>
</div>
  
<script src="../public/js/jquery-3.1.1.min.js"></script>
<script src="../public/datatables/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="../public/datatables/responsiveDatables.js"></script>
<script src="../public/js/materialize.min.js"></script>
 

   <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0-beta/js/materialize.min.js"></script>
  
   <script src="js/login.js?new"></script>

</body>

</html>