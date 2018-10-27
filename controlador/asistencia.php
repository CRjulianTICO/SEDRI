<?php

require_once "../modelo/Asistencia.php";
$instAsistencia = new Asistencia();



session_start();
    
    require_once "../modelo/AutenticacionTokens.php";

    $token = $_SESSION["token"];
    $instAuth = new Auth();
    
    $dataToken = [];
    $dataTokenEncrip = $instAuth->GetData($token);
	
    foreach ($dataTokenEncrip as $key => $value) {
        $dataToken += ["".$key."" => $value];
    }
	$rol = $dataToken["rol"];
	$grado = $dataToken["grado"];
	$idgrado = $dataToken["idgrado"];
	
    
   
	


$cedula= isset($_POST["cedula"])?limpiarCadena($_POST["cedula"]):"";
$idGrado= isset($_POST["telefono"])?limparCadena($_POST["telefono"]):"";
$nota = isset($_POST["nota"])?limpiarCadena($_POST["nota"]):"";
$justificacion= isset($_POST["justificacion"])?limpiarCadena($_POST["justificacion"]):"";
$estado= isset($_POST["estado"])?limpiarCadena($_POST["estado"]):"";
$fecha= isset($_POST["fecha"])?limpiarCadena($_POST["fecha"]):"";
date_default_timezone_set('America/Costa_Rica');
$dtFecha =  date("Y/m/d");

$cont = 1;



switch ($_GET["opcion"]){
	case 'guardar':
	
			if($nota==null || $nota == ""){
				$nota = 'No se ingresaron comentarios.';
			}

			$res=$instAsistencia->verificarAsistenciasActual($grado,$dtFecha);
			
			if($res<5){
				$rspta=$instAsistencia->insertaAsistencia($estado,$nota,$cedula,$dtFecha,$idgrado);
				echo $rspta ? "Registrado" : "Error";
			}else{
				echo "0";
			}
			
	break;

	case 'editar':
			$rspta=$instAsistencia->actualizarAsistencia($ced,$just,$nota,$fecha);
			echo $rspta ? "Registrado" : "Error" ;
	break;

    case 'listar':
		$rspta=$instAsistencia->listarAsistenciasActual($idgrado);
 		$data= Array();
 		while ($reg=$rspta->fetch_object()){
 			$data[]=array(
 				"0"=>"<form id='frm".$cont."' method='POST'><input type='hidden' name='id' value='1' /></form> <input form='frm".$cont."' class='ced' name='cedula' value='".$reg->cedula."' disabled> </input>",
 				"1"=>$reg->nombre,
                "2"=>$reg->apellido1,
				"3"=>$reg->apellido2,
				"4"=>$reg->nombreGrado,
                "5"=>'<div>
                        <select id="estado" name="estado" form=frm'.$cont.'>
                        <option value="1">Presente</option>
                        <option value="0">Ausente</option>
                      </select>
                    </div>',
				"6"=>"<div  class='input-field inline'>
                        <input name='nota' id='txtNota' type='text' class='validate' form='frm".$cont."'>
                        <label for='txtNota'>Nota</label>
					  </div>"
						 );
						$cont++;
 		}
 		$results = array(
 			"sEcho"=>1, //Información para el datatables
 			"iTotalRecords"=>count($data), //enviamos el total registros al datatable
 			"iTotalDisplayRecords"=>count($data), //enviamos el total registros a visualizar
 			"aaData"=>$data);
 		echo json_encode($results);
	break;

    case 'mostrar':
    
	$rspta=$instAsistencia->listarAsistencia($idGrado,$fecha);
 		$data= Array();
 		while ($reg=$rspta->fetch_object()){
 			$data[]=array(
 				"0"=>$reg->cedula,
 				"1"=>$reg->nombre,
                "2"=>$reg->apellido1,
				"3"=>$reg->apellido2,
				"4"=>$reg->nombreGrado,
				"5"=>$reg->ESTADO,
                "6"=>$reg->NOTA,
                "7"=>$reg->FECHA,
                "8"=>$reg->AUSENCIA
                         );
 		}
 		$results = array(
 			"sEcho"=>1, //Información para el datatables
 			"iTotalRecords"=>count($data), //enviamos el total registros al datatable
 			"iTotalDisplayRecords"=>count($data), //enviamos el total registros a visualizar
 			"aaData"=>$data);
         echo json_encode($results);
         
		break;


	}





?>