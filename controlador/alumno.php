<?php
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


switch ($_GET["opcion"]){
	case 'guardar':
			echo "Valores que llegan a controlador".$cedula.$nombre.$apellido1.$apellido2.$sexo.$direccion.$nacionalidad;
			$rspta=$alumno->insertar($cedula, $nombre, $apellido1, $apellido2, $sexo, $direccion, $nacionalidad);
			$alumno->getIdPersona($cedula);//SOLUCIONAR
			echo $rspta ? "Registrado" : "Error".$nombre;
	break;

	case 'editar':
			$rspta=$alumno->actualizar($cedula, $nombre, $apellido1, $apellido2, $sexo, $direccion, $nacionalidad);
			echo $rspta ? "Registrado" : "Error";
	break;

	case 'listar':
		$rspta=$alumno->listar();
 		$data= Array();
 		while ($reg=$rspta->fetch_object()){
 			$data[]=array(
 				"0"=>($reg->disponible)?'<button  onclick="mostrar('.$reg->cedula.')"><i class="fa fa-pencil"></i></button>'.
 					' <button  onclick="desactivar('.$reg->cedula.')"><i class="fa fa-close"></i></button>':
 					'<button  onclick="mostrar('.$reg->cedula.')"><i class="fa fa-pencil"></i></button>'.
 					' <button  onclick="activar('.$reg->cedula.')"><i class="fa fa-check"></i></button>',
 				"1"=>$reg->cedula,
 				"2"=>$reg->nombre,
        "3"=>$reg->apellido1,
        "4"=>$reg->apellido2,
        "5"=>$reg->sexo,
        "6"=>$reg->direccion,
        "7"=>$reg->pais,
 				"8"=>($reg->disponible)?'<span class="label bg-green">Activado</span>':
 				'<span class="label bg-red">Desactivado</span>'
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
		 echo $rspta ? "Categoría activada" : "Categoría no se puede activar";
		break;

	case 'activar':
		 $respuesta = $alumno->activar($cedula);
		 echo $rspta ? "Categoría activada" : "Categoría no se puede activar";
		break;

	case 'mostrar':
		$rspta=$alumno->cargar($cedula);
 		//Se cofifica para que quede en json
 		echo json_encode($rspta);
		break;


}
?>
