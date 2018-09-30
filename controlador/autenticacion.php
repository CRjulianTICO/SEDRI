<?php 
ob_start();



 require_once "../modelo/Autenticacion.php";
// require_once "header.php";


$inst = new Autenticacion();
$user= isset($_POST["user"])?limpiarCadena($_POST["user"]):"";
$pass = isset($_POST["pass"])?limpiarCadena($_POST["pass"]):"";


switch ($_GET["opcion"]){
    case 'login':
    

    $value = $inst->verifyPassword($user,$pass);
 
            if($value == null){
                // echo 'mamaste wey'; 
            }else{
                //header('Location: ../vistas/UIMantenimientoBeca.php');
                echo "<script  type='text/javascript'>window.location='../vistas/UIMantenimientoBeca.php';</script>" ;
                echo '<script type="text/javascript">alert("hello!");</script>';
            }
	break;

	case 'recuperar':
			$rspta=$instPuesto->actualizar($id,$nombre,$descripcion);
			
	break;
	
	}
ob_end_flush();

?>