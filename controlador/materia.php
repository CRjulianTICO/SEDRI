?php 
require_once "../modelo/Materia.php";

$instaMateria = new Materia();

$id= isset($_POST["idmateria"])?limpiarCadena($_POST["idmateria"]):"";
$nombre = isset($_POST["nombreMateria"])?limpiarCadena($_POST["nombreMateria"]):"";

?>
