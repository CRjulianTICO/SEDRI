<?php 
  session_start();
  if(isset($_SESSION["token"])){
    
    require_once "../modelo/AutenticacionTokens.php";

    $token = $_SESSION["token"];

    $instAuth = new Auth();

    $dataToken = [];

    $dataTokenEncrip = $instAuth->GetData($token);

    foreach ($dataTokenEncrip as $key => $value) {
        $dataToken += ["".$key."" => $value];
    }

    $rol = $dataToken["rol"];
    
	if ($rol == 'Profesor'){

		$idgrado = $dataToken["idgrado"];
	}else{

		$idgrado = 0;
	}
   


  }else{
    header("Location: http://localhost:8888/SEDRI/vistas/Login.php");
  }

require_once "../modelo/Alumno.php";

$alumno=new Alumno();


//$idalumno=isset($_POST["idalumno"])? limpiarCadena($_POST["idalumno"]):"";
	$cedula=isset($_POST['cedula'])? limpiarCadena($_POST['cedula']):"";
	$nombre=isset($_POST["nombre"])? limpiarCadena($_POST["nombre"]):"";
	$apellido1=isset($_POST["apellido1"])? limpiarCadena($_POST["apellido1"]):"";
	$apellido2=isset($_POST["apellido2"])? limpiarCadena($_POST["apellido2"]):"";
	$grado=isset($_POST["grado"])? limpiarCadena($_POST["grado"]):"";




switch ($_GET["opcion"]){
	case 'guardar':

			$rspta=$alumno->insertar($cedula, $nombre, $apellido1, $apellido2, $sexo, $direccion, $nacionalidad,$nota,$idgrado);
			echo $rspta ? "Registrado" : "Error".$cedula. $nombre. $apellido1. $apellido2. $sexo. $direccion. $nacionalidad.$nota.$idgrado;
	break;

	case 'editar':
			$rspta=$alumno->actualizar($cedula, $nombre, $apellido1, $apellido2, $sexo, $direccion, $nacionalidad,$nota);
			echo $rspta ? "Registrado" : "Error";
	break;

	case 'listar':
	
		$rspta=$alumno->listar($idgrado);
 		$data= Array();
 		while ($reg=$rspta->fetch_object()){
 			$data[]=array(
 				
 		"0"=>$reg->cedula,
 		"1"=>$reg->nombre,
        "2"=>$reg->apellido1,
        "3"=>$reg->apellido2,
		"4"=>$reg->nombreGrado);
        }
         
 		$results = array(
 			"sEcho"=>1, //Información para el datatables
 			"iTotalRecords"=>count($data), //enviamos el total registros al datatable
 			"iTotalDisplayRecords"=>count($data), //enviamos el total registros a visualizar
 			"aaData"=>$data);
 		echo json_encode($results);
	break;

	case 'mostrar':
		$rspta=$alumno->cargar($cedula);
 		//Se cofifica para que quede en json
 		echo json_encode($rspta);
		break;

	case 'cargarPais':

	$rspta=$alumno->cargarPais();
 		$data= Array();
 		while ($reg=$rspta->fetch_object()){
 			$data[]=array(
 		
 				'idNacionalidad' => $reg->idNacionalidad,
			    'pais' => $reg->pais
		
		);
	}
	echo json_encode($data);
	break;


}
?>

