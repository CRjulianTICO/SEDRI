<?php

session_start();
if(isset($_SESSION["token"])){
  
  require_once "../modelo/AutenticacionTokens.php";

  $token = $_SESSION["token"];
  $instAuth = new Auth();
  $instAuth->Check($token);
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
 


}else
{
  header("Location: http://localhost:8888/SEDRI/vistas/Login.php");
}

require_once "../modelo/Alumno.php";
require_once "../modelo/Encargado.php";
require_once "../modelo/Pais.php";
require_once "../modelo/Alumno.php";


$encargado=new Encargado();
$pais = new Pais();
$alumno=new Alumno();


   $cedulaE=isset($_POST["cedulaE"])? limpiarCadena($_POST["cedulaE"]):"";
	$cedula=isset($_POST['cedula'])? limpiarCadena($_POST['cedula']):"0";
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
		$rspta=$encargado->insertar($cedula, $nombre, $apellido1, $apellido2, $sexo, $direccion,$telefono,$telefono2,$nacionalidad);

		if($rspta != null){
			$resp = $encargado->consultaID($cedula);
			$id = $resp['idencargado'];
			echo 'id'.$id.'<br>';
			$array = $_POST['estudiante'];
			echo '<hr>';
			foreach($array as $value){
				echo '<hr>'.$value.' '.$id;
				$encargado->insertaAlumno($id,$value);
				;
			 }

		}else{
			echo 'Error';
		}
	break;

	case 'editar':
			$rspta=$encargado->actualizar($cedula, $nombre, $apellido1, $apellido2, $sexo, $direccion,$telefono,$nacionalidad,$nacionalidad);
			
			if($rspta != null){
				$resp = $encargado->consultaID($cedula);
				$id = $resp['idencargado'];
				echo 'id'.$id.'<br>';
				echo $encargado->borrarAlumno($id);
				$array = $_POST['estudiante'];
				echo '<hr>';
				foreach($array as $value){
					echo '<hr>'.$value.' '.$id;
					$encargado->insertaAlumno($id,$value);
					;
				 }
	
			}else{
				echo 'Error';
			}
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
 				"9"=>'<button class="mostrarEditar" onclick="mostrar('.$reg->cedula.')"><i class="material-icons center blue-text ">edit</i></button>
					 <button class="mostrarBlock" onclick="desactivar('.$reg->cedula.')"><i class="material-icons center red-text ">block</i></button>'
					 
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

	case 'cargarEstudiante' : 
	$rspta=$alumno->listarAlumnos($idgrado);
	$data= Array();
 		while ($reg=$rspta->fetch_object()){
 			$data[]=array(

 				'idalumno' => $reg->idalumno,
			    'nombre' => $reg->nombre

		);
	}
		echo json_encode($data);
	 break;
	 


	 case 'cargarEstudianteEncargado' : 
	 $id = $_GET['post'];
	$rspta=$alumno->listarAlumnosEncargado($id,$idgrado);
	$data= Array();
 		while ($reg=$rspta->fetch_object()){
 			$data[]=array(

 				'idalumno' => $reg->idalumno,
			    'nombre' => $reg->nombre

		);
	}
		echo json_encode($data);
	 break;
}
?>
