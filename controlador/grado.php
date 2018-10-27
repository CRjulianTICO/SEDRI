<?php
require_once "../modelo/Grado.php";


$grado=new Grado();
  $idgrado=isset($_POST["idgrado"])? limpiarCadena($_POST["idgrado"]):"";
	$nombreGrado=isset($_POST["nombreGrado"])? limpiarCadena($_POST["nombreGrado"]):"";
	$annio = isset($_POST["annio"])? limpiarCadena($_POST["annio"]):"";
switch ($_GET["opcion"]){
	case 'guardar':
			$rspta=$grado->insertar($nombreGrado,$annio);
			echo $rspta ? "Registrado".$nombreGrado: "Error";
	break;
	case 'editar':
			$rspta=$grado->actualizar($idgrado,$nombreGrado,$annio);
			echo $rspta ? "Registrado id = ".$idgrado." Nombre".$nombreGrado : "Error";
	break;

	case 'listar':
		$rspta=$grado->listar();
 		$data= Array();
 		while ($reg=$rspta->fetch_object()){
 			$data[]=array(

 				 "0"=>$reg->idgrado,
				 "1"=>$reg->nombreGrado,
				 "2" =>$reg->annio, 
 				"3"=>'<button class="mostrarEditar" onclick="mostrar('.$reg->idgrado.')"><i class="material-icons center blue-text ">edit</i></button>'
 				);
 		}
 		$results = array(
 			"sEcho"=>1, //Información para el datatables
 			"iTotalRecords"=>count($data), //enviamos el total registros al datatable
 			"iTotalDisplayRecords"=>count($data), //enviamos el total registros a visualizar
 			"aaData"=>$data);
 		echo json_encode($results);
	break;
	
	case 'listaSimple':
		$rspta=$grado->listar();
 		$data= Array();
 		while ($reg=$rspta->fetch_object()){
 			$data[]=array(
 				"ID_GRADO"=>$reg->idgrado,
				 "NOMBRE_GRADO"=>$reg->nombreGrado,
				 "ANNIO"=>$reg->annio
				 );
				
		 }
		 echo json_encode($data);
	break;

	case 'mostrar':
		$rspta=$grado->cargar($idgrado);
 		echo json_encode($rspta);
		break;
}
?>
