<?php 



 require_once "../modelo/Autenticacion.php";
 require_once "../modelo/AutenticacionTokens.php";
// require_once "header.php";


$instLogin = new Autenticacion();
$instToken = new Auth();
$user= isset($_POST["user"])?limpiarCadena($_POST["user"]):"";
$pass = isset($_POST["pass"])?limpiarCadena($_POST["pass"]):"";


switch ($_GET["opcion"]){
    case 'login':
    

    $value = $instLogin->verifyPassword($user,$pass);
            
            if($value == null){
                 echo '0'; 
                /* echo '<script type="text/javascript">';
                echo 'document.write("Hello World!")';
                echo '</script>'; */
            }else{
                $rol = $value["rol"];
                if($rol == "Profesor"){
                    echo "1";
                    $token = $instToken->SignIn($value);
                    session_start();
                    $_SESSION["token"] = $token;
                }else{
                    echo "2";
                    $token = $instToken->SignIn($value);
                    session_start();
                    $_SESSION["token"] = $token;
                }
                
                // echo '<script language="javascript">window.location.href ="'.$url.'"</script>'; 
                // echo '<script type="text/javascript"> 
                //         document.getElementById("contenido").innerHTML="";
                //       </script>'; 
                // header("HTTP/1.1 301 Moved Permanently"); 
                // header("Location: http://localhost:8888/SEDRI/vistas/UIListaAlumno.php",TRUE,301); 
                // exit();
                // header('Location: http://localhost:8888/SEDRI/vistas/UIListaAlumno.php');
                //  echo "<script  type='text/javascript'>window.location='../vistas/UIMantenimientoBeca.php';</script>" ;
                // echo '<script type="text/javascript">alert("hello!");</script>'; 
            }
	break;

	case 'recuperar':
			$rspta=$instPuesto->actualizar($id,$nombre,$descripcion);
			
	break;
	
	}

?>