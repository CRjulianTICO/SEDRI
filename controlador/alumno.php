<?php 
//   session_start();
//   if(isset($_SESSION["token"])){
    
//     require_once "../modelo/AutenticacionTokens.php";

//     $token = $_SESSION["token"];
//     $instAuth = new Auth();
//     $instAuth->Check($token);
//     $dataToken = [];
//     $dataTokenEncrip = $instAuth->GetData($token);
//     foreach ($dataTokenEncrip as $key => $value) {
//         $dataToken += ["".$key."" => $value];
// }
// 	$rol = $dataToken["rol"];
// 	if ($rol == 'Profesor'){
// 		$idgrado = $dataToken["idgrado"];
// 	}else{
// 		$idgrado = 0;
// 	}
   


//   }else
//   {
//     header("Location: http://localhost:8888/SEDRI/vistas/Login.php");
//   }

require_once "../modelo/Alumno.php";

$alumno=new Alumno();


//$idalumno=isset($_POST["idalumno"])? limpiarCadena($_POST["idalumno"]):"";
	$cedula=isset($_POST['cedula'])? limpiarCadena($_POST['cedula']):"";
	$nombre=isset($_POST["nombre"])? limpiarCadena($_POST["nombre"]):"";
	$apellido1=isset($_POST["apellido1"])? limpiarCadena($_POST["apellido1"]):"";
	$apellido2=isset($_POST["apellido2"])? limpiarCadena($_POST["apellido2"]):"";
	$sexo=isset($_POST["sexo"])? limpiarCadena($_POST["sexo"]):"";
	$direccion=isset($_POST["direccion"])? limpiarCadena($_POST["direccion"]):"";
	$nacionalidad=isset($_POST["nacionalidad"])? limpiarCadena($_POST["nacionalidad"]):"";
	$nota=isset($_POST["nota"])? limpiarCadena($_POST["nota"]):"";
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
	
		$rspta=$alumno->listar(1);//AQUIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
 		$data= Array();
 		while ($reg=$rspta->fetch_object()){
 			$data[]=array(
 				
 		"0"=>$reg->cedula,
 		"1"=>$reg->nombre,
        "2"=>$reg->apellido1,
        "3"=>$reg->apellido2,
        "4"=>$reg->sexo,
		"5"=>$reg->pais,
		"6"=>$reg->nombreGrado,
		"7"=>$reg->annio,
		"8"=>$reg->direccion,
		"9"=>$reg->nota_medica,
 				"10"=>'<button class="btn  btn-small bg-yellow" onclick="mostrar('.$reg->cedula.')"><i class="material-icons center white-text ">edit</i></button>
					 <button class="btn btn-small bg-red" onclick="desactivar('.$reg->cedula.')"><i class="material-icons center white-text ">block</i></button>
					 '
					 
 				);
  				
 		}
 		$results = array(
 			"sEcho"=>1, //Información para el datatables
 			"iTotalRecords"=>count($data), //enviamos el total registros al datatable
 			"iTotalDisplayRecords"=>count($data), //enviamos el total registros a visualizar
 			"aaData"=>$data);
 		echo json_encode($results);
	break;

	case 'desactivar':
		 $respuesta = $alumno->desactivar($cedula);
		 echo "string".$cedula;
		 echo $rspta ? "Alumno activada" : "Alumno no se puede activar";
		break;

	case 'activar':
		 $respuesta = $alumno->activar($cedula);
		 echo $rspta ? "Alumno activada" : "Alumno no se puede activar";
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
