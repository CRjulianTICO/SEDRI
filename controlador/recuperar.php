<?php
require_once "../modelo/Profesor.php";
require_once "../modelo/Pais.php";
require_once "mail.php";
require_once "../modelo/Autenticacion.php";



$profesor=new Profesor();
$pais = new Pais();
$mail = new Mailer();
$auth = new Autenticacion();

//$idalumno=isset($_POST["idalumno"])? limpiarCadena($_POST["idalumno"]):"";
	$cedula=isset($_POST['cedula'])? limpiarCadena($_POST['cedula']):"";
	$nombre=isset($_POST["nombre"])? limpiarCadena($_POST["nombre"]):"";
	$apellido1=isset($_POST["apellido1"])? limpiarCadena($_POST["apellido1"]):"";
	$apellido2=isset($_POST["apellido2"])? limpiarCadena($_POST["apellido2"]):"";
	$sexo=isset($_POST["sexo"])? limpiarCadena($_POST["sexo"]):"";
	$direccion=isset($_POST["direccion"])? limpiarCadena($_POST["direccion"]):"";
	$telefono=isset($_POST["telefono"])? limpiarCadena($_POST["telefono"]):"";
	$email=isset($_POST["email"])? limpiarCadena($_POST["email"]):"";
	$nacionalidad=isset($_POST["nacionalidad"])? limpiarCadena($_POST["nacionalidad"]):"";
	$idgrado=isset($_POST["idgrado"])? limpiarCadena($_POST["idgrado"]):"";
	$annio=isset($_POST["annio"])? limpiarCadena($_POST["annio"]):"";

switch ($_GET["opcion"]){
	case 'guardar':
				
   //Carácteres para la contraseña

			$rspta=$profesor->insertar($cedula, $nombre, $apellido1, $apellido2, $sexo, $direccion,$telefono,$email,$nacionalidad,$annio,$idgrado,$hpass);

			echo $rspta ? $mail->enviarCorreo(1,$email,$password): "Error";
	break;

	case 'editar':
			$rspta=$profesor->actualizar($cedula, $nombre, $apellido1, $apellido2, $sexo, $direccion,$telefono,$email,$nacionalidad);
			echo $rspta ? "Registrado" : "Error";
	break;

	case 'listar':
		$rspta=$profesor->listar();
 		$data= Array();
 		while ($reg=$rspta->fetch_object()){
 			$data[]=array(

 				"0"=>$reg->CEDULA,
 				"1"=>$reg->NOMBRE,
        		"2"=>$reg->APELLIDO1,
				"3"=>$reg->APELLIDO2,
        		"4"=>$reg->SEXO,
        		"5"=>$reg->DIRECCION,
				"6"=>$reg->TELEFONO,
				"7"=>$reg->EMAIL,
        		"8"=>$reg->PAIS,
 				"9"=>($reg->DISPONIBLE)?'<span class="label bg-green">Activado</span>':
 				'<span class="label bg-red">Desactivado</span>',
 				"10"=>'<button class="mostrarEditar" onclick="mostrar('.$reg->CEDULA.')"><i class="material-icons center blue-text ">edit</i></button>
					 <button class="mostrarBlock" onclick="desactivar('.$reg->CEDULA.')"><i class="material-icons center red-text ">block</i></button>',
				"11"=>$reg->nombreGrado." ".$reg->annio,
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
		 $respuesta = $profesor->desactivar($cedula);
		 echo $rspta ? "Activo" : "no se puede activar";
		break;

	case 'activar':
		 $respuesta = $profesor->activar($cedula);
		 echo $rspta ? "activado" : "no se puede activar";
		break;

	case 'mostrar':
		$rspta=$profesor->cargar($cedula);
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
