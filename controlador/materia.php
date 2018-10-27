<?php
require_once "../modelo/Materia.php";

$instaMateria = new Materia();

$id= isset($_POST["idmateria"])?limpiarCadena($_POST["idmateria"]):"";
$nombre = isset($_POST["nombreMateria"])?limpiarCadena($_POST["nombreMateria"]):"";
$tipoMateria = isset($_POST["tipoMateria"])?limpiarCadena($_POST["tipoMateria"]):"";


switch ($_GET["opcion"]){
	case 'guardar':
			$rspta=$instaMateria->insertar($nombre,$tipoMateria);
			echo $rspta ? "Registrado" : "Error";
	break;

	case 'editar':
			$rspta=$instaMateria->actualizar($id,$nombre);
			echo $rspta ? "Registrado" : "Error".$id."/".$nombre;
	break;

	case 'listar':
		$rspta=$instaMateria->listar();
 		$data= Array();
 		while ($reg=$rspta->fetch_object()){
 			$data[]=array(

 				"0"=>$reg->idmateria,
				 "1"=>$reg->nombre,
				 "2"=>$reg->tipo,
 				"3"=>($reg->estado)?'<span class="label bg-green">Activado</span>':
 				'<span class="label bg-red">Desactivado</span>',
 				"4"=>($reg->estado)?'<button class="mostrarEditar" onclick="mostrar('.$reg->idmateria.')"><i class="material-icons center blue-text ">edit</i></button>'.
 					' <button class="mostrarBlock" onclick="desactivar('.$reg->idmateria.')"><i class="material-icons center red-text ">block</i></button>':
 					'<button class="mostrarEditar" onclick="mostrar('.$reg->idmateria.')"><i class="material-icons center blue-text ">edit</i></button>'.
 					' <button class="mostrarCheck" onclick="activar('.$reg->idmateria.')"><i class="material-icons center green-text">check</i></button>',
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
		 $rspta = $instaMateria->desactivar($id);
		 echo "string".$cedula;
		 echo $rspta ? "Materia activada" : "Materia no se puede activar";
		break;

	case 'activar':
		 $rspta = $$instaMateria->activar($id);
		 echo $rspta ? "Materia activada" : "Materia no se puede activar";
		break;

	case 'mostrar':
		$rspta=$instaMateria->consultaEspecifica($id);
 		echo json_encode($rspta);
		break;

	case 'tipoMaterias':

	$rspta=$instaMateria->tiposMaterias();
 		$data= Array();
 		while ($reg=$rspta->fetch_object()){
 			$data[]=array(

 				'idTipo' => $reg->idTipo,
			    'tipo' => $reg->tipo

		);

	}
	echo json_encode($data);
	break;

	case 'listarMaterias':

	$rspta=$instaMateria->listarMaterias();
		$data= Array();
		while ($reg=$rspta->fetch_object()){
			$data[]=array(

				'idmateria' => $reg->idmateria,
					'nombre' => $reg->nombre

		);

	}
	echo json_encode($data);
	break;


}


?>
