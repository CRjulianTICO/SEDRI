<?php 



 require_once "../modelo/Autenticacion.php";
 require_once "../modelo/AutenticacionTokens.php";
 require_once "mail.php";

// require_once "header.php";


$instLogin = new Autenticacion();
$instToken = new Auth();

$mail = new Mailer();

$user= isset($_POST["user"])?limpiarCadena($_POST["user"]):"";
$pass = isset($_POST["pass"])?limpiarCadena($_POST["pass"]):"";
$cedula = isset($_POST["cedula"])?limpiarCadena($_POST["cedula"]):"";


switch ($_GET["opcion"]){
    case 'login':

    $value = $instLogin->verifyPassword($user,$pass);

            if($value == null){
                 echo '0'; 
            }else{


                $rol = $value["rol"];
                $cambio = $value["cambio"];
                $email = $value["email"];

                if($rol == "Profesor"){
                    switch ($cambio) {
                        case '1':
                            echo "3";
                            break;
                        case '0':
                            echo "1";
                            $token = $instToken->SignIn($value);
                            session_start();
                            $_SESSION["token"] = $token;
                            break;
                    }       
                }else{
                    switch ($cambio) {
                        case '1':
                            echo "3";
                            break;
                        case '0':
                            echo "2";
                            $token = $instToken->SignIn($value);
                            session_start();
                            $_SESSION["token"] = $token;
                            break;
                    }   

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
   $rspta=$instLogin->recuperar($cedula); 

                if($rspta==null){
                    echo '0';

                }else{
                    ob_start();
                    $email = $rspta["email"];
                    $passActual = $rspta["password"];
                    $id = $rspta["idUsuario"];
                    $instLogin->historico($id,$email,$passActual);
                    $pass = $mail->generarPassword();
                    $hpass=$instLogin->hashPassword($pass);
                    $instLogin->actualizar($rspta["idUsuario"],$hpass,1);
                    
                    $mail->enviarCorreo(1,$email,$pass);
                    ob_end_clean();                 
                    echo '1';

                }
    break;
    
    case 'cambiar':   
   $rspta=$instLogin->recuperar($cedula);
   $var = '0';
   $varP = false; 
                if($rspta==null){
                    $var = '0';
                }else{
                    $hpass=$instLogin->hashPassword($pass);
                    $id=$rspta["idUsuario"];
                    $historico = $instLogin->mostrarHistorico($id);

                    while ($reg=$historico->fetch_object()) {
                        $varP = $instLogin->verificar($pass,$reg->pass);
                        if($varP == '1'){
                            $var = '2';
                           break;
                        }
                        
                    }
                     if($varP == '0'){
                        $instLogin->actualizar($rspta["idUsuario"],$hpass,0);  
                        $var = '1';
                     }       

                }
                echo $var;
    break;

	

    }
    


?>