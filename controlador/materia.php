?php 
require_once "../modelo/Materia.php";

$instaMateria = new Materia();

$id= isset($_POST["idmateria"])?limpiarCadena($_POST["idmateria"]):"";
$nombre = isset($_POST["nombreMateria"])?limpiarCadena($_POST["nombreMateria"]):"";

switch ($_GET["opcion"]){
	case 'guardar':
			$rspta=$instaMateria->insertar($nombre);
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
 				"2"=>($reg->estado)?'<span class="label bg-green">Activado</span>':
 				'<span class="label bg-red">Desactivado</span>',
                                "3"=>($reg->estado)?'<button class="mostrarEditar" onclick="mostrar('.$reg->idmateria.')"><i class="material-icons center blue-text ">edit</i></button>'.
 					' <button class="mostrarBlock" onclick="desactivar('.$reg->idmateria.')"><i class="material-icons center red-text ">block</i></button>':
 					'<button class="mostrarEditar" onclick="mostrar('.$reg->idmateria.')"><i class="material-icons center blue-text ">edit</i></button>'.
 					' <button class="mostrarCheck" onclick="activar('.$reg->idmateria.')"><i class="material-icons center green-text">check</i></button>',
 				);
?>
