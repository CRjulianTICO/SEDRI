<?php
require "../config/Conexion.php";

Class Grado
{
	//Implementamos nuestro constructor
	public function __construct()
	{

	}
	//Guardar  solo parametros necesarios para un estudiante
	public function insertar($nombreGrado,$annio)
	{
		$sql="INSERT INTO `grado` (`idgrado`, `nombreGrado`,`annio`)
    		VALUES (NULL, '$nombreGrado',$annio);";
		return consulta($sql);
	}

	public function actualizar($idgrado,$nombreGrado,$annio)
	{
		$sql="UPDATE `grado` SET `nombreGrado` = '".$nombreGrado."',  `annio` = '".$annio."' where idgrado='".$idgrado."';";

		return consulta($sql);
	}
	//Usando la vista creada
	public function listar()
	{
		$sql="SELECT * FROM grado";
		return consulta($sql);
	}


	public function cargar($id){
		$sql = "SELECT * FROM grado WHERE idgrado='".$id."'";
	    return consultaSimple($sql);
	}
}

?>
