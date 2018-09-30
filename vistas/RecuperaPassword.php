<!DOCTYPE html>
<html>
<head>
	<title></title>
	<meta charset="utf-8">
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
 <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0-beta/css/materialize.min.css">
 <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.1/jquery.min.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0-beta/js/materialize.min.js"></script>
   <link rel="stylesheet" type="text/css" href="../public/css/cuenta.css"> 
</head>
</head>
<body>

<div class="section"></div>
  <main>
    <center>
      

      
      <div class="section"></div>

      <div class="container">
        <div class="z-depth-1 grey lighten-4 row" style="display: inline-block; padding: 32px 48px 0px 48px; border: 1px solid #EEE;">

          <form class="col s12" method="post">
            <div class='row'>
              <div class='col s12'>
              	<h5 class="blue-text">Recuperar contraseña</h5>
              </div>
            </div>

            <div class='row'>
              <div class='input-field col s12'>
                	
<i class="material-icons prefix ">person</i>
                <input class='validate' type='text' name='cedula' id='cedula' required maxlength="20" minlength="8" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$" />
                <label for='cedula'>Digita tu numero de Cedula</label>
              </div>
             
              <label style='float: right;'>
								<a class='blue-text' href='inicio.html'><b>
              <i class="material-icons prefix bot">arrow_back</i>Volver a inicio</b></a>
							</label>
            </div>

            

            <br />
            <center>
              <div class='row'>

                <button type='submit' name='btn_recupera' class='col s12 btn btn-large waves-effect blue'>Recuperar <i class="material-icons prefix   center ">vpn_key</i></button>
              </div>
            </center>
          </form>
        </div>
      </div>
    </center>

    <div class="section"></div>
    <div class="section"></div>
  </main>


</body>
</html>