<?php
require_once "../modelo/Encargado.php";
require_once "../modelo/Pais.php";

$encargado=new Encargado();
$pais = new Pais();

//$idalumno=isset($_POST["idalumno"])? limpiarCadena($_POST["idalumno"]):"";
	$cedula=isset($_POST['cedula'])? limpiarCadena($_POST['cedula']):"";
	$nombre=isset($_POST["nombre"])? limpiarCadena($_POST["nombre"]):"";
	$apellido1=isset($_POST["apellido1"])? limpiarCadena($_POST["apellido1"]):"";
	$apellido2=isset($_POST["apellido2"])? limpiarCadena($_POST["apellido2"]):"";
	$sexo=isset($_POST["sexo"])? limpiarCadena($_POST["sexo"]):"";
	$direccion=isset($_POST["direccion"])? limpiarCadena($_POST["direccion"]):"";
	$telefono=isset($_POST["telefono"])? limpiarCadena($_POST["telefono"]):"";
	$telefono2=isset($_POST["telefono_secundario"])? limpiarCadena($_POST["telefono_secundario"]):"";
	$nacionalidad=isset($_POST["nacionalidad"])? limpiarCadena($_POST["nacionalidad"]):"";


switch ($_GET["opcion"]){
	case 'guardar':
			$rspta=$encargado->insertar($cedula, $nombre, $apellido1, $apellido2, $sexo, $direccion,$telefono,$telefono2,$nacionalidad,$ced_e,$parentezco);

			echo $rspta ? "Registrado": "Error";
	break;

	case 'editar':
			$rspta=$encargado->actualizar($cedula, $nombre, $apellido1, $apellido2, $sexo, $direccion,$telefono,$nacionalidad,$nacionalidad);
			echo $rspta ? "Registrado" : "Error";
	break;

	case 'listar':
		$rspta=$encargado->listar();
 		$data= Array();
 		while ($reg=$rspta->fetch_object()){
 			$data[]=array(

 				"0"=>$reg->cedula,
 				"1"=>$reg->nombre,
        		"2"=>$reg->apellido1,
				"3"=>$reg->apellido2,
        		"4"=>$reg->telefono,
        		"5"=>$reg->telefono_secundario,
				"6"=>$reg->direccion,
				"7"=>$reg->sexo,
				"8"=>$reg->pais,
				"9"=>$reg->cedula_e,
				"10"=>$reg->nombre_estudiante,
				"11"=>$reg->parentezco,
 				"12"=>'<button class="mostrarEditar" onclick="mostrar('.$reg->cedula.')"><i class="material-icons center blue-text ">edit</i></button>
					 <button class="mostrarBlock" onclick="desactivar('.$reg->cedula.')"><i class="material-icons center red-text ">block</i></button>',
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
		 $respuesta = $encargado->desactivar($cedula);
		 echo $rspta ? "Activo" : "no se puede activar";
		break;

	case 'activar':
		 $respuesta = $encargado->activar($cedula);
		 echo $rspta ? "activado" : "no se puede activar";
		break;

	case 'mostrar':
		$rspta=$encargado->cargar($cedula);
 		//Se cofifica para que quede en json
 		echo json_encode($rspta);
		break;

	case 'cargarPais':

	$rspta=$pais->cargarPais();
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
