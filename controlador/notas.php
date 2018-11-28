<?php 
require_once "../modelo/Notas.php";
$instNotas = new Notas();

require_once "../modelo/Grado.php";
$instaGrado = new Grado();


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
	$tipoP = $dataToken["tipoProfesor"];
    $idPersona = $dataToken["id"];
    $idTipoMateria = $dataToken["tipoMateria"];

$cedula= isset($_POST["cedula"])?limpiarCadena($_POST["cedula"]):"";
//$IDgrado= isset($_POST["grados"])?limparCadena($_POST["grados"]):"";
$Idgrado= isset($_GET["grados"])?limpiarCadena($_GET["grados"]):"";
$trabajo_cotidiano = isset($_POST["trabajo_cotidiano"])?limpiarCadena($_POST["trabajo_cotidiano"]):"";
$trimestre= isset($_GET["trimestres"])?limpiarCadena($_GET["trimestres"]):"";
$tareas= isset($_POST["tareas"])?limpiarCadena($_POST["tareas"]):"";
$pruebas= isset($_POST["pruebas"])?limpiarCadena($_POST["pruebas"]):"";
$asistencia= isset($_POST["asistencia"])?limpiarCadena($_POST["asistencia"]):"";
$idGrado=isset($_GET["grado"])? limpiarCadena($_GET["grado"]):"";

$cont = 1;



switch ($_GET["opcion"]){
	case 'guardar':
            $nota = '1';
            if($trabajo_cotidiano==null || $trabajo_cotidiano == 0.00
            ||$asistencia==0.00||$asistencia==null||$tareas == 0.00||$tareas == null
            ||$pruebas==0.00||$pruebas==null){
				$nota = '0';
            }
            
			$nombreG=$instaGrado->listarNombre($Idgrado);
			$nombre = $nombreG["nombreGrado"];
			
			if($nota='1'){
                if($tipoP!=0){
                    $nombreM=$instNotas->listarMateriasEspecial($idTipoMateria,$idPersona);
                    $idMateria = $nombreM["id"];
				$rspta=$instNotas->insertaNotas($cedula,$idMateria,$Idgrado,$trabajo_cotidiano,$pruebas,$tareas,$asistencia,$trimestre);
                echo $rspta ? "Registrado" : "Error/"."Ce:".$cedula."/Ma:".$idMateria."/Gr:".$Idgrado."/Co:".$trabajo_cotidiano."/Pr:".$pruebas."/Ta:".$tareas."/As:".$asistencia."/Tr:".$trimestre;
                }else{
                   $rspta=$instNotas->insertaNotas($cedula,$Idgrado,$idgrado,$trabajo_cotidiano,$pruebas,$tareas,$asistencia,$trimestre);
                echo $rspta ? "Registrado" : "Error/"."Ce:".$cedula."/Ma:".$Idgrado."/Gr:".$idgrado."/Co:".$trabajo_cotidiano."/Pr:".$pruebas."/Ta:".$tareas."/As:".$asistencia."/Tr:".$trimestre;
                 
                }
            
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
		if($tipoP!=0){
        $nombreG=$instaGrado->listarNombre($Idgrado);
        $nombreGrado = $nombreG["nombreGrado"];
        
        $nombreM=$instNotas->listarMateriasEspecial($idTipoMateria,$idPersona);
        $nombreMater = $nombreM["nombre"];
		$rspta=$instNotas->listarPorGrado($nombreGrado,$trimestre,"$nombreMater");
 		$data= Array();
 		while ($reg=$rspta->fetch_object()){
 			$data[]=array(
 				"0"=>"<form id='frm".$cont."' method='POST'><input type='hidden' name='id' value='1' /></form> <input form='frm".$cont."' class='ced' name='cedula' value='".$reg->cedula."' disabled> </input>",
 				"1"=>$reg->nombre,
                "2"=>$reg->apellido1,
				"3"=>$reg->apellido2,
				"4"=>$reg->nombreGrado,
                "5"=>$reg->materia,
                "6"=>"<input pattern=".'^[^0][0-9]{1,2}'."  title=".'Solo puede insertar numeros con un maximo de 2 digitos'."  form='frm".$cont."' class='trabajo_cotidiano' name='trabajo_cotidiano' value='".$reg->trabajo_cotidiano."' > </input>",
                "7"=>"<input pattern=".'^[^0][0-9]{1,2}'."  title=".'Solo puede insertar numeros con un maximo de 2 digitos'."  form='frm".$cont."' class='pruebas' name='pruebas' value='".$reg->pruebas."' > </input>",
                "8"=>"<input pattern=".'^[^0][0-9]{1,2}'."  title=".'Solo puede insertar numeros con un maximo de 2 digitos'."  form='frm".$cont."' class='tareas' name='tareas' value='".$reg->tareas."' > </input>",
                "9"=>"<input pattern=".'^[^0][0-9]{1,2}'."  title=".'Solo puede insertar numeros con un maximo de 2 digitos'."  form='frm".$cont."' class='asistencia' name='asistencia' value='".$reg->asistencia."' > </input>",
                "10"=>"<input form='frm".$cont."' class='total' name='total' value='".$reg->total."' disabled> </input>"
                
						 );
						$cont++;
 		}
 		$results = array(
 			"sEcho"=>1, //Información para el datatables
 			"iTotalRecords"=>count($data), //enviamos el total registros al datatable
 			"iTotalDisplayRecords"=>count($data), //enviamos el total registros a visualizar
 			"aaData"=>$data);
		 echo json_encode($results);
	
		 }else{
		  
        $nombreG=$instaGrado->listarNombre($idgrado);
        $nombreGrado = $nombreG["nombreGrado"];
        $nombreMat=$instNotas->nombreMaterias($Idgrado);
        $nombreMateria = $nombreMat["nombre"];
        
		$rspta=$instNotas->listarPorMateria($nombreMateria,$trimestre,$nombreGrado);
 		$data= Array();
 		while ($reg=$rspta->fetch_object()){
 			$data[]=array(
 				"0"=>"<form id='frm".$cont."' method='POST'><input type='hidden' name='id' value='1' /></form> <input form='frm".$cont."' class='ced' name='cedula' value='".$reg->cedula."' disabled> </input>",
 				"1"=>$reg->nombre,
                "2"=>$reg->apellido1,
				"3"=>$reg->apellido2,
				"4"=>$reg->nombreGrado,
                "5"=>$reg->materia,
                "6"=>"<input form='frm".$cont."' class='trabajo_cotidiano' name='trabajo_cotidiano' value='".$reg->trabajo_cotidiano."' > </input>",
                "7"=>"<input form='frm".$cont."' class='pruebas' name='pruebas' value='".$reg->pruebas."' > </input>",
                "8"=>"<input form='frm".$cont."' class='tareas' name='tareas' value='".$reg->tareas."' > </input>",
                "9"=>"<input form='frm".$cont."' class='asistencia' name='asistencia' value='".$reg->asistencia."' > </input>",
                "10"=>"<input form='frm".$cont."' class='total' name='total' value='".$reg->total."' disabled> </input>"
                
						 );
						$cont++;
 		}
 		$results = array(
 			"sEcho"=>1, //Información para el datatables
 			"iTotalRecords"=>count($data), //enviamos el total registros al datatable
 			"iTotalDisplayRecords"=>count($data), //enviamos el total registros a visualizar
 			"aaData"=>$data);
		 echo json_encode($results);
		 }
		 
	break;

	case 'cargar':
		if($tipoP==0){
                $rspta=$instNotas->listarMaterias($idTipoMateria,$idPersona);
                $data= Array();
                while ($reg=$rspta->fetch_object()){
                    $data[]=array(
                        "id_grado"=>$reg->id,
                        "nombreGrado"=>$reg->nombre
                    );
                }
		         echo json_encode($data);
			}else{
                $rspta=$instNotas->listarGrados($idPersona);
                $data= Array();
                while ($reg=$rspta->fetch_object()){
                    $data[]=array(
                        "id_grado"=>$reg->id_grado,
                        "nombreGrado"=>$reg->nombreGrado
                    );
                }
		 echo json_encode($data);
			}
	break;
/*S
    case 'mostrar':
			
		if($fecha==null || $fecha == ""){
				$date = $dtFecha;
		}else{
			$date = $fecha;
		}
	$nombreG=$instaGrado->listarNombre($Idgrado);
	$nombre = $nombreG["nombreGrado"];
	$res=$instAsistencia->verificarAsistenciasActual($nombre,$date);
	//print_r($res);
	if($res==0){
		$date = date('Y/m/d',strtotime("-1 days"));
	}
	
	if($tipoP!=0){
	$rspta=$instAsistencia->listarAsistencia($nombre,$date);
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
		 }else{
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
		 }
		break;
*/
	}
    



?>