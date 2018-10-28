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
$fecha= isset($_GET["fecha"])?limpiarCadena($_GET["fecha"]):"";
$dia= isset($_POST["dia"])?limpiarCadena($_POST["dia"]):"";
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
			if($dia==null || $dia == ""){
					$date = $dtFecha;
				}else{
					$date = $dia;
				}

			echo $cedula."<br>".$justificacion."<br>".$nota."<br>".$date;
			$rspta=$instAsistencia->actualizarAsistencia($cedula,$justificacion,$nota,$date);
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
			
		if($fecha==null || $fecha == ""){
				$date = $dtFecha;
		}else{
			$date = $fecha;
		}
	
	$res=$instAsistencia->verificarAsistenciasActual($grado,$date);
	//print_r($res);
	if($res==0){
		$date = date('Y/m/d',strtotime("-1 days"));
	}
	
	
	$rspta=$instAsistencia->listarAsistencia($grado,$date);
		 $data= Array();
		 $estado;
		 $ausencia;
		 $nota;
 		while ($reg=$rspta->fetch_object()){
			if($reg->ESTADO==1){
					$estado= "Presente";
				}else{
					$estado ="Ausente";
				}
			if($reg->AUSENCIA==null){
					$ausencia= "Presente";
					$nota ="<input value='".$reg->NOTA."' name='nota' type='text' class='' id='nota".$reg->cedula."' disabled>";
				}elseif($reg->AUSENCIA==1){
					$ausencia ="<p class='green-text'>Justificada</p>";
					$nota ="<input value='".$reg->NOTA."' name='nota' type='text' class=''id='nota".$reg->cedula."' disabled>";
				}else{
					$ausencia = "<p class='red-text'>Injustificada</p>   "."<button class='btn waves-effect waves-light yellow' id='btnJust' onclick='justificar(".$reg->cedula.")'>Justificar</button>";
					$nota ="<input value='".$reg->NOTA."' name='nota' type='text' class='input-field inline' id='nota".$reg->cedula."'>";
				}	 
 			$data[]=array(
 				"0"=>$reg->cedula,
 				"1"=>$reg->nombre,
                "2"=>$reg->apellido1." ".$reg->apellido2,
				"3"=>$reg->nombreGrado,
				"4"=>$estado,
                "5"=>$nota,
                "6"=>$reg->FECHA,
                "7"=>$ausencia
                         );
 		}
 		$results = array(
 			"sEcho"=>1, //Información para el datatables
 			"iTotalRecords"=>count($data), //enviamos el total registros al datatable
 			"iTotalDisplayRecords"=>count($data), //enviamos el total registros a visualizar
 			"aaData"=>$data);
         echo json_encode($results);
         //print_r($data);
		break;

	}





?>