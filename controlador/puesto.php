<?php 
require_once "../modelo/Puesto.php";

$instPuesto =new Puesto();

$id= isset($_POST["idPuesto"])?limpiarCadena($_POST["idPuesto"]):"";
$nombre = isset($_POST["nombrePuesto"])?limpiarCadena($_POST["nombrePuesto"]):"";
$descripcion = isset($_POST["descripcionPuesto"])?limpiarCadena($_POST["descripcionPuesto"]):"";


switch ($_GET["opcion"]){
	case 'guardar':
			$rspta=$instPuesto->insertar($nombre,$descripcion);
			echo $rspta ? "Registrado" : "Error".$nombre.$descripcion;
	break;

	case 'editar':
			$rspta=$instPuesto->actualizar($id,$nombre,$descripcion);
			echo $rspta ? "Registrado" : "Error";
	break;

	case 'listar':
		$rspta=$instPuesto->listar();
 		$data= Array();
 		while ($reg=$rspta->fetch_object()){
 			$data[]=array(
 				
 				"0"=>$reg->idPuesto,
 				"1"=>$reg->nombrePuesto,
                "2"=>$reg->descrpcionPuesto,
 				"3"=>'<button class="bg-blue" onclick="mostrar('.$reg->idPuesto.')"><i class="material-icons center white-text ">edit</i></button>'
 				
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
		
		$rspta=$instPuesto->listarEspecifica($id);
	
 		//Se cofifica para que quede en json
 		echo json_encode($rspta);
		break;

	
	}


?>