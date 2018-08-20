<?php
require_once "../modelo/Beca.php";

$instBeca = new Beca();

$cedula= isset($_POST["cedula"])?limpiarCadena($_POST["cedula"]):"";
$descripcion= isset($_POST["descripcionBeca"])?limpiarCadena($_POST["descripcionBeca"]):"";
$monto= isset($_POST["monto"])?limpiarCadena($_POST["monto"]):"";

switch ($_GET["opcion"]){
	case 'guardar':
			$rspta=$instBeca->insertar($descripcion,$monto,$cedula);
			echo $rspta ? "Registrado" : "Error".$cedula;
	break;

	case 'editar':
			$rspta=$instBeca->actualizar($descripcion,$monto,$cedula);
			echo $rspta ? "Registrado" : "Error".$cedula;
	break;

	case 'listar':
		$rspta=$instBeca->listar();
 		$data= Array();
 		while ($reg=$rspta->fetch_object()){
 			$data[]=array(
 				"0"=>$reg->cedula,
 				"1"=>$reg->nombre,
                "2"=>$reg->apellidos,
				"3"=>$reg->descripcion_beca,
				"4"=>$reg->monto_beca,
				"5"=>($reg->estado)?'<span class="label bg-green">Activado</span>':
 				'<span class="label bg-red">Desactivado</span>',
 				"6"=>($reg->estado)?'<button class="mostrarEditar" onclick="mostrar('.$reg->cedula.')"><i class="material-icons center blue-text ">edit</i></button>'.
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
		$rspta=$instBeca->listarEspecifica($cedula);
 		//Se cofifica para que quede en json
 		echo json_encode($rspta);
		break;

	case 'activar':
		$rspta=$instBeca->activar($cedula);
	break;

	case 'desactivar':
		$rspta=$instBeca->desactivar($cedula);
	break;

	}


?>