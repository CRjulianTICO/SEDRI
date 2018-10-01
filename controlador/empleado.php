<?php
require_once "../modelo/Empleado.php";

$instEmpleado =new Empleado();

$cedula= isset($_POST["cedula"])?limpiarCadena($_POST["cedula"]):"";
$nombre= isset($_POST["nombre"])?limpiarCadena($_POST["nombre"]):"";
$apellido1= isset($_POST["apellido1"])?limpiarCadena($_POST["apellido1"]):"";
$apellido2= isset($_POST["apellido2"])?limpiarCadena($_POST["apellido2"]):"";
$sexo= isset($_POST["sexo"])?limpiarCadena($_POST["sexo"]):"";
$telefono= isset($_POST["telefono"])?limpiarCadena($_POST["telefono"]):"";
$direccion= isset($_POST["direccion"])?limpiarCadena($_POST["direccion"]):"";
$idPuesto= isset($_POST["idPuesto"])?limpiarCadena($_POST["idPuesto"]):"";
$idNacionalidad= isset($_POST["idNacionalidad"])?limpiarCadena($_POST["idNacionalidad"]):"";

switch ($_GET["opcion"]){
	case 'guardar':
			$rspta=$instEmpleado->insertar($cedula,$nombre,$apellido1,$apellido2,$sexo,$direccion,$telefono,$idNacionalidad,$idPuesto);
			echo $rspta ? "Registrado" : "Error";
	break;

	case 'editar':
			$rspta=$instEmpleado->actualizar($cedula,$nombre,$apellido1,$apellido2,$sexo,$direccion,$telefono,$idNacionalidad,$idPuesto);
			echo $rspta ? "Registrado" : "Error" ;
	break;

	case 'listar':
		$rspta=$instEmpleado->listar();
 		$data= Array();
 		while ($reg=$rspta->fetch_object()){
 			$data[]=array(
 				"0"=>$reg->cedula,
 				"1"=>$reg->nombre,
        "2"=>$reg->apellido1,
				"3"=>$reg->apellido2,
				"4"=>$reg->sexo,
				"5"=>$reg->direccion,
				"6"=>$reg->telefono,
				"7"=>$reg->pais,
				"8"=>$reg->nombrePuesto,
				"9"=>($reg->disponible)?'<span class="label bg-green">Activado</span>':
 				'<span class="label bg-red">Desactivado</span>',
 				"10"=>($reg->disponible)?'<button class="mostrarEditar" onclick="mostrar('.$reg->cedula.')"><i class="material-icons center blue-text ">edit</i></button>'.
 					' <button class="mostrarBlock" onclick="desactivar('.$reg->cedula.')"><i class="material-icons center red-text ">block</i></button>':
 					'<button class="mostrarEditar" onclick="mostrar('.$reg->cedula.')"><i class="material-icons center blue-text ">edit</i></button>'.
 					' <button class="mostrarCheck" onclick="activar('.$reg->cedula.')"><i class="material-icons center green-text">check</i></button>',
 				);
 		}
 		$results = array(
 			"sEcho"=>1, //Información para el datatables
 			"iTotalRecords"=>count($data), //enviamos el total registros al datatable
 			"iTotalDisplayRecords"=>count($data), //enviamos el total registros a visualizar
 			"aaData"=>$data);
 		echo json_encode($results);
	break;

	case 'mostrar':
		$rspta=$instEmpleado->listarEspecifica($cedula);
 		//Se cofifica para que quede en json
 		echo json_encode($rspta);
		break;

	case 'activar':
		$rspta=$instEmpleado->activar($cedula);
	break;

	case 'desactivar':
		$rspta=$instEmpleado->desactivar($cedula);
	break;

	case "cargarPais":
	$rspta=$instEmpleado->cargarPais();
	$data= Array();
 		while ($reg=$rspta->fetch_object()){
 			$data[]=array(
 				'idNacionalidad' => $reg->idNacionalidad,
			    'pais' => $reg->pais
		);
	}
	echo json_encode($data);
	break;

	case "cargarPuesto":
	$rspta=$instEmpleado->cargarPuesto();
	$data= Array();
 		while ($reg=$rspta->fetch_object()){
 			$data[]=array(

 				'idPuesto' => $reg->idPuesto,
			    'nombrePuesto' => $reg->nombrePuesto

		);
	}
	echo json_encode($data);
	break;

	}


?>
