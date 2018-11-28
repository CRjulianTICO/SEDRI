<?php 
  session_start();
  if(isset($_SESSION["token"])){

    header("Location: http://sedricr.com/controlador/autenticacionTokens.php");
    exit();
  }
?>
<!DOCTYPE html>
<html>
<head>
<title>SEDRI</title>
  <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

    <!-- DATATABLES -->

<link href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.0/css/materialize.min.css" rel="stylesheet" />
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="../public/datatables/jquery.dataTables.min.css">
<link href="../public/datatables/responsive.dataTables.min.css" rel="stylesheet"/>
<link href="../public/css/estilos.css?hi" rel="stylesheet"/>
<link href="../public/css/menuProfesor.css?ki" rel="stylesheet"/>
<link href="../public/css/login.css?hi" rel="stylesheet"/>
<link rel="icon" 
        type="image/png" 
        href="../public/images/favicon.ico">


</head>

<body>
<div id="contenido">
  <div class="section"></div>
  <main>
    <center>
      

      
      <div class="section"></div>

      <div class="container">
        <div class="white  row caja" style="display: inline-block; padding: 32px 48px 0px 48px; border: 1px solid #EEE;">

          <form class="col s12" method="POST" id="formLogin">
            <div class='row'>
              <div class='col s12'>
              	<h5 class="title">Bienvenido a SEDRI</h5>
              </div>
            </div>
            <img src="../public/images/gorro.png" class="img-inicio" alt="Imagen">
            <br>
            <div class='col s12'>
              	
              </div>
              <br>
            <div class='row'>
              <div class='input-field col s12'>
                	
             <i class="material-icons prefix ">account_circle</i>
                <input class='validate' type='text' name='user' id='user' min="100000" max="9999999" placeholder="" required />
                <label for='cedula'>Ingresar la Cédula</label>
              </div>
            </div>

            <div class='row'>
              <div class='input-field col s12'>
              	<i class="material-icons prefix">lock</i>
                <input class='validate' type='password' name='pass' id='pass' pattern=".{6,}" title="Debe tener 6-10 caracteres" required pattern="^[^0][0-9]{9,10}"/>
                <label for='password'>Digitar la contraseña</label>
              </div>

             
              <a class='blue-text subtitle' href='vistas/RecuperaPassword.php'><b>Olvidó su contraseña</b> <i class="material-icons">help</i></a>
							
            
							
            </div>

            <br/>
            <center>
              <div class='row'>
                <button name='btn_login' id="btn_login" class='col s12 btn btn-large waves-effect bg-green' >Iniciar Sesión</button>
              </div>

              <div class="card-panel red darken-2 white-text lighten-2" data-error="credenciales malas"id="resp"></div>

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
  
   <script src="vistas/js/login.js"></script>

</body>

</html>