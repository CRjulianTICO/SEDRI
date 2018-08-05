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

?>
